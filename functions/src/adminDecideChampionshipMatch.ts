// Cloud Function for admins to decide a match outcome when the deadline is exceeded
// or when a result is disputed (Story 30.12).
// Decisions: 'set_result' | 'award_walkover' | 'cancel'
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { SetInput, validateMatchResult, computeChampionshipPoints } from "./scoreValidation";
import { withLogging } from './utils/logger';

// ============================================================================
// Type Definitions
// ============================================================================

type AdminDecision = "set_result" | "award_walkover" | "cancel";

interface AdminDecideMatchRequest {
  championshipId: string;
  matchId: string;
  decision: AdminDecision;
  winnerId?: string;  // required for 'award_walkover'
  sets?: SetInput[];  // required for 'set_result'
  notes: string;      // always required
}

interface AdminDecideMatchResponse {
  matchId: string;
  decision: AdminDecision;
}

// Statuses that can be admin-decided
const ACTIONABLE_STATUSES = ["disputed", "pending", "scheduled", "played"];

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function adminDecideChampionshipMatchHandler(
  data: AdminDecideMatchRequest,
  context: functions.https.CallableContext
): Promise<AdminDecideMatchResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to decide a match"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[adminDecideChampionshipMatch] Start", {
    callerId,
    championshipId: data?.championshipId,
    matchId: data?.matchId,
    decision: data?.decision,
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

  if (!["set_result", "award_walkover", "cancel"].includes(data?.decision)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Field 'decision' must be 'set_result', 'award_walkover', or 'cancel'"
    );
  }

  if (!data?.notes?.trim()) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Admin notes are required for all decisions"
    );
  }

  if (data.decision === "set_result") {
    if (!Array.isArray(data?.sets) || data.sets.length === 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Field 'sets' is required when decision is 'set_result'"
      );
    }
    const scoreValidation = validateMatchResult(data.sets);
    if (!scoreValidation.valid) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        scoreValidation.error ?? "Invalid match result"
      );
    }
  }

  if (data.decision === "award_walkover") {
    if (!data?.winnerId?.trim()) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Field 'winnerId' is required when decision is 'award_walkover'"
      );
    }
  }

  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);
  const matchRef = champRef.collection("matches").doc(data.matchId);

  // ── 3. Load Championship & Match (parallel) ────────────────────────────────
  const [champSnap, matchSnap] = await Promise.all([
    champRef.get(),
    matchRef.get(),
  ]);

  if (!champSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Championship not found");
  }

  if (!matchSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Match not found");
  }

  const championship = champSnap.data()!;
  const match = matchSnap.data()!;

  // ── 4. Admin Permission Check ──────────────────────────────────────────────
  const adminIds: string[] = championship.adminIds ?? [];
  if (!adminIds.includes(callerId)) {
    functions.logger.warn("[adminDecideChampionshipMatch] Permission denied", {
      callerId,
      championshipId: data.championshipId,
    });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only championship admins can decide match outcomes"
    );
  }

  // ── 5. Status & Deadline Guard ────────────────────────────────────────────
  if (!ACTIONABLE_STATUSES.includes(match.status)) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Match cannot be admin-decided in status: ${match.status}`
    );
  }

  // Non-disputed matches require deadline to have passed
  if (match.status !== "disputed") {
    const deadline: admin.firestore.Timestamp = match.deadline;
    const now = admin.firestore.Timestamp.now();
    if (deadline.seconds > now.seconds) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Match deadline has not yet passed — admin decisions are only allowed after the deadline"
      );
    }
  }

  // ── 6. Validate winnerId for walkover ──────────────────────────────────────
  if (data.decision === "award_walkover") {
    if (data.winnerId !== match.teamAId && data.winnerId !== match.teamBId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "winnerId must be one of the match teams"
      );
    }
  }

  // ── 7. Build result payload ────────────────────────────────────────────────
  let resultPayload: Record<string, unknown> | null = null;

  if (data.decision === "set_result") {
    const { teamAPoints, teamBPoints, winner } = computeChampionshipPoints(data.sets!);
    resultPayload = {
      sets: data.sets,
      winner,
      teamAPoints,
      teamBPoints,
    };
  } else if (data.decision === "award_walkover") {
    const winnerIsTeamA = data.winnerId === match.teamAId;
    // Synthetic 2-0 walkover: 21-0, 21-0
    resultPayload = {
      sets: [
        { setNumber: 1, teamAPoints: winnerIsTeamA ? 21 : 0, teamBPoints: winnerIsTeamA ? 0 : 21 },
        { setNumber: 2, teamAPoints: winnerIsTeamA ? 21 : 0, teamBPoints: winnerIsTeamA ? 0 : 21 },
      ],
      winner: winnerIsTeamA ? "teamA" : "teamB",
      teamAPoints: winnerIsTeamA ? 3 : 0,
      teamBPoints: winnerIsTeamA ? 0 : 3,
    };
  }
  // 'cancel' → no result

  // ── 8. Write Decision ──────────────────────────────────────────────────────
  const adminDecisionPayload: Record<string, unknown> = {
    decidedBy: callerId,
    notes: data.notes.trim(),
    decidedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  const update: Record<string, unknown> = {
    status: "admin_decided",
    adminDecision: adminDecisionPayload,
  };

  if (resultPayload !== null) {
    update.result = resultPayload;
  }

  try {
    await matchRef.update(update);
  } catch (err) {
    functions.logger.error("[adminDecideChampionshipMatch] Write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to save admin decision. Please try again."
    );
  }

  functions.logger.info("[adminDecideChampionshipMatch] Decision applied", {
    matchId: data.matchId,
    decision: data.decision,
    decidedBy: callerId,
  });

  return { matchId: data.matchId, decision: data.decision };
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const adminDecideChampionshipMatch = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('adminDecideChampionshipMatch', adminDecideChampionshipMatchHandler));
