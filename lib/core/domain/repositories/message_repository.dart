import '../../data/models/chat_message_model.dart';

abstract class MessageRepository {
  /// Stream messages from [contextPath]/messages (ordered by sentAt ascending).
  /// [contextPath] is a Firestore document path, e.g. 'games/gameId'.
  Stream<List<ChatMessageModel>> getMessages({required String contextPath});

  /// Send a message to [contextPath]/messages.
  Future<void> sendMessage({
    required String contextPath,
    required String senderId,
    required String senderDisplayName,
    required String text,
    String? teamId,
  });
}
