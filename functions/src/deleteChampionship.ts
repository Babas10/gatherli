// Cloud Function: deleteChampionship.
// Admin-only callable — permanently deletes a championship and its registered
// teams while it is still in registration or registration_closed status
// (i.e. before startChampionship has generated matches/standings).
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

interface DeleteChampionshipRequest {
  championshipId: string;
}

interface DeleteChampionshipResponse {
  championshipId: string;
}

export async function deleteChampionshipHandler(
  data: DeleteChampionshipRequest,
  context: functions.https.CallableContext
): Promise<DeleteChampionshipResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to delete a championship"
    );
  }

  const uid = context.auth.uid;
  functions.logger.info("[deleteChampionship] Start", {
    uid,
    championshipId: data?.championshipId,
  });

  // ── 2. Input Validation ────────────────────────────────────────────────────
  if (!data?.championshipId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: championshipId"
    );
  }

  // ── 3. Load Championship ───────────────────────────────────────────────────
  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);
  const champSnap = await champRef.get();

  if (!champSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Championship not found");
  }

  const champ = champSnap.data()!;

  // ── 4. Admin check ─────────────────────────────────────────────────────────
  const adminIds: string[] = champ.adminIds ?? [];
  if (!adminIds.includes(uid)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only the championship admin can delete it"
    );
  }

  // ── 5. Status check — only deletable before championship goes active ───────
  const deletableStatuses = ["registration", "registration_closed"];
  if (!deletableStatuses.includes(champ.status)) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Championship cannot be deleted in status '${champ.status}'`
    );
  }

  // ── 6. Delete championship + registered teams ───────────────────────────────
  // matches/standings subcollections only get created by startChampionship,
  // which is unreachable at this status, so only "teams" can have docs.
  try {
    const teamsSnap = await champRef.collection("teams").get();
    const batch = db.batch();
    teamsSnap.docs.forEach((doc) => batch.delete(doc.ref));
    batch.delete(champRef);
    await batch.commit();
  } catch (err) {
    functions.logger.error("[deleteChampionship] Delete failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to delete championship. Please try again."
    );
  }

  functions.logger.info("[deleteChampionship] Championship deleted", {
    championshipId: data.championshipId,
    uid,
  });

  return { championshipId: data.championshipId };
}

export const deleteChampionship = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('deleteChampionship', deleteChampionshipHandler));
