// Story 31.3: One-time migration to remove unbounded arrays from user documents
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const BATCH_SIZE = 400;
const FIELDS_TO_REMOVE = ["groupIds", "gameIds", "recentGameIds", "friendIds"];

/**
 * Admin-only callable function that removes unbounded array fields from all user documents.
 * Idempotent: skips documents that no longer have any of the target fields.
 * Processes documents in paginated batches of 400 to stay within Firestore limits.
 */
export const migrateRemoveUserArrays = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 540, memory: "512MB" })
  .https.onCall(async (data, context) => {
    // 1. Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "You must be logged in to run this migration."
      );
    }

    // 2. Admin-only gate
    const db = admin.firestore();
    const adminDoc = await db.collection("appAdmins").doc(context.auth.uid).get();
    if (!adminDoc.exists) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Only app admins can run this migration."
      );
    }

    functions.logger.info("migrateRemoveUserArrays: starting", {
      uid: context.auth.uid,
    });

    let totalProcessed = 0;
    let totalPatched = 0;
    let lastDoc: admin.firestore.DocumentSnapshot | null = null;
    let hasMore = true;

    while (hasMore) {
      // Paginate through all user documents
      let query: admin.firestore.Query = db.collection("users").limit(BATCH_SIZE);
      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const snapshot = await query.get();
      if (snapshot.empty) {
        hasMore = false;
        break;
      }

      const batch = db.batch();
      let batchCount = 0;

      for (const doc of snapshot.docs) {
        const data = doc.data();
        const fieldsPresent = FIELDS_TO_REMOVE.filter(
          (field) => data[field] !== undefined
        );

        if (fieldsPresent.length > 0) {
          const patch: Record<string, unknown> = {};
          for (const field of fieldsPresent) {
            patch[field] = admin.firestore.FieldValue.delete();
          }
          batch.update(doc.ref, patch);
          batchCount++;
        }
      }

      if (batchCount > 0) {
        await batch.commit();
        totalPatched += batchCount;
      }

      totalProcessed += snapshot.size;
      lastDoc = snapshot.docs[snapshot.docs.length - 1];

      functions.logger.info("migrateRemoveUserArrays: batch complete", {
        totalProcessed,
        totalPatched,
        batchSize: snapshot.size,
      });

      if (snapshot.size < BATCH_SIZE) {
        hasMore = false;
      }
    }

    functions.logger.info("migrateRemoveUserArrays: done", {
      totalProcessed,
      totalPatched,
    });

    return { totalProcessed, totalPatched };
  });
