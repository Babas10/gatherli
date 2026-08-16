// Cloud Function to leave / delete a team from a championship (Story 30.3)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

// ============================================================================
// Type Definitions
// ============================================================================

interface LeaveChampionshipTeamRequest {
  championshipId: string;
  teamId: string;
}

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function leaveChampionshipTeamHandler(
  data: LeaveChampionshipTeamRequest,
  context: functions.https.CallableContext
): Promise<{ success: boolean }> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to leave a team"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[leaveChampionshipTeam] Start", {
    callerId,
    championshipId: data?.championshipId,
    teamId: data?.teamId,
  });

  // ── 2. Input Validation ────────────────────────────────────────────────────
  if (!data?.championshipId || !data?.teamId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: championshipId, teamId"
    );
  }

  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);
  const teamRef = champRef.collection("teams").doc(data.teamId);

  // ── 3. Championship & Team Validation ─────────────────────────────────────
  const [champSnap, teamSnap] = await Promise.all([
    champRef.get(),
    teamRef.get(),
  ]);

  if (!champSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Championship not found");
  }

  if (!teamSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Team not found");
  }

  const champ = champSnap.data()!;
  const team = teamSnap.data()!;

  if (champ.status !== "registration" && champ.status !== "registration_closed") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "You can only leave a team during the registration phase"
    );
  }

  if (!team.memberIds?.includes(callerId)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You are not a member of this team"
    );
  }

  // ── 4. Delete Team (atomic transaction) ────────────────────────────────────
  try {
    await db.runTransaction(async (tx) => {
      const champData = (await tx.get(champRef)).data()!;
      const newTeamsCount = Math.max(0, champData.teamsCount - 1);
      const newStatus = "registration"; // Always reopen on team removal

      tx.delete(teamRef);
      tx.update(champRef, {
        teamsCount: newTeamsCount,
        status: newStatus,
      });
    });
  } catch (error) {
    if (error instanceof functions.https.HttpsError) throw error;
    functions.logger.error("[leaveChampionshipTeam] Transaction failed", {
      callerId,
      error,
    });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to leave team. Please try again."
    );
  }

  functions.logger.info("[leaveChampionshipTeam] Team removed", {
    teamId: data.teamId,
    callerId,
    championshipId: data.championshipId,
  });

  return { success: true };
}

export const leaveChampionshipTeam = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('leaveChampionshipTeam', leaveChampionshipTeamHandler));
