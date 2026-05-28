// Manages championship list loading and team create/leave operations.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'team_registration_event.dart';
import 'team_registration_state.dart';

class TeamRegistrationBloc
    extends Bloc<TeamRegistrationEvent, TeamRegistrationState> {
  final ChampionshipRepository _championshipRepository;

  TeamRegistrationBloc({required ChampionshipRepository championshipRepository})
      : _championshipRepository = championshipRepository,
        super(const TeamRegistrationInitial()) {
    on<LoadChampionships>(_onLoadChampionships);
    on<CreateTeam>(_onCreateTeam);
    on<LeaveTeam>(_onLeaveTeam);
  }

  Future<void> _onLoadChampionships(
    LoadChampionships event,
    Emitter<TeamRegistrationState> emit,
  ) async {
    emit(const TeamRegistrationLoading());
    try {
      await emit.forEach(
        _championshipRepository.getOpenChampionships(),
        onData: (championships) {
          return TeamRegistrationLoaded(championships: championships);
        },
        onError: (_, __) => const TeamRegistrationError(
          message: 'Failed to load championships',
          errorCode: 'LOAD_ERROR',
        ),
      );
    } on ChampionshipException catch (e) {
      emit(TeamRegistrationError(
        message: e.message,
        errorCode: e.code ?? 'LOAD_ERROR',
      ));
    } catch (e) {
      emit(TeamRegistrationError(
        message: 'Failed to load championships: ${e.toString()}',
        errorCode: 'LOAD_ERROR',
      ));
    }
  }

  Future<void> _onCreateTeam(
    CreateTeam event,
    Emitter<TeamRegistrationState> emit,
  ) async {
    emit(const TeamRegistrationSubmitting());
    try {
      final teamId = await _championshipRepository.createTeam(
        championshipId: event.championshipId,
        teamName: event.teamName,
        partnerId: event.partnerId,
      );
      emit(TeamCreated(teamId: teamId));
    } on ChampionshipException catch (e) {
      emit(TeamRegistrationError(
        message: e.message,
        errorCode: e.code ?? 'CREATE_TEAM_ERROR',
      ));
    } catch (e) {
      emit(TeamRegistrationError(
        message: 'Failed to create team: ${e.toString()}',
        errorCode: 'CREATE_TEAM_ERROR',
      ));
    }
  }

  Future<void> _onLeaveTeam(
    LeaveTeam event,
    Emitter<TeamRegistrationState> emit,
  ) async {
    emit(const TeamRegistrationSubmitting());
    try {
      await _championshipRepository.leaveTeam(
        championshipId: event.championshipId,
        teamId: event.teamId,
      );
      emit(const TeamLeft());
    } on ChampionshipException catch (e) {
      emit(TeamRegistrationError(
        message: e.message,
        errorCode: e.code ?? 'LEAVE_TEAM_ERROR',
      ));
    } catch (e) {
      emit(TeamRegistrationError(
        message: 'Failed to leave team: ${e.toString()}',
        errorCode: 'LEAVE_TEAM_ERROR',
      ));
    }
  }
}
