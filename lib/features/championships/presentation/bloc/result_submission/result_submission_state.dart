// States for ResultSubmissionBloc handling championship match result submission.
import 'package:equatable/equatable.dart';

abstract class ResultSubmissionState extends Equatable {
  const ResultSubmissionState();
  @override
  List<Object?> get props => [];
}

class ResultSubmissionInitial extends ResultSubmissionState {
  const ResultSubmissionInitial();
}

class ResultSubmissionSubmitting extends ResultSubmissionState {
  const ResultSubmissionSubmitting();
}

class ResultSubmissionSuccess extends ResultSubmissionState {
  const ResultSubmissionSuccess();
}

class ResultSubmissionError extends ResultSubmissionState {
  final String message;
  final String? errorCode;

  const ResultSubmissionError({required this.message, this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}
