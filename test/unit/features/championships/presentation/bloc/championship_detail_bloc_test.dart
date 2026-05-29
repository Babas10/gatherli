// Validates ChampionshipDetailBloc state transitions for loading championship,
// standings, and matches data.
import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';

class MockChampionshipRepository extends Mock
    implements ChampionshipRepository {}

// ── Factories ────────────────────────────────────────────────────────────────

ChampionshipModel _makeChamp({
  String id = 'c1',
  int currentRound = 3,
  int totalRounds = 9,
  ChampionshipStatus status = ChampionshipStatus.active,
}) {
  return ChampionshipModel(
    id: id,
    title: 'Test Championship',
    status: status,
    createdBy: 'admin',
    createdAt: DateTime(2026, 1, 1),
    registrationDeadline: DateTime(2026, 2, 1),
    currentRound: currentRound,
    totalRounds: totalRounds,
  );
}

ChampionshipStandingsModel _makeStanding({
  String teamId = 't1',
  String teamName = 'Team A',
  int position = 1,
  int points = 9,
}) {
  return ChampionshipStandingsModel(
    teamId: teamId,
    teamName: teamName,
    position: position,
    points: points,
    played: 3,
    wins20: 3,
  );
}

ChampionshipMatchModel _makeMatch({
  String id = 'm1',
  int round = 3,
  String teamAId = 't1',
  String teamBId = 't2',
}) {
  return ChampionshipMatchModel(
    id: id,
    round: round,
    teamAId: teamAId,
    teamBId: teamBId,
    deadline: DateTime(2026, 3, 1),
  );
}

void main() {
  late MockChampionshipRepository mockRepo;

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  ChampionshipDetailBloc makeBloc() =>
      ChampionshipDetailBloc(repository: mockRepo);

  group('LoadChampionshipDetail', () {
    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'initial state is ChampionshipDetailInitial',
      build: makeBloc,
      act: (_) {},
      expect: () => [],
      verify: (bloc) =>
          expect(bloc.state, const ChampionshipDetailInitial()),
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'emits Loading then Loaded on successful championship stream',
      build: () {
        final champ = _makeChamp();
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => Stream.value(champ));
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const ChampionshipDetailLoading(),
        isA<ChampionshipDetailLoaded>(),
      ],
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'Loaded state has championship data and selectedRound=currentRound',
      build: () {
        final champ = _makeChamp(currentRound: 4);
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => Stream.value(champ));
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final loaded = bloc.state as ChampionshipDetailLoaded;
        expect(loaded.selectedRound, 4);
        expect(loaded.championship.id, 'c1');
      },
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'selectedRound defaults to 1 when currentRound is 0',
      build: () {
        final champ = _makeChamp(
          currentRound: 0,
          status: ChampionshipStatus.registration,
        );
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => Stream.value(champ));
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        final loaded = bloc.state as ChampionshipDetailLoaded;
        expect(loaded.selectedRound, 1);
      },
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'emits Error when championship stream errors',
      build: () {
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => Stream.error(
                  ChampionshipException('Not found', code: 'NOT_FOUND'),
                ));
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const ChampionshipDetailLoading(),
        isA<ChampionshipDetailError>(),
      ],
    );
  });

  group('Standings and Matches updates', () {
    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'standings stream updates standings in Loaded state',
      build: () {
        final champCtrl = StreamController<ChampionshipModel>();
        final standingsCtrl =
            StreamController<List<ChampionshipStandingsModel>>();

        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => champCtrl.stream);
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => standingsCtrl.stream);
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());

        // Emit championship first, then standings
        Future.microtask(() {
          champCtrl.add(_makeChamp());
          Future.delayed(
            const Duration(milliseconds: 10),
            () => standingsCtrl.add([_makeStanding()]),
          );
        });

        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final loaded = bloc.state as ChampionshipDetailLoaded;
        expect(loaded.standings.length, 1);
        expect(loaded.standings.first.teamName, 'Team A');
      },
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'matches stream updates currentRoundMatches in Loaded state',
      build: () {
        final champCtrl = StreamController<ChampionshipModel>();
        final matchesCtrl =
            StreamController<List<ChampionshipMatchModel>>();

        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => champCtrl.stream);
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => matchesCtrl.stream);

        Future.microtask(() {
          champCtrl.add(_makeChamp());
          Future.delayed(
            const Duration(milliseconds: 10),
            () => matchesCtrl.add([_makeMatch()]),
          );
        });

        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final loaded = bloc.state as ChampionshipDetailLoaded;
        expect(loaded.currentRoundMatches.length, 1);
      },
    );
  });

  group('ChangeDetailRound', () {
    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'changing round updates selectedRound and clears matches',
      build: () {
        final champ = _makeChamp(currentRound: 3);
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => Stream.value(champ));
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(const LoadChampionshipDetail('c1'));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const ChangeDetailRound(5));
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final loaded = bloc.state as ChampionshipDetailLoaded;
        expect(loaded.selectedRound, 5);
      },
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'ChangeDetailRound calls getMatchesForRound with new round',
      build: () {
        final champ = _makeChamp(currentRound: 3);
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => Stream.value(champ));
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(const LoadChampionshipDetail('c1'));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const ChangeDetailRound(7));
      },
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        verify(
          () => mockRepo.getMatchesForRound(
            championshipId: 'c1',
            round: 7,
          ),
        ).called(1);
      },
    );

    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'ChangeDetailRound is ignored when state is not Loaded',
      build: makeBloc,
      act: (bloc) => bloc.add(const ChangeDetailRound(2)),
      expect: () => [],
    );
  });

  group('Championship stream update after first load', () {
    blocTest<ChampionshipDetailBloc, ChampionshipDetailState>(
      'second championship stream event updates championship in Loaded state',
      build: () {
        final ctrl = StreamController<ChampionshipModel>();
        when(() => mockRepo.getChampionshipById('c1'))
            .thenAnswer((_) => ctrl.stream);
        when(() => mockRepo.getStandings('c1'))
            .thenAnswer((_) => const Stream.empty());
        when(
          () => mockRepo.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          ),
        ).thenAnswer((_) => const Stream.empty());

        Future.microtask(() {
          ctrl.add(_makeChamp(currentRound: 3));
          Future.delayed(
            const Duration(milliseconds: 20),
            () => ctrl.add(_makeChamp(currentRound: 4)),
          );
        });

        return makeBloc();
      },
      act: (bloc) => bloc.add(const LoadChampionshipDetail('c1')),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final loaded = bloc.state as ChampionshipDetailLoaded;
        expect(loaded.championship.currentRound, 4);
      },
    );
  });
}
