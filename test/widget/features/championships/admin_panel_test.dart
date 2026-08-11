// Validates the admin panel tab renders correctly based on AdminPanelBloc state.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_app.dart';
import '../../../helpers/fixtures.dart';

// ── Helpers ───────────────────────────────────────────────────────────────────

AdminPanelLoaded _makeLoadedState({
  List<ChampionshipMatchModel>? matches,
  bool isDeciding = false,
  String? decisionError,
  String? lastDecidedMatchId,
}) {
  return AdminPanelLoaded(
    matches: matches ?? [makeMatch(teamAId: 'teamA', teamBId: 'teamB', status: ChampionshipMatchStatus.disputed)],
    isDeciding: isDeciding,
    decisionError: decisionError,
    lastDecidedMatchId: lastDecidedMatchId,
  );
}

Widget _buildTestWidget(MockAdminPanelBloc bloc) {
  return testApp(
    child: BlocProvider<AdminPanelBloc>.value(
      value: bloc,
      child: Scaffold(
        body: BlocBuilder<AdminPanelBloc, AdminPanelState>(
          builder: (context, state) {
            if (state is AdminPanelLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AdminPanelError) {
              return Center(child: Text('ERROR: ${state.message}'));
            }
            if (state is AdminPanelLoaded) {
              final l10n = AppLocalizations.of(context)!;
              if (state.matches.isEmpty) {
                return Center(
                    child: Text(l10n.adminPanelNoMatchesNeedingAttention));
              }
              return ListView(
                children: [
                  for (final m in state.matches)
                    Text('MATCH:${m.id}:${m.status.name}'),
                  if (state.isDeciding) const Text('IS_DECIDING'),
                  if (state.decisionError != null)
                    Text('DECISION_ERROR:${state.decisionError}'),
                  if (state.lastDecidedMatchId != null)
                    Text('DECIDED:${state.lastDecidedMatchId}'),
                ],
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
  late MockAdminPanelBloc bloc;

  setUpAll(registerFallbackValues);

  setUp(() {
    bloc = MockAdminPanelBloc();
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() => bloc.close());

  group('Loading state', () {
    testWidgets('shows CircularProgressIndicator when Loading', (tester) async {
      when(() => bloc.state).thenReturn(const AdminPanelLoading());
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Error state', () {
    testWidgets('shows error message when Error', (tester) async {
      when(() => bloc.state)
          .thenReturn(const AdminPanelError(message: 'Network error'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      expect(find.text('ERROR: Network error'), findsOneWidget);
    });
  });

  group('Loaded state', () {
    testWidgets('shows empty state when no matches need attention',
        (tester) async {
      when(() => bloc.state).thenReturn(_makeLoadedState(matches: []));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('No matches requiring admin attention'), findsOneWidget);
    });

    testWidgets('shows match entries when matches need attention',
        (tester) async {
      when(() => bloc.state).thenReturn(_makeLoadedState(matches: [
        makeMatch(id: 'm1', teamAId: 'teamA', teamBId: 'teamB', status: ChampionshipMatchStatus.disputed),
        makeMatch(id: 'm2', teamAId: 'teamA', teamBId: 'teamB', status: ChampionshipMatchStatus.played),
      ]));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('MATCH:m1:disputed'), findsOneWidget);
      expect(find.text('MATCH:m2:played'), findsOneWidget);
    });

    testWidgets('shows IS_DECIDING when isDeciding is true', (tester) async {
      when(() => bloc.state)
          .thenReturn(_makeLoadedState(isDeciding: true));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('IS_DECIDING'), findsOneWidget);
    });

    testWidgets('shows decision error when present', (tester) async {
      when(() => bloc.state).thenReturn(
          _makeLoadedState(decisionError: 'Permission denied'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('DECISION_ERROR:Permission denied'), findsOneWidget);
    });

    testWidgets('shows decided match id on success', (tester) async {
      when(() => bloc.state).thenReturn(
          _makeLoadedState(lastDecidedMatchId: 'm1'));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('DECIDED:m1'), findsOneWidget);
    });
  });
}
