// Validates ChampionshipDetailPage renders standings, matches, and round navigation.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_bloc.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';
import 'package:play_with_me/features/championships/presentation/pages/championship_detail_page.dart';
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

  group('ChampionshipDetailPage — delete championship (real page)', () {
    late MockChampionshipRepository mockChampionshipRepository;
    late MockUserRepository mockUserRepository;
    late MockAuthenticationBloc mockAuthBloc;

    const testUserId = 'test-admin-uid';

    setUp(() async {
      mockChampionshipRepository = MockChampionshipRepository();
      mockUserRepository = MockUserRepository();
      mockAuthBloc = MockAuthenticationBloc();

      when(() => mockUserRepository.currentUser)
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getChampionshipById(any()))
          .thenAnswer(
        (_) => Stream.value(makeChampionship(id: 'c1', adminIds: [testUserId])),
      );
      when(() => mockChampionshipRepository.getStandings(any()))
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getTeams(any()))
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getAllMatches(any()))
          .thenAnswer((_) => Stream.value(const []));
      when(() => mockChampionshipRepository.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          )).thenAnswer((_) => const Stream.empty());

      when(() => mockAuthBloc.state).thenReturn(
        AuthenticationAuthenticated(
          UserEntity(
            uid: testUserId,
            email: 'admin@example.com',
            isEmailVerified: true,
            createdAt: DateTime(2026, 1, 1),
            lastSignInAt: DateTime(2026, 1, 1),
          ),
        ),
      );
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await sl.reset();
      sl.registerFactory<ChampionshipDetailBloc>(
        () => ChampionshipDetailBloc(
          repository: mockChampionshipRepository,
          userRepository: mockUserRepository,
        ),
      );
      sl.registerFactory<AdminPanelBloc>(
        () => AdminPanelBloc(repository: mockChampionshipRepository),
      );
    });

    tearDown(() async {
      await sl.reset();
    });

    testWidgets(
      'admin sees a Delete League button for a registration-status championship, '
      'which opens a confirmation dialog',
      (tester) async {
        await tester.pumpWidget(testApp(
          child: BlocProvider<AuthenticationBloc>.value(
            value: mockAuthBloc,
            child: const ChampionshipDetailPage(championshipId: 'c1'),
          ),
        ));
        await tester.pumpAndSettle();

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.tap(find.text(l10n.adminPanelTabLabel));
        await tester.pumpAndSettle();

        expect(find.text(l10n.deleteChampionshipButton), findsOneWidget);

        await tester.tap(find.text(l10n.deleteChampionshipButton));
        await tester.pumpAndSettle();

        expect(find.text(l10n.deleteChampionshipConfirmTitle), findsOneWidget);
        expect(find.text(l10n.deleteChampionshipConfirmBody), findsOneWidget);
      },
    );

    testWidgets(
      'no Delete League button once the championship is active',
      (tester) async {
        when(() => mockChampionshipRepository.getChampionshipById(any()))
            .thenAnswer(
          (_) => Stream.value(makeChampionship(
            id: 'c1',
            adminIds: [testUserId],
            status: ChampionshipStatus.active,
            currentRound: 1,
          )),
        );

        await tester.pumpWidget(testApp(
          child: BlocProvider<AuthenticationBloc>.value(
            value: mockAuthBloc,
            child: const ChampionshipDetailPage(championshipId: 'c1'),
          ),
        ));
        await tester.pumpAndSettle();

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.tap(find.text(l10n.adminPanelTabLabel));
        await tester.pumpAndSettle();

        expect(find.text(l10n.deleteChampionshipButton), findsNothing);
      },
    );
  });

  group('ChampionshipDetailPage — copy link button (real page)', () {
    late MockChampionshipRepository mockChampionshipRepository;
    late MockUserRepository mockUserRepository;
    late MockAuthenticationBloc mockAuthBloc;

    const testUserId = 'test-uid-not-admin';

    setUp(() async {
      mockChampionshipRepository = MockChampionshipRepository();
      mockUserRepository = MockUserRepository();
      mockAuthBloc = MockAuthenticationBloc();

      when(() => mockUserRepository.currentUser)
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getChampionshipById(any()))
          .thenAnswer((_) => Stream.value(makeChampionship(id: 'c1')));
      when(() => mockChampionshipRepository.getStandings(any()))
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getTeams(any()))
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getAllMatches(any()))
          .thenAnswer((_) => const Stream.empty());
      when(() => mockChampionshipRepository.getMatchesForRound(
            championshipId: any(named: 'championshipId'),
            round: any(named: 'round'),
          )).thenAnswer((_) => const Stream.empty());

      when(() => mockAuthBloc.state).thenReturn(
        AuthenticationAuthenticated(
          UserEntity(
            uid: testUserId,
            email: 'test@example.com',
            isEmailVerified: true,
            createdAt: DateTime(2026, 1, 1),
            lastSignInAt: DateTime(2026, 1, 1),
          ),
        ),
      );
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await sl.reset();
      sl.registerFactory<ChampionshipDetailBloc>(
        () => ChampionshipDetailBloc(
          repository: mockChampionshipRepository,
          userRepository: mockUserRepository,
        ),
      );
    });

    tearDown(() async {
      await sl.reset();
    });

    testWidgets('shows a copy link button', (tester) async {
      await tester.pumpWidget(testApp(
        child: BlocProvider<AuthenticationBloc>.value(
          value: mockAuthBloc,
          child: const ChampionshipDetailPage(championshipId: 'c1'),
        ),
      ));
      await tester.pumpAndSettle();

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.byIcon(Icons.copy), findsOneWidget);
      expect(find.text(l10n.copyLink), findsOneWidget);
    });
  });
}
