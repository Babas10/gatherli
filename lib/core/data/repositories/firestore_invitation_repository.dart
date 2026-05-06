// Unified invitation repository — handles group and game invitations.
// All invitations are stored in the top-level `invitations/{id}` collection.
// Write operations go through Cloud Functions (Admin SDK); reads go direct.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../domain/exceptions/repository_exceptions.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../models/game_invitation_details.dart';
import '../models/invitation_model.dart';
import '../models/invitable_player_model.dart';

class FirestoreInvitationRepository implements InvitationRepository {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  static const String _invitationsCollection = 'invitations';

  FirestoreInvitationRepository({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _functions =
           functions ?? FirebaseFunctions.instanceFor(region: 'europe-west6');

  // ============================================================
  // Group invitations
  // ============================================================

  @override
  Future<String> sendGroupInvitation({
    required String groupId,
    required String invitedUserId,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendInvitation');
      final result = await callable.call({
        'type': 'group',
        'groupId': groupId,
        'invitedUserId': invitedUserId,
      });
      final data = result.data as Map<String, dynamic>;
      return data['invitationId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw InvitationException(_mapGroupError(e), code: e.code);
    } catch (e) {
      throw InvitationException('Failed to send invitation: $e');
    }
  }

  @override
  Future<bool> hasPendingGroupInvitation({
    required String userId,
    required String groupId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_invitationsCollection)
          .where('invitedUserId', isEqualTo: userId)
          .where('groupId', isEqualTo: groupId)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw InvitationException('Failed to check pending invitation: $e');
    }
  }

  // ============================================================
  // Game invitations
  // ============================================================

  @override
  Future<String> sendGameInvitation({
    required String gameId,
    required String invitedUserId,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendInvitation');
      final result = await callable.call({
        'type': 'game',
        'gameId': gameId,
        'invitedUserId': invitedUserId,
      });
      final data = result.data as Map<String, dynamic>;
      return data['invitationId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw GameInvitationException(_mapGameError(e), code: e.code);
    } catch (e) {
      throw GameInvitationException('Failed to send game invitation: $e');
    }
  }

  @override
  Future<List<GameInvitationDetails>> getGameInvitations() async {
    try {
      final callable = _functions.httpsCallable('getGameInvitationsForUser');
      final result = await callable.call<Map<String, dynamic>>();
      final data = Map<String, dynamic>.from(result.data as Map);
      final raw = data['invitations'] as List<dynamic>;
      return raw
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map(GameInvitationDetails.fromMap)
          .toList();
    } on FirebaseFunctionsException catch (e) {
      throw GameInvitationException(
        e.message ?? 'Failed to load game invitations',
        code: e.code,
      );
    } catch (e) {
      throw GameInvitationException('Failed to load game invitations: $e');
    }
  }

  @override
  Future<List<InvitablePlayerModel>> getInvitablePlayers(String gameId) async {
    try {
      final callable = _functions.httpsCallable('getInvitablePlayersForGame');
      final result = await callable.call({'gameId': gameId});
      final data = Map<String, dynamic>.from(result.data as Map);
      return (data['players'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map(InvitablePlayerModel.fromMap)
          .toList();
    } on FirebaseFunctionsException catch (e) {
      throw GameInvitationException(_mapGameError(e), code: e.code);
    } catch (e) {
      throw GameInvitationException('Failed to load invitable players: $e');
    }
  }

  // ============================================================
  // Shared — all invitation types
  // ============================================================

  @override
  Stream<List<InvitationModel>> getPendingInvitations(String userId) {
    return _firestore
        .collection(_invitationsCollection)
        .where('invitedUserId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .where((doc) => doc.exists)
              .map((doc) => InvitationModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Future<List<InvitationModel>> getInvitations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_invitationsCollection)
          .where('invitedUserId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .where((doc) => doc.exists)
          .map((doc) => InvitationModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw InvitationException('Failed to get invitations: $e');
    }
  }

  @override
  Future<void> acceptInvitation({
    required String userId,
    required String invitationId,
  }) async {
    try {
      final callable = _functions.httpsCallable('acceptInvitation');
      await callable.call({'invitationId': invitationId});
    } on FirebaseFunctionsException catch (e) {
      throw InvitationException(
        'Failed to accept invitation: ${e.message ?? e.code}',
        code: e.code,
      );
    } catch (e) {
      throw InvitationException('Failed to accept invitation: $e');
    }
  }

  @override
  Future<void> declineInvitation({
    required String userId,
    required String invitationId,
  }) async {
    try {
      final callable = _functions.httpsCallable('declineInvitation');
      await callable.call({'invitationId': invitationId});
    } on FirebaseFunctionsException catch (e) {
      throw InvitationException(
        'Failed to decline invitation: ${e.message ?? e.code}',
        code: e.code,
      );
    } catch (e) {
      throw InvitationException('Failed to decline invitation: $e');
    }
  }

  @override
  Future<void> deleteInvitation({
    required String userId,
    required String invitationId,
  }) async {
    try {
      await _firestore
          .collection(_invitationsCollection)
          .doc(invitationId)
          .delete();
    } catch (e) {
      throw InvitationException('Failed to delete invitation: $e');
    }
  }

  @override
  Future<void> cancelInvitation({
    required String userId,
    required String invitationId,
  }) async {
    try {
      await deleteInvitation(userId: userId, invitationId: invitationId);
    } catch (e) {
      throw InvitationException('Failed to cancel invitation: $e');
    }
  }

  // ============================================================
  // Private helpers
  // ============================================================

  String _mapGroupError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return 'You must be logged in to send invitations';
      case 'permission-denied':
        return e.message ?? 'You can only invite friends to groups';
      case 'not-found':
        return e.message ?? 'User or group not found';
      case 'already-exists':
        return e.message ?? 'Invitation already exists or user is already a member';
      case 'invalid-argument':
        return e.message ?? 'Invalid invitation parameters';
      default:
        return 'Failed to send invitation: ${e.message ?? e.code}';
    }
  }

  String _mapGameError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return 'You must be logged in to perform this action';
      case 'permission-denied':
        return e.message ?? 'You don\'t have permission for this action';
      case 'not-found':
        return e.message ?? 'Game or player not found';
      case 'already-exists':
        return e.message ?? 'Invitation already exists';
      case 'invalid-argument':
        return e.message ?? 'Invalid parameters';
      default:
        return e.message ?? 'An unexpected error occurred';
    }
  }
}
