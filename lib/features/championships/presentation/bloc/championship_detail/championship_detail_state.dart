// States for ChampionshipDetailBloc
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

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
  final List<ChampionshipTeamModel> teams;
  final List<ChampionshipMatchModel> currentRoundMatches;
  final int selectedRound;
  /// All matches across all rounds — used by the My Matches tab.
  final List<ChampionshipMatchModel> allMatches;
  /// Current user's gender: 'male', 'female', 'none', or null (unknown).
  final String? currentUserGender;

  const ChampionshipDetailLoaded({
    required this.championship,
    required this.standings,
    required this.teams,
    required this.currentRoundMatches,
    required this.selectedRound,
    this.allMatches = const [],
    this.currentUserGender,
  });

  ChampionshipDetailLoaded copyWith({
    ChampionshipModel? championship,
    List<ChampionshipStandingsModel>? standings,
    List<ChampionshipTeamModel>? teams,
    List<ChampionshipMatchModel>? currentRoundMatches,
    int? selectedRound,
    List<ChampionshipMatchModel>? allMatches,
    String? currentUserGender,
  }) {
    return ChampionshipDetailLoaded(
      championship: championship ?? this.championship,
      standings: standings ?? this.standings,
      teams: teams ?? this.teams,
      currentRoundMatches: currentRoundMatches ?? this.currentRoundMatches,
      selectedRound: selectedRound ?? this.selectedRound,
      allMatches: allMatches ?? this.allMatches,
      currentUserGender: currentUserGender ?? this.currentUserGender,
    );
  }

  @override
  List<Object?> get props => [
        championship,
        standings,
        teams,
        currentRoundMatches,
        selectedRound,
        allMatches,
        currentUserGender,
      ];
}

class ChampionshipDetailError extends ChampionshipDetailState {
  final String message;

  const ChampionshipDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
