// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(
  Map<String, dynamic> json,
) => _$GroupModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  photoUrl: json['photoUrl'] as String?,
  createdBy: json['createdBy'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
  memberIds:
      (json['memberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  adminIds:
      (json['adminIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  gameIds:
      (json['gameIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  privacy:
      $enumDecodeNullable(_$GroupPrivacyEnumMap, json['privacy']) ??
      GroupPrivacy.private,
  requiresApproval: json['requiresApproval'] as bool? ?? false,
  maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 20,
  location: json['location'] as String?,
  allowMembersToCreateGames: json['allowMembersToCreateGames'] as bool? ?? true,
  allowMembersToInviteOthers:
      json['allowMembersToInviteOthers'] as bool? ?? true,
  notifyMembersOfNewGames: json['notifyMembersOfNewGames'] as bool? ?? true,
  totalGamesPlayed: (json['totalGamesPlayed'] as num?)?.toInt() ?? 0,
  lastActivity: const NullableTimestampConverter().fromJson(
    json['lastActivity'],
  ),
);

Map<String, dynamic> _$$GroupModelImplToJson(
  _$GroupModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'photoUrl': instance.photoUrl,
  'createdBy': instance.createdBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
  'memberIds': instance.memberIds,
  'adminIds': instance.adminIds,
  'gameIds': instance.gameIds,
  'privacy': _$GroupPrivacyEnumMap[instance.privacy]!,
  'requiresApproval': instance.requiresApproval,
  'maxMembers': instance.maxMembers,
  'location': instance.location,
  'allowMembersToCreateGames': instance.allowMembersToCreateGames,
  'allowMembersToInviteOthers': instance.allowMembersToInviteOthers,
  'notifyMembersOfNewGames': instance.notifyMembersOfNewGames,
  'totalGamesPlayed': instance.totalGamesPlayed,
  'lastActivity': const NullableTimestampConverter().toJson(
    instance.lastActivity,
  ),
};

const _$GroupPrivacyEnumMap = {
  GroupPrivacy.public: 'public',
  GroupPrivacy.private: 'private',
  GroupPrivacy.inviteOnly: 'invite_only',
};
