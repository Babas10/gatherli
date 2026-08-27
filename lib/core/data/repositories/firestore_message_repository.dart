import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';

class FirestoreMessageRepository implements MessageRepository {
  final FirebaseFirestore _firestore;

  // Caps chat history to the most recent N messages per context. Without a
  // limit, this streams the entire chat history (unbounded growth) on every
  // load. Messages are fetched newest-first then reversed so callers keep
  // seeing ascending (oldest → newest) order.
  static const int _messagesLimit = 100;

  FirestoreMessageRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<ChatMessageModel>> getMessages({required String contextPath}) {
    try {
      return _firestore
          .doc(contextPath)
          .collection('messages')
          .orderBy('sentAt', descending: true)
          .limit(_messagesLimit)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => ChatMessageModel.fromFirestore(doc))
                .toList()
                .reversed
                .toList(),
          )
          .handleError((error) {
            if (error is FirebaseException) {
              throw MessageException(
                'Failed to stream messages: ${error.message}',
                code: error.code,
              );
            }
            throw MessageException(
              'Failed to stream messages: $error',
              code: 'stream-error',
            );
          });
    } catch (e) {
      throw MessageException(
        'Failed to stream messages: $e',
        code: 'stream-error',
      );
    }
  }

  @override
  Future<void> sendMessage({
    required String contextPath,
    required String senderId,
    required String senderDisplayName,
    required String text,
    String? teamId,
  }) async {
    try {
      final message = ChatMessageModel(
        id: '',
        senderId: senderId,
        senderDisplayName: senderDisplayName,
        text: text,
        sentAt: DateTime.now(),
        teamId: teamId,
      );
      await _firestore
          .doc(contextPath)
          .collection('messages')
          .add(message.toFirestore());
    } on FirebaseException catch (e) {
      throw MessageException(
        'Failed to send message: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw MessageException('Failed to send message: $e');
    }
  }
}
