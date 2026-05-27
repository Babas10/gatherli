// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'championship_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChampionshipMessageModel _$ChampionshipMessageModelFromJson(
  Map<String, dynamic> json,
) => _ChampionshipMessageModel(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  senderDisplayName: json['senderDisplayName'] as String,
  teamId: json['teamId'] as String?,
  text: json['text'] as String,
  sentAt: const TimestampConverter().fromJson(json['sentAt'] as Object),
);

Map<String, dynamic> _$ChampionshipMessageModelToJson(
  _ChampionshipMessageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'senderDisplayName': instance.senderDisplayName,
  'teamId': instance.teamId,
  'text': instance.text,
  'sentAt': const TimestampConverter().toJson(instance.sentAt),
};
