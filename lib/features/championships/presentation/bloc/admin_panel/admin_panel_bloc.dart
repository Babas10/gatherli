// BLoC for the championship admin panel (Story 30.12).
// Loads all matches in real-time, filters to those needing admin attention,
// and handles admin match decisions via Cloud Function.
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_state.dart';

// The statuses that are considered "final" — admin cannot act on them.
const _finalStatuses = {
  ChampionshipMatchStatus.verified,
  ChampionshipMatchStatus.adminDecided,
};

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  final ChampionshipRepository _repository;
  StreamSubscription<List<ChampionshipMatchModel>>? _matchSubscription;
  String? _championshipId;

  AdminPanelBloc({required ChampionshipRepository repository})
      : _repository = repository,
        super(const AdminPanelInitial()) {
    on<LoadAdminPanel>(_onLoadAdminPanel);
    on<DecideMatch>(_onDecideMatch);
    on<AdminMatchesUpdated>(_onMatchesUpdated);
    on<AdminMatchesError>(_onMatchesError);
  }

  Future<void> _onLoadAdminPanel(
    LoadAdminPanel event,
    Emitter<AdminPanelState> emit,
  ) async {
    _championshipId = event.championshipId;
    emit(const AdminPanelLoading());

    await _matchSubscription?.cancel();
    _matchSubscription = _repository
        .getAllMatches(event.championshipId)
        .listen(
          (matches) => add(AdminMatchesUpdated(matches)),
          onError: (e) => add(AdminMatchesError(e.toString())),
        );
  }

  void _onMatchesUpdated(
    AdminMatchesUpdated event,
    Emitter<AdminPanelState> emit,
  ) {
    final now = DateTime.now();
    final actionable = event.matches.where((m) {
      if (_finalStatuses.contains(m.status)) return false;
      if (m.status == ChampionshipMatchStatus.disputed) return true;
      // pending / scheduled / played that are past deadline
      return now.isAfter(m.deadline);
    }).toList();

    if (state is AdminPanelLoaded) {
      final current = state as AdminPanelLoaded;
      emit(current.copyWith(matches: actionable));
    } else {
      emit(AdminPanelLoaded(matches: actionable));
    }
  }

  void _onMatchesError(
    AdminMatchesError event,
    Emitter<AdminPanelState> emit,
  ) {
    emit(AdminPanelError(message: event.message));
  }

  Future<void> _onDecideMatch(
    DecideMatch event,
    Emitter<AdminPanelState> emit,
  ) async {
    if (state is! AdminPanelLoaded) return;
    final current = state as AdminPanelLoaded;

    emit(current.copyWith(
      isDeciding: true,
      decisionError: null,
      lastDecidedMatchId: null,
    ));

    try {
      await _repository.adminDecideMatch(
        championshipId: _championshipId!,
        matchId: event.matchId,
        decision: event.decision,
        winnerId: event.winnerId,
        sets: event.sets,
        notes: event.notes,
      );

      if (state is AdminPanelLoaded) {
        final updated = state as AdminPanelLoaded;
        emit(updated.copyWith(
          isDeciding: false,
          lastDecidedMatchId: event.matchId,
          decisionError: null,
        ));
      }
    } on ChampionshipException catch (e) {
      if (state is AdminPanelLoaded) {
        final updated = state as AdminPanelLoaded;
        emit(updated.copyWith(
          isDeciding: false,
          decisionError: e.message,
          lastDecidedMatchId: null,
        ));
      }
    } catch (e) {
      if (state is AdminPanelLoaded) {
        final updated = state as AdminPanelLoaded;
        emit(updated.copyWith(
          isDeciding: false,
          decisionError: e.toString(),
          lastDecidedMatchId: null,
        ));
      }
    }
  }

  @override
  Future<void> close() {
    _matchSubscription?.cancel();
    return super.close();
  }
}
