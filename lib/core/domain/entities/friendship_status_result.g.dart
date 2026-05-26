// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_status_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendshipStatusResult _$FriendshipStatusResultFromJson(
  Map<String, dynamic> json,
) => _FriendshipStatusResult(
  isFriend: json['isFriend'] as bool,
  hasPendingRequest: json['hasPendingRequest'] as bool,
  requestDirection: json['requestDirection'] as String?,
  friendshipId: json['friendshipId'] as String?,
);

Map<String, dynamic> _$FriendshipStatusResultToJson(
  _FriendshipStatusResult instance,
) => <String, dynamic>{
  'isFriend': instance.isFriend,
  'hasPendingRequest': instance.hasPendingRequest,
  'requestDirection': instance.requestDirection,
  'friendshipId': instance.friendshipId,
};
