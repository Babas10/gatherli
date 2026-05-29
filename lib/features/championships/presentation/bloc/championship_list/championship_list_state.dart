// States for ChampionshipListBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';

abstract class ChampionshipListState extends Equatable {
  const ChampionshipListState();
  @override
  List<Object?> get props => [];
}

class ChampionshipListInitial extends ChampionshipListState {
  const ChampionshipListInitial();
}

class ChampionshipListLoading extends ChampionshipListState {
  const ChampionshipListLoading();
}

class ChampionshipListLoaded extends ChampionshipListState {
  /// Full unfiltered list from repository (used to re-filter without re-fetching).
  final List<ChampionshipModel> allChampionships;

  /// Currently active filter:
  /// - null  → show all
  /// - 'registration' → show registration + registration_closed
  /// - 'active'       → show active
  /// - 'completed'    → show completed
  final String? activeFilter;

  const ChampionshipListLoaded({
    required this.allChampionships,
    this.activeFilter,
  });

  /// Returns the filtered subset of championships to display.
  List<ChampionshipModel> get championships {
    if (activeFilter == null) return allChampionships;
    if (activeFilter == 'registration') {
      return allChampionships
          .where((c) =>
              c.status == ChampionshipStatus.registration ||
              c.status == ChampionshipStatus.registrationClosed)
          .toList();
    }
    return allChampionships
        .where((c) => c.status.name == activeFilter)
        .toList();
  }

  ChampionshipListLoaded copyWith({
    List<ChampionshipModel>? allChampionships,
    Object? activeFilter = _sentinel,
  }) {
    return ChampionshipListLoaded(
      allChampionships: allChampionships ?? this.allChampionships,
      activeFilter:
          activeFilter == _sentinel ? this.activeFilter : activeFilter as String?,
    );
  }

  @override
  List<Object?> get props => [allChampionships, activeFilter];
}

const _sentinel = Object();

class ChampionshipListError extends ChampionshipListState {
  final String message;

  const ChampionshipListError({required this.message});

  @override
  List<Object?> get props => [message];
}
