// Visual regression harness orchestrator (Story 36.1).
//
// Runs one or more tagged flows from test/visual/manifest.json against a
// real iOS Simulator: drives each flow via `flutter test <file> -d <device>`,
// captures a real device screenshot at each `visualCheckpoint()` call inside
// the flow (synchronized via test/visual/tooling/sync_protocol.dart), diffs
// against the committed golden, and writes a local markdown report.
//
// Usage:
//   dart run test/visual/tooling/run_visual_tests.dart [--tags a,b] [--device <udid>] [--update-goldens] [--tolerance <percent>]
//
// iOS-Simulator-only: the checkpoint handshake relies on the simulator
// process sharing the host filesystem, which does not hold for a real device
// or an Android emulator (a true separate VM).
// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

import 'image_diff.dart';
import 'models.dart';
import 'report.dart';
import 'sync_protocol.dart';

const _repoRoot = '.';
const _manifestPath = '$_repoRoot/test/visual/manifest.json';
const _goldensRoot = '$_repoRoot/test/visual/goldens';
const _reportsRoot = '$_repoRoot/test/visual/reports';
const _defaultTolerancePercent = 0.5;

class FlowSpec {
  FlowSpec({required this.name, required this.tags, required this.file});
  final String name;
  final List<String> tags;
  final String file;
}

class Args {
  Args({
    required this.tags,
    required this.updateGoldens,
    required this.device,
    required this.tolerancePercent,
  });

  final List<String> tags;
  final bool updateGoldens;
  final String? device;
  final double tolerancePercent;

  static Args parse(List<String> argv) {
    var tags = <String>[];
    var updateGoldens = false;
    String? device;
    var tolerance = _defaultTolerancePercent;

    for (var i = 0; i < argv.length; i++) {
      final arg = argv[i];
      if (arg == '--tags' && i + 1 < argv.length) {
        tags = argv[++i].split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
      } else if (arg == '--update-goldens') {
        updateGoldens = true;
      } else if (arg == '--device' && i + 1 < argv.length) {
        device = argv[++i];
      } else if (arg == '--tolerance' && i + 1 < argv.length) {
        tolerance = double.parse(argv[++i]);
      } else if (arg == '--help' || arg == '-h') {
        _printUsage();
        exit(0);
      } else {
        stderr.writeln('Unknown argument: $arg');
        _printUsage();
        exit(2);
      }
    }

    return Args(tags: tags, updateGoldens: updateGoldens, device: device, tolerancePercent: tolerance);
  }
}

void _printUsage() {
  print('''
Usage: dart run test/visual/tooling/run_visual_tests.dart [options]

Options:
  --tags <a,b,c>       Only run flows tagged with at least one of these tags (default: all)
  --device <udid>      iOS Simulator device id (default: first booted simulator)
  --update-goldens     Overwrite committed goldens with freshly captured screenshots instead of diffing
  --tolerance <pct>    Max allowed percentage of differing pixels before a checkpoint fails (default: $_defaultTolerancePercent)
''');
}

Future<void> main(List<String> argv) async {
  final args = Args.parse(argv);

  final device = args.device ?? await _findBootedSimulator();
  if (device == null) {
    stderr.writeln('No booted iOS Simulator found. Boot one (e.g. `open -a Simulator`) or pass --device <udid>.');
    exit(1);
  }
  print('Using device: $device');

  final flows = _loadManifest(_manifestPath, args.tags);
  if (flows.isEmpty) {
    print('No flows match tags: ${args.tags.join(", ")}. Nothing to run.');
    return;
  }
  print('Running ${flows.length} flow(s): ${flows.map((f) => f.name).join(", ")}');

  await _freezeStatusBar(device);

  final runId = _timestamp();
  final runDir = Directory('$_reportsRoot/$runId')..createSync(recursive: true);

  final flowResults = <FlowResult>[];
  for (final flow in flows) {
    print('\n=== Flow: ${flow.name} ===');
    final result = await _runFlow(flow, device, args, runDir);
    flowResults.add(result);
  }

  final reportPath = writeReport(outputDir: runDir, flowResults: flowResults, requestedTags: args.tags);

  print('\n=== Report written to $reportPath ===');
  _printSummary(flowResults);

  final hasFailures = flowResults
      .expand((f) => f.checkpoints)
      .any((c) => c.status == CheckpointStatus.fail || c.status == CheckpointStatus.error);
  exit(hasFailures ? 1 : 0);
}

Future<String?> _findBootedSimulator() async {
  final result = await Process.run('xcrun', ['simctl', 'list', 'devices', 'booted', '--json']);
  if (result.exitCode != 0) return null;
  final json = jsonDecode(result.stdout as String) as Map<String, dynamic>;
  final devicesByRuntime = json['devices'] as Map<String, dynamic>;
  for (final entry in devicesByRuntime.entries) {
    final devices = entry.value as List<dynamic>;
    for (final d in devices) {
      final device = d as Map<String, dynamic>;
      if (device['state'] == 'Booted') {
        return device['udid'] as String;
      }
    }
  }
  return null;
}

Future<void> _freezeStatusBar(String device) async {
  final result = await Process.run('xcrun', [
    'simctl',
    'status_bar',
    device,
    'override',
    '--time', '9:41',
    '--dataNetwork', 'wifi',
    '--wifiMode', 'active',
    '--wifiBars', '3',
    '--batteryState', 'charged',
    '--batteryLevel', '100',
  ]);
  if (result.exitCode != 0) {
    stderr.writeln('Warning: failed to freeze status bar: ${result.stderr}');
  }
}

