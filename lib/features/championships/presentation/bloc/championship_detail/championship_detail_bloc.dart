// Manages real-time data loading for the championship detail screen:
// championship info, standings, and per-round matches.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';

import 'championship_detail_event.dart';
import 'championship_detail_state.dart';

class ChampionshipDetailBloc
    extends Bloc<ChampionshipDetailEvent, ChampionshipDetailState> {
  final ChampionshipRepository _repository;
  String? _championshipId;

  StreamSubscription? _champSub;
  StreamSubscription? _standingsSub;
  StreamSubscription? _matchesSub;

  ChampionshipDetailBloc({required ChampionshipRepository repository})
      : _repository = repository,
        super(const ChampionshipDetailInitial()) {
    on<LoadChampionshipDetail>(_onLoad);
    on<ChangeDetailRound>(_onChangeRound);
    on<ChampionshipDetailDataUpdated>(_onChampionshipUpdated);
    on<ChampionshipDetailStandingsUpdated>(_onStandingsUpdated);
    on<ChampionshipDetailMatchesUpdated>(_onMatchesUpdated);
    on<ChampionshipDetailLoadError>(_onError);
  }

  Future<void> _onLoad(
    LoadChampionshipDetail event,
    Emitter<ChampionshipDetailState> emit,
  ) async {
    emit(const ChampionshipDetailLoading());
    _championshipId = event.championshipId;

    await _champSub?.cancel();
    await _standingsSub?.cancel();
    await _matchesSub?.cancel();
    _matchesSub = null;

    _champSub = _repository
        .getChampionshipById(event.championshipId)
        .listen(
          (champ) => add(ChampionshipDetailDataUpdated(champ)),
          onError: (Object e) {
            final msg = e is ChampionshipException
                ? e.message
                : 'Failed to load championship';
            add(ChampionshipDetailLoadError(msg));
          },
        );

    _standingsSub = _repository
        .getStandings(event.championshipId)
        .listen(
          (standings) => add(ChampionshipDetailStandingsUpdated(standings)),
          onError: (_) {}, // standings may not exist yet
        );
  }

  void _onChampionshipUpdated(
    ChampionshipDetailDataUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    final currentState = state;
    final champ = event.championship;
    final round = champ.currentRound > 0 ? champ.currentRound : 1;

    if (currentState is ChampionshipDetailLoading) {
      // First event — subscribe to matches and transition to loaded.
      _subscribeToMatches(_championshipId!, round);
      emit(ChampionshipDetailLoaded(
        championship: champ,
        standings: const [],
        currentRoundMatches: const [],
        selectedRound: round,
      ));
    } else if (currentState is ChampionshipDetailLoaded) {
      emit(currentState.copyWith(championship: champ));
    }
  }

  void _onStandingsUpdated(
    ChampionshipDetailStandingsUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    if (state is ChampionshipDetailLoaded) {
      emit(
        (state as ChampionshipDetailLoaded)
            .copyWith(standings: event.standings),
      );
    }
  }

  void _onMatchesUpdated(
    ChampionshipDetailMatchesUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    if (state is ChampionshipDetailLoaded) {
      emit(
        (state as ChampionshipDetailLoaded)
            .copyWith(currentRoundMatches: event.matches),
      );
    }
  }

  Future<void> _onChangeRound(
    ChangeDetailRound event,
    Emitter<ChampionshipDetailState> emit,
  ) async {
    if (state is! ChampionshipDetailLoaded) return;
    final current = state as ChampionshipDetailLoaded;
    if (event.round == current.selectedRound) return;

    emit(current.copyWith(
      selectedRound: event.round,
      currentRoundMatches: const [],
    ));

    await _matchesSub?.cancel();
    _subscribeToMatches(_championshipId!, event.round);
  }

  void _onError(
    ChampionshipDetailLoadError event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    emit(ChampionshipDetailError(message: event.message));
  }

  void _subscribeToMatches(String championshipId, int round) {
    _matchesSub = _repository
        .getMatchesForRound(
          championshipId: championshipId,
          round: round,
        )
        .listen(
          (matches) => add(ChampionshipDetailMatchesUpdated(matches)),
          onError: (_) {}, // empty rounds are normal before championship starts
        );
  }

  @override
  Future<void> close() async {
    await _champSub?.cancel();
    await _standingsSub?.cancel();
    await _matchesSub?.cancel();
    return super.close();
  }
}
