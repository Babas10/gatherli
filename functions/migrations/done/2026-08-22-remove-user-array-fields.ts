import * as admin from "firebase-admin";

/**
 * Migration: Remove friendIds, gameIds, recentGameIds, groupIds arrays from
 *            user documents and recompute friendCount from friendships collection.
 *
 * Date: 2026-08-22
 * Story: 34.2 (#865)
 *
 * What it changes:
 *   Before: users/{uid} may contain friendIds[], gameIds[], recentGameIds[],
 *           groupIds[] — unbounded arrays that duplicate other collections.
 *           friendCount may have drifted (observed: count=14, array.length=12).
 *   After:  those 4 array fields are deleted; friendCount is recomputed from
 *           the authoritative friendships collection.
 *
 * Safe to run multiple times? YES — idempotent
 * Estimated documents affected: ~43 users in prod
 */

if (!admin.apps.length) {
  admin.initializeApp();
}
const db = admin.firestore();
const ARRAY_FIELDS = ["friendIds", "gameIds", "recentGameIds", "groupIds"];

async function getFriendCount(uid: string): Promise<number> {
  const [asInitiator, asRecipient] = await Promise.all([
    db.collection("friendships")
      .where("initiatorId", "==", uid)
      .where("status", "==", "accepted")
      .get(),
    db.collection("friendships")
      .where("recipientId", "==", uid)
      .where("status", "==", "accepted")
      .get(),
  ]);
  const ids = new Set<string>();
  asInitiator.docs.forEach(d => ids.add(d.data().recipientId));
  asRecipient.docs.forEach(d => ids.add(d.data().initiatorId));
  return ids.size;
}

async function migrate(): Promise<void> {
  const snapshot = await db.collection("users").get();
  let arrayDeletions = 0;
  let friendCountFixed = 0;
  let usersPatched = 0;

  for (const doc of snapshot.docs) {
    const data = doc.data();
    const update: Record<string, unknown> = {};

    for (const field of ARRAY_FIELDS) {
      if (field in data) {
        update[field] = admin.firestore.FieldValue.delete();
        arrayDeletions++;
      }
    }

    const correctCount = await getFriendCount(doc.id);
    const storedCount = typeof data.friendCount === "number" ? data.friendCount : null;
    if (storedCount !== correctCount) {
      update.friendCount = correctCount;
      friendCountFixed++;
      console.log(`  friendCount fix: ${doc.id} | stored=${storedCount} → correct=${correctCount}`);
    }

    if (Object.keys(update).length > 0) {
      await doc.ref.update(update);
      usersPatched++;
    }
  }

  console.log("Migration complete:");
  console.log(`  Users processed:         ${snapshot.size}`);
  console.log(`  Users patched:           ${usersPatched}`);
  console.log(`  Array field deletions:   ${arrayDeletions}`);
  console.log(`  friendCount corrections: ${friendCountFixed}`);
}

migrate().catch(e => { console.error(e); process.exit(1); });
