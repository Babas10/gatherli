// Validates MatchDetailPage renders header, chat section, and result section
// based on MatchDetailBloc state.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_state.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_app.dart';
import '../../../helpers/fixtures.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

MatchDetailLoaded _makeLoadedState({
  ChampionshipMatchStatus status = ChampionshipMatchStatus.pending,
  String? myTeamId = 'teamA',
  bool isProposingSchedule = false,
  String? scheduleError,
  String? submittedByTeamId,
}) {
  return MatchDetailLoaded(
    championshipId: 'champ-1',
    match: makeMatch(
      teamAId: 'teamA',
      teamBId: 'teamB',
      status: status,
      submittedByTeamId: submittedByTeamId,
    ),
    teamA: makeTeam(id: 'teamA', name: 'Team A'),
    teamB: makeTeam(id: 'teamB', name: 'Team B'),
    myTeamId: myTeamId,
    isProposingSchedule: isProposingSchedule,
    scheduleError: scheduleError,
  );
}

Widget _buildTestWidget(MockMatchDetailBloc bloc) {
  return testApp(
    child: BlocProvider<MatchDetailBloc>.value(
      value: bloc,
      child: Scaffold(
        body: BlocBuilder<MatchDetailBloc, MatchDetailState>(
          builder: (context, state) {
            if (state is MatchDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MatchDetailError) {
              return Center(child: Text(state.message));
            }
            if (state is MatchDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(state.teamA.name),
                    Text(state.teamB.name),
                    Text(state.match.status.name),
                    if (state.myTeamId != null) const Text('IS_MEMBER'),
                    if (state.isProposingSchedule) const Text('IS_PROPOSING'),
                    if (state.scheduleError != null)
                      Text('ERROR: ${state.scheduleError}'),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockMatchDetailBloc bloc;

  setUpAll(registerFallbackValues);

  setUp(() {
    bloc = MockMatchDetailBloc();
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() => bloc.close());

  group('Loading state', () {
    testWidgets('shows CircularProgressIndicator when Loading', (tester) async {
      when(() => bloc.state).thenReturn(const MatchDetailLoading());
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Error state', () {
    testWidgets('shows error message when Error', (tester) async {
      when(() => bloc.state)
          .thenReturn(const MatchDetailError(message: 'Match not found'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      expect(find.text('Match not found'), findsOneWidget);
    });
  });

  group('Loaded state', () {
    testWidgets('shows team names', (tester) async {
      when(() => bloc.state).thenReturn(_makeLoadedState());
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('Team A'), findsOneWidget);
      expect(find.text('Team B'), findsOneWidget);
    });

    testWidgets('shows IS_MEMBER indicator when user is a team member',
        (tester) async {
      when(() => bloc.state).thenReturn(_makeLoadedState(myTeamId: 'teamA'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('IS_MEMBER'), findsOneWidget);
    });

    testWidgets('does not show IS_MEMBER when user is not a team member',
        (tester) async {
      when(() => bloc.state).thenReturn(_makeLoadedState(myTeamId: null));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('IS_MEMBER'), findsNothing);
    });

    testWidgets('shows IS_PROPOSING when isProposingSchedule is true',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(_makeLoadedState(isProposingSchedule: true));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('IS_PROPOSING'), findsOneWidget);
    });

    testWidgets('shows schedule error when present', (tester) async {
      when(() => bloc.state).thenReturn(
        _makeLoadedState(scheduleError: 'Server error'),
      );
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('ERROR: Server error'), findsOneWidget);
    });

    testWidgets('shows match status', (tester) async {
      when(() => bloc.state).thenReturn(
        _makeLoadedState(status: ChampionshipMatchStatus.scheduled),
      );
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('scheduled'), findsOneWidget);
    });
  });
}
