// Scheduled Cloud Function — closes registration for expired championships (Story 30.19)
// and auto-completes active championships whose endDate has passed (Story 30.32).
// Runs every hour.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { sendChampionshipNotificationToUsers } from "./championshipNotifications";

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

  // ── Story 30.32: auto-complete active championships past their endDate ──────
  const expiredSnap = await db
    .collection("championships")
    .where("status", "==", "active")
    .where("endDate", "<=", now)
    .get();

  let completed = 0;
  for (const doc of expiredSnap.docs) {
    const champRef = doc.ref;
    const championshipId = doc.id;

    try {
      // Determine champion (position 1 in standings)
      const standingsSnap = await champRef
        .collection("standings")
        .orderBy("position")
        .limit(1)
        .get();
      const championTeamId = standingsSnap.empty ? null : standingsSnap.docs[0].id;

      await champRef.update({
        status: "completed",
        championTeamId: championTeamId ?? admin.firestore.FieldValue.delete(),
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        completedBy: "system:endDate",
      });

      functions.logger.info("enforceRegistrationDeadlines: auto-completed championship", {
        championshipId,
        championTeamId,
      });

      // Notify all team members (non-fatal)
      try {
        const teamsSnap = await champRef.collection("teams").get();
        for (const teamDoc of teamsSnap.docs) {
          const memberIds: string[] = teamDoc.data().memberIds ?? [];
          if (memberIds.length === 0) continue;
          const isChampion = teamDoc.id === championTeamId;
          await sendChampionshipNotificationToUsers(db, memberIds, {
            title: isChampion ? "🏆 You are champions!" : "Championship complete",
            body: isChampion
              ? "Congratulations! You won the championship."
              : "The championship has ended. See the final standings.",
            data: { type: "championship", championshipId },
          });
        }
      } catch (notifErr) {
        functions.logger.error("enforceRegistrationDeadlines: completion notification failed", {
          notifErr, championshipId,
        });
      }

      completed++;
    } catch (err) {
      functions.logger.error("enforceRegistrationDeadlines: failed to auto-complete championship", {
        err, championshipId,
      });
    }
  }

  if (completed > 0) {
    functions.logger.info(`enforceRegistrationDeadlines: auto-completed ${completed} championship(s)`);
  }

  return { processed: count + completed };
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
