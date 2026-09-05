import 'dart:async';

import 'sync_protocol.dart';

/// Call from a visual flow (after `tester.pumpAndSettle()`) to hand control
/// to the host orchestrator, which captures a real device screenshot named
/// [name] and hands control back once it's done.
///
/// Requires the flow to be running under `run_visual_tests.dart` (which
/// drives it and watches for checkpoints) — a bare `flutter test`/`flutter
/// drive` run will time out waiting for the done-marker, since nothing is
/// watching the ready-marker.
Future<void> visualCheckpoint(
  String name, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  // ignore: avoid_print
  print('SCREENSHOT_CHECKPOINT:$name');

  VisualSyncProtocol.readyFile.writeAsStringSync(name);

  final deadline = DateTime.now().add(timeout);
  while (true) {
    if (VisualSyncProtocol.doneFile.existsSync()) {
      final ackName = VisualSyncProtocol.doneFile.readAsStringSync().trim();
      if (ackName == name) {
        VisualSyncProtocol.doneFile.deleteSync();
        if (VisualSyncProtocol.readyFile.existsSync()) {
          VisualSyncProtocol.readyFile.deleteSync();
        }
        return;
      }
    }
    if (DateTime.now().isAfter(deadline)) {
      throw TimeoutException(
        'visualCheckpoint("$name") timed out waiting for the host '
        'orchestrator to capture a screenshot. Is this flow running under '
        'run_visual_tests.dart (not a bare flutter test/drive)?',
      );
    }
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
