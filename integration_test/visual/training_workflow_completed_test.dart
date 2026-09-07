// Visual regression flow (tag: training) — training session lifecycle
// against the real gatherli-dev Firebase project: seeds 4 users and a group
// directly via Firestore (membership only — training sessions depend only
// on group membership, same rationale as the game-workflow flows), creates
// a training session via the real UI, has all 4 users join (unlike games,
// the creator is NOT auto-added as a participant on creation), forces it
// into a completed state, and confirms propagation to the group's
// Activities tab and Home's "Next Training Session" card. Training sessions
// have no scores/ELO — completion is a pure attendance/status concept.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/presentation/widgets/auth_button.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../test/visual/tooling/checkpoint.dart';
import '../../test/visual/tooling/dev_firebase.dart';

const _password = 'VisualTest123';
const _groupName = 'Visual Training Squad';
const _sessionTitle = 'Beach Volleyball Training';

class _SeedUser {
  const _SeedUser(this.email, this.displayName);
  final String email;
  final String displayName;
}

const _users = [
  _SeedUser('visual-training-1@gatherli.test', 'T One'),
  _SeedUser('visual-training-2@gatherli.test', 'T Two'),
  _SeedUser('visual-training-3@gatherli.test', 'T Three'),
  _SeedUser('visual-training-4@gatherli.test', 'T Four'),
];

Future<void> _login(
  WidgetTester tester,
  AppLocalizations l10n,
  String email,
) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, l10n.emailHint),
    email,
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, l10n.passwordHint),
    _password,
  );
  await tester.tap(find.byType(AuthButton));
  await tester.pumpAndSettle(const Duration(seconds: 5));
}

Future<void> _logout(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.logout));
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(FilledButton),
    ),
  );
  await tester.pumpAndSettle(const Duration(seconds: 3));
}

Future<void> _navigateToGroupActivities(
  WidgetTester tester,
  AppLocalizations l10n,
) async {
  await tester.tap(find.text(l10n.groups));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(find.text(_groupName));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(find.text(l10n.activities));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

// Start Time needs a date-picker step (accept the pre-selected default of
// tomorrow) then a Cupertino time dialog (accept the default of 14:00,
// since "tomorrow" is never "today"). End Time only shows the time dialog —
// TrainingSessionCreationPage._selectEndTime has no date step, it reuses
// the start date — and is already pre-filled to start+2h, so accepting the
// default with a single OK is enough.
Future<void> _acceptDefaultStartAndEndTime(
  WidgetTester tester,
  AppLocalizations l10n,
) async {
  await tester.tap(find.text(l10n.startTime));
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok)); // confirm calendar date
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok)); // confirm time-of-day
  await tester.pumpAndSettle();

  await tester.tap(find.text(l10n.endTime));
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok)); // confirm time-of-day
  await tester.pumpAndSettle();
}

