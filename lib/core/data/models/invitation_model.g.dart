// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvitationModelImpl _$$InvitationModelImplFromJson(
  Map<String, dynamic> json,
) => _$InvitationModelImpl(
  id: json['id'] as String,
  type:
      $enumDecodeNullable(_$InvitationTypeEnumMap, json['type']) ??
      InvitationType.group,
  invitedBy: json['invitedBy'] as String,
  inviterName: json['inviterName'] as String,
  invitedUserId: json['invitedUserId'] as String,
  status:
      $enumDecodeNullable(_$InvitationStatusEnumMap, json['status']) ??
      InvitationStatus.pending,
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  respondedAt: const NullableTimestampConverter().fromJson(json['respondedAt']),
  expiresAt: const NullableTimestampConverter().fromJson(json['expiresAt']),
  groupId: json['groupId'] as String?,
  groupName: json['groupName'] as String?,
  gameId: json['gameId'] as String?,
  gameTitle: json['gameTitle'] as String?,
  gameScheduledAt: const NullableTimestampConverter().fromJson(
    json['gameScheduledAt'],
  ),
  gameLocationName: json['gameLocationName'] as String?,
);

Map<String, dynamic> _$$InvitationModelImplToJson(
  _$InvitationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$InvitationTypeEnumMap[instance.type]!,
  'invitedBy': instance.invitedBy,
  'inviterName': instance.inviterName,
  'invitedUserId': instance.invitedUserId,
  'status': _$InvitationStatusEnumMap[instance.status]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'respondedAt': const NullableTimestampConverter().toJson(
    instance.respondedAt,
  ),
  'expiresAt': const NullableTimestampConverter().toJson(instance.expiresAt),
  'groupId': instance.groupId,
  'groupName': instance.groupName,
  'gameId': instance.gameId,
  'gameTitle': instance.gameTitle,
  'gameScheduledAt': const NullableTimestampConverter().toJson(
    instance.gameScheduledAt,
  ),
  'gameLocationName': instance.gameLocationName,
};

const _$InvitationTypeEnumMap = {
  InvitationType.group: 'group',
  InvitationType.game: 'game',
  InvitationType.championship: 'championship',
};

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.declined: 'declined',
  InvitationStatus.expired: 'expired',
};
