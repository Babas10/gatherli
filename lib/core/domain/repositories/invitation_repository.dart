import '../../data/models/game_invitation_details.dart';
import '../../data/models/invitation_model.dart';
import '../../data/models/invitable_player_model.dart';

abstract class InvitationRepository {
  // ============================================================
  // Group invitations
  // ============================================================

  /// Send a group invitation to a user.
  /// Returns the invitation ID.
  Future<String> sendGroupInvitation({
    required String groupId,
    required String invitedUserId,
  });

  /// Check if user has pending invitation for a group.
  Future<bool> hasPendingGroupInvitation({
    required String userId,
    required String groupId,
  });

  // ============================================================
  // Game invitations
  // ============================================================

  /// Send a game invitation to a user (cross-group guest).
  /// Returns the invitation ID.
  Future<String> sendGameInvitation({
    required String gameId,
    required String invitedUserId,
  });

  /// Get all pending game invitations for the current user (enriched with game details).
  Future<List<GameInvitationDetails>> getGameInvitations();

  /// Returns users eligible to be invited as guest players for [gameId].
  Future<List<InvitablePlayerModel>> getInvitablePlayers(String gameId);

  // ============================================================
  // Shared — all invitation types
  // ============================================================

  /// Stream of pending invitations for the given user (all types).
  Stream<List<InvitationModel>> getPendingInvitations(String userId);

  /// One-time fetch of all invitations for the given user (any status).
  Future<List<InvitationModel>> getInvitations(String userId);

  /// Accept an invitation (group → joins group; game → joins game as guest).
  Future<void> acceptInvitation({
    required String userId,
    required String invitationId,
  });

  /// Decline an invitation.
  Future<void> declineInvitation({
    required String userId,
    required String invitationId,
  });

  /// Delete an invitation document.
  Future<void> deleteInvitation({
    required String userId,
    required String invitationId,
  });

  /// Cancel an invitation (sent by the inviter or group admin).
  Future<void> cancelInvitation({
    required String userId,
    required String invitationId,
  });
}
