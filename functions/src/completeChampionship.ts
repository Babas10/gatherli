// Cloud Function to manually mark a championship as completed — admin-only (Story 30.16)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { sendChampionshipNotificationToUsers } from "./championshipNotifications";

interface CompleteChampionshipRequest {
  championshipId: string;
}

interface CompleteChampionshipResponse {
  status: "completed";
}

export async function completeChampionshipHandler(
  data: CompleteChampionshipRequest,
  context: functions.https.CallableContext
): Promise<CompleteChampionshipResponse> {
  // ── 1. Auth ──────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to perform this action."
    );
  }
  const uid = context.auth.uid;

  // ── 2. Validate input ────────────────────────────────────────────────────
  if (!data?.championshipId || typeof data.championshipId !== "string") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "championshipId is required."
    );
  }

  functions.logger.info("completeChampionship called", {
    uid,
    championshipId: data.championshipId,
  });

  const db = admin.firestore();

  // ── 3. Fetch championship ─────────────────────────────────────────────────
  const champRef = db.collection("championships").doc(data.championshipId);
  const champSnap = await champRef.get();
  if (!champSnap.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "Championship not found."
    );
  }

  const champ = champSnap.data()!;

  // ── 4. Check admin permission — only the championship creator/admin ────────
  const adminIds: string[] = champ.adminIds ?? [];
  if (!adminIds.includes(uid)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only the championship admin can complete it."
    );
  }

  if (champ.status !== "active") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Championship must be active to be completed (current status: ${champ.status}).`
    );
  }

  // ── 5. Determine champion (team at position 1 in standings) ───────────────
  const standingsSnap = await db
    .collection("championships")
    .doc(data.championshipId)
    .collection("standings")
    .orderBy("position")
    .limit(1)
    .get();

  const championTeamId = standingsSnap.empty
    ? null
    : standingsSnap.docs[0].id;

  // ── 6. Update championship status ─────────────────────────────────────────
  await champRef.update({
    status: "completed",
    championTeamId: championTeamId ?? admin.firestore.FieldValue.delete(),
    completedAt: admin.firestore.FieldValue.serverTimestamp(),
    completedBy: uid,
  });

  functions.logger.info("Championship completed", {
    championshipId: data.championshipId,
    championTeamId,
    uid,
  });

  // ── 7. Notify all registered teams (non-fatal) ─────────────────────────────
  try {
    const teamsSnap = await champRef.collection("teams").get();
    for (const teamDoc of teamsSnap.docs) {
      const memberIds: string[] = teamDoc.data().memberIds ?? [];
      if (memberIds.length === 0) continue;

      const isChampion = teamDoc.id === championTeamId;
      await sendChampionshipNotificationToUsers(db, memberIds, {
        title: isChampion ? "🏆 You are champions!" : "Championship complete",
        body: isChampion
          ? "Congratulations! You won the championship. Check the final standings."
          : "The championship has ended. See the final standings.",
        data: {
          type: "championship",
          championshipId: data.championshipId,
        },
      });
    }
  } catch (notifErr) {
    // Non-fatal — completion is already recorded.
    functions.logger.error("completeChampionship: notification failed (non-fatal)", {
      notifErr,
      championshipId: data.championshipId,
    });
  }

  return { status: "completed" };
}

export const completeChampionship = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(completeChampionshipHandler);
