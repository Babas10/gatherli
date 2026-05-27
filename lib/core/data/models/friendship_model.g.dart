// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendshipModel _$FriendshipModelFromJson(
  Map<String, dynamic> json,
) => _FriendshipModel(
  id: json['id'] as String,
  initiatorId: json['initiatorId'] as String,
  recipientId: json['recipientId'] as String,
  status: $enumDecode(_$FriendshipStatusEnumMap, json['status']),
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt'] as Object),
  initiatorName: json['initiatorName'] as String,
  recipientName: json['recipientName'] as String,
);

Map<String, dynamic> _$FriendshipModelToJson(_FriendshipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'initiatorId': instance.initiatorId,
      'recipientId': instance.recipientId,
      'status': _$FriendshipStatusEnumMap[instance.status]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'initiatorName': instance.initiatorName,
      'recipientName': instance.recipientName,
    };

const _$FriendshipStatusEnumMap = {
  FriendshipStatus.pending: 'pending',
  FriendshipStatus.accepted: 'accepted',
  FriendshipStatus.declined: 'declined',
};
