// Integration tests validating the get/list split introduced for shareable
// activity links: `get` (fetch by known ID) is open to any authenticated
// user for games and trainingSessions, while `list` (query/enumeration)
// stays scoped to group members/players/participants exactly as before.
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

  group('games/{gameId} — get vs list split', () {
    test(
      'Non-member authenticated user CAN get a game by ID (shareable link)',
      () async {
        final creator = await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'creator@test.com',
          password: 'password123',
          displayName: 'Creator User',
        );
        await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'outsider@test.com',
          password: 'password123',
          displayName: 'Outsider User',
        );

        await FirebaseEmulatorHelper.signIn(
          email: 'creator@test.com',
          password: 'password123',
        );
        final groupId = await FirebaseEmulatorHelper.createTestGroup(
          createdBy: creator.uid,
          name: 'Test Group',
        );
        final gameId = await FirebaseEmulatorHelper.createTestGame(
          groupId: groupId,
          createdBy: creator.uid,
          title: 'Members Only Game',
          playerIds: [creator.uid],
        );

        await FirebaseEmulatorHelper.signOut();
        await FirebaseEmulatorHelper.signIn(
          email: 'outsider@test.com',
          password: 'password123',
        );

        final doc = await FirebaseEmulatorHelper.firestore
            .collection('games')
            .doc(gameId)
            .get();

        expect(doc.exists, isTrue);
        expect(doc.data()!['title'], 'Members Only Game');
      },
    );

    test(
      'Non-member authenticated user does NOT see the game via a list query',
      () async {
        final creator = await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'creator2@test.com',
          password: 'password123',
          displayName: 'Creator User',
        );
        await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'outsider2@test.com',
          password: 'password123',
          displayName: 'Outsider User',
        );

        await FirebaseEmulatorHelper.signIn(
          email: 'creator2@test.com',
          password: 'password123',
        );
        final groupId = await FirebaseEmulatorHelper.createTestGroup(
          createdBy: creator.uid,
          name: 'Test Group 2',
        );
        await FirebaseEmulatorHelper.createTestGame(
          groupId: groupId,
          createdBy: creator.uid,
          title: 'Members Only Game 2',
          playerIds: [creator.uid],
        );

        await FirebaseEmulatorHelper.signOut();
        await FirebaseEmulatorHelper.signIn(
          email: 'outsider2@test.com',
          password: 'password123',
        );

        // Unfiltered list — the list rule still requires playerIds/group
        // membership/pendingInvitee, so the outsider should see none of
        // this group's games even though get-by-ID now succeeds.
        final snapshot = await FirebaseEmulatorHelper.firestore
            .collection('games')
            .get();

        expect(
          snapshot.docs.where((d) => d.data()['title'] == 'Members Only Game 2'),
          isEmpty,
        );
      },
    );
  });

  group('trainingSessions/{sessionId} — get vs list split', () {
    test(
      'Non-member authenticated user CAN get a training session by ID (shareable link)',
      () async {
        final creator = await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'creator3@test.com',
          password: 'password123',
          displayName: 'Creator User',
        );
        await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'outsider3@test.com',
          password: 'password123',
          displayName: 'Outsider User',
        );

        await FirebaseEmulatorHelper.signIn(
          email: 'creator3@test.com',
          password: 'password123',
        );
        final groupId = await FirebaseEmulatorHelper.createTestGroup(
          createdBy: creator.uid,
          name: 'Test Group 3',
        );
        final sessionId =
            await FirebaseEmulatorHelper.createTestTrainingSession(
          groupId: groupId,
          createdBy: creator.uid,
          title: 'Members Only Training',
          participantIds: [creator.uid],
        );

        await FirebaseEmulatorHelper.signOut();
        await FirebaseEmulatorHelper.signIn(
          email: 'outsider3@test.com',
          password: 'password123',
        );

        final doc = await FirebaseEmulatorHelper.firestore
            .collection('trainingSessions')
            .doc(sessionId)
            .get();

        expect(doc.exists, isTrue);
        expect(doc.data()!['title'], 'Members Only Training');
      },
    );

    test(
      'Non-member authenticated user does NOT see the session via a list query',
      () async {
        final creator = await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'creator4@test.com',
          password: 'password123',
          displayName: 'Creator User',
        );
        await FirebaseEmulatorHelper.createCompleteTestUser(
          email: 'outsider4@test.com',
          password: 'password123',
          displayName: 'Outsider User',
        );

        await FirebaseEmulatorHelper.signIn(
          email: 'creator4@test.com',
          password: 'password123',
        );
        final groupId = await FirebaseEmulatorHelper.createTestGroup(
          createdBy: creator.uid,
          name: 'Test Group 4',
        );
        await FirebaseEmulatorHelper.createTestTrainingSession(
          groupId: groupId,
          createdBy: creator.uid,
          title: 'Members Only Training 2',
          participantIds: [creator.uid],
        );

        await FirebaseEmulatorHelper.signOut();
        await FirebaseEmulatorHelper.signIn(
          email: 'outsider4@test.com',
          password: 'password123',
        );

        final snapshot = await FirebaseEmulatorHelper.firestore
            .collection('trainingSessions')
            .get();

        expect(
          snapshot.docs
              .where((d) => d.data()['title'] == 'Members Only Training 2'),
          isEmpty,
        );
      },
    );
  });

  group('games/{gameId} — unauthenticated access still denied', () {
    test('Unauthenticated user CANNOT get a game by ID', () async {
      final creator = await FirebaseEmulatorHelper.createCompleteTestUser(
        email: 'creator5@test.com',
        password: 'password123',
        displayName: 'Creator User',
      );

      await FirebaseEmulatorHelper.signIn(
        email: 'creator5@test.com',
        password: 'password123',
      );
      final groupId = await FirebaseEmulatorHelper.createTestGroup(
        createdBy: creator.uid,
        name: 'Test Group 5',
      );
      final gameId = await FirebaseEmulatorHelper.createTestGame(
        groupId: groupId,
        createdBy: creator.uid,
        title: 'Some Game',
        playerIds: [creator.uid],
      );

      await FirebaseEmulatorHelper.signOut();

      await expectLater(
        () async =>
            FirebaseEmulatorHelper.firestore.collection('games').doc(gameId).get(),
        throwsA(
          isA<FirebaseException>()
              .having((e) => e.code, 'code', 'permission-denied'),
        ),
      );
    });
  });
}
