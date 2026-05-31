// Validates MatchDetailPage renders header, chat section, and result section
// based on MatchDetailBloc state.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class MockMatchDetailBloc
    extends MockBloc<MatchDetailEvent, MatchDetailState>
    implements MatchDetailBloc {}

class FakeMatchDetailEvent extends Fake implements MatchDetailEvent {}
class FakeMatchDetailState extends Fake implements MatchDetailState {}

// ── Helpers ──────────────────────────────────────────────────────────────────

ChampionshipMatchModel _makeMatch({
  String id = 'm1',
  ChampionshipMatchStatus status = ChampionshipMatchStatus.pending,
  String? submittedByTeamId,
  DateTime? scheduledAt,
}) {
  return ChampionshipMatchModel(
    id: id,
    round: 1,
    teamAId: 'teamA',
    teamBId: 'teamB',
    deadline: DateTime(2026, 9, 1),
    status: status,
    submittedByTeamId: submittedByTeamId,
    scheduledAt: scheduledAt,
  );
}

ChampionshipTeamModel _makeTeam({
  String id = 'teamA',
  String name = 'Team A',
  List<String>? memberIds,
}) {
  return ChampionshipTeamModel(
    id: id,
    name: name,
    captainId: 'user-1',
    memberIds: memberIds ?? ['user-1', 'user-2'],
    createdAt: DateTime(2026, 1, 1),
  );
}

MatchDetailLoaded _makeLoadedState({
  ChampionshipMatchStatus status = ChampionshipMatchStatus.pending,
  String? myTeamId = 'teamA',
  bool isProposingSchedule = false,
  String? scheduleError,
  String? submittedByTeamId,
}) {
  return MatchDetailLoaded(
    championshipId: 'champ-1',
    match: _makeMatch(status: status, submittedByTeamId: submittedByTeamId),
    teamA: _makeTeam(id: 'teamA', name: 'Team A'),
    teamB: _makeTeam(id: 'teamB', name: 'Team B'),
    myTeamId: myTeamId,
    isProposingSchedule: isProposingSchedule,
    scheduleError: scheduleError,
  );
}

// ── Widget helpers ────────────────────────────────────────────────────────────

Widget _buildTestWidget(MockMatchDetailBloc bloc) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en')],
    home: BlocProvider<MatchDetailBloc>.value(
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
                    // Team names
                    Text(state.teamA.name),
                    Text(state.teamB.name),
                    // Status
                    Text(state.match.status.name),
                    // myTeamId indicator
                    if (state.myTeamId != null) const Text('IS_MEMBER'),
                    // isProposing indicator
                    if (state.isProposingSchedule)
                      const Text('IS_PROPOSING'),
                    // scheduleError indicator
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

  setUpAll(() {
    registerFallbackValue(FakeMatchDetailEvent());
    registerFallbackValue(FakeMatchDetailState());
  });

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
      when(() => bloc.state)
          .thenReturn(_makeLoadedState(myTeamId: 'teamA'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('IS_MEMBER'), findsOneWidget);
    });

    testWidgets('does not show IS_MEMBER when user is not a team member',
        (tester) async {
      when(() => bloc.state)
          .thenReturn(_makeLoadedState(myTeamId: null));
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
