// Cloud Function to propose a match schedule (Story 30.5 / 30.11 / 30.20).
// Updates the match with scheduledAt/location/scheduledByTeamId, advances
// status to 'scheduled', adds a system message to the match coordination chat,
// and notifies the opposing team (Story 30.20).
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';
import {
  sendChampionshipNotificationToUsers,
} from "./championshipNotifications";

// ============================================================================
// Type Definitions
// ============================================================================

interface ProposeMatchScheduleRequest {
  championshipId: string;
  matchId: string;
  scheduledAt: string; // ISO 8601
  location?: string;
}

interface ProposeMatchScheduleResponse {
  matchId: string;
  status: "scheduled";
}

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function proposeMatchScheduleHandler(
  data: ProposeMatchScheduleRequest,
  context: functions.https.CallableContext
): Promise<ProposeMatchScheduleResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to propose a schedule"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[proposeMatchSchedule] Start", {
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
  if (!data?.scheduledAt) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: scheduledAt"
    );
  }

  const scheduledDate = new Date(data.scheduledAt);
  if (isNaN(scheduledDate.getTime())) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid scheduledAt — must be a valid ISO 8601 date string"
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

  // ── 4. Status Check ────────────────────────────────────────────────────────
  const schedulableStatuses = ["pending", "scheduled"];
  if (!schedulableStatuses.includes(match.status)) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Cannot propose a schedule for a match with status '${match.status}'`
    );
  }

  // ── 5. Permission Check ────────────────────────────────────────────────────
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
      "Only members of the competing teams can propose a schedule"
    );
  }

  const proposingTeamId = isTeamAMember ? match.teamAId : match.teamBId;
  const opposingTeamId = isTeamAMember ? match.teamBId : match.teamAId;
  const opposingMembers: string[] = isTeamAMember ? teamBMembers : teamAMembers;

  const proposingTeamData = isTeamAMember
    ? teamASnap.data()
    : teamBSnap.data();
  const teamName: string = proposingTeamData?.name ?? "A team";

  // ── 6. Build system message text ───────────────────────────────────────────
  const dateStr = scheduledDate.toLocaleDateString("en-GB", {
    day: "2-digit",
    month: "short",
    year: "numeric",
  });
  const timeStr = scheduledDate.toLocaleTimeString("en-GB", {
    hour: "2-digit",
    minute: "2-digit",
  });
  const locationStr = data.location ? ` · ${data.location}` : "";
  const systemText = `${teamName} proposed: ${dateStr} at ${timeStr}${locationStr}`;

  // ── 7. Atomic write: update match + add system message ─────────────────────
  const batch = db.batch();

  const updatePayload: Record<string, unknown> = {
    status: "scheduled",
    scheduledAt: admin.firestore.Timestamp.fromDate(scheduledDate),
    scheduledByTeamId: proposingTeamId,
  };
  if (data.location !== undefined && data.location !== null) {
    updatePayload.location = data.location;
  }
  batch.update(matchRef, updatePayload);

  const msgRef = matchRef.collection("messages").doc();
  batch.set(msgRef, {
    senderId: callerId,
    senderDisplayName: teamName,
    teamId: null,
    text: systemText,
    sentAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  try {
    await batch.commit();
  } catch (err) {
    functions.logger.error("[proposeMatchSchedule] Write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to save schedule. Please try again."
    );
  }

  // ── 8. Notify the opposing team ───────────────────────────────────────────
  // Resolve unused variable warning — opposingTeamId is intentionally stored
  // for potential future use but the notification uses the members list directly.
  void opposingTeamId;

  await sendChampionshipNotificationToUsers(db, opposingMembers, {
    title: "Schedule Proposed",
    body: `${teamName} proposed a match time. Accept or suggest another.`,
    data: {
      type: "championship_match",
      championshipId: data.championshipId,
      matchId: data.matchId,
    },
  });

  functions.logger.info("[proposeMatchSchedule] Schedule proposed", {
    matchId: data.matchId,
    scheduledAt: data.scheduledAt,
    proposedByTeam: teamName,
  });

  return { matchId: data.matchId, status: "scheduled" };
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const proposeMatchSchedule = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('proposeMatchSchedule', proposeMatchScheduleHandler));
