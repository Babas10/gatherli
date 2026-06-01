// States for ChampionshipCreationBloc.
import 'package:equatable/equatable.dart';

abstract class ChampionshipCreationState extends Equatable {
  const ChampionshipCreationState();

  @override
  List<Object?> get props => [];
}

class ChampionshipCreationInitial extends ChampionshipCreationState {
  const ChampionshipCreationInitial();
}

class ChampionshipCreationSubmitting extends ChampionshipCreationState {
  const ChampionshipCreationSubmitting();
}

class ChampionshipCreationSuccess extends ChampionshipCreationState {
  final String championshipId;

  const ChampionshipCreationSuccess({required this.championshipId});

  @override
  List<Object?> get props => [championshipId];
}

class ChampionshipCreationError extends ChampionshipCreationState {
  final String message;

  const ChampionshipCreationError({required this.message});

  @override
  List<Object?> get props => [message];
}
