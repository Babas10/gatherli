// Validates ChampionshipListBloc state transitions, including the stream-error
// routing fix (ChampionshipsLoadFailed event must not call emit after completion).
import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_state.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';

class MockChampionshipRepository extends Mock
    implements ChampionshipRepository {}

ChampionshipModel _makeChamp(String id) => ChampionshipModel(
      id: id,
      title: 'Champ $id',
      status: ChampionshipStatus.registration,
      teamsCount: 2,
      maxTeams: 8,
      currentRound: 0,
      totalRounds: 5,
      createdBy: 'admin',
      createdAt: DateTime(2026, 1, 1),
      registrationDeadline: DateTime(2026, 6, 1),
    );

void main() {
  late MockChampionshipRepository mockRepo;

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  ChampionshipListBloc makeBloc() =>
      ChampionshipListBloc(repository: mockRepo);

  group('ChampionshipListBloc', () {
    blocTest<ChampionshipListBloc, ChampionshipListState>(
      'emits [loading, loaded] on successful stream data',
      build: () {
        when(() => mockRepo.getChampionships())
            .thenAnswer((_) => Stream.value([_makeChamp('c1')]));
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionships()),
      expect: () => [
        const ChampionshipListLoading(),
        isA<ChampionshipListLoaded>().having(
          (s) => s.championships.length,
          'length',
          1,
        ),
      ],
    );

    blocTest<ChampionshipListBloc, ChampionshipListState>(
      'emits [loading, error] when stream emits ChampionshipException',
      build: () {
        final controller = StreamController<List<ChampionshipModel>>();
        when(() => mockRepo.getChampionships())
            .thenAnswer((_) => controller.stream);
        // Emit error after subscription is set up
        Future.microtask(
          () => controller.addError(ChampionshipException('load failed')),
        );
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionships()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const ChampionshipListLoading(),
        const ChampionshipListError(message: 'load failed'),
      ],
    );

    blocTest<ChampionshipListBloc, ChampionshipListState>(
      'emits [loading, error] with generic message when stream emits unknown error',
      build: () {
        final controller = StreamController<List<ChampionshipModel>>();
        when(() => mockRepo.getChampionships())
            .thenAnswer((_) => controller.stream);
        Future.microtask(() => controller.addError(Exception('network down')));
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionships()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const ChampionshipListLoading(),
        const ChampionshipListError(message: 'Failed to load championships'),
      ],
    );

    blocTest<ChampionshipListBloc, ChampionshipListState>(
      'ChampionshipsLoadFailed event emits error state',
      build: () {
        when(() => mockRepo.getChampionships())
            .thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) =>
          bloc.add(const ChampionshipsLoadFailed('direct error message')),
      expect: () => [
        const ChampionshipListError(message: 'direct error message'),
      ],
    );

    blocTest<ChampionshipListBloc, ChampionshipListState>(
      'FilterChampionships applies filter to loaded championships',
      build: () {
        when(() => mockRepo.getChampionships())
            .thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      seed: () => ChampionshipListLoaded(
        allChampionships: [
          _makeChamp('c1'),
          ChampionshipModel(
            id: 'c2',
            title: 'Active Champ',
            status: ChampionshipStatus.active,
            teamsCount: 2,
            maxTeams: 8,
            currentRound: 1,
            totalRounds: 5,
            createdBy: 'admin',
            createdAt: DateTime(2026, 1, 1),
            registrationDeadline: DateTime(2026, 6, 1),
          ),
        ],
        activeFilter: null,
      ),
      act: (bloc) => bloc.add(const FilterChampionships(status: 'active')),
      expect: () => [
        isA<ChampionshipListLoaded>()
            .having((s) => s.activeFilter, 'activeFilter', 'active')
            .having((s) => s.championships.length, 'length', 1),
      ],
    );
  });
}
