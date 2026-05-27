// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'championship_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChampionshipTeamModel _$ChampionshipTeamModelFromJson(
  Map<String, dynamic> json,
) => _ChampionshipTeamModel(
  id: json['id'] as String,
  name: json['name'] as String,
  captainId: json['captainId'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
);

Map<String, dynamic> _$ChampionshipTeamModelToJson(
  _ChampionshipTeamModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'captainId': instance.captainId,
  'memberIds': instance.memberIds,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
