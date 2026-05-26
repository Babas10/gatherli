// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teammate_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeammateStats _$TeammateStatsFromJson(Map<String, dynamic> json) =>
    _TeammateStats(
      userId: json['userId'] as String,
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      gamesWon: (json['gamesWon'] as num).toInt(),
      gamesLost: (json['gamesLost'] as num).toInt(),
      pointsScored: (json['pointsScored'] as num?)?.toInt() ?? 0,
      pointsAllowed: (json['pointsAllowed'] as num?)?.toInt() ?? 0,
      eloChange: (json['eloChange'] as num?)?.toDouble() ?? 0.0,
      recentGames:
          (json['recentGames'] as List<dynamic>?)
              ?.map((e) => RecentGameResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdated: const NullableTimestampConverter().fromJson(
        json['lastUpdated'],
      ),
    );

Map<String, dynamic> _$TeammateStatsToJson(_TeammateStats instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'gamesLost': instance.gamesLost,
      'pointsScored': instance.pointsScored,
      'pointsAllowed': instance.pointsAllowed,
      'eloChange': instance.eloChange,
      'recentGames': instance.recentGames,
      'lastUpdated': const NullableTimestampConverter().toJson(
        instance.lastUpdated,
      ),
    };

_RecentGameResult _$RecentGameResultFromJson(Map<String, dynamic> json) =>
    _RecentGameResult(
      gameId: json['gameId'] as String,
      won: json['won'] as bool,
      pointsScored: (json['pointsScored'] as num).toInt(),
      pointsAllowed: (json['pointsAllowed'] as num).toInt(),
      eloChange: (json['eloChange'] as num).toDouble(),
      timestamp: const TimestampConverter().fromJson(
        json['timestamp'] as Object,
      ),
    );

Map<String, dynamic> _$RecentGameResultToJson(_RecentGameResult instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
      'won': instance.won,
      'pointsScored': instance.pointsScored,
      'pointsAllowed': instance.pointsAllowed,
      'eloChange': instance.eloChange,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
