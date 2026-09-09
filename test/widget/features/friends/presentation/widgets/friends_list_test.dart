// Validates FriendsList's remove-confirmation dialog uses OutlinedButton +
// danger styling (regression guard for a violation found during the Epic 37
// design-system audit, where it rendered as a solid filled red button).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/friends/presentation/widgets/friends_list.dart';

import '../../../../../helpers/fixtures.dart';
import '../../../../../helpers/test_app.dart';

void main() {
  testWidgets(
    'remove-friend confirmation button is OutlinedButton with danger color',
    (tester) async {
      await tester.pumpWidget(testApp(
        child: FriendsList(
          friends: [makeUserEntity(uid: 'f1', displayName: 'Friend One')],
          onRemoveFriend: (_) {},
        ),
      ));

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final style = button.style!;
      expect(style.foregroundColor?.resolve({}), AppColors.danger);
      expect(find.byType(FilledButton), findsNothing);
    },
  );
}
