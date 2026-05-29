// Validates MatchVerificationBloc state transitions for match result verification.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_verification/match_verification_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_verification/match_verification_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_verification/match_verification_state.dart';

class MockChampionshipRepository extends Mock implements ChampionshipRepository {}

void main() {
  late MockChampionshipRepository mockRepo;

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  MatchVerificationBloc makeBloc() =>
      MatchVerificationBloc(championshipRepository: mockRepo);

  group('VerifyMatchResult', () {
    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'initial state is MatchVerificationInitial',
      build: makeBloc,
      act: (_) {},
      expect: () => [],
      verify: (bloc) => expect(bloc.state, const MatchVerificationInitial()),
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'emits Loading then Verified on successful verify',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenAnswer((_) async => 'verified');
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const VerifyMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
        ),
      ),
      expect: () => [
        const MatchVerificationLoading(),
        const MatchVerificationVerified(),
      ],
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'passes action=verify to repository',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenAnswer((_) async => 'verified');
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const VerifyMatchResult(
          championshipId: 'champ-99',
          matchId: 'match-42',
        ),
      ),
      verify: (_) => verify(
        () => mockRepo.verifyMatchResult(
          championshipId: 'champ-99',
          matchId: 'match-42',
          action: 'verify',
        ),
      ).called(1),
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'emits Loading then Error with code on ChampionshipException during verify',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenThrow(ChampionshipException('permission-denied', code: 'PERMISSION_DENIED'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const VerifyMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
        ),
      ),
      expect: () => [
        const MatchVerificationLoading(),
        const MatchVerificationError(
          message: 'permission-denied',
          errorCode: 'PERMISSION_DENIED',
        ),
      ],
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'emits Loading then Error on generic exception during verify',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenThrow(Exception('network error'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const VerifyMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
        ),
      ),
      expect: () => [
        const MatchVerificationLoading(),
        isA<MatchVerificationError>(),
      ],
    );
  });

  group('DisputeMatchResult', () {
    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'emits Loading then Disputed on successful dispute',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenAnswer((_) async => 'disputed');
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const DisputeMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
          reason: 'Wrong scores entered.',
        ),
      ),
      expect: () => [
        const MatchVerificationLoading(),
        const MatchVerificationDisputed(),
      ],
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'passes action=dispute and reason to repository',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenAnswer((_) async => 'disputed');
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const DisputeMatchResult(
          championshipId: 'champ-99',
          matchId: 'match-42',
          reason: 'Scores were reversed.',
        ),
      ),
      verify: (_) => verify(
        () => mockRepo.verifyMatchResult(
          championshipId: 'champ-99',
          matchId: 'match-42',
          action: 'dispute',
          disputeReason: 'Scores were reversed.',
        ),
      ).called(1),
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'emits Loading then Error with code on ChampionshipException during dispute',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenThrow(ChampionshipException('not-member', code: 'NOT_MEMBER'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const DisputeMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
          reason: 'Wrong.',
        ),
      ),
      expect: () => [
        const MatchVerificationLoading(),
        const MatchVerificationError(
          message: 'not-member',
          errorCode: 'NOT_MEMBER',
        ),
      ],
    );

    blocTest<MatchVerificationBloc, MatchVerificationState>(
      'emits Loading then Error on generic exception during dispute',
      build: () {
        when(
          () => mockRepo.verifyMatchResult(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            action: any(named: 'action'),
            disputeReason: any(named: 'disputeReason'),
          ),
        ).thenThrow(Exception('timeout'));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const DisputeMatchResult(
          championshipId: 'champ-1',
          matchId: 'match-1',
          reason: 'Wrong.',
        ),
      ),
      expect: () => [
        const MatchVerificationLoading(),
        isA<MatchVerificationError>(),
      ],
    );
  });
}
