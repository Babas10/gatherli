// Cloud Function to register a 2-person team in a championship (Story 30.3)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { checkFriendship } from "./friendships";

// ============================================================================
// Type Definitions
// ============================================================================

interface CreateChampionshipTeamRequest {
  championshipId: string;
  teamName: string;
  partnerId: string;
}

interface CreateChampionshipTeamResponse {
  teamId: string;
}

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function createChampionshipTeamHandler(
  data: CreateChampionshipTeamRequest,
  context: functions.https.CallableContext
): Promise<CreateChampionshipTeamResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to register a team"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[createChampionshipTeam] Start", {
    callerId,
    championshipId: data?.championshipId,
  });

  // ── 2. Input Validation ────────────────────────────────────────────────────
  if (!data?.championshipId || !data?.teamName?.trim() || !data?.partnerId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: championshipId, teamName, partnerId"
    );
  }

  if (data.teamName.trim().length < 2) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Team name must be at least 2 characters"
    );
  }

  if (data.teamName.trim().length > 50) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Team name must be at most 50 characters"
    );
  }

  if (data.partnerId === callerId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "You cannot invite yourself as a partner"
    );
  }

  const db = admin.firestore();

  // ── 3. Championship Validation ─────────────────────────────────────────────
  const champDoc = await db.collection("championships").doc(data.championshipId).get();
  if (!champDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Championship not found");
  }

  const champ = champDoc.data()!;
  if (champ.status !== "registration") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Championship is not accepting registrations"
    );
  }

  if (champ.teamsCount >= champ.maxTeams) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Championship is full"
    );
  }

  // ── 4. Friendship Check ────────────────────────────────────────────────────
  const areFriends = await checkFriendship(callerId, data.partnerId);
  if (!areFriends) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only invite friends as your partner"
    );
  }

  // ── 5. Duplicate Membership Check ─────────────────────────────────────────
  // Check if caller or partner is already in a team in this championship.
  const teamsRef = db
    .collection("championships")
    .doc(data.championshipId)
    .collection("teams");

  const [callerTeams, partnerTeams] = await Promise.all([
    teamsRef.where("memberIds", "array-contains", callerId).limit(1).get(),
    teamsRef.where("memberIds", "array-contains", data.partnerId).limit(1).get(),
  ]);

  if (!callerTeams.empty) {
    throw new functions.https.HttpsError(
      "already-exists",
      "You are already registered in a team for this championship"
    );
  }

  if (!partnerTeams.empty) {
    throw new functions.https.HttpsError(
      "already-exists",
      "Your partner is already registered in a team for this championship"
    );
  }

  // ── 6. Create Team (atomic transaction) ────────────────────────────────────
  let teamId: string;

  try {
    const teamRef = teamsRef.doc();
    teamId = teamRef.id;

    await db.runTransaction(async (tx) => {
      // Re-read championship inside transaction to prevent TOCTOU races
      const champSnap = await tx.get(champDoc.ref);
      const champData = champSnap.data()!;

      if (champData.status !== "registration") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Championship is no longer accepting registrations"
        );
      }
      if (champData.teamsCount >= champData.maxTeams) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Championship is full"
        );
      }

      const newTeamsCount = champData.teamsCount + 1;
      const newStatus =
        newTeamsCount >= champData.maxTeams ? "registration_closed" : "registration";

      tx.set(teamRef, {
        name: data.teamName.trim(),
        captainId: callerId,
        memberIds: [callerId, data.partnerId],
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      tx.update(champDoc.ref, {
        teamsCount: newTeamsCount,
        status: newStatus,
      });
    });
  } catch (error) {
    if (error instanceof functions.https.HttpsError) throw error;
    functions.logger.error("[createChampionshipTeam] Transaction failed", {
      callerId,
      error,
    });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to create team. Please try again."
    );
  }

  functions.logger.info("[createChampionshipTeam] Team created", {
    teamId,
    callerId,
    championshipId: data.championshipId,
  });

  return { teamId };
}

export const createChampionshipTeam = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(createChampionshipTeamHandler);
