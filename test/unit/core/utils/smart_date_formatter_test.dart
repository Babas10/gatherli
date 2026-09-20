// Verifies formatSmartDateTime — the shared "Today/Tomorrow/<date>" + time
// formatter extracted from 5 duplicated private implementations (Story
// 37.8b) that disagreed on the day/time separator.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/utils/smart_date_formatter.dart';

import '../../../helpers/test_app.dart';

void main() {
  group('formatSmartDateTime', () {
    testWidgets('formats today as "Today • <time>"', (tester) async {
      final now = DateTime.now();
      final today3pm = DateTime(now.year, now.month, now.day, 15);

      late String result;
      await tester.pumpWidget(testApp(
        child: Builder(
          builder: (context) {
            result = formatSmartDateTime(context, today3pm);
            return const SizedBox.shrink();
          },
        ),
      ));
      await tester.pumpAndSettle();

      expect(result, 'Today • 3:00 PM');
    });

    testWidgets('formats tomorrow as "Tomorrow • <time>"', (tester) async {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final tomorrow3pm =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 15);

      late String result;
      await tester.pumpWidget(testApp(
        child: Builder(
          builder: (context) {
            result = formatSmartDateTime(context, tomorrow3pm);
            return const SizedBox.shrink();
          },
        ),
      ));
      await tester.pumpAndSettle();

      expect(result, 'Tomorrow • 3:00 PM');
    });

    testWidgets('formats a distant date as "<EEE, MMM d> • <time>"',
        (tester) async {
      final distant = DateTime(2026, 3, 15, 9, 30);

      late String result;
      await tester.pumpWidget(testApp(
        child: Builder(
          builder: (context) {
            result = formatSmartDateTime(context, distant);
            return const SizedBox.shrink();
          },
        ),
      ));
      await tester.pumpAndSettle();

      expect(result, 'Sun, Mar 15 • 9:30 AM');
    });
  });
}
