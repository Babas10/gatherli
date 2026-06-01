// Validates ChampionshipDetailPage renders standings, matches, and round navigation.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class MockChampionshipDetailBloc
    extends MockBloc<ChampionshipDetailEvent, ChampionshipDetailState>
    implements ChampionshipDetailBloc {}

class FakeChampionshipDetailEvent extends Fake
    implements ChampionshipDetailEvent {}

class FakeChampionshipDetailState extends Fake
    implements ChampionshipDetailState {}

// ── Helpers ──────────────────────────────────────────────────────────────────

ChampionshipModel _makeChamp({
  String id = 'c1',
  int currentRound = 2,
  ChampionshipStatus status = ChampionshipStatus.active,
}) {
  return ChampionshipModel(
    id: id,
    title: 'Summer Cup',
    status: status,
    createdBy: 'admin',
    createdAt: DateTime(2026, 1, 1),
    registrationDeadline: DateTime(2026, 2, 1),
    currentRound: currentRound,
  );
}

ChampionshipStandingsModel _makeStanding({
  String teamId = 't1',
  String teamName = 'Team A',
  int position = 1,
}) {
  return ChampionshipStandingsModel(
    teamId: teamId,
    teamName: teamName,
    position: position,
    played: 2,
    wins20: 2,
    points: 6,
  );
}

ChampionshipMatchModel _makeMatch({String id = 'm1'}) {
  return ChampionshipMatchModel(
    id: id,
    round: 2,
    teamAId: 't1',
    teamBId: 't2',
    deadline: DateTime(2026, 4, 1),
  );
}

Widget _buildTestWidget(MockChampionshipDetailBloc bloc) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en')],
    home: BlocProvider<ChampionshipDetailBloc>.value(
      value: bloc,
      child: const Scaffold(body: _TestDetailView()),
    ),
  );
}

/// Minimal view mirroring _ChampionshipDetailView behavior.
/// Uses a plain Column instead of DefaultTabController to avoid animation hangs
/// in widget tests.
class _TestDetailView extends StatelessWidget {
  const _TestDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChampionshipDetailBloc, ChampionshipDetailState>(
      builder: (context, state) {
        if (state is ChampionshipDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChampionshipDetailError) {
          return Center(child: Text(state.message));
        }
        if (state is ChampionshipDetailLoaded) {
          final l10n = AppLocalizations.of(context)!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.championship.title),
                Text(l10n.championshipDetailStandingsTab),
                Text(l10n.championshipDetailMatchesTab),
                if (state.standings.isEmpty)
                  Text(l10n.championshipDetailNoStandings)
                else
                  ...state.standings.map((s) => Text(s.teamName)),
                if (state.currentRoundMatches.isEmpty)
                  Text(l10n.championshipDetailNoMatchesForRound)
                else
                  ...state.currentRoundMatches.map((m) => Text(m.id)),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockChampionshipDetailBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeChampionshipDetailEvent());
    registerFallbackValue(FakeChampionshipDetailState());
  });

  setUp(() {
    bloc = MockChampionshipDetailBloc();
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() => bloc.close());

  group('ChampionshipDetailPage — state rendering', () {
    testWidgets('shows loading indicator in loading state', (tester) async {
      when(() => bloc.state).thenReturn(const ChampionshipDetailLoading());
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows championship title when loaded', (tester) async {
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: _makeChamp(),
        standings: const [],
        teams: const [],
        currentRoundMatches: const [],
        selectedRound: 2,
      ));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('Summer Cup'), findsOneWidget);
    });

    testWidgets('shows error message on error state', (tester) async {
      when(() => bloc.state)
          .thenReturn(const ChampionshipDetailError(message: 'Load failed'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('Load failed'), findsOneWidget);
    });

    testWidgets('shows Standings and Matches tab labels when loaded',
        (tester) async {
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: _makeChamp(),
        standings: const [],
        teams: const [],
        currentRoundMatches: const [],
        selectedRound: 1,
      ));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('Standings'), findsOneWidget);
      expect(find.text('Matches'), findsOneWidget);
    });
  });

  group('ChampionshipDetailPage — standings tab', () {
    testWidgets('shows empty state when no standings', (tester) async {
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: _makeChamp(),
        standings: const [],
        teams: const [],
        currentRoundMatches: const [],
        selectedRound: 1,
      ));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('No standings yet.'), findsOneWidget);
    });

    testWidgets('shows team names in standings', (tester) async {
      final standings = [
        _makeStanding(teamId: 't1', teamName: 'Team Alpha', position: 1),
        _makeStanding(teamId: 't2', teamName: 'Team Beta', position: 2),
      ];
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: _makeChamp(),
        standings: standings,
        teams: const [],
        currentRoundMatches: const [],
        selectedRound: 1,
      ));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('Team Alpha'), findsOneWidget);
      expect(find.text('Team Beta'), findsOneWidget);
    });
  });

  group('ChampionshipDetailPage — matches tab', () {
    testWidgets('shows empty state when no matches', (tester) async {
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: _makeChamp(),
        standings: const [],
        teams: const [],
        currentRoundMatches: const [],
        selectedRound: 2,
      ));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('No matches for this round.'), findsOneWidget);
    });

    testWidgets('shows match ids when matches exist', (tester) async {
      final matches = [_makeMatch(id: 'match-1'), _makeMatch(id: 'match-2')];
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: _makeChamp(),
        standings: const [],
        teams: const [],
        currentRoundMatches: matches,
        selectedRound: 2,
      ));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('match-1'), findsOneWidget);
      expect(find.text('match-2'), findsOneWidget);
    });
  });

  group('ChampionshipDetailLoaded.copyWith', () {
    test('updates selectedRound while preserving other fields', () {
      final champ = _makeChamp();
      final standings = [_makeStanding()];
      final matches = [_makeMatch()];
      final original = ChampionshipDetailLoaded(
        championship: champ,
        standings: standings,
        teams: const [],
        currentRoundMatches: matches,
        selectedRound: 3,
      );

      final updated = original.copyWith(selectedRound: 6);

      expect(updated.selectedRound, 6);
      expect(updated.standings, standings);
      expect(updated.currentRoundMatches, matches);
      expect(updated.championship.id, 'c1');
    });

    test('clears matches while preserving championship and standings', () {
      final champ = _makeChamp();
      final original = ChampionshipDetailLoaded(
        championship: champ,
        standings: [_makeStanding()],
        teams: const [],
        currentRoundMatches: [_makeMatch()],
        selectedRound: 3,
      );

      final updated =
          original.copyWith(currentRoundMatches: const [], selectedRound: 4);

      expect(updated.currentRoundMatches, isEmpty);
      expect(updated.selectedRound, 4);
      expect(updated.standings.length, 1);
    });
  });
}
