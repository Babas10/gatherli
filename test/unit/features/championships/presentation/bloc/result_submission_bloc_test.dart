// Validates ResultSubmissionBloc state transitions for match result submission.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/bloc/result_submission/result_submission_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/result_submission/result_submission_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/result_submission/result_submission_state.dart';

class MockChampionshipRepository extends Mock implements ChampionshipRepository {}

void main() {
  late MockChampionshipRepository mockRepo;

  const sets2_0 = [
    MatchSetScore(teamAPoints: 21, teamBPoints: 15, setNumber: 1),
    MatchSetScore(teamAPoints: 21, teamBPoints: 18, setNumber: 2),
  ];

  setUpAll(() {
    registerFallbackValue(sets2_0);
  });

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  ResultSubmissionBloc makeBloc() =>
      ResultSubmissionBloc(championshipRepository: mockRepo);

  group('SubmitMatchResult', () {
    blocTest<ResultSubmissionBloc, ResultSubmissionState>(
      'emits Submitting then Success on successful submission',
      build: () {
        when(
          () => mockRepo.submitMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            sets: any(named: 'sets'),
          ),
        ).thenAnswer((_) async {});
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const SubmitMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
          sets: sets2_0,
        ),
      ),
      expect: () => [
        const ResultSubmissionSubmitting(),
        const ResultSubmissionSuccess(),
      ],
    );

    blocTest<ResultSubmissionBloc, ResultSubmissionState>(
      'emits Submitting then Error with message on ChampionshipException',
      build: () {
        when(
          () => mockRepo.submitMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            sets: any(named: 'sets'),
          ),
        ).thenThrow(ChampionshipException('permission-denied', code: 'PERMISSION_DENIED'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const SubmitMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
          sets: sets2_0,
        ),
      ),
      expect: () => [
        const ResultSubmissionSubmitting(),
        const ResultSubmissionError(
          message: 'permission-denied',
          errorCode: 'PERMISSION_DENIED',
        ),
      ],
    );

    blocTest<ResultSubmissionBloc, ResultSubmissionState>(
      'emits Submitting then Error on generic exception',
      build: () {
        when(
          () => mockRepo.submitMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            sets: any(named: 'sets'),
          ),
        ).thenThrow(Exception('network error'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const SubmitMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
          sets: sets2_0,
        ),
      ),
      expect: () => [
        const ResultSubmissionSubmitting(),
        isA<ResultSubmissionError>(),
      ],
    );

    blocTest<ResultSubmissionBloc, ResultSubmissionState>(
      'passes correct championshipId, matchId, and sets to repository',
      build: () {
        when(
          () => mockRepo.submitMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            sets: any(named: 'sets'),
          ),
        ).thenAnswer((_) async {});
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const SubmitMatchResult(
          championshipId: 'champ-99',
          matchId: 'match-42',
          sets: sets2_0,
        ),
      ),
      verify: (_) => verify(
        () => mockRepo.submitMatchResult(
          championshipId: 'champ-99',
          matchId: 'match-42',
          sets: sets2_0,
        ),
      ).called(1),
    );

    blocTest<ResultSubmissionBloc, ResultSubmissionState>(
      'initial state is ResultSubmissionInitial',
      build: makeBloc,
      act: (_) {},
      expect: () => [],
      verify: (bloc) => expect(bloc.state, const ResultSubmissionInitial()),
    );
  });
}
