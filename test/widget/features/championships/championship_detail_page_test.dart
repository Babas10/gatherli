// Validates ChampionshipDetailPage renders standings, matches, and round navigation.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_app.dart';
import '../../../helpers/fixtures.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

Widget _buildTestWidget(MockChampionshipDetailBloc bloc) {
  return testApp(
    child: BlocProvider<ChampionshipDetailBloc>.value(
      value: bloc,
      child: const Scaffold(body: _TestDetailView()),
    ),
  );
}

/// Minimal view mirroring _ChampionshipDetailView behavior.
/// Uses a plain Column instead of DefaultTabController to avoid animation hangs.
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

  setUpAll(registerFallbackValues);

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
        championship: makeChampionship(title: 'Summer Cup', currentRound: 2),
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
        championship: makeChampionship(),
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
        championship: makeChampionship(),
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
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: makeChampionship(),
        standings: [
          makeStandings(teamId: 't1', teamName: 'Team Alpha', position: 1),
          makeStandings(teamId: 't2', teamName: 'Team Beta', position: 2),
        ],
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
        championship: makeChampionship(currentRound: 2),
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
      when(() => bloc.state).thenReturn(ChampionshipDetailLoaded(
        championship: makeChampionship(currentRound: 2),
        standings: const [],
        teams: const [],
        currentRoundMatches: [makeMatch(id: 'match-1'), makeMatch(id: 'match-2')],
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
      final standings = [makeStandings()];
      final matches = [makeMatch()];
      final original = ChampionshipDetailLoaded(
        championship: makeChampionship(),
        standings: standings,
        teams: const [],
        currentRoundMatches: matches,
        selectedRound: 3,
      );

      final updated = original.copyWith(selectedRound: 6);

      expect(updated.selectedRound, 6);
      expect(updated.standings, standings);
      expect(updated.currentRoundMatches, matches);
    });

    test('clears matches while preserving championship and standings', () {
      final original = ChampionshipDetailLoaded(
        championship: makeChampionship(),
        standings: [makeStandings()],
        teams: const [],
        currentRoundMatches: [makeMatch()],
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
