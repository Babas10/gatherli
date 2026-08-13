// Manages real-time data loading for the championship detail screen:
// championship info, standings, and per-round matches.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/core/domain/repositories/user_repository.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';

import 'championship_detail_event.dart';
import 'championship_detail_state.dart';

class ChampionshipDetailBloc
    extends Bloc<ChampionshipDetailEvent, ChampionshipDetailState> {
  final ChampionshipRepository _repository;
  final UserRepository _userRepository;
  String? _championshipId;

  StreamSubscription? _champSub;
  StreamSubscription? _standingsSub;
  StreamSubscription? _teamsSub;
  StreamSubscription? _matchesSub;
  StreamSubscription? _allMatchesSub;
  StreamSubscription? _userSub;

  ChampionshipDetailBloc({
    required ChampionshipRepository repository,
    required UserRepository userRepository,
  })  : _repository = repository,
        _userRepository = userRepository,
        super(const ChampionshipDetailInitial()) {
    on<LoadChampionshipDetail>(_onLoad);
    on<ChangeDetailRound>(_onChangeRound);
    on<ChampionshipDetailDataUpdated>(_onChampionshipUpdated);
    on<ChampionshipDetailStandingsUpdated>(_onStandingsUpdated);
    on<ChampionshipDetailTeamsUpdated>(_onTeamsUpdated);
    on<ChampionshipDetailMatchesUpdated>(_onMatchesUpdated);
    on<ChampionshipDetailAllMatchesUpdated>(_onAllMatchesUpdated);
    on<ChampionshipDetailUserUpdated>(_onUserUpdated);
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
    await _teamsSub?.cancel();
    await _matchesSub?.cancel();
    await _allMatchesSub?.cancel();
    await _userSub?.cancel();
    _matchesSub = null;

    _userSub = _userRepository.currentUser.listen(
      (user) => add(ChampionshipDetailUserUpdated(user?.gender?.name)),
      onError: (_) {},
    );

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

    _teamsSub = _repository
        .getTeams(event.championshipId)
        .listen(
          (teams) => add(ChampionshipDetailTeamsUpdated(teams)),
          onError: (_) {}, // no teams yet is normal
        );

    _allMatchesSub = _repository
        .getAllMatches(event.championshipId)
        .listen(
          (matches) => add(ChampionshipDetailAllMatchesUpdated(matches)),
          onError: (_) {}, // no matches yet is normal before championship starts
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
        teams: const [],
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

  void _onTeamsUpdated(
    ChampionshipDetailTeamsUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    if (state is ChampionshipDetailLoaded) {
      emit(
        (state as ChampionshipDetailLoaded).copyWith(teams: event.teams),
      );
    }
  }

  void _onUserUpdated(
    ChampionshipDetailUserUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    if (state is ChampionshipDetailLoaded) {
      final current = state as ChampionshipDetailLoaded;
      // Use copyWith so new fields (allMatches etc.) are preserved.
      // currentUserGender may be null — pass it explicitly via a wrapper
      // because copyWith uses a sentinel to distinguish "not provided" from null.
      emit(ChampionshipDetailLoaded(
        championship: current.championship,
        standings: current.standings,
        teams: current.teams,
        currentRoundMatches: current.currentRoundMatches,
        selectedRound: current.selectedRound,
        allMatches: current.allMatches,
        currentUserGender: event.gender,
      ));
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

  void _onAllMatchesUpdated(
    ChampionshipDetailAllMatchesUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    if (state is ChampionshipDetailLoaded) {
      emit(
        (state as ChampionshipDetailLoaded)
            .copyWith(allMatches: event.matches),
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
    await _teamsSub?.cancel();
    await _matchesSub?.cancel();
    await _allMatchesSub?.cancel();
    await _userSub?.cancel();
    return super.close();
  }
}
