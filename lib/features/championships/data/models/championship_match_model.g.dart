// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'championship_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchSetScore _$MatchSetScoreFromJson(Map<String, dynamic> json) =>
    _MatchSetScore(
      teamAPoints: (json['teamAPoints'] as num).toInt(),
      teamBPoints: (json['teamBPoints'] as num).toInt(),
      setNumber: (json['setNumber'] as num).toInt(),
    );

Map<String, dynamic> _$MatchSetScoreToJson(_MatchSetScore instance) =>
    <String, dynamic>{
      'teamAPoints': instance.teamAPoints,
      'teamBPoints': instance.teamBPoints,
      'setNumber': instance.setNumber,
    };

_MatchResult _$MatchResultFromJson(Map<String, dynamic> json) => _MatchResult(
  sets: const MatchSetScoreListConverter().fromJson(json['sets'] as List),
  winner: json['winner'] as String,
  teamAPoints: (json['teamAPoints'] as num).toInt(),
  teamBPoints: (json['teamBPoints'] as num).toInt(),
);

Map<String, dynamic> _$MatchResultToJson(_MatchResult instance) =>
    <String, dynamic>{
      'sets': const MatchSetScoreListConverter().toJson(instance.sets),
      'winner': instance.winner,
      'teamAPoints': instance.teamAPoints,
      'teamBPoints': instance.teamBPoints,
    };

_AdminDecision _$AdminDecisionFromJson(Map<String, dynamic> json) =>
    _AdminDecision(
      decidedBy: json['decidedBy'] as String,
      notes: json['notes'] as String,
      decidedAt: const TimestampConverter().fromJson(
        json['decidedAt'] as Object,
      ),
    );

Map<String, dynamic> _$AdminDecisionToJson(_AdminDecision instance) =>
    <String, dynamic>{
      'decidedBy': instance.decidedBy,
      'notes': instance.notes,
      'decidedAt': const TimestampConverter().toJson(instance.decidedAt),
    };

_ChampionshipMatchModel _$ChampionshipMatchModelFromJson(
  Map<String, dynamic> json,
) => _ChampionshipMatchModel(
  id: json['id'] as String,
  round: (json['round'] as num).toInt(),
  teamAId: json['teamAId'] as String,
  teamBId: json['teamBId'] as String,
  deadline: const TimestampConverter().fromJson(json['deadline'] as Object),
  status:
      $enumDecodeNullable(_$ChampionshipMatchStatusEnumMap, json['status']) ??
      ChampionshipMatchStatus.pending,
  scheduledAt: const NullableTimestampConverter().fromJson(json['scheduledAt']),
  location: json['location'] as String?,
  result: const MatchResultConverter().fromJson(
    json['result'] as Map<String, dynamic>?,
  ),
  submittedByTeamId: json['submittedByTeamId'] as String?,
  submittedByUserId: json['submittedByUserId'] as String?,
  verifiedByTeamId: json['verifiedByTeamId'] as String?,
  verifiedByUserId: json['verifiedByUserId'] as String?,
  verifiedAt: const NullableTimestampConverter().fromJson(json['verifiedAt']),
  adminDecision: const AdminDecisionConverter().fromJson(
    json['adminDecision'] as Map<String, dynamic>?,
  ),
  standingsUpdated: json['standingsUpdated'] as bool? ?? false,
);

Map<String, dynamic> _$ChampionshipMatchModelToJson(
  _ChampionshipMatchModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'round': instance.round,
  'teamAId': instance.teamAId,
  'teamBId': instance.teamBId,
  'deadline': const TimestampConverter().toJson(instance.deadline),
  'status': _$ChampionshipMatchStatusEnumMap[instance.status]!,
  'scheduledAt': const NullableTimestampConverter().toJson(
    instance.scheduledAt,
  ),
  'location': instance.location,
  'result': const MatchResultConverter().toJson(instance.result),
  'submittedByTeamId': instance.submittedByTeamId,
  'submittedByUserId': instance.submittedByUserId,
  'verifiedByTeamId': instance.verifiedByTeamId,
  'verifiedByUserId': instance.verifiedByUserId,
  'verifiedAt': const NullableTimestampConverter().toJson(instance.verifiedAt),
  'adminDecision': const AdminDecisionConverter().toJson(
    instance.adminDecision,
  ),
  'standingsUpdated': instance.standingsUpdated,
};

const _$ChampionshipMatchStatusEnumMap = {
  ChampionshipMatchStatus.pending: 'pending',
  ChampionshipMatchStatus.scheduled: 'scheduled',
  ChampionshipMatchStatus.played: 'played',
  ChampionshipMatchStatus.disputed: 'disputed',
  ChampionshipMatchStatus.adminDecided: 'admin_decided',
  ChampionshipMatchStatus.verified: 'verified',
};