Future<void> _joinSession(WidgetTester tester, AppLocalizations l10n) async {
  await tester.tap(find.text(_sessionTitle));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(find.text(l10n.join));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'training: create, join, auto-complete, propagation to Activities & Home',
    (tester) async {
      await bootstrapFirebaseAgainstDev();

      for (final user in _users) {
        await deleteTestUserIfExists(email: user.email, password: _password);
      }

      final uids = <String>[];
      for (final user in _users) {
        final uid = await createTestUser(
          email: user.email,
          password: _password,
          displayName: user.displayName,
        );
        uids.add(uid);
      }

      // Seed the group directly as membership-only — same rationale as the
      // game-workflow flows: training sessions depend only on group
      // membership, not the social graph.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _users[0].email,
        password: _password,
      );
      final groupRef = await FirebaseFirestore.instance.collection('groups').add({
        'name': _groupName,
        'createdBy': uids[0],
        'createdAt': FieldValue.serverTimestamp(),
        'memberIds': [uids[0]],
        'adminIds': [uids[0]],
        'lastActivity': FieldValue.serverTimestamp(),
      });
      await groupRef.update({'memberIds': uids});
      await FirebaseAuth.instance.signOut();

      await initializeDependencies();

      await tester.pumpWidget(const PlayWithMeApp());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      // ── Organizer: create the training session ──────────────────────────
      await _login(tester, l10n, _users[0].email);
      await _navigateToGroupActivities(tester, l10n);

      await tester.tap(find.text(l10n.createTraining));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(
        find.widgetWithText(TextFormField, l10n.title),
        _sessionTitle,
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, l10n.location),
        'Beach Court 1',
      );
      await _acceptDefaultStartAndEndTime(tester, l10n);

      await tester.ensureVisible(
        find.widgetWithText(FilledButton, l10n.createTrainingSession),
      );
      await tester.tap(
        find.widgetWithText(FilledButton, l10n.createTrainingSession),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Unlike games, the creator is NOT auto-added as a participant.
      await tester.tap(find.text(l10n.join));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // No screenshot here deliberately: this screen shows the freshly
      // auto-selected "tomorrow" date/time, which is a different calendar
      // date every day the flow runs — an unavoidable diff, not a
      // regression. The organizer's join is still verified functionally by
      // "4/10 participants" showing up in the later training_completed_status
      // checkpoint.

      await _logout(tester);

      // ── Remaining 3 users join ───────────────────────────────────────────
      for (var i = 1; i < _users.length; i++) {
        await _login(tester, l10n, _users[i].email);
        await _navigateToGroupActivities(tester, l10n);
        await _joinSession(tester, l10n);
        await _logout(tester);
      }

      // Force the session into the past — the creation UI only allows
      // future times, but completion requires endTime to have already
      // elapsed. Requires authentication for the query, so sign in via the
      // SDK just for this.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _users[0].email,
        password: _password,
      );
      final sessionQuery = await FirebaseFirestore.instance
          .collection('trainingSessions')
          .where('groupId', isEqualTo: groupRef.id)
          .where('title', isEqualTo: _sessionTitle)
          .limit(1)
          .get();
      final sessionId = sessionQuery.docs.single.id;
      // Must stay a recent past time, not a fixed historical date: the
      // group Activities tab buckets old items into a paginated "older past
      // activities" section behind a "Load older activities" tap — a fixed
      // 2020 date fell into that bucket and the flow could no longer find
      // the session by title. This does mean the details page's displayed
      // start time drifts by a few minutes run to run (unavoidable without
      // losing visibility) — not a regression if training_completed_status
      // shows only a minute-level diff.
      await FirebaseFirestore.instance
          .collection('trainingSessions')
          .doc(sessionId)
          .update({
            'startTime': Timestamp.fromDate(
              DateTime.now().subtract(const Duration(hours: 3)),
            ),
            'endTime': Timestamp.fromDate(
              DateTime.now().subtract(const Duration(hours: 1)),
            ),
          });
      await FirebaseAuth.instance.signOut();

      // ── Organizer: reopen the session to trigger the client-side
      // status-flip check (TrainingSessionDetailsPage.initState calls
      // updateSessionStatusIfNeeded — there is no manual "mark completed"
      // action). All 4 participants (>= minParticipants of 2) are already
      // joined, so it flips to completed rather than auto-cancelling.
      await _login(tester, l10n, _users[0].email);
      await _navigateToGroupActivities(tester, l10n);
      await tester.tap(find.text(_sessionTitle));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Known flaky checkpoint, two sources, neither a regression:
      // (1) the participant list has no explicit sort order (same root
      // cause as community_friends_and_group_test.dart's
      // friends_list_seeded — fresh random Firestore doc IDs each run);
      // (2) the displayed start time drifts by a few minutes run to run
      // (see the scheduledAt patch above for why it can't be a fixed date).
      await visualCheckpoint('training_completed_status');
      expect(find.text(l10n.completed), findsWidgets);
      // No action button (join/leave) once completed.
      expect(find.text(l10n.join), findsNothing);
      expect(find.text(l10n.leave), findsNothing);

      // Feedback tab only appears once completed and the viewer participated.
      expect(find.text(l10n.feedback), findsOneWidget);

      // ── Propagation checks ────────────────────────────────────────────────
      await tester.pageBack();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await visualCheckpoint('training_group_activity_completed');

      await tester.tap(find.text(l10n.home));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await visualCheckpoint('training_home_no_upcoming_session');

      // ── Functional assertion: no ELO/score fields exist on training docs.
      final completedSession = await FirebaseFirestore.instance
          .collection('trainingSessions')
          .doc(sessionId)
          .get();
      final data = completedSession.data()!;
      expect(data['status'], equals('completed'));
      expect(data.containsKey('eloCalculated'), isFalse);
      expect(data.containsKey('eloUpdates'), isFalse);

      await _logout(tester);

      // ── Cleanup ──────────────────────────────────────────────────────────
      for (final user in _users) {
        await deleteTestUserIfExists(email: user.email, password: _password);
      }
    },
  );
}
