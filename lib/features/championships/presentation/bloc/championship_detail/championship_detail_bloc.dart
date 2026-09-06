// Manages real-time data loading for the championship detail screen:
// championship info, standings, and per-round matches.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/core/domain/repositories/user_repository.dart';
import 'package:play_with_me/core/presentation/bloc/base_bloc.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';

import 'championship_detail_event.dart';
import 'championship_detail_state.dart';

class ChampionshipDetailBloc
    extends BaseBloc<ChampionshipDetailEvent, ChampionshipDetailState> {
  final ChampionshipRepository _repository;
  final UserRepository _userRepository;
  String? _championshipId;

  // Caches the latest value from each sibling stream so it is available when
  // ChampionshipDetailLoaded is first emitted. All of these streams are
  // subscribed concurrently with _champSub in _onLoad, and their handlers
  // below only apply updates once state is already ChampionshipDetailLoaded
  // — if one of them fires its first snapshot before _champSub does (a race,
  // since these are independent async streams), that snapshot would
  // otherwise be silently dropped. Because these are live Firestore
  // listeners that only re-emit on actual document changes, a dropped
  // snapshot for data that doesn't change again (e.g. a stable set of
  // matches) means the UI would be stuck showing the Loaded state's default
  // empty list forever.
  String? _pendingUserGender;
  List<ChampionshipStandingsModel>? _pendingStandings;
  List<ChampionshipTeamModel>? _pendingTeams;
  List<ChampionshipMatchModel>? _pendingAllMatches;

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
    _pendingUserGender = null; // reset for new load
    _pendingStandings = null;
    _pendingTeams = null;
    _pendingAllMatches = null;

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
    trackSubscription(_userSub!);

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
    trackSubscription(_champSub!);

    _standingsSub = _repository
        .getStandings(event.championshipId)
        .listen(
          (standings) => add(ChampionshipDetailStandingsUpdated(standings)),
          onError: (_) {}, // standings may not exist yet
        );
    trackSubscription(_standingsSub!);

    _teamsSub = _repository
        .getTeams(event.championshipId)
        .listen(
          (teams) => add(ChampionshipDetailTeamsUpdated(teams)),
          onError: (_) {}, // no teams yet is normal
        );
    trackSubscription(_teamsSub!);

    _allMatchesSub = _repository
        .getAllMatches(event.championshipId)
        .listen(
          (matches) => add(ChampionshipDetailAllMatchesUpdated(matches)),
          onError: (_) {}, // no matches yet is normal before championship starts
        );
    trackSubscription(_allMatchesSub!);
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
      // Include any values already received from the sibling streams
      // (_pendingUserGender/_pendingStandings/_pendingTeams/_pendingAllMatches)
      // to avoid the race condition where one of them fires during Loading,
      // before this championship snapshot arrives.
      _subscribeToMatches(_championshipId!, round);
      emit(ChampionshipDetailLoaded(
        championship: champ,
        standings: _pendingStandings ?? const [],
        teams: _pendingTeams ?? const [],
        currentRoundMatches: const [],
        selectedRound: round,
        allMatches: _pendingAllMatches ?? const [],
        currentUserGender: _pendingUserGender,
      ));
    } else if (currentState is ChampionshipDetailLoaded) {
      emit(currentState.copyWith(championship: champ));
    }
  }

  void _onStandingsUpdated(
    ChampionshipDetailStandingsUpdated event,
    Emitter<ChampionshipDetailState> emit,
  ) {
    _pendingStandings = event.standings;
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
    _pendingTeams = event.teams;
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
    // Always cache the latest gender — used when ChampionshipDetailLoaded is
    // first emitted if this event arrived during ChampionshipDetailLoading.
    _pendingUserGender = event.gender;

    if (state is ChampionshipDetailLoaded) {
      final current = state as ChampionshipDetailLoaded;
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
    _pendingAllMatches = event.matches;
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
    trackSubscription(_matchesSub!);
  }
}
