// Visual regression flow (tag: auth) — drives the real registration form
// end-to-end and captures the resulting home screen with the
// email-verification prompt banner (the app's actual "please verify your
// email" UI, shown automatically for a freshly registered account).
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

const _testEmail = 'visual-signup@gatherli.test';
const _testPassword = 'VisualTest123';

/// See auth_login_and_navigation_test.dart — same rationale: wipes emulator
/// auth accounts so this fixed signup email doesn't collide on rerun.
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

  testWidgets('auth: sign up reaches the email verification prompt', (
    tester,
  ) async {
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

    await initializeDependencies();

    await tester.pumpWidget(const PlayWithMeApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    await tester.tap(find.text(l10n.signUp));
    await tester.pumpAndSettle();

    await visualCheckpoint('registration_form');

    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.firstNameHint),
      'Visual',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.lastNameHint),
      'Tester',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.displayNameHintRequired),
      'Visual Signup Tester',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.emailHint),
      _testEmail,
    );
    await tester.tap(find.text(l10n.genderMale));
    await tester.pump();
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.passwordHint),
      _testPassword,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.confirmPassword),
      _testPassword,
    );

    await tester.ensureVisible(find.byType(AuthButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(AuthButton));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await visualCheckpoint('post_signup_home');
  });
}
