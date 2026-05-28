// States for TeamRegistrationBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

abstract class TeamRegistrationState extends Equatable {
  const TeamRegistrationState();

  @override
  List<Object?> get props => [];
}

class TeamRegistrationInitial extends TeamRegistrationState {
  const TeamRegistrationInitial();
}

class TeamRegistrationLoading extends TeamRegistrationState {
  const TeamRegistrationLoading();
}

/// Championships loaded; may include the user's existing team.
class TeamRegistrationLoaded extends TeamRegistrationState {
  final List<ChampionshipModel> championships;

  /// Map of championshipId → user's team (null if not registered).
  final Map<String, ChampionshipTeamModel?> myTeams;

  const TeamRegistrationLoaded({
    required this.championships,
    this.myTeams = const {},
  });

  TeamRegistrationLoaded copyWith({
    List<ChampionshipModel>? championships,
    Map<String, ChampionshipTeamModel?>? myTeams,
  }) {
    return TeamRegistrationLoaded(
      championships: championships ?? this.championships,
      myTeams: myTeams ?? this.myTeams,
    );
  }

  @override
  List<Object?> get props => [championships, myTeams];
}

/// A create/leave action is in progress (spinner on the action button).
class TeamRegistrationSubmitting extends TeamRegistrationState {
  const TeamRegistrationSubmitting();
}

/// Team created successfully.
class TeamCreated extends TeamRegistrationState {
  final String teamId;

  const TeamCreated({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}

/// Team left successfully.
class TeamLeft extends TeamRegistrationState {
  const TeamLeft();
}

class TeamRegistrationError extends TeamRegistrationState {
  final String message;
  final String? errorCode;

  const TeamRegistrationError({required this.message, this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}
