import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    required String senderId,
    required String senderDisplayName,
    required String text,
    @TimestampConverter() required DateTime sentAt,
    String? teamId,
  }) = _ChatMessageModel;

  const ChatMessageModel._();

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  /// Factory constructor for creating from Firestore DocumentSnapshot
  factory ChatMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessageModel.fromJson({...data, 'id': doc.id});
  }

  /// Convert to Firestore-compatible map (excludes id since it's the document ID)
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id'); // Remove id as it's the document ID
    return json;
  }
}

