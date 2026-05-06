// Dual-aware acceptInvitation — Story 31.6
// Tries the unified top-level `invitations/{id}` collection first; falls back
// to the legacy `users/{userId}/invitations/{id}` subcollection for backward
// compatibility with invitations created before the migration.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {checkFriendship} from "./friendships";

/**
 * Request interface for acceptInvitation Cloud Function
 */
export interface AcceptInvitationRequest {
  invitationId: string;
}

/**
 * Response interface for acceptInvitation Cloud Function
 */
export interface AcceptInvitationResponse {
  success: boolean;
  groupId: string;
  message: string;
}

/**
 * Handler function for accepting invitations (exported for testing)
 */
export async function acceptInvitationHandler(
  data: AcceptInvitationRequest,
  context: functions.https.CallableContext
): Promise<AcceptInvitationResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated to accept invitations"
    );
  }

  const userId = context.auth.uid;
  const {invitationId} = data;

  functions.logger.info("[acceptInvitation] Start", {userId, invitationId});

  if (!invitationId || typeof invitationId !== "string") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "invitationId is required and must be a string"
    );
  }

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

    functions.logger.debug("[acceptInvitation] Lookup", {
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
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Invitation is not pending"
      );
    }

    if (invitationData.invitedUserId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "This invitation is not for you"
      );
    }

    // ── 3. Type-dispatched acceptance ────────────────────────────────────────
    const invType: string = invitationData.type ?? "group"; // old-style defaults to group

    if (invType === "game") {
      return await acceptGameInvitation(
        db,
        userId,
        invitationId,
        invitationRef,
        invitationData
      );
    }

    // Default: group invitation (covers both new-style type='group' and old-style)
    return await acceptGroupInvitation(
      db,
      userId,
      invitationId,
      invitationRef,
      invitationData
    );
  } catch (error) {
    if (error instanceof functions.https.HttpsError) throw error;
    functions.logger.error("[acceptInvitation] Unexpected error", {
      userId,
      invitationId,
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });
    throw new functions.https.HttpsError("internal", "Failed to accept invitation");
  }
}

// ── Group acceptance ──────────────────────────────────────────────────────────

async function acceptGroupInvitation(
  db: admin.firestore.Firestore,
  userId: string,
  invitationId: string,
  invitationRef: admin.firestore.DocumentReference,
  invitationData: admin.firestore.DocumentData
): Promise<AcceptInvitationResponse> {
  // Friendship re-validation (Story 11.4)
  const inviterId = invitationData.invitedBy;
  const areFriends = await checkFriendship(inviterId, userId);
  if (!areFriends) {
    functions.logger.warn("[acceptInvitation] Not friends", {userId, inviterId, invitationId});
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only accept invitations from friends. Please add them as a friend first."
    );
  }

  const groupId = invitationData.groupId;
  const groupRef = db.collection("groups").doc(groupId);

  const groupDoc = await groupRef.get();
  if (!groupDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "The group for this invitation no longer exists"
    );
  }

  await db.runTransaction(async (tx) => {
    const currentInv = await tx.get(invitationRef);
    if (!currentInv.exists || currentInv.data()?.status !== "pending") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Invitation is no longer pending"
      );
    }
    const currentGroup = await tx.get(groupRef);
    if (!currentGroup.exists) {
      throw new functions.https.HttpsError("not-found", "Group no longer exists");
    }

    tx.update(invitationRef, {
      status: "accepted",
      respondedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    tx.update(groupRef, {
      memberIds: admin.firestore.FieldValue.arrayUnion(userId),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      lastActivity: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  functions.logger.info("[acceptInvitation] Group invitation accepted", {
    userId,
    invitationId,
    groupId,
  });

  return {
    success: true,
    groupId,
    message: `Successfully joined ${invitationData.groupName ?? "the group"}`,
  };
}

// ── Game acceptance ───────────────────────────────────────────────────────────

async function acceptGameInvitation(
  db: admin.firestore.Firestore,
  userId: string,
  invitationId: string,
  invitationRef: admin.firestore.DocumentReference,
  invitationData: admin.firestore.DocumentData
): Promise<AcceptInvitationResponse> {
  const gameId = invitationData.gameId;
  const gameRef = db.collection("games").doc(gameId);

  const gameDoc = await gameRef.get();
  if (!gameDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "The game for this invitation no longer exists"
    );
  }

  const game = gameDoc.data()!;

  // Check game is still accepting players
  if (game.status !== "scheduled") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "This game is no longer accepting players"
    );
  }

  await db.runTransaction(async (tx) => {
    const currentInv = await tx.get(invitationRef);
    if (!currentInv.exists || currentInv.data()?.status !== "pending") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Invitation is no longer pending"
      );
    }
    const currentGame = await tx.get(gameRef);
    if (!currentGame.exists) {
      throw new functions.https.HttpsError("not-found", "Game no longer exists");
    }

    tx.update(invitationRef, {
      status: "accepted",
      respondedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    tx.update(gameRef, {
      playerIds: admin.firestore.FieldValue.arrayUnion(userId),
      pendingInviteeIds: admin.firestore.FieldValue.arrayRemove(userId),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  functions.logger.info("[acceptInvitation] Game invitation accepted", {
    userId,
    invitationId,
    gameId,
  });

  // groupId is used by the Flutter client to navigate; return the game's groupId
  return {
    success: true,
    groupId: game.groupId ?? "",
    message: "Successfully joined the game",
  };
}

/**
 * Cloud Function to securely accept a group or game invitation.
 *
 * Dual-aware: checks the unified `invitations` collection first, then falls
 * back to the legacy `users/{userId}/invitations` subcollection.
 * Dispatches on `type` field: 'group' → join group; 'game' → join game.
 */
export const acceptInvitation = functions
  .region("europe-west6")
  .https.onCall(acceptInvitationHandler);
