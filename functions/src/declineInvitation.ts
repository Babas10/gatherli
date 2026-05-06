// Dual-aware declineInvitation — Story 31.6
// Tries the unified top-level `invitations/{id}` collection first; falls back
// to the legacy `users/{userId}/invitations/{id}` subcollection for backward
// compatibility with invitations created before the migration.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Request interface for declineInvitation Cloud Function
 */
export interface DeclineInvitationRequest {
  invitationId: string;
}

/**
 * Response interface for declineInvitation Cloud Function
 */
export interface DeclineInvitationResponse {
  success: boolean;
  message: string;
}

/**
 * Handler function for declining invitations (exported for testing)
 */
export async function declineInvitationHandler(
  data: DeclineInvitationRequest,
  context: functions.https.CallableContext
): Promise<DeclineInvitationResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated to decline invitations"
    );
  }

  const userId = context.auth.uid;
  const {invitationId} = data;

  if (!invitationId || typeof invitationId !== "string") {
    functions.logger.warn("[declineInvitation] Missing invitationId", {userId});
    throw new functions.https.HttpsError(
      "invalid-argument",
      "invitationId is required and must be a string"
    );
  }

  functions.logger.info("[declineInvitation] Start", {userId, invitationId});

  const db = admin.firestore();

  try {
    // ── 1. Locate the invitation (new collection first, then legacy) ─────────
    const topLevelRef = db.collection("invitations").doc(invitationId);
    const topLevelDoc = await topLevelRef.get();

    const isNewStyle = topLevelDoc.exists;
    const invitationRef = isNewStyle
      ? topLevelRef
      : db.collection("users").doc(userId).collection("invitations").doc(invitationId);

    const invitationDoc = isNewStyle ? topLevelDoc : await invitationRef.get();

    functions.logger.debug("[declineInvitation] Lookup", {
      userId,
      invitationId,
      isNewStyle,
      exists: invitationDoc.exists,
    });

    if (!invitationDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Invitation not found");
    }

    const invitationData = invitationDoc.data()!;

    // ── 2. Basic validations ─────────────────────────────────────────────────
    if (invitationData.status !== "pending") {
      functions.logger.warn("[declineInvitation] Not pending", {
        userId,
        invitationId,
        currentStatus: invitationData.status,
      });
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Invitation is not pending"
      );
    }

    if (invitationData.invitedUserId !== userId) {
      functions.logger.warn("[declineInvitation] Ownership mismatch", {
        userId,
        invitationId,
        invitedUserId: invitationData.invitedUserId,
      });
      throw new functions.https.HttpsError(
        "permission-denied",
        "This invitation is not for you"
      );
    }

    // ── 3. Update status ─────────────────────────────────────────────────────
    const invType: string = invitationData.type ?? "group";

    await invitationRef.update({
      status: "declined",
      respondedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // For game invitations, remove user from pendingInviteeIds on the game doc
    if (invType === "game" && invitationData.gameId) {
      try {
        await db.collection("games").doc(invitationData.gameId).update({
          pendingInviteeIds: admin.firestore.FieldValue.arrayRemove(userId),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (e) {
        // Non-fatal: game may have already been deleted
        functions.logger.warn("[declineInvitation] Could not update game pendingInviteeIds", {
          userId,
          gameId: invitationData.gameId,
          error: e instanceof Error ? e.message : String(e),
        });
      }
    }

    functions.logger.info("[declineInvitation] Declined successfully", {
      userId,
      invitationId,
      type: invType,
    });

    const contextLabel =
      invType === "game"
        ? "game invitation"
        : `invitation to ${invitationData.groupName ?? "the group"}`;

    return {
      success: true,
      message: `Declined ${contextLabel}`,
    };
  } catch (error) {
    if (error instanceof functions.https.HttpsError) throw error;
    functions.logger.error("[declineInvitation] Unexpected error", {
      userId,
      invitationId,
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });
    throw new functions.https.HttpsError("internal", "Failed to decline invitation");
  }
}

/**
 * Cloud Function to securely decline a group or game invitation.
 *
 * Dual-aware: checks the unified `invitations` collection first, then falls
 * back to the legacy `users/{userId}/invitations` subcollection.
 * For game invitations, also removes the user from `pendingInviteeIds` on the game.
 */
export const declineInvitation = functions
  .region("europe-west6")
  .https.onCall(declineInvitationHandler);
