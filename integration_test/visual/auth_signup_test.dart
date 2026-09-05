// Visual regression flow (tag: auth) — drives the real registration form
// end-to-end against the real gatherli-dev Firebase project and captures
// the resulting home screen with the email-verification prompt banner (the
// app's actual "please verify your email" UI, shown automatically for a
// freshly registered account). Cleans up the created account afterward via
// the real deleteUserAccount Cloud Function.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/presentation/widgets/auth_button.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../test/visual/tooling/checkpoint.dart';
import '../../test/visual/tooling/dev_firebase.dart';

const _testEmail = 'visual-signup@gatherli.test';
const _testPassword = 'VisualTest123';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('auth: sign up reaches the email verification prompt', (
    tester,
  ) async {
    await bootstrapFirebaseAgainstDev();

    // Defensive: clean up a leftover account from a previous crashed run.
    await deleteTestUserIfExists(email: _testEmail, password: _testPassword);

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

    // The signup flow leaves the account signed in — reuse that session
    // directly rather than deleteTestUserIfExists's sign-in-first logic.
    await deleteUserAccount();
  });
}
