import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Response interface for migrateRemoveGroupGameIds Cloud Function
 */
export interface MigrateRemoveGroupGameIdsResponse {
  success: boolean;
  message: string;
  groupsProcessed: number;
  groupsUpdated: number;
}

/**
 * Handler function for migrateRemoveGroupGameIds (exported for testing)
 *
 * One-time migration: removes the `gameIds` field from all group documents.
 *
 * Background:
 * - GroupModel previously stored `gameIds: List<String>` — an unbounded array
 *   of every game ID ever created in the group.
 * - This field is redundant because every GameModel already stores `groupId`,
 *   and games are queried via `games.where('groupId', isEqualTo: groupId)`.
 * - Story 31.2 removes this field from the Flutter model and all write paths.
 * - This function cleans up existing Firestore documents in production.
 *
 * Safety:
 * - Idempotent: skips documents that do not have the `gameIds` field.
 * - Restricted to admin users only (uid must be in the allowedAdmins list or
 *   the function must be called from a trusted context).
 * - Processes groups in batches of 400 (Firestore batch limit is 500).
 * - Returns a summary of how many documents were processed and updated.
 *
 * Deployment order:
 * 1. Deploy this function to dev, verify output.
 * 2. Deploy updated Flutter client (without gameIds reads/writes).
 * 3. Run this migration on prod.
 * 4. Optionally delete this function after migration is confirmed.
 *
 * @param _data - Not used; no input required
 * @param context - Firebase Functions context with auth information
 * @returns Promise resolving to MigrateRemoveGroupGameIdsResponse
 */
export async function migrateRemoveGroupGameIdsHandler(
  _data: unknown,
  context: functions.https.CallableContext
): Promise<MigrateRemoveGroupGameIdsResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be authenticated to run this migration."
    );
  }

  const callerUid = context.auth.uid;

  // Restrict to admin users by checking the custom claim or a hardcoded list.
  // Using a Firestore-based admin check to avoid shipping UIDs in source code.
  const db = admin.firestore();
  const adminDoc = await db.collection("appAdmins").doc(callerUid).get();
  if (!adminDoc.exists) {
    functions.logger.warn("[migrateRemoveGroupGameIds] Unauthorized attempt", {
      callerUid,
    });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only app admins can run data migrations."
    );
  }

  functions.logger.info("[migrateRemoveGroupGameIds] Migration started", {
    callerUid,
  });

  let groupsProcessed = 0;
  let groupsUpdated = 0;
  const batchSize = 400;

  try {
    // Paginate through all group documents
    let lastDoc: admin.firestore.QueryDocumentSnapshot | undefined;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection("groups").limit(batchSize);
      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const snapshot = await query.get();

      if (snapshot.empty) {
        hasMore = false;
        break;
      }

      // Collect documents that still have the gameIds field
      const docsToUpdate: admin.firestore.QueryDocumentSnapshot[] = [];
      for (const doc of snapshot.docs) {
        groupsProcessed++;
        const data = doc.data();
        if ("gameIds" in data) {
          docsToUpdate.push(doc);
        }
      }

      // Write in a single batch per page
      if (docsToUpdate.length > 0) {
        const batch = db.batch();
        for (const doc of docsToUpdate) {
          batch.update(doc.ref, {
            gameIds: admin.firestore.FieldValue.delete(),
          });
          groupsUpdated++;
        }
        await batch.commit();

        functions.logger.info(
          `[migrateRemoveGroupGameIds] Batch committed: removed gameIds from ${docsToUpdate.length} groups`,
          {batchSize: docsToUpdate.length, totalUpdatedSoFar: groupsUpdated}
        );
      }

      lastDoc = snapshot.docs[snapshot.docs.length - 1];
      hasMore = snapshot.docs.length === batchSize;
    }

    functions.logger.info("[migrateRemoveGroupGameIds] Migration complete", {
      callerUid,
      groupsProcessed,
      groupsUpdated,
    });

    return {
      success: true,
      message: `Migration complete. Processed ${groupsProcessed} groups, removed gameIds from ${groupsUpdated}.`,
      groupsProcessed,
      groupsUpdated,
    };
  } catch (error) {
    functions.logger.error("[migrateRemoveGroupGameIds] Migration failed", {
      callerUid,
      groupsProcessed,
      groupsUpdated,
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    throw new functions.https.HttpsError(
      "internal",
      `Migration failed after processing ${groupsProcessed} groups (${groupsUpdated} updated). Error: ${
        error instanceof Error ? error.message : String(error)
      }`
    );
  }
}

/**
 * One-time callable Cloud Function to remove the deprecated `gameIds` array
 * from all group documents in Firestore.
 *
 * See migrateRemoveGroupGameIdsHandler for full documentation.
 *
 * Restricted to app admins only (caller uid must exist in `appAdmins` collection).
 */
export const migrateRemoveGroupGameIds = functions
  .region("europe-west6")
  .runWith({
    timeoutSeconds: 540, // Max 9 minutes — enough for large group collections
    memory: "512MB",
  })
  .https.onCall(migrateRemoveGroupGameIdsHandler);
