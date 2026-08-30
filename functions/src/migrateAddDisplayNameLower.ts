import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

/**
 * Response interface for migrateAddDisplayNameLower Cloud Function
 */
export interface MigrateAddDisplayNameLowerResponse {
  success: boolean;
  message: string;
  usersProcessed: number;
  usersUpdated: number;
}

/**
 * Handler function for migrateAddDisplayNameLower (exported for testing)
 *
 * One-time migration: backfills the `displayNameLower` field on all existing
 * user documents that have a `displayName` but are missing it.
 *
 * Background:
 * - Story 35.7 adds `displayNameLower`, a denormalized lowercase copy of
 *   `displayName`, so searchUsers.ts can run a case-insensitive indexed
 *   prefix-range query instead of a full-collection scan.
 * - New/updated user documents get `displayNameLower` going forward from
 *   updateUserNames.ts, createUserDocument.ts, and the client's
 *   updateUserProfile write path.
 * - This function backfills documents that predate those changes.
 *
 * Safety:
 * - Idempotent: skips documents that already have `displayNameLower`, or
 *   that have no non-empty `displayName` to derive it from.
 * - Restricted to admin users only (uid must exist in the `appAdmins`
 *   collection).
 * - Processes users in batches of 400 (Firestore batch limit is 500).
 * - Returns a summary of how many documents were processed and updated.
 *
 * Deployment order:
 * 1. Deploy this function (and the write-path changes) to dev, verify output.
 * 2. Deploy to prod.
 * 3. Run this migration once on prod to backfill existing users.
 * 4. Optionally delete this function after migration is confirmed.
 *
 * @param _data - Not used; no input required
 * @param context - Firebase Functions context with auth information
 * @returns Promise resolving to MigrateAddDisplayNameLowerResponse
 */
export async function migrateAddDisplayNameLowerHandler(
  _data: unknown,
  context: functions.https.CallableContext
): Promise<MigrateAddDisplayNameLowerResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be authenticated to run this migration."
    );
  }

  const callerUid = context.auth.uid;

  // Restrict to admin users by checking a Firestore-based admin list, to
  // avoid shipping UIDs in source code.
  const db = admin.firestore();
  const adminDoc = await db.collection("appAdmins").doc(callerUid).get();
  if (!adminDoc.exists) {
    functions.logger.warn("[migrateAddDisplayNameLower] Unauthorized attempt", {
      callerUid,
    });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only app admins can run data migrations."
    );
  }

  functions.logger.info("[migrateAddDisplayNameLower] Migration started", {
    callerUid,
  });

  let usersProcessed = 0;
  let usersUpdated = 0;
  const batchSize = 400;

  try {
    // Paginate through all user documents
    let lastDoc: admin.firestore.QueryDocumentSnapshot | undefined;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection("users").limit(batchSize);
      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const snapshot = await query.get();

      if (snapshot.empty) {
        hasMore = false;
        break;
      }

      // Collect documents that have a displayName but no displayNameLower yet
      const docsToUpdate: {
        ref: FirebaseFirestore.DocumentReference;
        displayNameLower: string;
      }[] = [];
      for (const doc of snapshot.docs) {
        usersProcessed++;
        const data = doc.data();
        const displayName = data.displayName;
        if (
          typeof displayName === "string" &&
          displayName.length > 0 &&
          !("displayNameLower" in data)
        ) {
          docsToUpdate.push({
            ref: doc.ref,
            displayNameLower: displayName.toLowerCase(),
          });
        }
      }

      // Write in a single batch per page
      if (docsToUpdate.length > 0) {
        const batch = db.batch();
        for (const { ref, displayNameLower } of docsToUpdate) {
          batch.update(ref, { displayNameLower });
          usersUpdated++;
        }
        await batch.commit();

        functions.logger.info(
          `[migrateAddDisplayNameLower] Batch committed: backfilled displayNameLower for ${docsToUpdate.length} users`,
          {batchSize: docsToUpdate.length, totalUpdatedSoFar: usersUpdated}
        );
      }

      lastDoc = snapshot.docs[snapshot.docs.length - 1];
      hasMore = snapshot.docs.length === batchSize;
    }

    functions.logger.info("[migrateAddDisplayNameLower] Migration complete", {
      callerUid,
      usersProcessed,
      usersUpdated,
    });

    return {
      success: true,
      message: `Migration complete. Processed ${usersProcessed} users, backfilled displayNameLower for ${usersUpdated}.`,
      usersProcessed,
      usersUpdated,
    };
  } catch (error) {
    functions.logger.error("[migrateAddDisplayNameLower] Migration failed", {
      callerUid,
      usersProcessed,
      usersUpdated,
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    throw new functions.https.HttpsError(
      "internal",
      `Migration failed after processing ${usersProcessed} users (${usersUpdated} updated). Error: ${
        error instanceof Error ? error.message : String(error)
      }`
    );
  }
}

/**
 * One-time callable Cloud Function to backfill the denormalized
 * `displayNameLower` field on all existing user documents.
 *
 * See migrateAddDisplayNameLowerHandler for full documentation.
 *
 * Restricted to app admins only (caller uid must exist in `appAdmins` collection).
 */
export const migrateAddDisplayNameLower = functions
  .region("europe-west6")
  .runWith({
    timeoutSeconds: 540, // Max 9 minutes — enough for large user collections
    memory: "512MB",
  })
  .https.onCall(withLogging('migrateAddDisplayNameLower', migrateAddDisplayNameLowerHandler));
