import * as admin from "firebase-admin";

/**
 * Migration: <short description>
 *
 * Date: YYYY-MM-DD
 * Story: <story number> (#<issue>)
 *
 * What it changes:
 *   Before: <old data shape>
 *   After:  <new data shape>
 *
 * Safe to run multiple times? YES / NO — <explain>
 * Estimated documents affected: ~N
 */

if (!admin.apps.length) {
  admin.initializeApp();
}
const db = admin.firestore();

async function migrate(): Promise<void> {
  let processed = 0;
  let updated = 0;

  const snapshot = await db.collection("COLLECTION").get();
  let batch = db.batch();
  let batchCount = 0;

  for (const doc of snapshot.docs) {
    processed++;
    const data = doc.data();

    // Idempotency check — skip documents that are already migrated. This
    // makes it safe to re-run the script if it fails partway through.
    if (data.newField !== undefined) continue;

    batch.update(doc.ref, {
      newField: data.oldField ?? null,
      // oldField: admin.firestore.FieldValue.delete(), // only after the old app version is retired
    });
    updated++;
    batchCount++;

    // Firestore batch limit is 500 writes.
    if (batchCount === 500) {
      await batch.commit();
      batch = db.batch();
      batchCount = 0;
    }
  }

  if (batchCount > 0) {
    await batch.commit();
  }

  console.log("Migration complete:");
  console.log(`  Documents processed: ${processed}`);
  console.log(`  Documents updated:   ${updated}`);
}

migrate().catch(e => {
  console.error(e);
  process.exit(1);
});
