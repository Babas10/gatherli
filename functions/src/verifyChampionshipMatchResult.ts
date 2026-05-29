// Cloud Function for the opposing team to verify or dispute a submitted match result (Story 30.7).
// On 'verify': sets status to 'verified' → triggers standings update (Story 30.8).
// On 'dispute': sets status to 'disputed' → requires admin resolution (Story 30.12).
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// ============================================================================
// Type Definitions
// ============================================================================

type VerificationAction = "verify" | "dispute";

interface VerifyMatchResultRequest {
  championshipId: string;
  matchId: string;
  action: VerificationAction;
  disputeReason?: string;
}

interface VerifyMatchResultResponse {
  status: "verified" | "disputed";
}

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function verifyChampionshipMatchResultHandler(
  data: VerifyMatchResultRequest,
  context: functions.https.CallableContext
): Promise<VerifyMatchResultResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to verify a match result"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[verifyChampionshipMatchResult] Start", {
    callerId,
    championshipId: data?.championshipId,
    matchId: data?.matchId,
    action: data?.action,
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

  if (data?.action !== "verify" && data?.action !== "dispute") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Field 'action' must be 'verify' or 'dispute'"
    );
  }

  if (data.action === "dispute") {
    if (!data.disputeReason?.trim()) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "A dispute reason is required when disputing a result"
      );
    }
  }

  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);
  const matchRef = champRef.collection("matches").doc(data.matchId);

  // ── 3. Load Match ──────────────────────────────────────────────────────────
  const matchSnap = await matchRef.get();
  if (!matchSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Match not found");
  }

  const match = matchSnap.data()!;

  // ── 4. Status Check: must be 'played' ─────────────────────────────────────
  if (match.status !== "played") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Match must be in 'played' status to verify (current: ${match.status})`
    );
  }

  // ── 5. Permission Check: caller must be in the opposing team ──────────────
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
    functions.logger.warn("[verifyChampionshipMatchResult] Not a team member", {
      callerId,
    });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only members of the competing teams can verify a result"
    );
  }

  // Caller must be from the team that did NOT submit the result
  const callerTeamId = isTeamAMember ? match.teamAId : match.teamBId;
  if (callerTeamId === match.submittedByTeamId) {
    functions.logger.warn(
      "[verifyChampionshipMatchResult] Submitting team cannot verify",
      { callerId, submittedByTeamId: match.submittedByTeamId }
    );
    throw new functions.https.HttpsError(
      "permission-denied",
      "The team that submitted the result cannot verify it"
    );
  }

  // ── 6. Write Verification / Dispute ───────────────────────────────────────
  try {
    if (data.action === "verify") {
      await matchRef.update({
        status: "verified",
        verifiedByTeamId: callerTeamId,
        verifiedByUserId: callerId,
        verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      functions.logger.info("[verifyChampionshipMatchResult] Verified", {
        matchId: data.matchId,
        verifiedByTeamId: callerTeamId,
      });

      return { status: "verified" };
    } else {
      await matchRef.update({
        status: "disputed",
        disputeReason: data.disputeReason!.trim(),
      });

      functions.logger.info("[verifyChampionshipMatchResult] Disputed", {
        matchId: data.matchId,
        disputeReason: data.disputeReason,
      });

      return { status: "disputed" };
    }
  } catch (err) {
    functions.logger.error("[verifyChampionshipMatchResult] Write failed", {
      err,
    });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to update match result. Please try again."
    );
  }
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const verifyChampionshipMatchResult = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(verifyChampionshipMatchResultHandler);
