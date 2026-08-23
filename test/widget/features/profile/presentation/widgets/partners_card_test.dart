// Widget tests for PartnersCard displaying teammate display names.
// Story 34.3: PartnersCard now takes List<TeammateStats> instead of UserModel.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/data/models/teammate_stats.dart';
import 'package:play_with_me/features/profile/presentation/widgets/partners_card.dart';
import '../../../../../helpers/test_app.dart';

TeammateStats makeStats({
  required String userId,
  required String teammateName,
  required int gamesPlayed,
  required int gamesWon,
  required int gamesLost,
}) =>
    TeammateStats(
      userId: userId,
      teammateName: teammateName,
      gamesPlayed: gamesPlayed,
      gamesWon: gamesWon,
      gamesLost: gamesLost,
    );

void main() {
  group('PartnersCard Widget Tests', () {
    testWidgets('displays teammate display name instead of user ID', (
      tester,
    ) async {
      final stats = [
        makeStats(
          userId: 'teammate-456',
          teammateName: 'John Doe',
          gamesPlayed: 10,
          gamesWon: 8,
          gamesLost: 2,
        ),
      ];

      await tester.pumpWidget(
        testApp(child: Scaffold(body: PartnersCard(teammateStats: stats))),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.textContaining('teammate-456'), findsNothing);
      expect(find.text('80.0% Win Rate'), findsOneWidget);
      expect(find.text('8W - 2L \u2022 10 games'), findsOneWidget);
    });

    testWidgets('shows user ID prefix when teammateName is missing', (
      tester,
    ) async {
      final stats = [
        const TeammateStats(
          userId: 'teammate-789',
          gamesPlayed: 7,
          gamesWon: 5,
          gamesLost: 2,
        ),
      ];

      await tester.pumpWidget(
        testApp(child: Scaffold(body: PartnersCard(teammateStats: stats))),
      );

      // Without teammateName, falls back to userId prefix
      expect(find.textContaining('teamm'), findsOneWidget);
      expect(find.text('71.4% Win Rate'), findsOneWidget);
    });

    testWidgets('shows empty state when no teammates have 5+ games', (
      tester,
    ) async {
      final stats = [
        makeStats(
          userId: 'teammate-111',
          teammateName: 'Alice Smith',
          gamesPlayed: 3,
          gamesWon: 2,
          gamesLost: 1,
        ),
      ];

      await tester.pumpWidget(
        testApp(child: Scaffold(body: PartnersCard(teammateStats: stats))),
      );

      expect(find.text('No partner data yet'), findsOneWidget);
      expect(find.text('Alice Smith'), findsNothing);
    });

    testWidgets('selects teammate with highest win rate', (tester) async {
      final stats = [
        makeStats(
          userId: 'teammate-low',
          teammateName: 'Bob Jones',
          gamesPlayed: 10,
          gamesWon: 6,
          gamesLost: 4,
        ),
        makeStats(
          userId: 'teammate-high',
          teammateName: 'Sarah Lee',
          gamesPlayed: 8,
          gamesWon: 7,
          gamesLost: 1,
        ),
      ];

      await tester.pumpWidget(
        testApp(child: Scaffold(body: PartnersCard(teammateStats: stats))),
      );

      expect(find.text('Sarah Lee'), findsOneWidget);
      expect(find.text('87.5% Win Rate'), findsOneWidget);
      expect(find.text('Bob Jones'), findsNothing);
    });

    testWidgets('handles long teammate names with ellipsis', (tester) async {
      final stats = [
        makeStats(
          userId: 'teammate-long',
          teammateName: 'Alexander Maximilian Constantine Rodriguez',
          gamesPlayed: 10,
          gamesWon: 7,
          gamesLost: 3,
        ),
      ];

      await tester.pumpWidget(
        testApp(
          child: Scaffold(
            body: SizedBox(
              width: 400,
              child: PartnersCard(teammateStats: stats),
            ),
          ),
        ),
      );

      expect(find.textContaining('Alexander'), findsOneWidget);
      final textWidget =
          tester.widget<Text>(find.textContaining('Alexander'));
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
