// Events for ChampionshipListBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';

abstract class ChampionshipListEvent extends Equatable {
  const ChampionshipListEvent();
  @override
  List<Object?> get props => [];
}

/// Subscribes to the championships stream from the repository.
class LoadChampionships extends ChampionshipListEvent {
  const LoadChampionships();
}

/// Internal event emitted when the repository stream emits a new list.
class ChampionshipsUpdated extends ChampionshipListEvent {
  final List<ChampionshipModel> championships;

  const ChampionshipsUpdated(this.championships);

  @override
  List<Object?> get props => [championships];
}

/// Filters the loaded championships by status.
/// [status] is null to show all, or 'registration' / 'active' / 'completed'.
class FilterChampionships extends ChampionshipListEvent {
  final String? status;

  const FilterChampionships({this.status});

  @override
  List<Object?> get props => [status];
}
