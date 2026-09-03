// Visual regression flow (tag: smoke) — boots the real app against the
// Firebase Emulator and captures its initial screen. Proves the harness
// pipeline end-to-end (Story 36.1); not a functional assertion test.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';

import '../../test/visual/tooling/checkpoint.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke: app launch reaches its initial screen', (tester) async {
    // iOS auto-initializes the default Firebase app natively (from the
    // bundled GoogleService-Info.plist) before this test body runs, but the
    // Dart-side Firebase.apps cache doesn't know about it yet — Firebase.app()
    // is what actually binds to it. Firebase.apps.isEmpty is not a reliable
    // check here, so try initializeApp() and fall back on duplicate-app.
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

    await initializeDependencies();

    await tester.pumpWidget(const PlayWithMeApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await visualCheckpoint('initial_screen');
  });
}
