// Events for ChampionshipDetailBloc
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';

abstract class ChampionshipDetailEvent extends Equatable {
  const ChampionshipDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Initiates loading of all championship detail data.
class LoadChampionshipDetail extends ChampionshipDetailEvent {
  final String championshipId;

  const LoadChampionshipDetail(this.championshipId);

  @override
  List<Object?> get props => [championshipId];
}

/// Navigates the matches view to a different round.
class ChangeDetailRound extends ChampionshipDetailEvent {
  final int round;

  const ChangeDetailRound(this.round);

  @override
  List<Object?> get props => [round];
}

/// Internal — emitted by the championship stream listener.
class ChampionshipDetailDataUpdated extends ChampionshipDetailEvent {
  final ChampionshipModel championship;

  const ChampionshipDetailDataUpdated(this.championship);

  @override
  List<Object?> get props => [championship];
}

/// Internal — emitted by the standings stream listener.
class ChampionshipDetailStandingsUpdated extends ChampionshipDetailEvent {
  final List<ChampionshipStandingsModel> standings;

  const ChampionshipDetailStandingsUpdated(this.standings);

  @override
  List<Object?> get props => [standings];
}

/// Internal — emitted by the matches stream listener.
class ChampionshipDetailMatchesUpdated extends ChampionshipDetailEvent {
  final List<ChampionshipMatchModel> matches;

  const ChampionshipDetailMatchesUpdated(this.matches);

  @override
  List<Object?> get props => [matches];
}

/// Internal — emitted when the championship stream produces an error.
class ChampionshipDetailLoadError extends ChampionshipDetailEvent {
  final String message;

  const ChampionshipDetailLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
