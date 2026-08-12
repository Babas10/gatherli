import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_message_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
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
  Stream<List<ChampionshipModel>> getChampionships() {
    try {
      return _firestore
          .collection('championships')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snap) => snap.docs
              .map((d) => ChampionshipModel.fromFirestore(d))
              .toList())
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
  Stream<List<ChampionshipModel>> getOpenChampionships() {
    return getChampionships().map(
      (all) =>
          all.where((c) => c.status == ChampionshipStatus.registration).toList(),
    );
  }

  @override
  Stream<ChampionshipModel> getChampionshipById(String championshipId) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .snapshots()
          .map((doc) {
        if (!doc.exists) {
          throw ChampionshipException(
            'Championship not found',
            code: 'NOT_FOUND',
          );
        }
        return ChampionshipModel.fromFirestore(doc);
      }).handleError((e) {
        throw ChampionshipException(
          'Failed to load championship: $e',
          code: 'LOAD_CHAMPIONSHIP_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
        'Failed to load championship: $e',
        code: 'LOAD_CHAMPIONSHIP_ERROR',
      ));
    }
  }

  @override
  Stream<List<ChampionshipStandingsModel>> getStandings(
      String championshipId) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('standings')
          .orderBy('position')
          .snapshots()
          .map((snap) => snap.docs
              .map((d) => ChampionshipStandingsModel.fromFirestore(d))
              .toList())
          .handleError((e) {
        throw ChampionshipException(
          'Failed to load standings: $e',
          code: 'LOAD_STANDINGS_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
        'Failed to load standings: $e',
        code: 'LOAD_STANDINGS_ERROR',
      ));
    }
  }

  @override
  Stream<List<ChampionshipTeamModel>> getTeams(String championshipId) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('teams')
          .orderBy('createdAt')
          .snapshots()
          .map((snap) => snap.docs
              .map((d) => ChampionshipTeamModel.fromFirestore(d))
              .toList())
          .handleError((e) {
        throw ChampionshipException(
          'Failed to load teams: $e',
          code: 'LOAD_TEAMS_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
        'Failed to load teams: $e',
        code: 'LOAD_TEAMS_ERROR',
      ));
    }
  }

  @override
  Stream<List<ChampionshipMatchModel>> getMatchesForRound({
    required String championshipId,
    required int round,
  }) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('matches')
          .where('round', isEqualTo: round)
          .snapshots()
          .map((snap) => snap.docs
              .map((d) => ChampionshipMatchModel.fromFirestore(d))
              .toList())
          .handleError((e) {
        throw ChampionshipException(
          'Failed to load matches: $e',
          code: 'LOAD_MATCHES_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
        'Failed to load matches: $e',
        code: 'LOAD_MATCHES_ERROR',
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

  @override
  Stream<ChampionshipMatchModel> getMatch({
    required String championshipId,
    required String matchId,
  }) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('matches')
          .doc(matchId)
          .snapshots()
          .map((doc) {
        if (!doc.exists) {
          throw ChampionshipException('Match not found', code: 'NOT_FOUND');
        }
        return ChampionshipMatchModel.fromFirestore(doc);
      }).handleError((e) {
        throw ChampionshipException(
          'Failed to load match: $e',
          code: 'LOAD_MATCH_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(
          ChampionshipException('Failed to load match: $e', code: 'LOAD_MATCH_ERROR'));
    }
  }

  @override
  Stream<List<ChampionshipMessageModel>> getMatchMessages({
    required String championshipId,
    required String matchId,
  }) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('matches')
          .doc(matchId)
          .collection('messages')
          .orderBy('sentAt')
          .snapshots()
          .map((snap) => snap.docs
              .map((d) => ChampionshipMessageModel.fromFirestore(d))
              .toList())
          .handleError((e) {
        throw ChampionshipException(
          'Failed to load match messages: $e',
          code: 'LOAD_MESSAGES_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
          'Failed to load match messages: $e', code: 'LOAD_MESSAGES_ERROR'));
    }
  }

  @override
  Future<void> sendMatchMessage({
    required String championshipId,
    required String matchId,
    required String senderId,
    required String senderDisplayName,
    required String teamId,
    required String text,
  }) async {
    try {
      await _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('matches')
          .doc(matchId)
          .collection('messages')
          .add({
        'senderId': senderId,
        'senderDisplayName': senderDisplayName,
        'teamId': teamId,
        'text': text,
        'sentAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw ChampionshipException(
        'Failed to send message: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to send message: $e');
    }
  }

  @override
  Future<void> proposeMatchSchedule({
    required String championshipId,
    required String matchId,
    required DateTime scheduledAt,
    String? location,
  }) async {
    try {
      final callable = _functions.httpsCallable('proposeMatchSchedule');
      await callable.call({
        'championshipId': championshipId,
        'matchId': matchId,
        'scheduledAt': scheduledAt.toIso8601String(),
        if (location != null) 'location': location,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to propose schedule',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to propose schedule: $e');
    }
  }

  @override
  Future<void> confirmMatchSchedule({
    required String championshipId,
    required String matchId,
  }) async {
    try {
      final callable = _functions.httpsCallable('confirmMatchSchedule');
      await callable.call({
        'championshipId': championshipId,
        'matchId': matchId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to confirm schedule',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to confirm schedule: $e');
    }
  }

  @override
  Future<void> rejectMatchSchedule({
    required String championshipId,
    required String matchId,
  }) async {
    try {
      final callable = _functions.httpsCallable('rejectMatchSchedule');
      await callable.call({
        'championshipId': championshipId,
        'matchId': matchId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to reject schedule',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to reject schedule: $e');
    }
  }

  @override
  Future<ChampionshipTeamModel?> getTeamById({
    required String championshipId,
    required String teamId,
  }) async {
    try {
      final doc = await _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('teams')
          .doc(teamId)
          .get();
      if (!doc.exists) return null;
      return ChampionshipTeamModel.fromFirestore(doc);
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
  Stream<List<ChampionshipMatchModel>> getAllMatches(String championshipId) {
    try {
      return _firestore
          .collection('championships')
          .doc(championshipId)
          .collection('matches')
          .orderBy('round')
          .snapshots()
          .map((snap) => snap.docs
              .map((d) => ChampionshipMatchModel.fromFirestore(d))
              .toList())
          .handleError((e) {
        throw ChampionshipException(
          'Failed to load matches: $e',
          code: 'LOAD_MATCHES_ERROR',
        );
      });
    } catch (e) {
      return Stream.error(ChampionshipException(
        'Failed to load matches: $e',
        code: 'LOAD_MATCHES_ERROR',
      ));
    }
  }

  @override
  Future<void> adminDecideMatch({
    required String championshipId,
    required String matchId,
    required String decision,
    String? winnerId,
    List<MatchSetScore>? sets,
    required String notes,
  }) async {
    try {
      final callable =
          _functions.httpsCallable('adminDecideChampionshipMatch');
      await callable.call({
        'championshipId': championshipId,
        'matchId': matchId,
        'decision': decision,
        if (winnerId != null) 'winnerId': winnerId,
        if (sets != null) 'sets': sets.map((s) => s.toJson()).toList(),
        'notes': notes,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to apply admin decision',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to apply admin decision: $e');
    }
  }

  @override
  Future<String> createChampionship({
    required String title,
    required DateTime registrationDeadline,
    DateTime? startDate,
    DateTime? endDate,
    String? country,
    String? region,
    ChampionshipGenderCategory? genderCategory,
    int maxTeams = 10,
    int teamSize = 2,
  }) async {
    try {
      final callable = _functions.httpsCallable('createChampionship');
      final result = await callable.call({
        'title': title,
        'registrationDeadline': registrationDeadline.toIso8601String(),
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        if (country != null && country.isNotEmpty) 'country': country,
        if (region != null && region.isNotEmpty) 'region': region,
        if (genderCategory != null) 'genderCategory': genderCategory.name,
        'maxTeams': maxTeams,
        'teamSize': teamSize,
      });
      return result.data['championshipId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to create championship',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to create championship: $e');
    }
  }

  @override
  Future<void> completeChampionship({required String championshipId}) async {
    try {
      final callable = _functions.httpsCallable('completeChampionship');
      await callable.call({'championshipId': championshipId});
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to complete championship',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to complete championship: $e');
    }
  }

  @override
  Future<void> editChampionship({
    required String championshipId,
    String? title,
    DateTime? registrationDeadline,
  }) async {
    try {
      final callable = _functions.httpsCallable('editChampionship');
      await callable.call({
        'championshipId': championshipId,
        if (title != null) 'title': title,
        if (registrationDeadline != null)
          'registrationDeadline': registrationDeadline.toIso8601String(),
      });
    } on FirebaseFunctionsException catch (e) {
      throw ChampionshipException(
        e.message ?? 'Failed to edit championship',
        code: e.code,
      );
    } catch (e) {
      throw ChampionshipException('Failed to edit championship: $e');
    }
  }
}
