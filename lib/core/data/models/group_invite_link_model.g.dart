// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invite_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupInviteLinkModel _$GroupInviteLinkModelFromJson(
  Map<String, dynamic> json,
) => _GroupInviteLinkModel(
  id: json['id'] as String,
  token: json['token'] as String,
  createdBy: json['createdBy'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  expiresAt: const NullableTimestampConverter().fromJson(json['expiresAt']),
  revoked: json['revoked'] as bool? ?? false,
  usageLimit: (json['usageLimit'] as num?)?.toInt(),
  usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
  groupId: json['groupId'] as String,
  inviteType: json['inviteType'] as String? ?? 'group_link',
);

Map<String, dynamic> _$GroupInviteLinkModelToJson(
  _GroupInviteLinkModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'token': instance.token,
  'createdBy': instance.createdBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'expiresAt': const NullableTimestampConverter().toJson(instance.expiresAt),
  'revoked': instance.revoked,
  'usageLimit': instance.usageLimit,
  'usageCount': instance.usageCount,
  'groupId': instance.groupId,
  'inviteType': instance.inviteType,
};
