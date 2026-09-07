// Validates AdminPanelBloc state transitions: loading matches, filtering
// for admin attention, and applying admin decisions via the repository.
import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_state.dart';

import '../../../../../helpers/mocks.dart';

// ── Factories ─────────────────────────────────────────────────────────────────

ChampionshipMatchModel _makeMatch({
  String id = 'm1',
  ChampionshipMatchStatus status = ChampionshipMatchStatus.pending,
  DateTime? deadline,
}) {
  return ChampionshipMatchModel(
    id: id,
    round: 1,
    teamAId: 'teamA',
    teamBId: 'teamB',
    deadline: deadline ?? DateTime(2025, 1, 1), // past deadline by default
    status: status,
  );
}

void main() {
  late MockChampionshipRepository mockRepo;
  const championshipId = 'champ-1';

  setUpAll(() {
    registerFallbackValues();
    registerFallbackValue(_makeMatch());
  });

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  AdminPanelBloc makeBloc() => AdminPanelBloc(repository: mockRepo);

  // ──────────────────────────────────────────────────────────────────────────
  group('LoadAdminPanel', () {
    blocTest<AdminPanelBloc, AdminPanelState>(
      'initial state is AdminPanelInitial',
      build: makeBloc,
      act: (_) {},
      expect: () => [],
      verify: (bloc) => expect(bloc.state, const AdminPanelInitial()),
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits Loading then Loaded when stream emits',
      build: () {
        when(() => mockRepo.getAllMatches(championshipId))
            .thenAnswer((_) => Stream.value([_makeMatch()]));
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadAdminPanel(championshipId)),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const AdminPanelLoading(),
        isA<AdminPanelLoaded>(),
      ],
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'filters out verified and admin_decided matches',
      build: () {
        when(() => mockRepo.getAllMatches(championshipId)).thenAnswer(
          (_) => Stream.value([
            _makeMatch(id: 'm1', status: ChampionshipMatchStatus.verified),
            _makeMatch(id: 'm2', status: ChampionshipMatchStatus.adminDecided),
            _makeMatch(id: 'm3', status: ChampionshipMatchStatus.disputed),
          ]),
        );
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadAdminPanel(championshipId)),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.matches.length, 1);
        expect(state.matches.first.id, 'm3');
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'includes disputed matches regardless of deadline',
      build: () {
        final futureDeadline = DateTime.now().add(const Duration(days: 30));
        when(() => mockRepo.getAllMatches(championshipId)).thenAnswer(
          (_) => Stream.value([
            _makeMatch(
              id: 'm1',
              status: ChampionshipMatchStatus.disputed,
              deadline: futureDeadline,
            ),
          ]),
        );
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadAdminPanel(championshipId)),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.matches.length, 1);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'excludes pending match with future deadline',
      build: () {
        final futureDeadline = DateTime.now().add(const Duration(days: 30));
        when(() => mockRepo.getAllMatches(championshipId)).thenAnswer(
          (_) => Stream.value([
            _makeMatch(
              id: 'm1',
              status: ChampionshipMatchStatus.pending,
              deadline: futureDeadline,
            ),
          ]),
        );
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadAdminPanel(championshipId)),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.matches, isEmpty);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits Error when stream errors',
      build: () {
        when(() => mockRepo.getAllMatches(championshipId)).thenAnswer(
          (_) => Stream.error(ChampionshipException('Network error')),
        );
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadAdminPanel(championshipId)),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const AdminPanelLoading(),
        isA<AdminPanelError>(),
      ],
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'updates matches on subsequent stream events',
      build: () {
        final ctrl = StreamController<List<ChampionshipMatchModel>>();
        when(() => mockRepo.getAllMatches(championshipId))
            .thenAnswer((_) => ctrl.stream);
        Future.microtask(() {
          ctrl.add([_makeMatch(id: 'm1', status: ChampionshipMatchStatus.disputed)]);
          Future.delayed(const Duration(milliseconds: 20), () {
            ctrl.add([
              _makeMatch(id: 'm1', status: ChampionshipMatchStatus.disputed),
              _makeMatch(id: 'm2', status: ChampionshipMatchStatus.disputed),
            ]);
          });
        });
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadAdminPanel(championshipId)),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.matches.length, 2);
      },
    );
  });

  // ──────────────────────────────────────────────────────────────────────────
  group('DecideMatch', () {
    blocTest<AdminPanelBloc, AdminPanelState>(
      'calls adminDecideMatch and sets lastDecidedMatchId on success',
      build: () {
        when(() => mockRepo.getAllMatches(championshipId)).thenAnswer(
          (_) => Stream.value([
            _makeMatch(id: 'm1', status: ChampionshipMatchStatus.disputed),
          ]),
        );
        when(() => mockRepo.adminDecideMatch(
              championshipId: any(named: 'championshipId'),
              matchId: any(named: 'matchId'),
              decision: any(named: 'decision'),
              winnerId: any(named: 'winnerId'),
              sets: any(named: 'sets'),
              notes: any(named: 'notes'),
            )).thenAnswer((_) async {});
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(const LoadAdminPanel(championshipId));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const DecideMatch(
          matchId: 'm1',
          decision: 'cancel',
          notes: 'No result submitted by deadline',
        ));
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isDeciding, isFalse);
        expect(state.lastDecidedMatchId, 'm1');
        expect(state.decisionError, isNull);
        verify(() => mockRepo.adminDecideMatch(
              championshipId: championshipId,
              matchId: 'm1',
              decision: 'cancel',
              winnerId: null,
              sets: null,
              notes: 'No result submitted by deadline',
            )).called(1);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'sets decisionError on ChampionshipException',
      build: () {
        when(() => mockRepo.getAllMatches(championshipId)).thenAnswer(
          (_) => Stream.value([
            _makeMatch(id: 'm1', status: ChampionshipMatchStatus.disputed),
          ]),
        );
        when(() => mockRepo.adminDecideMatch(
              championshipId: any(named: 'championshipId'),
              matchId: any(named: 'matchId'),
              decision: any(named: 'decision'),
              winnerId: any(named: 'winnerId'),
              sets: any(named: 'sets'),
              notes: any(named: 'notes'),
            )).thenThrow(
                ChampionshipException('Not allowed', code: 'DENIED'));
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(const LoadAdminPanel(championshipId));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const DecideMatch(
          matchId: 'm1',
          decision: 'cancel',
          notes: 'Reason',
        ));
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isDeciding, isFalse);
        expect(state.decisionError, isNotNull);
        expect(state.lastDecidedMatchId, isNull);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'DecideMatch is ignored when state is not Loaded',
      build: makeBloc,
      act: (bloc) => bloc.add(const DecideMatch(
        matchId: 'm1',
        decision: 'cancel',
        notes: 'Reason',
      )),
      expect: () => [],
    );
  });
  group('StartChampionship', () {
    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits isStarting=true then matchesGenerated on success',
      build: () {
        when(() => mockRepo.getAllMatches(any()))
            .thenAnswer((_) => Stream.value([]));
        when(() => mockRepo.startChampionship(
              championshipId: any(named: 'championshipId'),
              startDate: any(named: 'startDate'),
            )).thenAnswer((_) async => 45);
        return makeBloc()..add(const LoadAdminPanel(championshipId));
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(StartChampionship(
          championshipId: championshipId,
          startDate: DateTime(2027, 1, 1),
        ));
      },
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isStarting, isFalse);
        expect(state.matchesGenerated, 45);
        expect(state.startError, isNull);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits startError on ChampionshipException',
      build: () {
        when(() => mockRepo.getAllMatches(any()))
            .thenAnswer((_) => Stream.value([]));
        when(() => mockRepo.startChampionship(
              championshipId: any(named: 'championshipId'),
              startDate: any(named: 'startDate'),
            )).thenThrow(ChampionshipException('Not enough teams'));
        return makeBloc()..add(const LoadAdminPanel(championshipId));
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(StartChampionship(
          championshipId: championshipId,
          startDate: DateTime(2027, 1, 1),
        ));
      },
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isStarting, isFalse);
        expect(state.startError, isNotNull);
        expect(state.matchesGenerated, isNull);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'StartChampionship is ignored when state is not Loaded',
      build: makeBloc,
      act: (bloc) => bloc.add(StartChampionship(
        championshipId: championshipId,
        startDate: DateTime(2027, 1, 1),
      )),
      expect: () => [],
    );
  });

  group('CompleteChampionship', () {
    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits isCompleted=true on success',
      build: () {
        when(() => mockRepo.getAllMatches(any()))
            .thenAnswer((_) => Stream.value([]));
        when(() => mockRepo.completeChampionship(
              championshipId: any(named: 'championshipId'),
            )).thenAnswer((_) async {});
        return makeBloc()..add(const LoadAdminPanel(championshipId));
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const CompleteChampionship(championshipId: championshipId));
      },
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isCompleting, isFalse);
        expect(state.isCompleted, isTrue);
        expect(state.completeError, isNull);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits completeError on ChampionshipException',
      build: () {
        when(() => mockRepo.getAllMatches(any()))
            .thenAnswer((_) => Stream.value([]));
        when(() => mockRepo.completeChampionship(
              championshipId: any(named: 'championshipId'),
            )).thenThrow(ChampionshipException('Already completed'));
        return makeBloc()..add(const LoadAdminPanel(championshipId));
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const CompleteChampionship(championshipId: championshipId));
      },
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isCompleting, isFalse);
        expect(state.completeError, isNotNull);
        expect(state.isCompleted, isFalse);
      },
    );
  });

  group('DeleteChampionship', () {
    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits isDeleted=true on success',
      build: () {
        when(() => mockRepo.getAllMatches(any()))
            .thenAnswer((_) => Stream.value([]));
        when(() => mockRepo.deleteChampionship(
              championshipId: any(named: 'championshipId'),
            )).thenAnswer((_) async {});
        return makeBloc()..add(const LoadAdminPanel(championshipId));
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const DeleteChampionship(championshipId: championshipId));
      },
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isDeleting, isFalse);
        expect(state.isDeleted, isTrue);
        expect(state.deleteError, isNull);
      },
    );

    blocTest<AdminPanelBloc, AdminPanelState>(
      'emits deleteError on ChampionshipException',
      build: () {
        when(() => mockRepo.getAllMatches(any()))
            .thenAnswer((_) => Stream.value([]));
        when(() => mockRepo.deleteChampionship(
              championshipId: any(named: 'championshipId'),
            )).thenThrow(ChampionshipException('Championship already started'));
        return makeBloc()..add(const LoadAdminPanel(championshipId));
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const DeleteChampionship(championshipId: championshipId));
      },
      verify: (bloc) {
        final state = bloc.state as AdminPanelLoaded;
        expect(state.isDeleting, isFalse);
        expect(state.deleteError, isNotNull);
        expect(state.isDeleted, isFalse);
      },
    );
  });
}
