// Scheduled Cloud Function — closes registration for expired championships (Story 30.19)
// Runs every hour. Transitions championships from `registration` to `registration_closed`
// when their registrationDeadline has passed.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Inner handler — exported separately for unit testing.
 */
export async function enforceRegistrationDeadlinesHandler(): Promise<{
  processed: number;
}> {
  const db = admin.firestore();
  const now = admin.firestore.Timestamp.now();

  // Query championships that are open for registration but past their deadline.
  const snap = await db
    .collection("championships")
    .where("status", "==", "registration")
    .where("registrationDeadline", "<=", now)
    .get();

  if (snap.empty) {
    functions.logger.info("enforceRegistrationDeadlines: no expired championships");
    return { processed: 0 };
  }

  const batch = db.batch();
  let count = 0;

  for (const doc of snap.docs) {
    batch.update(doc.ref, {
      status: "registration_closed",
      closedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    functions.logger.info("Closing registration for championship", {
      championshipId: doc.id,
      registrationDeadline: doc.data().registrationDeadline?.toDate()?.toISOString(),
    });
    count++;
  }

  await batch.commit();
  functions.logger.info(`enforceRegistrationDeadlines: closed ${count} championship(s)`);
  return { processed: count };
}

/**
 * Runs every hour to enforce registration deadlines.
 * Idempotent — running it multiple times has no additional effect on already-closed championships.
 */
export const enforceRegistrationDeadlines = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 60, memory: "256MB" })
  .pubsub.schedule("every 60 minutes")
  .onRun(async () => {
    await enforceRegistrationDeadlinesHandler();
  });
