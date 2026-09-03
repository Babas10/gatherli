// Widget test for SentRequestTile verifying the "Sent Xd ago" date text renders actual values.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/domain/entities/friendship_entity.dart';
import 'package:play_with_me/features/friends/presentation/widgets/sent_request_tile.dart';

import '../../../../../helpers/test_app.dart';

void main() {
  testWidgets(
    'renders the actual elapsed-time value, not a literal template string',
    (tester) async {
      final request = FriendshipEntity(
        id: 'friendship-1',
        initiatorId: 'me',
        recipientId: 'them',
        initiatorName: 'Me',
        recipientName: 'Felix Rodrigues Bauer',
        status: FriendshipStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        testApp(
          child: Scaffold(
            body: SentRequestTile(request: request, onCancel: () {}),
          ),
        ),
      );

      expect(find.text('Sent 3d ago'), findsOneWidget);
      expect(find.textContaining(r'$'), findsNothing);
    },
  );
}
