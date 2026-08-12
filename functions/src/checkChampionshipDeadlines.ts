// Scheduled function: sends 48h deadline warning notifications for
// championship matches that are still unplayed and due within 48 hours (Story 30.13).
// Runs daily at 09:00 UTC.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { sendChampionshipNotificationToUsers } from "./championshipNotifications";

const HOURS_48_MS = 48 * 60 * 60 * 1000;
const WARNING_FLAG = "deadlineWarning48hSent";

// ============================================================================
// Inner handler (exported for unit tests)
// ============================================================================

export async function checkChampionshipDeadlinesHandler(
  db: admin.firestore.Firestore,
  now: Date
): Promise<void> {
  const nowTs = admin.firestore.Timestamp.fromDate(now);
  const in48h = admin.firestore.Timestamp.fromDate(
    new Date(now.getTime() + HOURS_48_MS)
  );

  functions.logger.info("[checkChampionshipDeadlines] Running", {
    now: now.toISOString(),
  });

  // Load all active championships
  const champSnap = await db
    .collection("championships")
    .where("status", "==", "active")
    .get();

  if (champSnap.empty) {
    functions.logger.info("[checkChampionshipDeadlines] No active championships");
    return;
  }

  let warningsSent = 0;

  for (const champDoc of champSnap.docs) {
    const championshipId = champDoc.id;

    // Query matches that are unplayed and deadline is within [now, now+48h]
    const matchSnap = await db
      .collection("championships")
      .doc(championshipId)
      .collection("matches")
      .where("status", "in", ["pending", "scheduled"])
      .where("deadline", ">=", nowTs)
      .where("deadline", "<=", in48h)
      .get();

    for (const matchDoc of matchSnap.docs) {
      const match = matchDoc.data();
      const matchId = matchDoc.id;

      // Idempotency: skip if warning was already sent
      if (match[WARNING_FLAG] === true) {
        functions.logger.info(
          "[checkChampionshipDeadlines] Warning already sent — skipping",
          { championshipId, matchId }
        );
        continue;
      }

      functions.logger.info(
        "[checkChampionshipDeadlines] Sending 48h warning",
        { championshipId, matchId, deadline: match.deadline?.toDate?.() }
      );

      // Load team members and names in parallel
      const [teamASnap, teamBSnap] = await Promise.all([
        db
          .collection("championships")
          .doc(championshipId)
          .collection("teams")
          .doc(match.teamAId)
          .get(),
        db
          .collection("championships")
          .doc(championshipId)
          .collection("teams")
          .doc(match.teamBId)
          .get(),
      ]);

      const teamAMembers: string[] = teamASnap.exists
        ? (teamASnap.data()?.memberIds ?? [])
        : [];
      const teamBMembers: string[] = teamBSnap.exists
        ? (teamBSnap.data()?.memberIds ?? [])
        : [];
      const teamAName: string = teamASnap.data()?.name ?? match.teamAId;
      const teamBName: string = teamBSnap.data()?.name ?? match.teamBId;

      // Send personalised notifications per team (opposing team name in body)
      await Promise.all([
        teamAMembers.length > 0
          ? sendChampionshipNotificationToUsers(db, teamAMembers, {
              title: "Match deadline in 48h ⚠️",
              body: `You have 48 hours to play your match vs ${teamBName}.`,
              data: {
                type: "championship_match",
                championshipId,
                matchId,
              },
            })
          : Promise.resolve(),
        teamBMembers.length > 0
          ? sendChampionshipNotificationToUsers(db, teamBMembers, {
              title: "Match deadline in 48h ⚠️",
              body: `You have 48 hours to play your match vs ${teamAName}.`,
              data: {
                type: "championship_match",
                championshipId,
                matchId,
              },
            })
          : Promise.resolve(),
      ]);

      // Mark as sent to avoid duplicate warnings on next daily run
      await matchDoc.ref.update({ [WARNING_FLAG]: true });
      warningsSent++;
    }
  }

  functions.logger.info("[checkChampionshipDeadlines] Done", {
    warningsSent,
    championshipsChecked: champSnap.size,
  });
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const checkChampionshipDeadlines = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 300, memory: "256MB" })
  .pubsub.schedule("every 24 hours")
  .timeZone("UTC")
  .onRun(async () => {
    const db = admin.firestore();
    await checkChampionshipDeadlinesHandler(db, new Date());
  });
