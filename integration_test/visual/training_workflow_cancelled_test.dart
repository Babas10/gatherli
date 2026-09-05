// Visual regression flow (tag: training) — lighter-depth training session
// cancellation against the real gatherli-dev Firebase project: seeds 2
// users and a group directly via Firestore (membership only, same rationale
// as training_workflow_completed_test.dart), creates a training session,
// and has its creator cancel it via the real UI, confirming propagation to
// the group's Activities tab.
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
const _groupName = 'Visual Training Squad (Cancel)';
const _sessionTitle = 'Sunset Beach Training';

class _SeedUser {
  const _SeedUser(this.email, this.displayName);
  final String email;
  final String displayName;
}

const _users = [
  _SeedUser('visual-training-cancel-1@gatherli.test', 'TC One'),
  _SeedUser('visual-training-cancel-2@gatherli.test', 'TC Two'),
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

// See training_workflow_completed_test.dart for why Start Time needs a
// date-picker step + time dialog, while End Time only needs the time dialog.
Future<void> _acceptDefaultStartAndEndTime(
  WidgetTester tester,
  AppLocalizations l10n,
) async {
  await tester.tap(find.text(l10n.startTime));
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok));
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok));
  await tester.pumpAndSettle();

  await tester.tap(find.text(l10n.endTime));
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'training: creator cancels a session, propagation to Activities',
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
        'Beach Court 2',
      );
      await _acceptDefaultStartAndEndTime(tester, l10n);

      await tester.ensureVisible(
        find.widgetWithText(FilledButton, l10n.createTrainingSession),
      );
      await tester.tap(
        find.widgetWithText(FilledButton, l10n.createTrainingSession),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // ── Organizer cancels the session ────────────────────────────────────
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.cancelSession));
      await tester.pumpAndSettle();

      await visualCheckpoint('training_cancel_confirmation_dialog');

      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(l10n.cancelSession),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ── Propagation check ─────────────────────────────────────────────────
      await _navigateToGroupActivities(tester, l10n);
      await tester.tap(find.text(_sessionTitle));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await visualCheckpoint('training_cancelled_status');
      expect(find.text(l10n.cancelled), findsWidgets);
      expect(find.text(l10n.join), findsNothing);

      // ── Functional assertion ─────────────────────────────────────────────
      final sessionQuery = await FirebaseFirestore.instance
          .collection('trainingSessions')
          .where('groupId', isEqualTo: groupRef.id)
          .where('title', isEqualTo: _sessionTitle)
          .limit(1)
          .get();
      final data = sessionQuery.docs.single.data();
      expect(data['status'], equals('cancelled'));
      expect(data['cancelledBy'], equals(uids[0]));

      await _logout(tester);

      // ── Cleanup ──────────────────────────────────────────────────────────
      for (final user in _users) {
        await deleteTestUserIfExists(email: user.email, password: _password);
      }
    },
  );
}
