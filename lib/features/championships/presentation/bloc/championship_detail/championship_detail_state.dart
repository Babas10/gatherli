// States for ChampionshipDetailBloc
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';

abstract class ChampionshipDetailState extends Equatable {
  const ChampionshipDetailState();

  @override
  List<Object?> get props => [];
}

class ChampionshipDetailInitial extends ChampionshipDetailState {
  const ChampionshipDetailInitial();
}

class ChampionshipDetailLoading extends ChampionshipDetailState {
  const ChampionshipDetailLoading();
}

class ChampionshipDetailLoaded extends ChampionshipDetailState {
  final ChampionshipModel championship;
  final List<ChampionshipStandingsModel> standings;
  final List<ChampionshipMatchModel> currentRoundMatches;
  final int selectedRound;

  const ChampionshipDetailLoaded({
    required this.championship,
    required this.standings,
    required this.currentRoundMatches,
    required this.selectedRound,
  });

  ChampionshipDetailLoaded copyWith({
    ChampionshipModel? championship,
    List<ChampionshipStandingsModel>? standings,
    List<ChampionshipMatchModel>? currentRoundMatches,
    int? selectedRound,
  }) {
    return ChampionshipDetailLoaded(
      championship: championship ?? this.championship,
      standings: standings ?? this.standings,
      currentRoundMatches: currentRoundMatches ?? this.currentRoundMatches,
      selectedRound: selectedRound ?? this.selectedRound,
    );
  }

  @override
  List<Object?> get props => [
        championship,
        standings,
        currentRoundMatches,
        selectedRound,
      ];
}

class ChampionshipDetailError extends ChampionshipDetailState {
  final String message;

  const ChampionshipDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
