// Cloud Function: editChampionship (Story 30.28).
// Admin-only callable — updates title and/or registrationDeadline while
// the championship is in registration or registration_closed status.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

interface EditChampionshipRequest {
  championshipId: string;
  title?: string;
  registrationDeadline?: string; // ISO 8601
}

interface EditChampionshipResponse {
  championshipId: string;
}

export async function editChampionshipHandler(
  data: EditChampionshipRequest,
  context: functions.https.CallableContext
): Promise<EditChampionshipResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to edit a championship"
    );
  }

  const uid = context.auth.uid;
  functions.logger.info("[editChampionship] Start", {
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

  const updates: Record<string, unknown> = {};

  if (data.title !== undefined) {
    const title = data.title.trim();
    if (title.length < 3) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Title must be at least 3 characters"
      );
    }
    if (title.length > 100) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Title must be less than 100 characters"
      );
    }
    updates.title = title;
  }

  if (data.registrationDeadline !== undefined) {
    const deadline = new Date(data.registrationDeadline);
    if (isNaN(deadline.getTime())) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "registrationDeadline must be a valid ISO 8601 date"
      );
    }
    if (deadline <= new Date()) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "registrationDeadline must be in the future"
      );
    }
    updates.registrationDeadline = admin.firestore.Timestamp.fromDate(deadline);
  }

  if (Object.keys(updates).length === 0) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "At least one of title or registrationDeadline must be provided"
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
      "Only the championship admin can edit it"
    );
  }

  // ── 5. Status check — only editable before championship goes active ────────
  const editableStatuses = ["registration", "registration_closed"];
  if (!editableStatuses.includes(champ.status)) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Championship cannot be edited in status '${champ.status}'`
    );
  }

  // ── 6. Apply updates ───────────────────────────────────────────────────────
  try {
    await champRef.update(updates);
  } catch (err) {
    functions.logger.error("[editChampionship] Write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to update championship. Please try again."
    );
  }

  functions.logger.info("[editChampionship] Championship updated", {
    championshipId: data.championshipId,
    uid,
    fields: Object.keys(updates),
  });

  return { championshipId: data.championshipId };
}

export const editChampionship = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onCall(withLogging('editChampionship', editChampionshipHandler));
