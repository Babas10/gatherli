// States for MatchDetailBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

abstract class MatchDetailState extends Equatable {
  const MatchDetailState();

  @override
  List<Object?> get props => [];
}

class MatchDetailInitial extends MatchDetailState {
  const MatchDetailInitial();
}

class MatchDetailLoading extends MatchDetailState {
  const MatchDetailLoading();
}

class MatchDetailLoaded extends MatchDetailState {
  final String championshipId;
  final ChampionshipMatchModel match;
  final ChampionshipTeamModel teamA;
  final ChampionshipTeamModel teamB;

  /// The team ID the current user belongs to, or null if they are not a member
  /// of either competing team.
  final String? myTeamId;

  final bool isProposingSchedule;
  final String? scheduleError;

  const MatchDetailLoaded({
    required this.championshipId,
    required this.match,
    required this.teamA,
    required this.teamB,
    required this.myTeamId,
    this.isProposingSchedule = false,
    this.scheduleError,
  });

  bool get isTeamMember => myTeamId != null;

  MatchDetailLoaded copyWith({
    ChampionshipMatchModel? match,
    ChampionshipTeamModel? teamA,
    ChampionshipTeamModel? teamB,
    String? myTeamId,
    bool? isProposingSchedule,
    // Allows explicitly resetting scheduleError to null via copyWith.
    Object? scheduleError = _sentinel,
  }) {
    return MatchDetailLoaded(
      championshipId: championshipId,
      match: match ?? this.match,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      myTeamId: myTeamId ?? this.myTeamId,
      isProposingSchedule:
          isProposingSchedule ?? this.isProposingSchedule,
      scheduleError: scheduleError == _sentinel
          ? this.scheduleError
          : scheduleError as String?,
    );
  }

  @override
  List<Object?> get props => [
        championshipId,
        match,
        teamA,
        teamB,
        myTeamId,
        isProposingSchedule,
        scheduleError,
      ];
}

// Sentinel value used to distinguish "not provided" from explicit null in copyWith.
const Object _sentinel = Object();

class MatchDetailError extends MatchDetailState {
  final String message;

  const MatchDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
