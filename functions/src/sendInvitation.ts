// Type-dispatched invitation sender — Story 31.6
// Handles both group and game invitations, writing to the unified top-level
// `invitations/{id}` collection instead of the deprecated subcollections.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {checkFriendship} from "./friendships";

// ============================================================================
// Request / Response types
// ============================================================================

interface SendInvitationRequest {
  type: "group" | "game";
  // Required for type='group'
  groupId?: string;
  // Required for type='game'
  gameId?: string;
  // Required for both
  invitedUserId: string;
}

interface SendInvitationResponse {
  success: boolean;
  invitationId: string;
}

// ============================================================================
// Shared helpers
// ============================================================================

async function getUserProfile(
  db: admin.firestore.Firestore,
  userId: string
): Promise<{displayName: string; email: string} | null> {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) return null;
  const d = doc.data()!;
  return {displayName: d.displayName || d.email, email: d.email};
}

async function getGroupData(
  db: admin.firestore.Firestore,
  groupId: string
): Promise<{name: string; createdBy: string; memberIds: string[]; adminIds: string[]} | null> {
  const doc = await db.collection("groups").doc(groupId).get();
  if (!doc.exists) return null;
  const d = doc.data()!;
  return {
    name: d.name,
    createdBy: d.createdBy,
    memberIds: d.memberIds ?? [],
    adminIds: d.adminIds ?? [],
  };
}

// ============================================================================
// Group invitation branch
// ============================================================================

