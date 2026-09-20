// Verifies the single source of truth for TrainingStatus color/label mapping
// (Story 37.8a) — regression guard against training_session_details_page.dart
// and training_session_list_item.dart re-diverging on the "cancelled" color,
// as they previously did (red on the detail page, grey on the list item).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/data/models/training_session_model.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/games/presentation/widgets/training_status_style.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../../../helpers/test_app.dart';

void main() {
  group('TrainingStatusStyle', () {
    test('every status maps to a distinct AppColors value', () {
      final colors = TrainingStatus.values
          .map((status) => status.color)
          .toSet();
      expect(colors.length, TrainingStatus.values.length);
    });

    test('known canonical colors', () {
      expect(TrainingStatus.scheduled.color, AppColors.info);
      expect(TrainingStatus.completed.color, AppColors.textMuted);
      expect(TrainingStatus.cancelled.color, AppColors.danger);
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

      for (final status in TrainingStatus.values) {
        expect(status.label(l10n), isNotEmpty);
      }
    });
  });
}
