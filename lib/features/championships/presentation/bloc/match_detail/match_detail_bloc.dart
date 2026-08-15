// Manages the real-time match state, team loading, and schedule proposal for a
// championship match detail screen.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/base_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'match_detail_event.dart';
import 'match_detail_state.dart';

class MatchDetailBloc extends BaseBloc<MatchDetailEvent, MatchDetailState> {
  final ChampionshipRepository _repository;
  StreamSubscription<dynamic>? _matchSubscription;
  String? _championshipId;
  String? _currentUserId;

  MatchDetailBloc({required ChampionshipRepository repository})
      : _repository = repository,
        super(const MatchDetailInitial()) {
    on<LoadMatchDetail>(_onLoad);
    on<ProposeSchedule>(_onProposeSchedule);
    on<AcceptSchedule>(_onAcceptSchedule);
    on<RejectSchedule>(_onRejectSchedule);
    on<MatchDetailMatchUpdated>(_onMatchUpdated);
    on<MatchDetailLoadError>(_onLoadError);
  }

  Future<void> _onLoad(
    LoadMatchDetail event,
    Emitter<MatchDetailState> emit,
  ) async {
    emit(const MatchDetailLoading());
    _championshipId = event.championshipId;
    _currentUserId = event.currentUserId;

    await _matchSubscription?.cancel();
    _matchSubscription = _repository
        .getMatch(
          championshipId: event.championshipId,
          matchId: event.matchId,
        )
        .listen(
          (match) => add(MatchDetailMatchUpdated(match)),
          onError: (e) => add(MatchDetailLoadError(e.toString())),
        );
  }

  Future<void> _onMatchUpdated(
    MatchDetailMatchUpdated event,
    Emitter<MatchDetailState> emit,
  ) async {
    final match = event.match;

    // Subsequent stream updates — just update the match document.
    if (state is MatchDetailLoaded) {
      emit((state as MatchDetailLoaded).copyWith(match: match));
      return;
    }

    final championshipId = _championshipId;
    final userId = _currentUserId;
    if (championshipId == null || userId == null) return;

    // First snapshot: fetch both teams to determine role.
    try {
      final results = await Future.wait([
        _repository.getTeamById(
          championshipId: championshipId,
          teamId: match.teamAId,
        ),
        _repository.getTeamById(
          championshipId: championshipId,
          teamId: match.teamBId,
        ),
      ]);

      final teamA = results[0];
      final teamB = results[1];

      if (teamA == null || teamB == null) {
        emit(const MatchDetailError(message: 'Teams not found'));
        return;
      }

      final myTeamId = teamA.isMember(userId)
          ? match.teamAId
          : teamB.isMember(userId)
              ? match.teamBId
              : null;

      emit(MatchDetailLoaded(
        championshipId: championshipId,
        match: match,
        teamA: teamA,
        teamB: teamB,
        myTeamId: myTeamId,
      ));
    } on ChampionshipException catch (e) {
      emit(MatchDetailError(message: e.message));
    } catch (e) {
      emit(MatchDetailError(message: 'Failed to load match: $e'));
    }
  }

  Future<void> _onProposeSchedule(
    ProposeSchedule event,
    Emitter<MatchDetailState> emit,
  ) async {
    if (state is! MatchDetailLoaded) return;
    final loaded = state as MatchDetailLoaded;

    emit(loaded.copyWith(
      isProposingSchedule: true,
      scheduleError: null,
    ));

    try {
      await _repository.proposeMatchSchedule(
        championshipId: loaded.championshipId,
        matchId: loaded.match.id,
        scheduledAt: event.scheduledAt,
        location: event.location,
      );
      // The match stream will deliver the updated status automatically.
      if (state is MatchDetailLoaded) {
        emit((state as MatchDetailLoaded).copyWith(isProposingSchedule: false));
      }
    } on ChampionshipException catch (e) {
      emit(loaded.copyWith(
        isProposingSchedule: false,
        scheduleError: e.message,
      ));
    } catch (e) {
      emit(loaded.copyWith(
        isProposingSchedule: false,
        scheduleError: 'Failed to propose schedule: $e',
      ));
    }
  }

  Future<void> _onAcceptSchedule(
    AcceptSchedule event,
    Emitter<MatchDetailState> emit,
  ) async {
    if (state is! MatchDetailLoaded) return;
    final loaded = state as MatchDetailLoaded;

    emit(loaded.copyWith(
      isAcceptingSchedule: true,
      scheduleConfirmError: null,
    ));

    try {
      await _repository.confirmMatchSchedule(
        championshipId: loaded.championshipId,
        matchId: loaded.match.id,
      );
      // Stream update will deliver the cleared scheduledByTeamId automatically.
      if (state is MatchDetailLoaded) {
        emit((state as MatchDetailLoaded).copyWith(isAcceptingSchedule: false));
      }
    } on ChampionshipException catch (e) {
      emit(loaded.copyWith(
        isAcceptingSchedule: false,
        scheduleConfirmError: e.message,
      ));
    } catch (e) {
      emit(loaded.copyWith(
        isAcceptingSchedule: false,
        scheduleConfirmError: 'Failed to confirm schedule: $e',
      ));
    }
  }

  Future<void> _onRejectSchedule(
    RejectSchedule event,
    Emitter<MatchDetailState> emit,
  ) async {
    if (state is! MatchDetailLoaded) return;
    final loaded = state as MatchDetailLoaded;

    emit(loaded.copyWith(
      isRejectingSchedule: true,
      scheduleConfirmError: null,
    ));

    try {
      await _repository.rejectMatchSchedule(
        championshipId: loaded.championshipId,
        matchId: loaded.match.id,
      );
      // Stream update will deliver the reset status automatically.
      if (state is MatchDetailLoaded) {
        emit((state as MatchDetailLoaded).copyWith(isRejectingSchedule: false));
      }
    } on ChampionshipException catch (e) {
      emit(loaded.copyWith(
        isRejectingSchedule: false,
        scheduleConfirmError: e.message,
      ));
    } catch (e) {
      emit(loaded.copyWith(
        isRejectingSchedule: false,
        scheduleConfirmError: 'Failed to reject schedule: $e',
      ));
    }
  }

  void _onLoadError(
    MatchDetailLoadError event,
    Emitter<MatchDetailState> emit,
  ) {
    emit(MatchDetailError(message: event.message));
  }

  @override
  Future<void> close() {
    _matchSubscription?.cancel();
    return super.close();
  }
}