async function sendGroupInvitation(
  db: admin.firestore.Firestore,
  callerId: string,
  groupId: string,
  invitedUserId: string
): Promise<string> {
  // Cannot invite yourself
  if (callerId === invitedUserId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "You cannot invite yourself to a group"
    );
  }

  // Group must exist
  const groupData = await getGroupData(db, groupId);
  if (!groupData) {
    throw new functions.https.HttpsError("not-found", "Group not found");
  }

  // Caller must be a group admin or creator
  const isAdmin =
    groupData.adminIds.includes(callerId) || groupData.createdBy === callerId;
  if (!groupData.memberIds.includes(callerId) || !isAdmin) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only group admins can invite others to the group"
    );
  }

  // Invitee must not already be a member
  if (groupData.memberIds.includes(invitedUserId)) {
    throw new functions.https.HttpsError(
      "already-exists",
      "This user is already a member of the group"
    );
  }

  // Invitee must exist
  const inviteeDoc = await db.collection("users").doc(invitedUserId).get();
  if (!inviteeDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "The user you're trying to invite doesn't exist"
    );
  }

  // Friendship check (social graph boundary)
  const areFriends = await checkFriendship(callerId, invitedUserId);
  if (!areFriends) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only invite friends to groups"
    );
  }

  // Duplicate pending invitation check (top-level collection)
  const dupCheck = await db
    .collection("invitations")
    .where("type", "==", "group")
    .where("invitedUserId", "==", invitedUserId)
    .where("groupId", "==", groupId)
    .where("status", "==", "pending")
    .limit(1)
    .get();
  if (!dupCheck.empty) {
    throw new functions.https.HttpsError(
      "already-exists",
      "This user already has a pending invitation to this group"
    );
  }

  const inviterProfile = await getUserProfile(db, callerId);
  if (!inviterProfile) {
    throw new functions.https.HttpsError("internal", "Failed to retrieve inviter profile");
  }

  const ref = await db.collection("invitations").add({
    type: "group",
    groupId,
    groupName: groupData.name,
    invitedUserId,
    invitedBy: callerId,
    inviterName: inviterProfile.displayName,
    status: "pending",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return ref.id;
}

// ============================================================================
// Game invitation branch
// ============================================================================

async function sendGameInvitation(
  db: admin.firestore.Firestore,
  callerId: string,
  gameId: string,
  invitedUserId: string
): Promise<string> {
  // Cannot invite yourself
  if (callerId === invitedUserId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "You cannot invite yourself to a game"
    );
  }

  // Load game — caller must be creator
  const gameDoc = await db.collection("games").doc(gameId).get();
  if (!gameDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Game not found");
  }
  const game = gameDoc.data()!;

  if (game.createdBy !== callerId) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only the game creator can invite guests"
    );
  }

  // Invitee not already a player
  const playerIds: string[] = game.playerIds ?? [];
  if (playerIds.includes(invitedUserId)) {
    throw new functions.https.HttpsError(
      "already-exists",
      "This player is already participating in the game"
    );
  }

  // No duplicate pending invitation in new collection
  const dupNew = await db
    .collection("invitations")
    .where("type", "==", "game")
    .where("gameId", "==", gameId)
    .where("invitedUserId", "==", invitedUserId)
    .where("status", "==", "pending")
    .limit(1)
    .get();
  if (!dupNew.empty) {
    throw new functions.https.HttpsError(
      "already-exists",
      "A pending invitation already exists for this player and game"
    );
  }

  // Shared-group trust boundary
  const callerGroupsSnap = await db
    .collection("groups")
    .where("memberIds", "array-contains", callerId)
    .get();

  const sharedGroup = callerGroupsSnap.docs.find((doc) => {
    const members: string[] = doc.data().memberIds ?? [];
    return members.includes(invitedUserId);
  });

  if (!sharedGroup) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only invite players who share at least one group with you"
    );
  }

  // Atomic write: create invitation + update pendingInviteeIds on game
  const invitationRef = db.collection("invitations").doc();
  const gameRef = db.collection("games").doc(gameId);
  const batch = db.batch();

  batch.set(invitationRef, {
    type: "game",
    gameId,
    groupId: game.groupId,
    invitedUserId,
    invitedBy: callerId,
    status: "pending",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt: game.scheduledAt ?? null,
  });

  batch.update(gameRef, {
    pendingInviteeIds: admin.firestore.FieldValue.arrayUnion(invitedUserId),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  await batch.commit();

  return invitationRef.id;
}

// ============================================================================
// Handler
// ============================================================================

export async function sendInvitationHandler(
  data: SendInvitationRequest,
  context: functions.https.CallableContext
): Promise<SendInvitationResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to send invitations"
    );
  }

  const callerId = context.auth.uid;

  // Validate common fields
  if (!data || !["group", "game"].includes(data.type)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Parameter 'type' must be 'group' or 'game'"
    );
  }
  if (!data.invitedUserId || typeof data.invitedUserId !== "string") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Parameter 'invitedUserId' is required and must be a string"
    );
  }

  const db = admin.firestore();

  try {
    let invitationId: string;

    if (data.type === "group") {
      if (!data.groupId || typeof data.groupId !== "string") {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Parameter 'groupId' is required for type='group'"
        );
      }
      functions.logger.info("[sendInvitation] group", {
        callerId,
        groupId: data.groupId,
        invitedUserId: data.invitedUserId,
      });
      invitationId = await sendGroupInvitation(
        db,
        callerId,
        data.groupId,
        data.invitedUserId
      );
    } else {
      if (!data.gameId || typeof data.gameId !== "string") {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Parameter 'gameId' is required for type='game'"
        );
      }
      functions.logger.info("[sendInvitation] game", {
        callerId,
        gameId: data.gameId,
        invitedUserId: data.invitedUserId,
      });
      invitationId = await sendGameInvitation(
        db,
        callerId,
        data.gameId,
        data.invitedUserId
      );
    }

    functions.logger.info("[sendInvitation] created", {callerId, invitationId, type: data.type});
    return {success: true, invitationId};
  } catch (error) {
    if (error instanceof functions.https.HttpsError) throw error;
    functions.logger.error("[sendInvitation] unexpected error", {
      callerId,
      type: data.type,
      error: error instanceof Error ? error.message : String(error),
    });
    throw new functions.https.HttpsError("internal", "Failed to send invitation");
  }
}

/**
 * Callable Cloud Function — sendInvitation (Story 31.6)
 *
 * Unified invitation sender writing to the top-level `invitations` collection.
 * Dispatches on `type`:
 *   - 'group': validates friendship + admin status, then creates a group invitation
 *   - 'game': validates shared-group trust + creator status, then creates a game invitation
 */
export const sendInvitation = functions
  .region("europe-west6")
  .https.onCall(sendInvitationHandler);
