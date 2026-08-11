// Validates MatchDetailBloc state transitions for loading match details,
// determining team membership, and proposing a schedule.
import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_state.dart';

import '../../../../../helpers/mocks.dart';

// ── Factories ────────────────────────────────────────────────────────────────

ChampionshipMatchModel _makeMatch({
  String id = 'm1',
  String teamAId = 'teamA',
  String teamBId = 'teamB',
  ChampionshipMatchStatus status = ChampionshipMatchStatus.pending,
  String? submittedByTeamId,
  DateTime? scheduledAt,
}) {
  return ChampionshipMatchModel(
    id: id,
    round: 1,
    teamAId: teamAId,
    teamBId: teamBId,
    deadline: DateTime(2026, 6, 1),
    status: status,
    submittedByTeamId: submittedByTeamId,
    scheduledAt: scheduledAt,
  );
}

ChampionshipTeamModel _makeTeam({
  String id = 'teamA',
  String name = 'Team A',
  List<String> memberIds = const ['user-1', 'user-2'],
}) {
  return ChampionshipTeamModel(
    id: id,
    name: name,
    captainId: memberIds.first,
    memberIds: memberIds,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  late MockChampionshipRepository mockRepo;

  const String championshipId = 'champ-1';
  const String matchId = 'm1';
  const String userId = 'user-1';

  void stubMatch({
    required ChampionshipMatchModel match,
    required ChampionshipTeamModel teamA,
    required ChampionshipTeamModel teamB,
  }) {
    when(
      () => mockRepo.getMatch(
        championshipId: championshipId,
        matchId: matchId,
      ),
    ).thenAnswer((_) => Stream.value(match));

    when(
      () => mockRepo.getTeamById(
        championshipId: championshipId,
        teamId: teamA.id,
      ),
    ).thenAnswer((_) async => teamA);

    when(
      () => mockRepo.getTeamById(
        championshipId: championshipId,
        teamId: teamB.id,
      ),
    ).thenAnswer((_) async => teamB);
  }

  setUpAll(() {
    registerFallbackValues();
    registerFallbackValue(_makeMatch());
    registerFallbackValue(_makeTeam());
  });

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  MatchDetailBloc makeBloc() =>
      MatchDetailBloc(repository: mockRepo);

  // ──────────────────────────────────────────────────────────────────────────
  group('LoadMatchDetail', () {
    blocTest<MatchDetailBloc, MatchDetailState>(
      'initial state is MatchDetailInitial',
      build: makeBloc,
      act: (_) {},
      expect: () => [],
      verify: (bloc) => expect(bloc.state, const MatchDetailInitial()),
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'emits Loading then Loaded when match stream emits and teams load',
      build: () {
        final match = _makeMatch();
        final teamA = _makeTeam(id: 'teamA', memberIds: [userId, 'user-2']);
        final teamB = _makeTeam(id: 'teamB', name: 'Team B',
            memberIds: ['user-3', 'user-4']);
        stubMatch(match: match, teamA: teamA, teamB: teamB);
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadMatchDetail(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: userId,
      )),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const MatchDetailLoading(),
        isA<MatchDetailLoaded>(),
      ],
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'Loaded state has correct myTeamId when user is in teamA',
      build: () {
        final match = _makeMatch();
        final teamA = _makeTeam(id: 'teamA', memberIds: [userId, 'user-2']);
        final teamB = _makeTeam(id: 'teamB', name: 'Team B',
            memberIds: ['user-3', 'user-4']);
        stubMatch(match: match, teamA: teamA, teamB: teamB);
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadMatchDetail(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: userId,
      )),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final loaded = bloc.state as MatchDetailLoaded;
        expect(loaded.myTeamId, 'teamA');
        expect(loaded.isTeamMember, isTrue);
      },
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'Loaded state has myTeamId null when user is not in either team',
      build: () {
        final match = _makeMatch();
        final teamA = _makeTeam(id: 'teamA', memberIds: ['user-5', 'user-6']);
        final teamB = _makeTeam(id: 'teamB', name: 'Team B',
            memberIds: ['user-3', 'user-4']);
        stubMatch(match: match, teamA: teamA, teamB: teamB);
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadMatchDetail(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: userId,
      )),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final loaded = bloc.state as MatchDetailLoaded;
        expect(loaded.myTeamId, isNull);
        expect(loaded.isTeamMember, isFalse);
      },
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'emits Error when match stream errors',
      build: () {
        when(
          () => mockRepo.getMatch(
            championshipId: championshipId,
            matchId: matchId,
          ),
        ).thenAnswer((_) => Stream.error(
              ChampionshipException('Not found', code: 'NOT_FOUND'),
            ));
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadMatchDetail(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: userId,
      )),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const MatchDetailLoading(),
        isA<MatchDetailError>(),
      ],
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'emits Error when getTeamById returns null',
      build: () {
        final match = _makeMatch();
        when(
          () => mockRepo.getMatch(
            championshipId: championshipId,
            matchId: matchId,
          ),
        ).thenAnswer((_) => Stream.value(match));
        when(
          () => mockRepo.getTeamById(
            championshipId: any(named: 'championshipId'),
            teamId: any(named: 'teamId'),
          ),
        ).thenAnswer((_) async => null);
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadMatchDetail(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: userId,
      )),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const MatchDetailLoading(),
        isA<MatchDetailError>(),
      ],
    );
  });

  // ──────────────────────────────────────────────────────────────────────────
  group('Match stream update after first load', () {
    blocTest<MatchDetailBloc, MatchDetailState>(
      'subsequent stream events update match without re-fetching teams',
      build: () {
        final ctrl = StreamController<ChampionshipMatchModel>();
        final match1 = _makeMatch(status: ChampionshipMatchStatus.pending);
        final match2 = _makeMatch(status: ChampionshipMatchStatus.scheduled);
        final teamA = _makeTeam(id: 'teamA', memberIds: [userId, 'user-2']);
        final teamB =
            _makeTeam(id: 'teamB', name: 'Team B', memberIds: ['user-3']);

        when(
          () => mockRepo.getMatch(
            championshipId: championshipId,
            matchId: matchId,
          ),
        ).thenAnswer((_) => ctrl.stream);

        when(
          () => mockRepo.getTeamById(
            championshipId: any(named: 'championshipId'),
            teamId: 'teamA',
          ),
        ).thenAnswer((_) async => teamA);

        when(
          () => mockRepo.getTeamById(
            championshipId: any(named: 'championshipId'),
            teamId: 'teamB',
          ),
        ).thenAnswer((_) async => teamB);

        Future.microtask(() {
          ctrl.add(match1);
          Future.delayed(
            const Duration(milliseconds: 20),
            () => ctrl.add(match2),
          );
        });

        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadMatchDetail(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: userId,
      )),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final loaded = bloc.state as MatchDetailLoaded;
        expect(loaded.match.status, ChampionshipMatchStatus.scheduled);
        // Teams should only have been fetched once (for the first snapshot).
        verify(
          () => mockRepo.getTeamById(
            championshipId: any(named: 'championshipId'),
            teamId: any(named: 'teamId'),
          ),
        ).called(2); // one call per team on first load
      },
    );
  });

  // ──────────────────────────────────────────────────────────────────────────
  group('ProposeSchedule', () {
    blocTest<MatchDetailBloc, MatchDetailState>(
      'calls proposeMatchSchedule and clears isProposingSchedule on success',
      build: () {
        final match = _makeMatch();
        final teamA = _makeTeam(id: 'teamA', memberIds: [userId, 'user-2']);
        final teamB =
            _makeTeam(id: 'teamB', name: 'Team B', memberIds: ['user-3']);
        stubMatch(match: match, teamA: teamA, teamB: teamB);
        when(
          () => mockRepo.proposeMatchSchedule(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            scheduledAt: any(named: 'scheduledAt'),
            location: any(named: 'location'),
          ),
        ).thenAnswer((_) async {});
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(const LoadMatchDetail(
          championshipId: championshipId,
          matchId: matchId,
          currentUserId: userId,
        ));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(ProposeSchedule(
          scheduledAt: DateTime(2026, 7, 15, 18),
        ));
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<MatchDetailLoaded>());
        expect((state as MatchDetailLoaded).isProposingSchedule, isFalse);
        expect(state.scheduleError, isNull);
        verify(
          () => mockRepo.proposeMatchSchedule(
            championshipId: championshipId,
            matchId: matchId,
            scheduledAt: DateTime(2026, 7, 15, 18),
            location: null,
          ),
        ).called(1);
      },
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'sets scheduleError on ChampionshipException',
      build: () {
        final match = _makeMatch();
        final teamA = _makeTeam(id: 'teamA', memberIds: [userId, 'user-2']);
        final teamB =
            _makeTeam(id: 'teamB', name: 'Team B', memberIds: ['user-3']);
        stubMatch(match: match, teamA: teamA, teamB: teamB);
        when(
          () => mockRepo.proposeMatchSchedule(
            championshipId: any(named: 'championshipId'),
            matchId: any(named: 'matchId'),
            scheduledAt: any(named: 'scheduledAt'),
            location: any(named: 'location'),
          ),
        ).thenThrow(ChampionshipException('Not allowed', code: 'DENIED'));
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(const LoadMatchDetail(
          championshipId: championshipId,
          matchId: matchId,
          currentUserId: userId,
        ));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(ProposeSchedule(scheduledAt: DateTime(2026, 7, 15, 18)));
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final state = bloc.state as MatchDetailLoaded;
        expect(state.isProposingSchedule, isFalse);
        expect(state.scheduleError, isNotNull);
      },
    );

    blocTest<MatchDetailBloc, MatchDetailState>(
      'ProposeSchedule is ignored when state is not Loaded',
      build: makeBloc,
      act: (bloc) => bloc.add(
        ProposeSchedule(scheduledAt: DateTime(2026, 7, 15, 18)),
      ),
      expect: () => [],
    );
  });
}
