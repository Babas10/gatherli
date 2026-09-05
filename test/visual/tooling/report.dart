import 'dart:io';

import 'models.dart';

/// Writes a local markdown report (pass/fail table + diff thumbnails for
/// failures) to [outputDir]/report.md. Never posted anywhere automatically —
/// paste the relevant section into the PR description by hand (Story 36.3).
String writeReport({
  required Directory outputDir,
  required List<FlowResult> flowResults,
  required List<String> requestedTags,
}) {
  final allCheckpoints = flowResults.expand((f) => f.checkpoints).toList();
  final passed = allCheckpoints.where((c) => c.status == CheckpointStatus.pass).length;
  final failed = allCheckpoints.where((c) => c.status == CheckpointStatus.fail).length;
  final newBaselines = allCheckpoints.where((c) => c.status == CheckpointStatus.newBaseline).length;
  final updated = allCheckpoints.where((c) => c.status == CheckpointStatus.updated).length;
  final errored = allCheckpoints.where((c) => c.status == CheckpointStatus.error).length;

  final buffer = StringBuffer();
  buffer.writeln('# Visual Regression Report');
  buffer.writeln();
  buffer.writeln('Tags: ${requestedTags.isEmpty ? "(all)" : requestedTags.join(", ")}');
  buffer.writeln();
  buffer.writeln('## Summary');
  buffer.writeln();
  buffer.writeln('- Total checkpoints: ${allCheckpoints.length}');
  buffer.writeln('- ✅ Passed: $passed');
  buffer.writeln('- ❌ Failed: $failed');
  buffer.writeln('- 🆕 New (no baseline yet — run with --update-goldens to accept): $newBaselines');
  buffer.writeln('- 🔄 Updated (--update-goldens ran): $updated');
  buffer.writeln('- ⚠️ Errored (capture/process failure): $errored');
  buffer.writeln();

  final overallResult = (failed == 0 && errored == 0) ? 'PASS' : 'FAIL';
  buffer.writeln('**Overall: $overallResult**');
  buffer.writeln();

  if (failed > 0) {
    buffer.writeln('## Failures');
    buffer.writeln();
    for (final c in allCheckpoints.where((c) => c.status == CheckpointStatus.fail)) {
      buffer.writeln('### ${c.flow} / ${c.checkpoint}');
      buffer.writeln();
      buffer.writeln('- Diff: ${c.percentDifferent?.toStringAsFixed(2)}% of pixels differ');
      buffer.writeln('- Golden: `${c.goldenPath}`');
      buffer.writeln('- Captured: `${c.capturedPath}`');
      buffer.writeln('- Diff image: `${c.diffPath}`');
      buffer.writeln();
      if (c.diffPath != null) {
        buffer.writeln('![diff](${_relativeToReport(c.diffPath!, outputDir)})');
        buffer.writeln();
      }
    }
  }

  if (errored > 0) {
    buffer.writeln('## Errors');
    buffer.writeln();
    for (final c in allCheckpoints.where((c) => c.status == CheckpointStatus.error)) {
      buffer.writeln('- ${c.flow} / ${c.checkpoint}: ${c.message}');
    }
    buffer.writeln();
  }

  buffer.writeln('## All checkpoints');
  buffer.writeln();
  buffer.writeln('| Flow | Checkpoint | Status | Diff % |');
  buffer.writeln('|---|---|---|---|');
  for (final c in allCheckpoints) {
    final diffStr = c.percentDifferent != null ? c.percentDifferent!.toStringAsFixed(2) : '-';
    buffer.writeln('| ${c.flow} | ${c.checkpoint} | ${_statusLabel(c.status)} | $diffStr |');
  }
  buffer.writeln();

  final reportFile = File('${outputDir.path}/report.md');
  reportFile.writeAsStringSync(buffer.toString());
  return reportFile.path;
}

String _statusLabel(CheckpointStatus status) {
  switch (status) {
    case CheckpointStatus.pass:
      return '✅ pass';
    case CheckpointStatus.fail:
      return '❌ fail';
    case CheckpointStatus.newBaseline:
      return '🆕 new';
    case CheckpointStatus.updated:
      return '🔄 updated';
    case CheckpointStatus.error:
      return '⚠️ error';
  }
}

String _relativeToReport(String absoluteOrRelativePath, Directory outputDir) {
  final path = File(absoluteOrRelativePath).absolute.path;
  final base = outputDir.absolute.path;
  if (path.startsWith(base)) {
    return path.substring(base.length + 1);
  }
  return path;
}
