// Events for MatchDetailBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';

abstract class MatchDetailEvent extends Equatable {
  const MatchDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadMatchDetail extends MatchDetailEvent {
  final String championshipId;
  final String matchId;
  final String currentUserId;

  const LoadMatchDetail({
    required this.championshipId,
    required this.matchId,
    required this.currentUserId,
  });

  @override
  List<Object?> get props => [championshipId, matchId, currentUserId];
}

class ProposeSchedule extends MatchDetailEvent {
  final DateTime scheduledAt;
  final String? location;

  const ProposeSchedule({required this.scheduledAt, this.location});

  @override
  List<Object?> get props => [scheduledAt, location];
}

/// Confirms the schedule proposed by the opposing team.
class AcceptSchedule extends MatchDetailEvent {
  const AcceptSchedule();
}

/// Rejects the schedule proposed by the opposing team, resetting to pending.
class RejectSchedule extends MatchDetailEvent {
  const RejectSchedule();
}

/// Internal event emitted when the match stream delivers a new snapshot.
class MatchDetailMatchUpdated extends MatchDetailEvent {
  final ChampionshipMatchModel match;

  const MatchDetailMatchUpdated(this.match);

  @override
  List<Object?> get props => [match];
}

/// Internal event emitted when the match stream errors.
class MatchDetailLoadError extends MatchDetailEvent {
  final String message;

  const MatchDetailLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
