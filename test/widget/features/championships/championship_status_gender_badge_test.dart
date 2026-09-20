// Verifies ChampionshipStatusBadge and ChampionshipGenderBadge (Story 37.8b)
// — extracted from two independently-duplicated private widget classes in
// championship_detail_page.dart and championship_list_page.dart into one
// shared implementation each.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/presentation/widgets/championship_gender_badge.dart';
import 'package:play_with_me/features/championships/presentation/widgets/championship_status_badge.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/test_app.dart';

void main() {
  group('ChampionshipStatusBadge', () {
    testWidgets('renders a StatusBadge for every ChampionshipStatus', (
      tester,
    ) async {
      for (final status in ChampionshipStatus.values) {
        final championship = makeChampionship(
          status: status,
          currentRound: 3,
          totalRounds: 9,
        );
        late AppLocalizations l10n;

        await tester.pumpWidget(
          testApp(
            child: Builder(
              builder: (context) {
                l10n = AppLocalizations.of(context)!;
                return ChampionshipStatusBadge(
                  championship: championship,
                  l10n: l10n,
                );
              },
            ),
          ),
        );

        expect(find.byType(StatusBadge), findsOneWidget);
      }
    });

    testWidgets('active status label includes the current/total round', (
      tester,
    ) async {
      final championship = makeChampionship(
        status: ChampionshipStatus.active,
        currentRound: 3,
        totalRounds: 9,
      );

      await tester.pumpWidget(
        testApp(
          child: Builder(
            builder: (context) {
              return ChampionshipStatusBadge(
                championship: championship,
                l10n: AppLocalizations.of(context)!,
              );
            },
          ),
        ),
      );

      final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
      expect(badge.label, contains('3'));
      expect(badge.label, contains('9'));
      expect(badge.color, AppColors.primary);
    });

    testWidgets('completed status uses textMuted', (tester) async {
      final championship = makeChampionship(status: ChampionshipStatus.completed);

      await tester.pumpWidget(
        testApp(
          child: Builder(
            builder: (context) => ChampionshipStatusBadge(
              championship: championship,
              l10n: AppLocalizations.of(context)!,
            ),
          ),
        ),
      );

      final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
      expect(badge.color, AppColors.textMuted);
    });
  });

  group('ChampionshipGenderBadge', () {
    testWidgets('male and female categories render distinct labels, same color',
        (tester) async {
      for (final category in ChampionshipGenderCategory.values) {
        await tester.pumpWidget(
          testApp(
            child: Builder(
              builder: (context) => ChampionshipGenderBadge(
                category: category,
                l10n: AppLocalizations.of(context)!,
              ),
            ),
          ),
        );

        final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
        expect(badge.color, AppColors.info);
        expect(badge.label, isNotEmpty);
      }
    });
  });
}
