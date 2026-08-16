// Cloud Function to submit a championship match result by one team (Story 30.6).
// Result is stored pending verification by the opposing team (Story 30.7).
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { SetInput, validateMatchResult, computeChampionshipPoints } from "./scoreValidation";
import { withLogging } from './utils/logger';

// ============================================================================
// Type Definitions
// ============================================================================

interface SubmitMatchResultRequest {
  championshipId: string;
  matchId: string;
  sets: SetInput[];
}

interface SubmitMatchResultResponse {
  matchId: string;
  pendingVerification: true;
}

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function submitChampionshipMatchResultHandler(
  data: SubmitMatchResultRequest,
  context: functions.https.CallableContext
): Promise<SubmitMatchResultResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to submit a match result"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[submitChampionshipMatchResult] Start", {
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

  if (!Array.isArray(data?.sets) || data.sets.length === 0) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: sets"
    );
  }

  // ── 3. Validate Set Scores ─────────────────────────────────────────────────
  const scoreValidation = validateMatchResult(data.sets);
  if (!scoreValidation.valid) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      scoreValidation.error ?? "Invalid match result"
    );
  }

  const db = admin.firestore();
  const matchRef = db
    .collection("championships")
    .doc(data.championshipId)
    .collection("matches")
    .doc(data.matchId);

  // ── 4. Load Match ──────────────────────────────────────────────────────────
  const matchSnap = await matchRef.get();
  if (!matchSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Match not found");
  }

  const match = matchSnap.data()!;

  // ── 5. Status Check ────────────────────────────────────────────────────────
  const submittableStatuses = ["pending", "scheduled"];
  if (!submittableStatuses.includes(match.status)) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Match already has a result (status: ${match.status})`
    );
  }

  // ── 6. Permission Check: caller must be in teamA or teamB ─────────────────
  const champRef = db.collection("championships").doc(data.championshipId);
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
    functions.logger.warn("[submitChampionshipMatchResult] Permission denied", {
      callerId,
      matchId: data.matchId,
    });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only members of the competing teams can submit a result"
    );
  }

  const submittedByTeamId = isTeamAMember ? match.teamAId : match.teamBId;

  // ── 7. Compute Result ──────────────────────────────────────────────────────
  const { teamAPoints, teamBPoints, winner } = computeChampionshipPoints(data.sets);

  // ── 8. Write Result ────────────────────────────────────────────────────────
  try {
    await matchRef.update({
      status: "played",
      result: {
        sets: data.sets,
        winner,
        teamAPoints,
        teamBPoints,
      },
      submittedByTeamId,
      submittedByUserId: callerId,
    });
  } catch (err) {
    functions.logger.error("[submitChampionshipMatchResult] Write failed", {
      err,
    });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to save match result. Please try again."
    );
  }

  functions.logger.info("[submitChampionshipMatchResult] Result submitted", {
    matchId: data.matchId,
    winner,
    teamAPoints,
    teamBPoints,
    submittedByTeamId,
  });

  return { matchId: data.matchId, pendingVerification: true };
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const submitChampionshipMatchResult = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('submitChampionshipMatchResult', submitChampionshipMatchResultHandler));
