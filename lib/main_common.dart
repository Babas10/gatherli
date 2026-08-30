import 'dart:async';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/services/firebase_service.dart';
import 'package:play_with_me/core/services/connectivity_service.dart';
import 'package:play_with_me/core/services/feature_flags.dart';
import 'package:play_with_me/core/services/deferred_deep_link/deferred_deep_link_orchestrator.dart';

// Helper: run an async step with a timeout and step logging.
// If the step exceeds [timeout], it logs a warning and continues
// so the app always reaches runApp() within a bounded time.
Future<void> _step(
  String name,
  Future<void> Function() fn, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final sw = Stopwatch()..start();
  debugPrint('[startup] ⏳ $name...');
  try {
    await fn().timeout(timeout, onTimeout: () {
      debugPrint('[startup] ⚠️  $name TIMED OUT after ${timeout.inSeconds}s — continuing');
    });
    debugPrint('[startup] ✅ $name done in ${sw.elapsedMilliseconds}ms');
  } catch (e) {
    debugPrint('[startup] ❌ $name failed in ${sw.elapsedMilliseconds}ms: $e');
    rethrow;
  }
}

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[startup] 🚀 App starting...');

  try {
    await _step('Firebase.initialize', FirebaseService.initialize);

    await _step('Crashlytics.setEnabled', () async {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    });

    await _step('initializeDependencies', initializeDependencies);

    // Fire-and-forget: does not block first frame. DeepLinkBloc awaits this
    // exact same future (via ensureChecked()'s single-flight caching) before
    // reading PendingInviteStorage, so cold-start deep links still resolve
    // correctly even though this no longer blocks runApp().
    unawaited(sl<DeferredDeepLinkOrchestrator>().ensureChecked());
    debugPrint('[startup] ✅ DeferredDeepLink.checkOnce queued (background)');

    ConnectivityService.instance.initialize();
    debugPrint('[startup] ✅ ConnectivityService initialized');

    unawaited(FeatureFlags.refresh());
    debugPrint('[startup] ✅ FeatureFlags refresh queued (background)');

    debugPrint('[startup] 🎉 Calling runApp()');
    runApp(const PlayWithMeApp());
  } catch (e) {
    debugPrint('[startup] 💥 FATAL: $e');

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'Failed to initialize app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
