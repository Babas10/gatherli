// Manages real-time championship listing with client-side status filtering.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'championship_list_event.dart';
import 'championship_list_state.dart';

class ChampionshipListBloc
    extends Bloc<ChampionshipListEvent, ChampionshipListState> {
  final ChampionshipRepository _repository;
  StreamSubscription? _subscription;

  ChampionshipListBloc({required ChampionshipRepository repository})
      : _repository = repository,
        super(const ChampionshipListInitial()) {
    on<LoadChampionships>(_onLoad);
    on<ChampionshipsUpdated>(_onUpdated);
    on<ChampionshipsLoadFailed>(_onLoadFailed);
    on<FilterChampionships>(_onFilter);
  }

  Future<void> _onLoad(
    LoadChampionships event,
    Emitter<ChampionshipListState> emit,
  ) async {
    emit(const ChampionshipListLoading());
    await _subscription?.cancel();
    _subscription = _repository.getChampionships().listen(
      (championships) => add(ChampionshipsUpdated(championships)),
      onError: (e) {
        final msg = e is ChampionshipException
            ? e.message
            : 'Failed to load championships';
        // Route error through an event — calling emit() directly here would
        // fail because the _onLoad handler has already completed.
        add(ChampionshipsLoadFailed(msg));
      },
    );
  }

  void _onUpdated(
    ChampionshipsUpdated event,
    Emitter<ChampionshipListState> emit,
  ) {
    final currentFilter =
        state is ChampionshipListLoaded
            ? (state as ChampionshipListLoaded).activeFilter
            : null;
    emit(ChampionshipListLoaded(
      allChampionships: event.championships,
      activeFilter: currentFilter,
    ));
  }

  void _onLoadFailed(
    ChampionshipsLoadFailed event,
    Emitter<ChampionshipListState> emit,
  ) {
    emit(ChampionshipListError(message: event.message));
  }

  void _onFilter(
    FilterChampionships event,
    Emitter<ChampionshipListState> emit,
  ) {
    if (state is ChampionshipListLoaded) {
      emit((state as ChampionshipListLoaded)
          .copyWith(activeFilter: event.status));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
