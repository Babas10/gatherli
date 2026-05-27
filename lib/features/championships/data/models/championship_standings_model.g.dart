// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'championship_standings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChampionshipStandingsModel _$ChampionshipStandingsModelFromJson(
  Map<String, dynamic> json,
) => _ChampionshipStandingsModel(
  teamId: json['teamId'] as String,
  teamName: json['teamName'] as String,
  played: (json['played'] as num?)?.toInt() ?? 0,
  points: (json['points'] as num?)?.toInt() ?? 0,
  wins20: (json['wins20'] as num?)?.toInt() ?? 0,
  wins21: (json['wins21'] as num?)?.toInt() ?? 0,
  losses12: (json['losses12'] as num?)?.toInt() ?? 0,
  losses02: (json['losses02'] as num?)?.toInt() ?? 0,
  setsWon: (json['setsWon'] as num?)?.toInt() ?? 0,
  setsLost: (json['setsLost'] as num?)?.toInt() ?? 0,
  position: (json['position'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ChampionshipStandingsModelToJson(
  _ChampionshipStandingsModel instance,
) => <String, dynamic>{
  'teamId': instance.teamId,
  'teamName': instance.teamName,
  'played': instance.played,
  'points': instance.points,
  'wins20': instance.wins20,
  'wins21': instance.wins21,
  'losses12': instance.losses12,
  'losses02': instance.losses02,
  'setsWon': instance.setsWon,
  'setsLost': instance.setsLost,
  'position': instance.position,
};
