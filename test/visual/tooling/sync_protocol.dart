import 'dart:io';

/// File-based handshake synchronizing an in-app `visualCheckpoint()` call
/// (test/visual/tooling/checkpoint.dart, compiled into the app under test)
/// with the host-side orchestrator (run_visual_tests.dart) that captures the
/// real device screenshot.
///
/// This only works because the iOS Simulator is a plain macOS process that
/// shares the host filesystem — a real device or an Android emulator (a true
/// separate VM) cannot see this path, which is why visual testing is
/// iOS-Simulator-only for now (see Epic 36 non-goals).
class VisualSyncProtocol {
  static const String syncDirPath = '/tmp/gatherli_visual_test';

  static Directory get syncDir => Directory(syncDirPath);
  static File get readyFile => File('$syncDirPath/ready');
  static File get doneFile => File('$syncDirPath/done');

  /// Host-side only: call once before launching the flow under test.
  static void reset() {
    if (syncDir.existsSync()) {
      syncDir.deleteSync(recursive: true);
    }
    syncDir.createSync(recursive: true);
  }
}
