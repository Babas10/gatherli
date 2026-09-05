// Visual regression flow (tag: auth) — logs in via the real login form with
// a seeded emulator user, walks every bottom-nav tab, then logs out. One
// continuous flow keeps this to a single app build/boot cycle.
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/presentation/widgets/auth_button.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../helpers/firebase_emulator_helper.dart';
import '../../test/visual/tooling/checkpoint.dart';

const _testEmail = 'visual-login@gatherli.test';
const _testPassword = 'VisualTest123';
const _testDisplayName = 'Visual Tester';

/// Wipes all Firebase Auth emulator accounts so the fixed test user below can
/// be recreated deterministically on every run (same uid-independent
/// content: fixed email/displayName -> stable screenshots).
Future<void> _resetAuthEmulator() async {
  final client = HttpClient();
  final request = await client.deleteUrl(
    Uri.parse(
      'http://localhost:9099/emulator/v1/projects/gatherli-dev/accounts',
    ),
  );
  final response = await request.close();
  await response.drain<void>();
  client.close();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('auth: login, navigate all tabs, logout', (tester) async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'test-api-key',
          appId: 'test-app-id',
          messagingSenderId: 'test-sender-id',
          projectId: 'gatherli-dev',
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code != 'duplicate-app') rethrow;
      Firebase.app();
    }
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

    await _resetAuthEmulator();
    await FirebaseEmulatorHelper.clearFirestore();

    await FirebaseEmulatorHelper.createCompleteTestUser(
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
  });
}
