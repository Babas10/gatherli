// Tests FirestoreMessageRepository — message list capping and ordering.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/data/repositories/firestore_message_repository.dart';

void main() {
  group('FirestoreMessageRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late FirestoreMessageRepository repository;

    const contextPath = 'games/game-123';

    Future<void> addTestMessage({
      required String text,
      required DateTime sentAt,
    }) async {
      await fakeFirestore.doc(contextPath).collection('messages').add({
        'senderId': 'user-1',
        'senderDisplayName': 'User One',
        'text': text,
        'sentAt': Timestamp.fromDate(sentAt),
      });
    }

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      repository = FirestoreMessageRepository(firestore: fakeFirestore);
    });

    group('sendMessage', () {
      test('adds a message document under the context path', () async {
        await repository.sendMessage(
          contextPath: contextPath,
          senderId: 'user-1',
          senderDisplayName: 'User One',
          text: 'Hello',
        );

        final snapshot = await fakeFirestore
            .doc(contextPath)
            .collection('messages')
            .get();

        expect(snapshot.docs, hasLength(1));
        expect(snapshot.docs.first.data()['text'], 'Hello');
      });
    });

    group('getMessages', () {
      test('returns messages in ascending (oldest → newest) order', () async {
        final now = DateTime.now();
        await addTestMessage(text: 'first', sentAt: now.subtract(const Duration(minutes: 2)));
        await addTestMessage(text: 'second', sentAt: now.subtract(const Duration(minutes: 1)));
        await addTestMessage(text: 'third', sentAt: now);

        final messages = await repository
            .getMessages(contextPath: contextPath)
            .first;

        expect(messages.map((m) => m.text).toList(), ['first', 'second', 'third']);
      });

      test('caps to the most recent 100 messages, still ascending', () async {
        final now = DateTime.now();
        const totalMessages = 105;
        for (var i = 0; i < totalMessages; i++) {
          await addTestMessage(
            text: 'message-$i',
            sentAt: now.subtract(Duration(minutes: totalMessages - i)),
          );
        }

        final messages = await repository
            .getMessages(contextPath: contextPath)
            .first;

        // Capped to 100 instead of all 105.
        expect(messages, hasLength(100));

        // The oldest 5 messages (message-0..message-4) are dropped; the
        // most recent 100 remain, still in ascending order.
        expect(messages.first.text, 'message-5');
        expect(messages.last.text, 'message-104');
      });
    });
  });
}
