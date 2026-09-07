// Validates MemberListItemWithFriendship's trailing friend-request badge.
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/features/groups/presentation/widgets/member_list_item_with_friendship.dart';

import '../../../../../helpers/fixtures.dart';
import '../../../../../helpers/test_app.dart';

void main() {
  group('MemberListItemWithFriendship', () {
    testWidgets(
      'sentByMe status renders a StatusBadge with legible (non-solid) background',
      (tester) async {
        await tester.pumpWidget(testApp(
          child: MemberListItemWithFriendship(
            user: makeUserModel(uid: 'u2', displayName: 'Other User'),
            isAdmin: false,
            isCreator: false,
            isCurrentUser: false,
            currentUserId: 'u1',
            isFriend: false,
            requestStatus: FriendRequestStatus.sentByMe,
          ),
        ));
        await tester.pumpAndSettle();

        // Regression guard for a bug where this rendered as a raw Chip with
        // background == label color, making "Pending" invisible.
        expect(find.byType(StatusBadge), findsOneWidget);
        expect(find.text('Pending'), findsOneWidget);
      },
    );
  });
}
