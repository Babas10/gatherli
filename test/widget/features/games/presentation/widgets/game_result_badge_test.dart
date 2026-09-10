import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/games/presentation/widgets/game_result_badge.dart';

void main() {
  group('GameResultBadge', () {
    testWidgets('displays winner name and score correctly for Team A', (
      tester,
    ) async {
      // We need to construct a result with valid data so scoreDescription returns a valid description.
      const validResult = GameResult(
        games: [
          IndividualGame(
            gameNumber: 1,
            winner: 'teamA',
            sets: [SetScore(teamAPoints: 21, teamBPoints: 19, setNumber: 1)],
          ),
        ],
        overallWinner: 'teamA',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: GameResultBadge(result: validResult)),
        ),
      );

      expect(find.text('Team A won 1-0'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
    });

    testWidgets('displays winner name and score correctly for Team B', (
      tester,
    ) async {
      const validResult = GameResult(
        games: [
          IndividualGame(
            gameNumber: 1,
            winner: 'teamB',
            sets: [SetScore(teamAPoints: 19, teamBPoints: 21, setNumber: 1)],
          ),
        ],
        overallWinner: 'teamB',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: GameResultBadge(result: validResult)),
        ),
      );

      expect(find.text('Team B won 0-1'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      bool tapped = false;
      const validResult = GameResult(
        games: [
          IndividualGame(
            gameNumber: 1,
            winner: 'teamA',
            sets: [SetScore(teamAPoints: 21, teamBPoints: 19, setNumber: 1)],
          ),
        ],
        overallWinner: 'teamA',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameResultBadge(
              result: validResult,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GameResultBadge));
      expect(tapped, isTrue);
    });

    testWidgets(
      'background is tinted, not solid, so the icon/text stay legible',
      (tester) async {
        const validResult = GameResult(
          games: [
            IndividualGame(
              gameNumber: 1,
              winner: 'teamA',
              sets: [SetScore(teamAPoints: 21, teamBPoints: 19, setNumber: 1)],
            ),
          ],
          overallWinner: 'teamA',
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: GameResultBadge(result: validResult)),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Regression guard: background must not equal the solid icon/text
        // color (AppColors.success), or the content is invisible against
        // its own background.
        expect(decoration.color, isNot(equals(AppColors.success)));
      },
    );

    testWidgets('renders a tie distinctly from a win (muted, not success)', (
      tester,
    ) async {
      const tieResult = GameResult(
        games: [
          IndividualGame(
            gameNumber: 1,
            winner: 'teamA',
            sets: [SetScore(teamAPoints: 21, teamBPoints: 19, setNumber: 1)],
          ),
          IndividualGame(
            gameNumber: 2,
            winner: 'teamB',
            sets: [SetScore(teamAPoints: 19, teamBPoints: 21, setNumber: 1)],
          ),
        ],
        overallWinner: null,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: GameResultBadge(result: tieResult)),
        ),
      );

      expect(find.text('Tie 1-1'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsNothing);
      expect(find.byIcon(Icons.handshake), findsOneWidget);

      final text = tester.widget<Text>(find.text('Tie 1-1'));
      expect(text.style?.color, AppColors.textMuted);
    });
  });
}
