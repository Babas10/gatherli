// Verifies SearchResultTile renders the correct StatusBadge for each
// friendship state (Story 37.7a — migrated off raw Chip widgets).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/friends/presentation/widgets/search_result_tile.dart';

import '../../../../../helpers/test_app.dart';

const _user = UserEntity(
  uid: 'user-1',
  email: 'jane@example.com',
  displayName: 'Jane Doe',
  isEmailVerified: true,
);

void main() {
  group('SearchResultTile', () {
    testWidgets('already-friends state shows a muted "Friends" StatusBadge',
        (tester) async {
      await tester.pumpWidget(testApp(
        child: Scaffold(body: SearchResultTile(
          user: _user,
          isFriend: true,
          hasPendingRequest: false,
          searchedEmail: _user.email,
        )),
      ));

      expect(find.byType(StatusBadge), findsOneWidget);
      final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
      expect(badge.color, AppColors.textMuted);
    });

    testWidgets('pending-sent state shows a warning "Pending" StatusBadge',
        (tester) async {
      await tester.pumpWidget(testApp(
        child: Scaffold(body: SearchResultTile(
          user: _user,
          isFriend: false,
          hasPendingRequest: true,
          requestDirection: 'sent',
          searchedEmail: _user.email,
        )),
      ));

      expect(find.byType(StatusBadge), findsOneWidget);
      final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
      expect(badge.color, AppColors.warning);
    });

    testWidgets('no connection state shows a FilledButton, not a badge',
        (tester) async {
      await tester.pumpWidget(testApp(
        child: Scaffold(body: SearchResultTile(
          user: _user,
          isFriend: false,
          hasPendingRequest: false,
          searchedEmail: _user.email,
        )),
      ));

      expect(find.byType(StatusBadge), findsNothing);
    });
  });
}
