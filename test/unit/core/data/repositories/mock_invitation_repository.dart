// Mock repository for InvitationRepository used in testing
import 'dart:async';

import 'package:play_with_me/core/data/models/game_invitation_details.dart';
import 'package:play_with_me/core/data/models/invitation_model.dart';
import 'package:play_with_me/core/data/models/invitable_player_model.dart';
import 'package:play_with_me/core/domain/repositories/invitation_repository.dart';
import 'package:rxdart/rxdart.dart';

class MockInvitationRepository implements InvitationRepository {
  // Use BehaviorSubject for synchronous, deterministic emissions
  final BehaviorSubject<List<InvitationModel>> _invitationsController =
      BehaviorSubject<List<InvitationModel>>.seeded([]);
  final Map<String, InvitationModel> _invitations = {};
  int _idCounter = 0;

  MockInvitationRepository();

  BehaviorSubject<List<InvitationModel>> get invitationsController =>
      _invitationsController;

  // Helper methods for testing
  void addInvitation(InvitationModel invitation) {
    _invitations[invitation.id] = invitation;
    _emitPending(invitation.invitedUserId);
  }

  void clearInvitations() {
    _invitations.clear();
    _invitationsController.add([]);
  }

  void _emitPending(String userId) {
    if (!_invitationsController.isClosed) {
      final pending = _invitations.values
          .where((i) => i.invitedUserId == userId && i.isPending)
          .toList();
      _invitationsController.add(pending);
    }
  }

  void dispose() {
    _invitationsController.close();
  }

  List<InvitationModel> get allInvitations => _invitations.values.toList();

  // ============================================================
  // Group invitations
  // ============================================================

  @override
  Future<String> sendGroupInvitation({
    required String groupId,
    required String invitedUserId,
  }) async {
    final invitationId = 'invitation-${++_idCounter}';
    addInvitation(InvitationModel(
      id: invitationId,
      type: InvitationType.group,
      groupId: groupId,
      invitedUserId: invitedUserId,
      invitedBy: 'test-user',
      inviterName: 'Test User',
      createdAt: DateTime.now(),
    ));
    return invitationId;
  }

  @override
  Future<bool> hasPendingGroupInvitation({
    required String userId,
    required String groupId,
  }) async {
    return _invitations.values.any(
      (inv) =>
          inv.invitedUserId == userId &&
          inv.groupId == groupId &&
          inv.isPending,
    );
  }

  // ============================================================
  // Game invitations
  // ============================================================

  @override
  Future<String> sendGameInvitation({
    required String gameId,
    required String invitedUserId,
  }) async {
    final invitationId = 'game-invitation-${++_idCounter}';
    addInvitation(InvitationModel(
      id: invitationId,
      type: InvitationType.game,
      gameId: gameId,
      invitedUserId: invitedUserId,
      invitedBy: 'test-user',
      inviterName: 'Test User',
      createdAt: DateTime.now(),
    ));
    return invitationId;
  }

  @override
  Future<List<GameInvitationDetails>> getGameInvitations() async => [];

  @override
  Future<List<InvitablePlayerModel>> getInvitablePlayers(String gameId) async => [];

  // ============================================================
  // Shared
  // ============================================================

  @override
  Stream<List<InvitationModel>> getPendingInvitations(String userId) async* {
    yield _invitations.values
        .where((i) => i.invitedUserId == userId && i.isPending)
        .toList();

    yield* _invitationsController.stream.map(
      (list) => list
          .where((i) => i.invitedUserId == userId && i.isPending)
          .toList(),
    );
  }

  @override
  Future<List<InvitationModel>> getInvitations(String userId) async {
    return _invitations.values
        .where((i) => i.invitedUserId == userId)
        .toList();
  }

  @override
  Future<void> acceptInvitation({
    required String userId,
    required String invitationId,
  }) async {
    final inv = _invitations[invitationId];
    if (inv == null) throw Exception('Invitation not found');
    _invitations[invitationId] = inv.accept();
    _emitPending(userId);
  }

  @override
  Future<void> declineInvitation({
    required String userId,
    required String invitationId,
  }) async {
    final inv = _invitations[invitationId];
    if (inv == null) throw Exception('Invitation not found');
    _invitations[invitationId] = inv.decline();
    _emitPending(userId);
  }

  @override
  Future<void> deleteInvitation({
    required String userId,
    required String invitationId,
  }) async {
    _invitations.remove(invitationId);
    _emitPending(userId);
  }

  @override
  Future<void> cancelInvitation({
    required String userId,
    required String invitationId,
  }) async {
    await deleteInvitation(userId: userId, invitationId: invitationId);
  }
}
