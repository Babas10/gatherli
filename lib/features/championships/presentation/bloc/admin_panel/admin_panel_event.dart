// Events for AdminPanelBloc (Story 30.12)
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';

abstract class AdminPanelEvent extends Equatable {
  const AdminPanelEvent();

  @override
  List<Object?> get props => [];
}

/// Loads all matches for the championship and starts real-time updates.
class LoadAdminPanel extends AdminPanelEvent {
  final String championshipId;

  const LoadAdminPanel(this.championshipId);

  @override
  List<Object?> get props => [championshipId];
}

/// Applies an admin decision to a specific match.
class DecideMatch extends AdminPanelEvent {
  final String matchId;
  final String decision; // 'set_result' | 'award_walkover' | 'cancel'
  final String? winnerId;
  final List<MatchSetScore>? sets;
  final String notes;

  const DecideMatch({
    required this.matchId,
    required this.decision,
    this.winnerId,
    this.sets,
    required this.notes,
  });

  @override
  List<Object?> get props => [matchId, decision, winnerId, sets, notes];
}

/// Internal: fired when the match stream emits a new list.
class AdminMatchesUpdated extends AdminPanelEvent {
  final List<ChampionshipMatchModel> matches;

  const AdminMatchesUpdated(this.matches);

  @override
  List<Object?> get props => [matches];
}

/// Internal: fired when the match stream emits an error.
class AdminMatchesError extends AdminPanelEvent {
  final String message;

  const AdminMatchesError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Admin triggers the championship active phase (generates round-robin fixtures).
class StartChampionship extends AdminPanelEvent {
  final String championshipId;
  final DateTime startDate;

  const StartChampionship({
    required this.championshipId,
    required this.startDate,
  });

  @override
  List<Object?> get props => [championshipId, startDate];
}

/// Admin manually marks the championship as complete.
class CompleteChampionship extends AdminPanelEvent {
  final String championshipId;

  const CompleteChampionship({required this.championshipId});

  @override
  List<Object?> get props => [championshipId];
}
