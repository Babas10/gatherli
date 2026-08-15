// Contract test: validates Firestore championship documents match ChampionshipModel.fromJson
// Run against Firebase emulator. Schema changes that break the model fail here first.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

import '../helpers/firebase_emulator_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FirebaseFirestore db;

  setUpAll(() async {
    await FirebaseEmulatorHelper.initialize();
    db = FirebaseFirestore.instance;
  });

  setUp(() => FirebaseEmulatorHelper.clearFirestore());

  group('ChampionshipModel contract', () {
    test('deserializes full document without throwing', () async {
      final ref = db.collection('championships').doc('c1');
      await ref.set({
        'title': 'Test', 'status': 'registration', 'maxTeams': 8, 'teamSize': 2,
        'teamsCount': 0, 'adminIds': ['u1'], 'createdBy': 'u1', 'currentRound': 0,
        'totalRounds': 9, 'registrationDeadline': Timestamp.now(),
        'createdAt': Timestamp.now(), 'genderCategory': 'female',
      });
      final doc = await ref.get();
      expect(() => ChampionshipModel.fromJson({'id': doc.id, ...doc.data()!}), returnsNormally);
      final m = ChampionshipModel.fromJson({'id': doc.id, ...doc.data()!});
      expect(m.status, equals(ChampionshipStatus.registration));
      expect(m.genderCategory, equals(ChampionshipGenderCategory.female));
    });

    test('deserializes minimal document (optional fields absent)', () async {
      final ref = db.collection('championships').doc('c2');
      await ref.set({'title': 'Min', 'createdBy': 'u1', 'adminIds': ['u1'],
        'registrationDeadline': Timestamp.now(), 'createdAt': Timestamp.now()});
      final doc = await ref.get();
      expect(() => ChampionshipModel.fromJson({'id': doc.id, ...doc.data()!}), returnsNormally);
    });
  });

  group('ChampionshipTeamModel contract', () {
    test('deserializes a team document', () async {
      final ref = db.collection('championships').doc('c1').collection('teams').doc('t1');
      await ref.set({'name': 'Les Titans', 'captainId': 'u1',
        'memberIds': ['u1', 'u2'], 'createdAt': Timestamp.now()});
      final doc = await ref.get();
      expect(() => ChampionshipTeamModel.fromJson({'id': doc.id, ...doc.data()!}), returnsNormally);
    });
  });

  group('ChampionshipMatchModel contract', () {
    test('deserializes a pending match', () async {
      final ref = db.collection('championships').doc('c1').collection('matches').doc('m1');
      await ref.set({'teamAId': 't1', 'teamBId': 't2', 'round': 1, 'status': 'pending',
        'deadline': Timestamp.fromDate(DateTime.now().add(const Duration(days: 14))),
        'createdAt': Timestamp.now()});
      final doc = await ref.get();
      expect(() => ChampionshipMatchModel.fromJson({'id': doc.id, ...doc.data()!}), returnsNormally);
    });
  });

  group('ChampionshipStandingsModel contract', () {
    test('deserializes standings document', () async {
      final ref = db.collection('championships').doc('c1').collection('standings').doc('t1');
      await ref.set({'teamId': 't1', 'teamName': 'Les Titans', 'points': 6,
        'wins20': 2, 'wins21': 1, 'losses02': 0, 'losses12': 1,
        'played': 4, 'setRatio': 3, 'position': 1});
      final doc = await ref.get();
      expect(() => ChampionshipStandingsModel.fromJson({'id': doc.id, ...doc.data()!}), returnsNormally);
    });
  });
}
