// Events for MatchVerificationBloc handling verify/dispute of a submitted match result.
import 'package:equatable/equatable.dart';

abstract class MatchVerificationEvent extends Equatable {
  const MatchVerificationEvent();
  @override
  List<Object?> get props => [];
}

class VerifyMatchResult extends MatchVerificationEvent {
  final String championshipId;
  final String matchId;

  const VerifyMatchResult({
    required this.championshipId,
    required this.matchId,
  });

  @override
  List<Object?> get props => [championshipId, matchId];
}

class DisputeMatchResult extends MatchVerificationEvent {
  final String championshipId;
  final String matchId;
  final String reason;

  const DisputeMatchResult({
    required this.championshipId,
    required this.matchId,
    required this.reason,
  });

  @override
  List<Object?> get props => [championshipId, matchId, reason];
}
