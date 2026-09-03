enum CheckpointStatus { pass, fail, newBaseline, updated, error }

class CheckpointResult {
  CheckpointResult({
    required this.flow,
    required this.checkpoint,
    required this.status,
    this.percentDifferent,
    this.capturedPath,
    this.goldenPath,
    this.diffPath,
    this.message,
  });

  final String flow;
  final String checkpoint;
  final CheckpointStatus status;
  final double? percentDifferent;
  final String? capturedPath;
  final String? goldenPath;
  final String? diffPath;
  final String? message;
}

class FlowResult {
  FlowResult({
    required this.flowName,
    required this.checkpoints,
    required this.processExitCode,
  });

  final String flowName;
  final List<CheckpointResult> checkpoints;
  final int processExitCode;
}
