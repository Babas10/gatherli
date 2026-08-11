// Validates ChampionshipCreationBloc state transitions for championship creation.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_state.dart';

import '../../../../../helpers/mocks.dart';

void main() {
  late MockChampionshipRepository mockRepo;

  final deadline = DateTime(2026, 12, 1);

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  ChampionshipCreationBloc makeBloc() =>
      ChampionshipCreationBloc(repository: mockRepo);

  group('ChampionshipCreationBloc', () {
    blocTest<ChampionshipCreationBloc, ChampionshipCreationState>(
      'emits [submitting, success] on successful creation',
      build: () {
        when(() => mockRepo.createChampionship(
              title: any(named: 'title'),
              registrationDeadline: any(named: 'registrationDeadline'),
              startDate: any(named: 'startDate'),
              endDate: any(named: 'endDate'),
              country: any(named: 'country'),
              region: any(named: 'region'),
              genderCategory: any(named: 'genderCategory'),
            )).thenAnswer((_) async => 'new-champ-id');
        return makeBloc();
      },
      act: (bloc) => bloc.add(SubmitChampionshipCreation(
        title: 'Summer Open',
        registrationDeadline: deadline,
      )),
      expect: () => [
        const ChampionshipCreationSubmitting(),
        const ChampionshipCreationSuccess(championshipId: 'new-champ-id'),
      ],
    );

    blocTest<ChampionshipCreationBloc, ChampionshipCreationState>(
      'emits [submitting, error] when ChampionshipException is thrown',
      build: () {
        when(() => mockRepo.createChampionship(
              title: any(named: 'title'),
              registrationDeadline: any(named: 'registrationDeadline'),
              startDate: any(named: 'startDate'),
              endDate: any(named: 'endDate'),
              country: any(named: 'country'),
              region: any(named: 'region'),
              genderCategory: any(named: 'genderCategory'),
            )).thenThrow(ChampionshipException('permission-denied'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(SubmitChampionshipCreation(
        title: 'Summer Open',
        registrationDeadline: deadline,
      )),
      expect: () => [
        const ChampionshipCreationSubmitting(),
        const ChampionshipCreationError(message: 'permission-denied'),
      ],
    );

    blocTest<ChampionshipCreationBloc, ChampionshipCreationState>(
      'emits [submitting, error] on unexpected exception',
      build: () {
        when(() => mockRepo.createChampionship(
              title: any(named: 'title'),
              registrationDeadline: any(named: 'registrationDeadline'),
              startDate: any(named: 'startDate'),
              endDate: any(named: 'endDate'),
              country: any(named: 'country'),
              region: any(named: 'region'),
              genderCategory: any(named: 'genderCategory'),
            )).thenThrow(Exception('network error'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(SubmitChampionshipCreation(
        title: 'Summer Open',
        registrationDeadline: deadline,
      )),
      expect: () => [
        const ChampionshipCreationSubmitting(),
        isA<ChampionshipCreationError>(),
      ],
    );

    blocTest<ChampionshipCreationBloc, ChampionshipCreationState>(
      'passes optional country and region to repository',
      build: () {
        when(() => mockRepo.createChampionship(
              title: any(named: 'title'),
              registrationDeadline: any(named: 'registrationDeadline'),
              startDate: any(named: 'startDate'),
              endDate: any(named: 'endDate'),
              country: any(named: 'country'),
              region: any(named: 'region'),
              genderCategory: any(named: 'genderCategory'),
            )).thenAnswer((_) async => 'champ-id');
        return makeBloc();
      },
      act: (bloc) => bloc.add(SubmitChampionshipCreation(
        title: 'French Open',
        registrationDeadline: deadline,
        country: 'FR',
        region: 'Alsace',
      )),
      verify: (_) {
        verify(() => mockRepo.createChampionship(
              title: 'French Open',
              registrationDeadline: deadline,
              startDate: null,
              endDate: null,
              country: 'FR',
              region: 'Alsace',
              genderCategory: null,
            )).called(1);
      },
      expect: () => [
        const ChampionshipCreationSubmitting(),
        const ChampionshipCreationSuccess(championshipId: 'champ-id'),
      ],
    );

    test('initial state is ChampionshipCreationInitial', () {
      when(() => mockRepo.createChampionship(
            title: any(named: 'title'),
            registrationDeadline: any(named: 'registrationDeadline'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
            country: any(named: 'country'),
            region: any(named: 'region'),
            genderCategory: any(named: 'genderCategory'),
          )).thenAnswer((_) async => 'id');
      expect(
        makeBloc().state,
        const ChampionshipCreationInitial(),
      );
    });
  });
}
