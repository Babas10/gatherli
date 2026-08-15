// Cloud Function: confirmMatchSchedule (Story 30.20).
// Called by the opposing team to accept a proposed schedule.
// Clears scheduledByTeamId (marks schedule as confirmed) and notifies proposer.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

interface ConfirmMatchScheduleRequest {
  championshipId: string;
  matchId: string;
}

interface ConfirmMatchScheduleResponse {
  matchId: string;
  status: "confirmed";
}

export async function confirmMatchScheduleHandler(
  data: ConfirmMatchScheduleRequest,
  context: functions.https.CallableContext
): Promise<ConfirmMatchScheduleResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to confirm a schedule"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[confirmMatchSchedule] Start", {
    callerId,
    championshipId: data?.championshipId,
    matchId: data?.matchId,
  });

  // ── 2. Input Validation ────────────────────────────────────────────────────
  if (!data?.championshipId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: championshipId"
    );
  }
  if (!data?.matchId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: matchId"
    );
  }

  // ── 3. Load Match ──────────────────────────────────────────────────────────
  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);
  const matchRef = champRef.collection("matches").doc(data.matchId);

  const matchSnap = await matchRef.get();
  if (!matchSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Match not found");
  }

  const match = matchSnap.data()!;

  // ── 4. Status / State Check ────────────────────────────────────────────────
  if (match.status !== "scheduled") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Cannot confirm a schedule for a match with status '${match.status}'`
    );
  }

  if (!match.scheduledByTeamId) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "No pending schedule proposal to confirm"
    );
  }

  // ── 5. Permission Check — caller must be the OPPOSING team ─────────────────
  const [teamASnap, teamBSnap] = await Promise.all([
    champRef.collection("teams").doc(match.teamAId).get(),
    champRef.collection("teams").doc(match.teamBId).get(),
  ]);

  const teamAMembers: string[] = teamASnap.exists
    ? (teamASnap.data()?.memberIds ?? [])
    : [];
  const teamBMembers: string[] = teamBSnap.exists
    ? (teamBSnap.data()?.memberIds ?? [])
    : [];

  const isTeamAMember = teamAMembers.includes(callerId);
  const isTeamBMember = teamBMembers.includes(callerId);

  if (!isTeamAMember && !isTeamBMember) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only members of the competing teams can confirm a schedule"
    );
  }

  const myTeamId = isTeamAMember ? match.teamAId : match.teamBId;

  if (myTeamId === match.scheduledByTeamId) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "You cannot confirm your own schedule proposal"
    );
  }

  // ── 6. Determine names for system message ─────────────────────────────────
  const confirmingTeamData = isTeamAMember
    ? teamASnap.data()
    : teamBSnap.data();
  const confirmingTeamName: string = confirmingTeamData?.name ?? "A team";

  // ── 7. Atomic write: clear scheduledByTeamId + add system message ──────────
  const batch = db.batch();

  batch.update(matchRef, {
    scheduledByTeamId: admin.firestore.FieldValue.delete(),
  });

  const scheduledAt: admin.firestore.Timestamp | null =
    match.scheduledAt ?? null;
  const dateStr = scheduledAt
    ? scheduledAt.toDate().toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "short",
        year: "numeric",
      })
    : "";
  const timeStr = scheduledAt
    ? scheduledAt.toDate().toLocaleTimeString("en-GB", {
        hour: "2-digit",
        minute: "2-digit",
      })
    : "";

  const systemText = `${confirmingTeamName} confirmed the schedule: ${dateStr} at ${timeStr}`;

  const msgRef = matchRef.collection("messages").doc();
  batch.set(msgRef, {
    senderId: callerId,
    senderDisplayName: confirmingTeamName,
    teamId: null,
    text: systemText,
    sentAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  try {
    await batch.commit();
  } catch (err) {
    functions.logger.error("[confirmMatchSchedule] Write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to confirm schedule. Please try again."
    );
  }

  // Schedule confirmed notification removed — the proposing team sees the
  // confirmed date the next time they open the match. Not worth a push.

  functions.logger.info("[confirmMatchSchedule] Schedule confirmed", {
    matchId: data.matchId,
    confirmedBy: callerId,
  });

  return { matchId: data.matchId, status: "confirmed" };
}

export const confirmMatchSchedule = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('confirmMatchSchedule', confirmMatchScheduleHandler));
