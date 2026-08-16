// Validates ChampionshipListPage renders states and handles filter interactions.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_state.dart';
import 'package:play_with_me/features/championships/presentation/pages/championship_list_page.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_app.dart';
import '../../../helpers/fixtures.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

Widget _buildTestWidget(ChampionshipListBloc bloc) {
  return testApp(
    child: Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: Builder(
          builder: (context) =>
              BlocBuilder<ChampionshipListBloc, ChampionshipListState>(
            builder: (context, state) {
              if (state is ChampionshipListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ChampionshipListError) {
                return Center(child: Text(state.message));
              }
              if (state is ChampionshipListLoaded) {
                final items = state.championships;
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.championshipNoResults,
                    ),
                  );
                }
                return ListView(
                  children: items
                      .map((c) => ChampionshipCard(championship: c))
                      .toList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockChampionshipRepository mockRepo;

  setUpAll(registerFallbackValues);

  setUp(() {
    mockRepo = MockChampionshipRepository();
  });

  ChampionshipListBloc makeBloc() =>
      ChampionshipListBloc(repository: mockRepo);

  group('ChampionshipListPage', () {
    testWidgets('shows loading indicator while loading', (tester) async {
      when(() => mockRepo.getChampionships())
          .thenAnswer((_) => const Stream.empty());

      final bloc = makeBloc();
      await tester.pumpWidget(_buildTestWidget(bloc));
      bloc.add(const LoadChampionships());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      bloc.close();
    });

    testWidgets('shows empty state when no championships', (tester) async {
      when(() => mockRepo.getChampionships())
          .thenAnswer((_) => Stream.value([]));

      final bloc = makeBloc()..add(const LoadChampionships());
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('No championships at the moment.'), findsOneWidget);
      bloc.close();
    });

    testWidgets('shows championship cards when data is loaded', (tester) async {
      final championships = [
        makeChampionship(id: 'c1', title: 'Summer Cup'),
        makeChampionship(id: 'c2', title: 'Winter League'),
      ];
      when(() => mockRepo.getChampionships())
          .thenAnswer((_) => Stream.value(championships));

      final bloc = makeBloc()..add(const LoadChampionships());
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.text('Summer Cup'), findsOneWidget);
      expect(find.text('Winter League'), findsOneWidget);
      bloc.close();
    });

    testWidgets('shows error message on error state', (tester) async {
      final bloc = makeBloc();
      await tester.pumpWidget(_buildTestWidget(bloc));
      bloc.emit(const ChampionshipListError(message: 'Failed to load'));
      await tester.pumpAndSettle();

      expect(find.text('Failed to load'), findsOneWidget);
      bloc.close();
    });
  });

  group('ChampionshipCard', () {
    testWidgets('shows title, team count and registration status badge',
        (tester) async {
      final champ = makeChampionship(
        id: 'c1',
        title: 'Beach Open',
        status: ChampionshipStatus.registration,
        teamsCount: 3,
        maxTeams: 10,
      );

      await tester.pumpWidget(testApp(
        child: Scaffold(body: ChampionshipCard(championship: champ)),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Beach Open'), findsOneWidget);
      expect(find.text('3 / 10 teams'), findsOneWidget);
      expect(find.text('Registration Open'), findsOneWidget);
    });

    testWidgets('shows active status badge with round info', (tester) async {
      final champ = makeChampionship(
        id: 'c1',
        title: 'Active Champ',
        status: ChampionshipStatus.active,
        currentRound: 3,
      );

      await tester.pumpWidget(testApp(
        child: Scaffold(body: ChampionshipCard(championship: champ)),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Round 3/9'), findsOneWidget);
    });

    testWidgets('shows completed status badge', (tester) async {
      final champ = makeChampionship(
        id: 'c1',
        title: 'Done Champ',
        status: ChampionshipStatus.completed,
      );

      await tester.pumpWidget(testApp(
        child: Scaffold(body: ChampionshipCard(championship: champ)),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Completed'), findsOneWidget);
    });

    testWidgets('shows location when country is set', (tester) async {
      final champ = makeChampionship(id: 'c1', title: 'Loc Champ', country: 'Switzerland');

      await tester.pumpWidget(testApp(
        child: Scaffold(body: ChampionshipCard(championship: champ)),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Switzerland'), findsOneWidget);
    });

    testWidgets('shows deadline countdown for registration championship',
        (tester) async {
      final champ = makeChampionship(
        id: 'c1',
        title: 'Deadline Champ',
        status: ChampionshipStatus.registration,
        registrationDeadline: DateTime.now().add(const Duration(days: 7)),
      );

      await tester.pumpWidget(testApp(
        child: Scaffold(body: ChampionshipCard(championship: champ)),
      ));
      await tester.pumpAndSettle();

      expect(find.textContaining('days left'), findsOneWidget);
    });
  });

  group('Filter behaviour', () {
    test('ChampionshipListLoaded.championships filters by active', () {
      final all = [
        makeChampionship(id: 'r', title: 'Reg', status: ChampionshipStatus.registration),
        makeChampionship(id: 'a', title: 'Act', status: ChampionshipStatus.active),
        makeChampionship(id: 'c', title: 'Com', status: ChampionshipStatus.completed),
      ];

      final state =
          ChampionshipListLoaded(allChampionships: all, activeFilter: 'active');
      expect(state.championships.length, 1);
      expect(state.championships.first.title, 'Act');
    });

    test('ChampionshipListLoaded.championships returns all when filter is null',
        () {
      final all = [
        makeChampionship(id: 'r', title: 'Reg', status: ChampionshipStatus.registration),
        makeChampionship(id: 'a', title: 'Act', status: ChampionshipStatus.active),
      ];

      final state =
          ChampionshipListLoaded(allChampionships: all, activeFilter: null);
      expect(state.championships.length, 2);
    });

    test('includes registrationClosed in registration filter', () {
      final all = [
        makeChampionship(id: 'r', title: 'Reg', status: ChampionshipStatus.registration),
        makeChampionship(id: 'rc', title: 'RC', status: ChampionshipStatus.registrationClosed),
        makeChampionship(id: 'a', title: 'Act', status: ChampionshipStatus.active),
      ];

      final state = ChampionshipListLoaded(
          allChampionships: all, activeFilter: 'registration');
      expect(state.championships.length, 2);
      expect(state.championships.map((c) => c.id).toSet(),
          containsAll(['r', 'rc']));
    });
  });
}
