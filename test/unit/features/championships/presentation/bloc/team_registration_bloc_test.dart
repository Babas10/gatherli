// Validates TeamRegistrationBloc state transitions for loading championships and team CRUD.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_state.dart';

import '../../../../../helpers/mocks.dart';

ChampionshipModel _championship({
  String id = 'champ-1',
  String title = 'Summer Open',
  int teamsCount = 3,
}) =>
    ChampionshipModel(
      id: id,
      title: title,
      createdBy: 'admin-uid',
      createdAt: DateTime(2026, 1, 1),
      registrationDeadline: DateTime(2026, 8, 1),
      teamsCount: teamsCount,
    );

void main() {
  late MockChampionshipRepository mockRepo;

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  TeamRegistrationBloc makeBloc() =>
      TeamRegistrationBloc(championshipRepository: mockRepo);

  group('LoadChampionships', () {
    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Loading, Loaded] when championships stream emits',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.getOpenChampionships())
            .thenAnswer((_) => Stream.value([_championship()]));
      },
      act: (bloc) => bloc.add(const LoadChampionships('user-1')),
      expect: () => [
        const TeamRegistrationLoading(),
        isA<TeamRegistrationLoaded>()
            .having((s) => s.championships.length, 'count', 1),
      ],
    );

    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Loading, Error] when stream throws ChampionshipException',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.getOpenChampionships()).thenAnswer(
          (_) => Stream.error(ChampionshipException('Failed', code: 'LOAD_ERROR')),
        );
      },
      act: (bloc) => bloc.add(const LoadChampionships('user-1')),
      expect: () => [
        const TeamRegistrationLoading(),
        isA<TeamRegistrationError>(),
      ],
    );
  });

  group('CreateTeam', () {
    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Submitting, TeamCreated] on success',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.createTeam(
              championshipId: any(named: 'championshipId'),
              teamName: any(named: 'teamName'),
              partnerId: any(named: 'partnerId'),
            )).thenAnswer((_) async => 'team-abc');
      },
      act: (bloc) => bloc.add(const CreateTeam(
        championshipId: 'champ-1',
        teamName: 'Beach Wolves',
        partnerId: 'partner-uid',
      )),
      expect: () => [
        const TeamRegistrationSubmitting(),
        isA<TeamCreated>().having((s) => s.teamId, 'teamId', 'team-abc'),
      ],
    );

    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Submitting, Error] when repository throws ChampionshipException',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.createTeam(
              championshipId: any(named: 'championshipId'),
              teamName: any(named: 'teamName'),
              partnerId: any(named: 'partnerId'),
            )).thenThrow(ChampionshipException('permission-denied'));
      },
      act: (bloc) => bloc.add(const CreateTeam(
        championshipId: 'champ-1',
        teamName: 'Beach Wolves',
        partnerId: 'partner-uid',
      )),
      expect: () => [
        const TeamRegistrationSubmitting(),
        isA<TeamRegistrationError>(),
      ],
    );

    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Submitting, Error] on unexpected exception',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.createTeam(
              championshipId: any(named: 'championshipId'),
              teamName: any(named: 'teamName'),
              partnerId: any(named: 'partnerId'),
            )).thenThrow(Exception('network error'));
      },
      act: (bloc) => bloc.add(const CreateTeam(
        championshipId: 'champ-1',
        teamName: 'Beach Wolves',
        partnerId: 'partner-uid',
      )),
      expect: () => [
        const TeamRegistrationSubmitting(),
        isA<TeamRegistrationError>(),
      ],
    );
  });

  group('LeaveTeam', () {
    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Submitting, TeamLeft] on success',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.leaveTeam(
              championshipId: any(named: 'championshipId'),
              teamId: any(named: 'teamId'),
            )).thenAnswer((_) async {});
      },
      act: (bloc) => bloc.add(
          const LeaveTeam(championshipId: 'champ-1', teamId: 'team-abc')),
      expect: () => [
        const TeamRegistrationSubmitting(),
        const TeamLeft(),
      ],
    );

    blocTest<TeamRegistrationBloc, TeamRegistrationState>(
      'emits [Submitting, Error] when repository throws ChampionshipException',
      build: makeBloc,
      setUp: () {
        when(() => mockRepo.leaveTeam(
              championshipId: any(named: 'championshipId'),
              teamId: any(named: 'teamId'),
            )).thenThrow(ChampionshipException('failed-precondition'));
      },
      act: (bloc) => bloc.add(
          const LeaveTeam(championshipId: 'champ-1', teamId: 'team-abc')),
      expect: () => [
        const TeamRegistrationSubmitting(),
        isA<TeamRegistrationError>(),
      ],
    );
  });
}
