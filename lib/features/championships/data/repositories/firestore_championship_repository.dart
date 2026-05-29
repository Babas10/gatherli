import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';

class FirestoreChampionshipRepository implements ChampionshipRepository {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  FirestoreChampionshipRepository({
    required FirebaseFirestore firestore,
    required FirebaseFunctions functions,
  })  : _firestore = firestore,
        _functions = functions;

  @override
  Stream<List<ChampionshipModel>> getOpenChampionships() {
    try {
      return _firestore
          .collection('championships')
          .where('status', isEqualTo: 'registration')
          .snapshots()
          .map((snap) =>
              snap.docs.map((d) => ChampionshipModel.fromFirestore(d)).toList())
          .handleError((e) {
        throw ChampionshipException(
          'Failed to load championships: $e',
          code: 'LOAD_CHAMPIONSHIPS_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
        'Failed to load championships: $e',
        code: 'LOAD_CHAMPIONSHIPS_ERROR',
      ));
    }
  }

  @override
  Future<ChampionshipTeamModel?> getMyTeam({
    required String championshipId,
    required String userId,
  }) async {
    try {
      final snap = await _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('teams')
          .where('memberIds', arrayContains: userId)
          .limit(1)
          .get();

      if (snap.docs.isEmpty) return null;
      return ChampionshipTeamModel.fromFirestore(snap.docs.first);
    } on FirebaseException catch (e) {
      throw ChampionshipException(
        'Failed to load team: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to load team: $e');
    }
  }

  @override
  Future<String> createTeam({
    required String championshipId,
    required String teamName,
    required String partnerId,
  }) async {
    try {
      final callable = _functions.httpsCallable('createChampionshipTeam');
      final result = await callable.call({
        'championshipId': championshipId,
        'teamName': teamName,
        'partnerId': partnerId,
      });
      return result.data['teamId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(e.message ?? 'Failed to create team', code: e.code);
    } catch (e) {
      throw ChampionshipException('Failed to create team: $e');
    }
  }

  @override
  Future<void> leaveTeam({
    required String championshipId,
    required String teamId,
  }) async {
    try {
      final callable = _functions.httpsCallable('leaveChampionshipTeam');
      await callable.call({
        'championshipId': championshipId,
        'teamId': teamId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(e.message ?? 'Failed to leave team', code: e.code);
    } catch (e) {
      throw ChampionshipException('Failed to leave team: $e');
    }
  }

  @override
  Future<int> startChampionship({
    required String championshipId,
    required DateTime startDate,
  }) async {
    try {
      final callable = _functions.httpsCallable('startChampionship');
      final result = await callable.call({
        'championshipId': championshipId,
        'startDate': startDate.toIso8601String(),
      });
      return result.data['matchesCreated'] as int;
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(e.message ?? 'Failed to start championship', code: e.code);
    } catch (e) {
      throw ChampionshipException('Failed to start championship: $e');
    }
  }

  @override
  Future<void> submitMatchResult({
    required String championshipId,
    required String matchId,
    required List<MatchSetScore> sets,
  }) async {
    try {
      final callable = _functions.httpsCallable('submitChampionshipMatchResult');
      await callable.call({
        'championshipId': championshipId,
        'matchId': matchId,
        'sets': sets.map((s) => s.toJson()).toList(),
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to submit match result',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to submit match result: $e');
    }
  }

  @override
  Future<String> verifyMatchResult({
    required String championshipId,
    required String matchId,
    required String action,
    String? disputeReason,
  }) async {
    try {
      final callable =
          _functions.httpsCallable('verifyChampionshipMatchResult');
      final result = await callable.call({
        'championshipId': championshipId,
        'matchId': matchId,
        'action': action,
        if (disputeReason != null) 'disputeReason': disputeReason,
      });
      return result.data['status'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to verify match result',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to verify match result: $e');
    }
  }
}
