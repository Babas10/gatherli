// Visual regression flow (tag: games) — lighter-depth pickup-game lifecycle
// for an all-female game against the real gatherli-dev Firebase project:
// seeds 4 female users and a group directly via Firestore (membership only,
// same rationale as game_workflow_male_test.dart), creates a game via the
// real UI, has the other 3 players join, submits and verifies a score, then
// confirms the ELO change on Home and the Game Results page. See the male
// flow for the full-depth version covering Group Activities/My Games/Stats
// as well. Cleans up all 4 accounts afterward.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/presentation/widgets/auth_button.dart';
import 'package:play_with_me/features/games/presentation/widgets/game_team_picker_widget.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../test/visual/tooling/checkpoint.dart';
import '../../test/visual/tooling/dev_firebase.dart';

const _password = 'VisualTest123';
const _groupName = 'Visual Game Squad (Female)';
const _gameTitle = 'Female Pickup Game';

class _SeedUser {
  const _SeedUser(this.email, this.displayName);
  final String email;
  final String displayName;
}

// Short display names — see game_workflow_male_test.dart for why (avoids a
// pre-existing Game Results card overflow with longer combined team names).
const _users = [
  _SeedUser('visual-game-f1@gatherli.test', 'F One'),
  _SeedUser('visual-game-f2@gatherli.test', 'F Two'),
  _SeedUser('visual-game-f3@gatherli.test', 'F Three'),
  _SeedUser('visual-game-f4@gatherli.test', 'F Four'),
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

Future<void> _acceptDefaultDateTime(
  WidgetTester tester,
  AppLocalizations l10n,
) async {
  await tester.tap(find.text(l10n.dateTime));
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok).first);
  await tester.pumpAndSettle();
  await tester.tap(find.text(l10n.ok).first);
  await tester.pumpAndSettle();
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

Future<void> _joinGame(WidgetTester tester, AppLocalizations l10n) async {
  await tester.tap(find.text(_gameTitle));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  // Hardcoded literal in game_details_page.dart — not localized.
  await tester.tap(find.text("I'm In"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('games: female pickup game — create, join, score, verify, ELO', (
    tester,
  ) async {
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
        gender: 'female',
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

    // ── Organizer: create the game ──────────────────────────────────────────
    await _login(tester, l10n, _users[0].email);
    await _navigateToGroupActivities(tester, l10n);

    await tester.tap(find.text(l10n.createGame));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.gameTitle),
      _gameTitle,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.location),
      'Beach Court 2',
    );
    await _acceptDefaultDateTime(tester, l10n);

    await tester.ensureVisible(find.widgetWithText(FilledButton, l10n.createGame));
    await tester.tap(find.widgetWithText(FilledButton, l10n.createGame));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await _logout(tester);

    // ── Remaining 3 players join ────────────────────────────────────────────
    for (var i = 1; i < _users.length; i++) {
      await _login(tester, l10n, _users[i].email);
      await _navigateToGroupActivities(tester, l10n);
      await _joinGame(tester, l10n);
      await _logout(tester);
    }

    // Force the game into the past — see male flow for why. Requires
    // authentication for the query, so sign in via the SDK just for this.
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _users[0].email,
      password: _password,
    );
    final gameQuery = await FirebaseFirestore.instance
        .collection('games')
        .where('groupId', isEqualTo: groupRef.id)
        .where('title', isEqualTo: _gameTitle)
        .limit(1)
        .get();
    final gameId = gameQuery.docs.single.id;
    await FirebaseFirestore.instance.collection('games').doc(gameId).update({
      'scheduledAt': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(hours: 1)),
      ),
    });
    await FirebaseAuth.instance.signOut();

    // ── Organizer: enter and submit the score ───────────────────────────────
    await _login(tester, l10n, _users[0].email);
    await _navigateToGroupActivities(tester, l10n);
    await tester.tap(find.text(_gameTitle));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text(l10n.enterResults));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.widgetWithText(ElevatedButton, '1'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(GameTeamPickerWidget),
        matching: find.byType(InkWell),
      ).first,
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('team_a_score_0_0')), '21');
    await tester.enterText(find.byKey(const Key('team_b_score_0_0')), '18');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(FilledButton, l10n.saveScores));
    await tester.tap(find.widgetWithText(FilledButton, l10n.saveScores));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await _logout(tester);

    // ── A different participant confirms the result ─────────────────────────
    await _login(tester, l10n, _users[1].email);
    await _navigateToGroupActivities(tester, l10n);
    await tester.tap(find.text(_gameTitle));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Hardcoded literal in game_details_page.dart — not localized.
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // ── Propagation checks ───────────────────────────────────────────────────
    await tester.tap(find.text(l10n.home));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('female_home_elo');

    await _navigateToGroupActivities(tester, l10n);
    await tester.tap(find.text(_gameTitle));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Hardcoded literal in game_details_page.dart — not localized.
    await tester.tap(find.text('Game Results'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('female_game_results_elo');

    // ── Functional assertion: real ELO change for a same-gender game ───────
    final completedGame = await FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .get();
    final data = completedGame.data()!;
    expect(data['eloCalculated'], isTrue);
    final eloUpdates = Map<String, dynamic>.from(data['eloUpdates'] as Map);
    expect(eloUpdates, isNotEmpty);
    for (final uid in uids) {
      expect(eloUpdates.containsKey(uid), isTrue);
    }

    await _logout(tester);

    // ── Cleanup ──────────────────────────────────────────────────────────────
    for (final user in _users) {
      await deleteTestUserIfExists(email: user.email, password: _password);
    }
  });
}
