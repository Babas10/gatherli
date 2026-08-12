// Cloud Function: rejectMatchSchedule (Story 30.20).
// Called by the opposing team to reject a proposed schedule.
// Resets match status to 'pending', clears scheduledAt/location/scheduledByTeamId,
// and notifies the proposing team.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  sendChampionshipNotificationToUsers,
} from "./championshipNotifications";

interface RejectMatchScheduleRequest {
  championshipId: string;
  matchId: string;
}

interface RejectMatchScheduleResponse {
  matchId: string;
  status: "pending";
}

export async function rejectMatchScheduleHandler(
  data: RejectMatchScheduleRequest,
  context: functions.https.CallableContext
): Promise<RejectMatchScheduleResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to reject a schedule"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[rejectMatchSchedule] Start", {
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
      `Cannot reject a schedule for a match with status '${match.status}'`
    );
  }

  if (!match.scheduledByTeamId) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "No pending schedule proposal to reject"
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
      "Only members of the competing teams can reject a schedule"
    );
  }

  const myTeamId = isTeamAMember ? match.teamAId : match.teamBId;

  if (myTeamId === match.scheduledByTeamId) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "You cannot reject your own schedule proposal"
    );
  }

  // ── 6. Determine names for system message ─────────────────────────────────
  const rejectingTeamData = isTeamAMember ? teamASnap.data() : teamBSnap.data();
  const rejectingTeamName: string = rejectingTeamData?.name ?? "A team";

  // ── 7. Atomic write: reset to pending + add system message ─────────────────
  const batch = db.batch();

  batch.update(matchRef, {
    status: "pending",
    scheduledAt: admin.firestore.FieldValue.delete(),
    location: admin.firestore.FieldValue.delete(),
    scheduledByTeamId: admin.firestore.FieldValue.delete(),
  });

  const systemText = `${rejectingTeamName} rejected the proposed schedule. Please agree on a new time.`;

  const msgRef = matchRef.collection("messages").doc();
  batch.set(msgRef, {
    senderId: callerId,
    senderDisplayName: rejectingTeamName,
    teamId: null,
    text: systemText,
    sentAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  try {
    await batch.commit();
  } catch (err) {
    functions.logger.error("[rejectMatchSchedule] Write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to reject schedule. Please try again."
    );
  }

  // ── 8. Notify the proposing team ───────────────────────────────────────────
  const proposingTeamId = match.scheduledByTeamId as string;
  const proposingMembers: string[] =
    proposingTeamId === match.teamAId ? teamAMembers : teamBMembers;

  await sendChampionshipNotificationToUsers(db, proposingMembers, {
    title: "Schedule Rejected",
    body: `${rejectingTeamName} rejected your proposed schedule. Please agree on a new time.`,
    data: {
      type: "championship_match",
      championshipId: data.championshipId,
      matchId: data.matchId,
    },
  });

  functions.logger.info("[rejectMatchSchedule] Schedule rejected", {
    matchId: data.matchId,
    rejectedBy: callerId,
  });

  return { matchId: data.matchId, status: "pending" };
}

export const rejectMatchSchedule = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(rejectMatchScheduleHandler);
