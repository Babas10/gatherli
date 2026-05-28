// Events for TeamRegistrationBloc (championship team registration flow).
import 'package:equatable/equatable.dart';

abstract class TeamRegistrationEvent extends Equatable {
  const TeamRegistrationEvent();

  @override
  List<Object?> get props => [];
}

/// Load open championships and the user's existing team (if any).
class LoadChampionships extends TeamRegistrationEvent {
  final String userId;

  const LoadChampionships(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// Submit team creation request.
class CreateTeam extends TeamRegistrationEvent {
  final String championshipId;
  final String teamName;
  final String partnerId;

  const CreateTeam({
    required this.championshipId,
    required this.teamName,
    required this.partnerId,
  });

  @override
  List<Object?> get props => [championshipId, teamName, partnerId];
}

/// Leave / delete the user's current team.
class LeaveTeam extends TeamRegistrationEvent {
  final String championshipId;
  final String teamId;

  const LeaveTeam({required this.championshipId, required this.teamId});

  @override
  List<Object?> get props => [championshipId, teamId];
}
