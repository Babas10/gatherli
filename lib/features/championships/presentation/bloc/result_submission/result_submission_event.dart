// Events for ResultSubmissionBloc handling championship match result submission.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';

abstract class ResultSubmissionEvent extends Equatable {
  const ResultSubmissionEvent();
  @override
  List<Object?> get props => [];
}

class SubmitMatchResult extends ResultSubmissionEvent {
  final String championshipId;
  final String matchId;
  final List<MatchSetScore> sets;

  const SubmitMatchResult({
    required this.championshipId,
    required this.matchId,
    required this.sets,
  });

  @override
  List<Object?> get props => [championshipId, matchId, sets];
}
