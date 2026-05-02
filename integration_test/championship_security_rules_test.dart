// Integration tests for championship Firestore security rules (Epic 30 — Story 30.1).
// Verifies read/write access for championships, teams, matches, messages, and standings
// against the Firebase Emulator with real security rules.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/firebase_emulator_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await FirebaseEmulatorHelper.initialize();
  });

  setUp(() async {
    await FirebaseEmulatorHelper.clearFirestore();
    await FirebaseEmulatorHelper.signOut();
  });

  tearDown(() async {
    await FirebaseEmulatorHelper.signOut();
  });

  final firestore = FirebaseEmulatorHelper.firestore;

  // ─── helpers ──────────────────────────────────────────────────────────────

  Future<String> seedChampionship({required String createdBy}) async {
    final ref = firestore.collection('championships').doc();
    await ref.set({
      'title': 'Test Championship',
      'status': 'registration',
      'maxTeams': 10,
      'teamSize': 2,
      'adminIds': [createdBy],
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
      'registrationDeadline': Timestamp.fromDate(
        DateTime.now().add(const Duration(days: 30)),
      ),
      'currentRound': 0,
      'totalRounds': 9,
    });
    return ref.id;
  }

  Future<String> seedTeam({
    required String championshipId,
    required String captainId,
    required String partnerId,
  }) async {
    final ref =
        firestore.collection('championships/$championshipId/teams').doc();
    await ref.set({
      'name': 'Test Team',
      'captainId': captainId,
      'memberIds': [captainId, partnerId],
      'createdAt': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  Future<String> seedMatch({
    required String championshipId,
    required String teamAId,
    required String teamBId,
  }) async {
    final ref =
        firestore.collection('championships/$championshipId/matches').doc();
    await ref.set({
      'round': 1,
      'teamAId': teamAId,
      'teamBId': teamBId,
      'deadline': Timestamp.fromDate(
        DateTime.now().add(const Duration(days: 21)),
      ),
      'status': 'pending',
    });
    return ref.id;
  }

  Future<void> seedStandings({
    required String championshipId,
    required String teamId,
  }) async {
    await firestore
        .collection('championships/$championshipId/standings')
        .doc(teamId)
        .set({
      'teamId': teamId,
      'teamName': 'Test Team',
      'played': 0,
      'points': 0,
      'wins20': 0,
      'wins21': 0,
      'losses12': 0,
      'losses02': 0,
      'setsWon': 0,
      'setsLost': 0,
      'position': 0,
    });
  }

  // ─── Championship collection ───────────────────────────────────────────────

  group('championships — read access', () {
    test('authenticated user can read a championship', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'admin@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'admin@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);

      final other = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'other@test.com',
        password: 'password123',
        displayName: 'Other',
      );
      await FirebaseEmulatorHelper.signOut();
      await FirebaseEmulatorHelper.signIn(
        email: 'other@test.com',
        password: 'password123',
      );

      // other is now signed in and can read the championship
      expect(other.uid, isNotEmpty);
      final doc =
          await firestore.collection('championships').doc(champId).get();
      expect(doc.exists, isTrue);
    });

    test('unauthenticated user cannot read championships', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'admin2@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'admin2@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);
      await FirebaseEmulatorHelper.signOut();

      await expectLater(
        () => firestore.collection('championships').doc(champId).get(),
        throwsA(anything),
      );
    });
  });

  group('championships — write access', () {
    test('authenticated user cannot create championship directly', () async {
      await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'user@test.com',
        password: 'password123',
        displayName: 'User',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'user@test.com',
        password: 'password123',
      );

      await expectLater(
        () => firestore.collection('championships').doc().set({
          'title': 'Forbidden',
          'status': 'registration',
          'createdBy': 'user-id',
        }),
        throwsA(anything),
      );
    });
  });

  // ─── Teams subcollection ──────────────────────────────────────────────────

  group('championships/teams — read', () {
    test('authenticated user can list teams', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'tadmin@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'tadmin@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);

      final partner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'tpartner@test.com',
        password: 'password123',
        displayName: 'Partner',
      );
      await seedTeam(
        championshipId: champId,
        captainId: admin.uid,
        partnerId: partner.uid,
      );

      final snap = await firestore
          .collection('championships/$champId/teams')
          .get();
      expect(snap.docs.length, 1);
    });
  });

  group('championships/teams — write', () {
    test('captain can create team with themselves in memberIds', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'tcapt@test.com',
        password: 'password123',
        displayName: 'Captain',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'tcapt@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);

      final partner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'tpartner2@test.com',
        password: 'password123',
        displayName: 'Partner',
      );

      // Captain creates team — should succeed
      final teamRef =
          firestore.collection('championships/$champId/teams').doc();
      await teamRef.set({
        'name': 'My Team',
        'captainId': admin.uid,
        'memberIds': [admin.uid, partner.uid],
        'createdAt': FieldValue.serverTimestamp(),
      });

      final doc = await teamRef.get();
      expect(doc.exists, isTrue);
    });

    test('user cannot create team where captainId is not themselves', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'towner@test.com',
        password: 'password123',
        displayName: 'Owner',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'towner@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);

      final impostor = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'timpostor@test.com',
        password: 'password123',
        displayName: 'Impostor',
      );
      await FirebaseEmulatorHelper.signOut();
      await FirebaseEmulatorHelper.signIn(
        email: 'timpostor@test.com',
        password: 'password123',
      );

      await expectLater(
        () => firestore.collection('championships/$champId/teams').doc().set({
          'name': 'Stolen Team',
          'captainId': admin.uid, // not the impostor
          'memberIds': [admin.uid, impostor.uid],
          'createdAt': FieldValue.serverTimestamp(),
        }),
        throwsA(anything),
      );
    });
  });

  // ─── Matches subcollection ────────────────────────────────────────────────

  group('championships/matches — read', () {
    test('authenticated user can read matches', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'madmin@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'madmin@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);

      final partner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'mpartner@test.com',
        password: 'password123',
        displayName: 'Partner',
      );
      final teamAId = await seedTeam(
        championshipId: champId,
        captainId: admin.uid,
        partnerId: partner.uid,
      );

      final other = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'mother@test.com',
        password: 'password123',
        displayName: 'Other',
      );
      final teamBId = await seedTeam(
        championshipId: champId,
        captainId: other.uid,
        partnerId: partner.uid,
      );

      final matchId = await seedMatch(
        championshipId: champId,
        teamAId: teamAId,
        teamBId: teamBId,
      );

      final doc = await firestore
          .collection('championships/$champId/matches')
          .doc(matchId)
          .get();
      expect(doc.exists, isTrue);
    });
  });

  group('championships/matches — write', () {
    test('authenticated user cannot create match directly', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'mwadmin@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'mwadmin@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);

      await expectLater(
        () => firestore
            .collection('championships/$champId/matches')
            .doc()
            .set({'round': 1, 'teamAId': 'a', 'teamBId': 'b'}),
        throwsA(anything),
      );
    });
  });

  // ─── Messages subcollection ───────────────────────────────────────────────

  group('championships/matches/messages — read & write', () {
    test('team member can post and read messages', () async {
      final captain = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'msgcapt@test.com',
        password: 'password123',
        displayName: 'Captain',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'msgcapt@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: captain.uid);

      final partner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'msgpartner@test.com',
        password: 'password123',
        displayName: 'Partner',
      );
      final opponent = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'msgopp@test.com',
        password: 'password123',
        displayName: 'Opponent',
      );
      final oppPartner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'msgopppartner@test.com',
        password: 'password123',
        displayName: 'OppPartner',
      );

      final teamAId = await seedTeam(
        championshipId: champId,
        captainId: captain.uid,
        partnerId: partner.uid,
      );
      final teamBId = await seedTeam(
        championshipId: champId,
        captainId: opponent.uid,
        partnerId: oppPartner.uid,
      );
      final matchId = await seedMatch(
        championshipId: champId,
        teamAId: teamAId,
        teamBId: teamBId,
      );

      // Captain (teamA member) posts a message — should succeed
      final msgRef = firestore
          .collection('championships/$champId/matches/$matchId/messages')
          .doc();
      await msgRef.set({
        'senderId': captain.uid,
        'senderDisplayName': 'Captain',
        'teamId': teamAId,
        'text': 'Ready for Saturday?',
        'sentAt': FieldValue.serverTimestamp(),
      });

      final snap = await firestore
          .collection('championships/$champId/matches/$matchId/messages')
          .get();
      expect(snap.docs.length, 1);
    });

    test('non-participant cannot post messages', () async {
      final captain = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'npcapt@test.com',
        password: 'password123',
        displayName: 'Captain',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'npcapt@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: captain.uid);

      final partner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'nppartner@test.com',
        password: 'password123',
        displayName: 'Partner',
      );
      final opponent = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'npopp@test.com',
        password: 'password123',
        displayName: 'Opponent',
      );
      final oppPartner = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'npopppartner@test.com',
        password: 'password123',
        displayName: 'OppPartner',
      );

      final teamAId = await seedTeam(
        championshipId: champId,
        captainId: captain.uid,
        partnerId: partner.uid,
      );
      final teamBId = await seedTeam(
        championshipId: champId,
        captainId: opponent.uid,
        partnerId: oppPartner.uid,
      );
      final matchId = await seedMatch(
        championshipId: champId,
        teamAId: teamAId,
        teamBId: teamBId,
      );

      // Outsider tries to post
      final outsider = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'npoutsider@test.com',
        password: 'password123',
        displayName: 'Outsider',
      );
      await FirebaseEmulatorHelper.signOut();
      await FirebaseEmulatorHelper.signIn(
        email: 'npoutsider@test.com',
        password: 'password123',
      );

      await expectLater(
        () => firestore
            .collection(
              'championships/$champId/matches/$matchId/messages',
            )
            .doc()
            .set({
          'senderId': outsider.uid,
          'senderDisplayName': 'Outsider',
          'teamId': 'random-team',
          'text': 'Spam',
          'sentAt': FieldValue.serverTimestamp(),
        }),
        throwsA(anything),
      );
    });
  });

  // ─── Standings subcollection ──────────────────────────────────────────────

  group('championships/standings — read', () {
    test('authenticated user can read standings', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'stadmin@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'stadmin@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);
      await seedStandings(championshipId: champId, teamId: 'team-1');

      final snap = await firestore
          .collection('championships/$champId/standings')
          .get();
      expect(snap.docs.length, 1);
    });
  });

  group('championships/standings — write', () {
    test('authenticated user cannot update standings directly', () async {
      final admin = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'stwadmin@test.com',
        password: 'password123',
        displayName: 'Admin',
      );
      await FirebaseEmulatorHelper.signIn(
        email: 'stwadmin@test.com',
        password: 'password123',
      );
      final champId = await seedChampionship(createdBy: admin.uid);
      await seedStandings(championshipId: champId, teamId: 'team-xyz');

      await expectLater(
        () => firestore
            .collection('championships/$champId/standings')
            .doc('team-xyz')
            .update({'points': 999}),
        throwsA(anything),
      );
    });
  });
}
