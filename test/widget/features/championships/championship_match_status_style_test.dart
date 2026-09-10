// Verifies the single source of truth for ChampionshipMatchStatus color/label
// mapping (Story 37.4a) — regression guard against the mapping re-diverging
// across the multiple call sites it replaced.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/presentation/widgets/championship_match_status_style.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../helpers/test_app.dart';

void main() {
  group('ChampionshipMatchStatusStyle', () {
    test('every status maps to a distinct, non-raw AppColors color', () {
      final colors = ChampionshipMatchStatus.values
          .map((status) => status.color)
          .toSet();
      expect(colors.length, ChampionshipMatchStatus.values.length,
          reason: 'Each match status should render with its own color so '
              'statuses remain visually distinguishable.');
      expect(colors, everyElement(isNot(equals(Colors.purple))));
      expect(colors, everyElement(isNot(equals(Colors.deepOrange))));
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

      for (final status in ChampionshipMatchStatus.values) {
        expect(status.label(l10n), isNotEmpty);
      }
    });

    test('disputed and adminDecided use AppColors constants, not raw Colors',
        () {
      expect(ChampionshipMatchStatus.disputed.color, AppColors.danger);
      expect(ChampionshipMatchStatus.adminDecided.color,
          AppColors.adminAction);
      expect(ChampionshipMatchStatus.verified.color, AppColors.success);
      expect(ChampionshipMatchStatus.pending.color, AppColors.textMuted);
    });
  });
}
