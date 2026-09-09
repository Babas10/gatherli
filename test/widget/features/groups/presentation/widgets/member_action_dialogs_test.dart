// Validates destructive confirmation dialogs use OutlinedButton + danger
// styling, per CLAUDE.md's button rules (regression guard for a violation
// found during the Epic 37 design-system audit, where these rendered as
// solid filled red buttons instead).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/groups/presentation/widgets/member_action_dialogs.dart';

import '../../../../../helpers/fixtures.dart';
import '../../../../../helpers/test_app.dart';

void main() {
  group('member action dialogs — destructive button styling', () {
    testWidgets('remove-member dialog confirm button is OutlinedButton with danger color', (
      tester,
    ) async {
      await tester.pumpWidget(testApp(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () =>
                showRemoveMemberConfirmationDialog(context, makeUserModel()),
            child: const Text('open'),
          ),
        ),
      ));

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final style = button.style!;
      expect(
        style.foregroundColor?.resolve({}),
        AppColors.danger,
      );
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('leave-group dialog confirm button is OutlinedButton with danger color', (
      tester,
    ) async {
      await tester.pumpWidget(testApp(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () =>
                showLeaveGroupConfirmationDialog(context, 'Test Group'),
            child: const Text('open'),
          ),
        ),
      ));

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final style = button.style!;
      expect(
        style.foregroundColor?.resolve({}),
        AppColors.danger,
      );
      expect(find.byType(FilledButton), findsNothing);
    });
  });
}
