// Verifies the single source of truth for GameStatus color/label mapping
// (Story 37.4b) — regression guard against my_game_tile's dot indicator and
// pill badge re-diverging, as they previously did.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/games/presentation/widgets/game_status_style.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../../../helpers/test_app.dart';

void main() {
  group('GameStatusStyle', () {
    test('every status maps to a distinct AppColors value', () {
      final colors = GameStatus.values.map((status) => status.color).toSet();
      expect(colors.length, GameStatus.values.length);
      expect(colors, everyElement(isNot(equals(Colors.grey))));
    });

    test('known canonical colors', () {
      expect(GameStatus.scheduled.color, AppColors.info);
      expect(GameStatus.inProgress.color, AppColors.success);
      expect(GameStatus.verification.color, AppColors.warning);
      expect(GameStatus.completed.color, AppColors.textMuted);
      expect(GameStatus.cancelled.color, AppColors.danger);
    });

    testWidgets('label() resolves a non-empty localized string for every status',
        (tester) async {
      late AppLocalizations l10n;
      await tester.pumpWidget(testApp(
        child: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            return const SizedBox.shrink();
          },
        ),
      ));
      await tester.pumpAndSettle();

      for (final status in GameStatus.values) {
        expect(status.label(l10n), isNotEmpty);
      }
    });
  });
}
