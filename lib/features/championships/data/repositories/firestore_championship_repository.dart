import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
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
}
