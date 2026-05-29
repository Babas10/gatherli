// States for MatchVerificationBloc handling verify/dispute of a submitted match result.
import 'package:equatable/equatable.dart';

abstract class MatchVerificationState extends Equatable {
  const MatchVerificationState();
  @override
  List<Object?> get props => [];
}

class MatchVerificationInitial extends MatchVerificationState {
  const MatchVerificationInitial();
}

class MatchVerificationLoading extends MatchVerificationState {
  const MatchVerificationLoading();
}

class MatchVerificationVerified extends MatchVerificationState {
  const MatchVerificationVerified();
}

class MatchVerificationDisputed extends MatchVerificationState {
  const MatchVerificationDisputed();
}

class MatchVerificationError extends MatchVerificationState {
  final String message;
  final String? errorCode;

  const MatchVerificationError({required this.message, this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}
