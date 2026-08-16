// Cloud Function: renameChampionshipTeam (Story 30.33).
// Allows the team captain to rename their team during the registration phase.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

interface RenameChampionshipTeamRequest {
  championshipId: string;
  teamId: string;
  newName: string;
}

interface RenameChampionshipTeamResponse {
  teamId: string;
}

export async function renameChampionshipTeamHandler(
  data: RenameChampionshipTeamRequest,
  context: functions.https.CallableContext
): Promise<RenameChampionshipTeamResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to rename a team"
    );
  }

  const uid = context.auth.uid;
  functions.logger.info("[renameChampionshipTeam] Start", {
    uid,
    championshipId: data?.championshipId,
    teamId: data?.teamId,
  });

  // ── 2. Input Validation ────────────────────────────────────────────────────
  if (!data?.championshipId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: championshipId"
    );
  }
  if (!data?.teamId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: teamId"
    );
  }
  if (!data?.newName?.trim()) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: newName"
    );
  }

  const newName = data.newName.trim();
  if (newName.length < 2) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Team name must be at least 2 characters"
    );
  }
  if (newName.length > 30) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Team name must be 30 characters or fewer"
    );
  }

  // ── 3. Load championship + team ───────────────────────────────────────────
  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);
  const teamRef = champRef.collection("teams").doc(data.teamId);

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

  // ── 4. Status check — registration phase only ──────────────────────────────
  if (champ.status !== "registration" && champ.status !== "registration_closed") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Team name can only be changed during the registration phase"
    );
  }

  // ── 5. Captain check ───────────────────────────────────────────────────────
  if (team.captainId !== uid) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only the team captain can rename the team"
    );
  }

  // ── 6. Write: update team name + standings name if it exists ──────────────
  const batch = db.batch();
  batch.update(teamRef, { name: newName });

  const standingsRef = champRef.collection("standings").doc(data.teamId);
  const standingsSnap = await standingsRef.get();
  if (standingsSnap.exists) {
    batch.update(standingsRef, { teamName: newName });
  }

  try {
    await batch.commit();
  } catch (err) {
    functions.logger.error("[renameChampionshipTeam] Write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to rename team. Please try again."
    );
  }

  functions.logger.info("[renameChampionshipTeam] Team renamed", {
    championshipId: data.championshipId,
    teamId: data.teamId,
    newName,
    uid,
  });

  return { teamId: data.teamId };
}

export const renameChampionshipTeam = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('renameChampionshipTeam', renameChampionshipTeamHandler));
