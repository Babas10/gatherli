// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_elo_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BestEloRecord _$BestEloRecordFromJson(Map<String, dynamic> json) =>
    _BestEloRecord(
      elo: (json['elo'] as num).toDouble(),
      date: const TimestampConverter().fromJson(json['date'] as Object),
      gameId: json['gameId'] as String,
    );

Map<String, dynamic> _$BestEloRecordToJson(_BestEloRecord instance) =>
    <String, dynamic>{
      'elo': instance.elo,
      'date': const TimestampConverter().toJson(instance.date),
      'gameId': instance.gameId,
    };
