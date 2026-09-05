// Visual regression flow (tag: smoke) — boots the real app against the
// real gatherli-dev Firebase project and captures its initial screen.
// Proves the harness pipeline end-to-end (Story 36.1); not a functional
// assertion test. This flow creates no data, so it needs no cleanup.
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';

import '../../test/visual/tooling/checkpoint.dart';
import '../../test/visual/tooling/dev_firebase.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke: app launch reaches its initial screen', (tester) async {
    await bootstrapFirebaseAgainstDev();

    await initializeDependencies();

    await tester.pumpWidget(const PlayWithMeApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await visualCheckpoint('initial_screen');
  });
}
