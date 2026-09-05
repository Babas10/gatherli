// Visual regression flow (tag: auth) — logs in via the real login form with
// a seeded user on the real gatherli-dev Firebase project, walks every
// bottom-nav tab, then logs out. One continuous flow keeps this to a single
// app build/boot cycle. Cleans up the test user (defensively before seeding,
// and always after) via the real deleteUserAccount Cloud Function.
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

const _testEmail = 'visual-login@gatherli.test';
const _testPassword = 'VisualTest123';
const _testDisplayName = 'Visual Tester';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('auth: login, navigate all tabs, logout', (tester) async {
    await bootstrapFirebaseAgainstDev();

    // Defensive: clean up a leftover account from a previous crashed run
    // before creating a fresh one with the same fixed email.
    await deleteTestUserIfExists(email: _testEmail, password: _testPassword);
    await createTestUser(
      email: _testEmail,
      password: _testPassword,
      displayName: _testDisplayName,
    );
    await FirebaseAuth.instance.signOut();

    await initializeDependencies();

    await tester.pumpWidget(const PlayWithMeApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.emailHint),
      _testEmail,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.passwordHint),
      _testPassword,
    );
    await tester.tap(find.byType(AuthButton));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await visualCheckpoint('home_screen');

    await tester.tap(find.text(l10n.stats));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('tab_stats');

    await tester.tap(find.text(l10n.groups));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('tab_groups');

    await tester.tap(find.text(l10n.community));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('tab_community');

    await tester.tap(find.text(l10n.championshipsTitle));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await visualCheckpoint('tab_championships');

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(FilledButton),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await visualCheckpoint('logged_out_screen');

    await deleteTestUserIfExists(email: _testEmail, password: _testPassword);
  });
}
