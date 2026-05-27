import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';

part 'championship_message_model.freezed.dart';
part 'championship_message_model.g.dart';

/// Chat message for the per-match coordination chat (Story 30.5).
/// Fields mirror [ChatMessageModel] so the same UI components can be reused.
@freezed
abstract class ChampionshipMessageModel with _$ChampionshipMessageModel {
  const factory ChampionshipMessageModel({
    required String id,
    required String senderId,
    required String senderDisplayName,
    /// Null for system messages (e.g. schedule proposals).
    String? teamId,
    required String text,
    @TimestampConverter() required DateTime sentAt,
  }) = _ChampionshipMessageModel;

  const ChampionshipMessageModel._();

  factory ChampionshipMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipMessageModelFromJson(json);

  factory ChampionshipMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChampionshipMessageModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  bool get isSystemMessage => teamId == null;
}