List<FlowSpec> _loadManifest(String path, List<String> requestedTags) {
  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln('Manifest not found: $path');
    exit(1);
  }
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final flowsJson = json['flows'] as List<dynamic>;
  final flows = flowsJson.map((f) {
    final map = f as Map<String, dynamic>;
    return FlowSpec(
      name: map['name'] as String,
      tags: (map['tags'] as List<dynamic>).cast<String>(),
      file: map['file'] as String,
    );
  }).toList();

  if (requestedTags.isEmpty) return flows;
  return flows.where((f) => f.tags.any(requestedTags.contains)).toList();
}

Future<FlowResult> _runFlow(FlowSpec flow, String device, Args args, Directory runDir) async {
  VisualSyncProtocol.reset();
  final checkpoints = <CheckpointResult>[];

  final process = await Process.start('flutter', ['test', flow.file, '-d', device]);
  process.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
    print('[${flow.name}] $line');
  });
  process.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
    print('[${flow.name}][stderr] $line');
  });

  var watching = true;
  final watcherDone = _watchCheckpoints(
    flow: flow,
    device: device,
    args: args,
    runDir: runDir,
    checkpoints: checkpoints,
    isWatching: () => watching,
  );

  final exitCode = await process.exitCode;
  watching = false;
  await watcherDone;

  return FlowResult(flowName: flow.name, checkpoints: checkpoints, processExitCode: exitCode);
}

Future<void> _watchCheckpoints({
  required FlowSpec flow,
  required String device,
  required Args args,
  required Directory runDir,
  required List<CheckpointResult> checkpoints,
  required bool Function() isWatching,
}) async {
  while (isWatching()) {
    if (VisualSyncProtocol.readyFile.existsSync()) {
      final name = VisualSyncProtocol.readyFile.readAsStringSync().trim();
      print('[${flow.name}] capturing checkpoint "$name"...');

      final result = await _captureAndDiff(flow: flow, checkpointName: name, device: device, args: args, runDir: runDir);
      checkpoints.add(result);

      VisualSyncProtocol.doneFile.writeAsStringSync(name);

      // Wait for the in-app helper to ack (it deletes ready+done itself) so
      // we don't race and reprocess the same ready file twice.
      final ackDeadline = DateTime.now().add(const Duration(seconds: 10));
      while (VisualSyncProtocol.readyFile.existsSync() && DateTime.now().isBefore(ackDeadline)) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }
    await Future.delayed(const Duration(milliseconds: 150));
  }
}

Future<CheckpointResult> _captureAndDiff({
  required FlowSpec flow,
  required String checkpointName,
  required String device,
  required Args args,
  required Directory runDir,
}) async {
  final flowReportDir = Directory('${runDir.path}/${flow.name}')..createSync(recursive: true);
  final capturedPath = '${flowReportDir.path}/$checkpointName.png';
  final goldenDir = Directory('$_goldensRoot/${flow.name}');
  final goldenPath = '${goldenDir.path}/$checkpointName.png';

  final screenshot = await Process.run('xcrun', ['simctl', 'io', device, 'screenshot', capturedPath]);
  if (screenshot.exitCode != 0) {
    return CheckpointResult(
      flow: flow.name,
      checkpoint: checkpointName,
      status: CheckpointStatus.error,
      message: 'simctl screenshot failed: ${screenshot.stderr}',
    );
  }

  if (args.updateGoldens) {
    goldenDir.createSync(recursive: true);
    File(capturedPath).copySync(goldenPath);
    return CheckpointResult(
      flow: flow.name,
      checkpoint: checkpointName,
      status: CheckpointStatus.updated,
      capturedPath: capturedPath,
      goldenPath: goldenPath,
    );
  }

  if (!File(goldenPath).existsSync()) {
    return CheckpointResult(
      flow: flow.name,
      checkpoint: checkpointName,
      status: CheckpointStatus.newBaseline,
      capturedPath: capturedPath,
      message: 'No golden yet — run with --update-goldens to accept this as the baseline.',
    );
  }

  final diff = diffImages(
    goldenBytes: File(goldenPath).readAsBytesSync(),
    capturedBytes: File(capturedPath).readAsBytesSync(),
  );

  if (diff.percentDifferent <= args.tolerancePercent) {
    return CheckpointResult(
      flow: flow.name,
      checkpoint: checkpointName,
      status: CheckpointStatus.pass,
      percentDifferent: diff.percentDifferent,
      capturedPath: capturedPath,
      goldenPath: goldenPath,
    );
  }

  final diffPath = '${flowReportDir.path}/$checkpointName.diff.png';
  File(diffPath).writeAsBytesSync(diff.diffImageBytes);
  return CheckpointResult(
    flow: flow.name,
    checkpoint: checkpointName,
    status: CheckpointStatus.fail,
    percentDifferent: diff.percentDifferent,
    capturedPath: capturedPath,
    goldenPath: goldenPath,
    diffPath: diffPath,
    message: diff.dimensionMismatch ? 'Image dimensions differ from golden' : null,
  );
}

void _printSummary(List<FlowResult> flowResults) {
  for (final flow in flowResults) {
    for (final c in flow.checkpoints) {
      final label = switch (c.status) {
        CheckpointStatus.pass => 'PASS',
        CheckpointStatus.fail => 'FAIL',
        CheckpointStatus.newBaseline => 'NEW ',
        CheckpointStatus.updated => 'UPD ',
        CheckpointStatus.error => 'ERR ',
      };
      final diffStr = c.percentDifferent != null ? ' (${c.percentDifferent!.toStringAsFixed(2)}%)' : '';
      print('  [$label] ${c.flow}/${c.checkpoint}$diffStr');
    }
  }
}

String _timestamp() {
  final now = DateTime.now();
  String p2(int n) => n.toString().padLeft(2, '0');
  return '${now.year}${p2(now.month)}${p2(now.day)}_${p2(now.hour)}${p2(now.minute)}${p2(now.second)}';
}
