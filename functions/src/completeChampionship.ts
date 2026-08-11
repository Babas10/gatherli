// Cloud Function to manually mark a championship as completed — admin-only (Story 30.16)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface CompleteChampionshipRequest {
  championshipId: string;
}

interface CompleteChampionshipResponse {
  status: "completed";
}

export async function completeChampionshipHandler(
  data: CompleteChampionshipRequest,
  context: functions.https.CallableContext
): Promise<CompleteChampionshipResponse> {
  // ── 1. Auth ──────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to perform this action."
    );
  }
  const uid = context.auth.uid;

  // ── 2. Validate input ────────────────────────────────────────────────────
  if (!data?.championshipId || typeof data.championshipId !== "string") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "championshipId is required."
    );
  }

  functions.logger.info("completeChampionship called", {
    uid,
    championshipId: data.championshipId,
  });

  const db = admin.firestore();

  // ── 3. Check admin permission ─────────────────────────────────────────────
  const adminDoc = await db.collection("platform_admins").doc(uid).get();
  if (!adminDoc.exists) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only platform admins can complete a championship."
    );
  }

  // ── 4. Fetch championship ─────────────────────────────────────────────────
  const champRef = db.collection("championships").doc(data.championshipId);
  const champSnap = await champRef.get();
  if (!champSnap.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "Championship not found."
    );
  }

  const champ = champSnap.data()!;
  if (champ.status !== "active") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Championship must be active to be completed (current status: ${champ.status}).`
    );
  }

  // ── 5. Determine champion (team at position 1 in standings) ───────────────
  const standingsSnap = await db
    .collection("championships")
    .doc(data.championshipId)
    .collection("standings")
    .orderBy("position")
    .limit(1)
    .get();

  const championTeamId = standingsSnap.empty
    ? null
    : standingsSnap.docs[0].id;

  // ── 6. Update championship status ─────────────────────────────────────────
  await champRef.update({
    status: "completed",
    championTeamId: championTeamId ?? admin.firestore.FieldValue.delete(),
    completedAt: admin.firestore.FieldValue.serverTimestamp(),
    completedBy: uid,
  });

  functions.logger.info("Championship completed", {
    championshipId: data.championshipId,
    championTeamId,
    uid,
  });

  return { status: "completed" };
}

export const completeChampionship = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(completeChampionshipHandler);
