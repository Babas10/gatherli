// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'championship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChampionshipModelImpl _$$ChampionshipModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChampionshipModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  status:
      $enumDecodeNullable(_$ChampionshipStatusEnumMap, json['status']) ??
      ChampionshipStatus.registration,
  maxTeams: (json['maxTeams'] as num?)?.toInt() ?? 10,
  teamSize: (json['teamSize'] as num?)?.toInt() ?? 2,
  adminIds:
      (json['adminIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdBy: json['createdBy'] as String,
  createdAt: const ChampionshipTimestampConverter().fromJson(
    json['createdAt'] as Object,
  ),
  registrationDeadline: const ChampionshipTimestampConverter().fromJson(
    json['registrationDeadline'] as Object,
  ),
  currentRound: (json['currentRound'] as num?)?.toInt() ?? 0,
  totalRounds: (json['totalRounds'] as num).toInt(),
  startDate: const ChampionshipNullableTimestampConverter().fromJson(
    json['startDate'],
  ),
  country: json['country'] as String?,
  region: json['region'] as String?,
);

Map<String, dynamic> _$$ChampionshipModelImplToJson(
  _$ChampionshipModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'status': _$ChampionshipStatusEnumMap[instance.status]!,
  'maxTeams': instance.maxTeams,
  'teamSize': instance.teamSize,
  'adminIds': instance.adminIds,
  'createdBy': instance.createdBy,
  'createdAt': const ChampionshipTimestampConverter().toJson(
    instance.createdAt,
  ),
  'registrationDeadline': const ChampionshipTimestampConverter().toJson(
    instance.registrationDeadline,
  ),
  'currentRound': instance.currentRound,
  'totalRounds': instance.totalRounds,
  'startDate': const ChampionshipNullableTimestampConverter().toJson(
    instance.startDate,
  ),
  'country': instance.country,
  'region': instance.region,
};

const _$ChampionshipStatusEnumMap = {
  ChampionshipStatus.registration: 'registration',
  ChampionshipStatus.active: 'active',
  ChampionshipStatus.completed: 'completed',
};

_$ChampionshipTeamModelImpl _$$ChampionshipTeamModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChampionshipTeamModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  captainId: json['captainId'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: const ChampionshipTimestampConverter().fromJson(
    json['createdAt'] as Object,
  ),
);

Map<String, dynamic> _$$ChampionshipTeamModelImplToJson(
  _$ChampionshipTeamModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'captainId': instance.captainId,
  'memberIds': instance.memberIds,
  'createdAt': const ChampionshipTimestampConverter().toJson(
    instance.createdAt,
  ),
};

_$MatchSetScoreImpl _$$MatchSetScoreImplFromJson(Map<String, dynamic> json) =>
    _$MatchSetScoreImpl(
      setNumber: (json['setNumber'] as num).toInt(),
      teamAPoints: (json['teamAPoints'] as num).toInt(),
      teamBPoints: (json['teamBPoints'] as num).toInt(),
    );

Map<String, dynamic> _$$MatchSetScoreImplToJson(_$MatchSetScoreImpl instance) =>
    <String, dynamic>{
      'setNumber': instance.setNumber,
      'teamAPoints': instance.teamAPoints,
      'teamBPoints': instance.teamBPoints,
    };

_$MatchResultImpl _$$MatchResultImplFromJson(Map<String, dynamic> json) =>
    _$MatchResultImpl(
      sets: const MatchSetScoreListConverter().fromJson(json['sets'] as List),
      winner: json['winner'] as String,
    );

Map<String, dynamic> _$$MatchResultImplToJson(_$MatchResultImpl instance) =>
    <String, dynamic>{
      'sets': const MatchSetScoreListConverter().toJson(instance.sets),
      'winner': instance.winner,
    };

_$AdminDecisionImpl _$$AdminDecisionImplFromJson(Map<String, dynamic> json) =>
    _$AdminDecisionImpl(
      adminId: json['adminId'] as String,
      winner: json['winner'] as String,
      reason: json['reason'] as String,
      decidedAt: const ChampionshipTimestampConverter().fromJson(
        json['decidedAt'] as Object,
      ),
    );

Map<String, dynamic> _$$AdminDecisionImplToJson(_$AdminDecisionImpl instance) =>
    <String, dynamic>{
      'adminId': instance.adminId,
      'winner': instance.winner,
      'reason': instance.reason,
      'decidedAt': const ChampionshipTimestampConverter().toJson(
        instance.decidedAt,
      ),
    };

_$ChampionshipMatchModelImpl _$$ChampionshipMatchModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChampionshipMatchModelImpl(
  id: json['id'] as String,
  round: (json['round'] as num).toInt(),
  teamAId: json['teamAId'] as String,
  teamBId: json['teamBId'] as String,
  deadline: const ChampionshipTimestampConverter().fromJson(
    json['deadline'] as Object,
  ),
  status:
      $enumDecodeNullable(_$MatchStatusEnumMap, json['status']) ??
      MatchStatus.pending,
  scheduledAt: const ChampionshipNullableTimestampConverter().fromJson(
    json['scheduledAt'],
  ),
  location: json['location'] as String?,
  result: const MatchResultConverter().fromJson(
    json['result'] as Map<String, dynamic>?,
  ),
  submittedByTeamId: json['submittedByTeamId'] as String?,
  submittedByUserId: json['submittedByUserId'] as String?,
  verifiedByTeamId: json['verifiedByTeamId'] as String?,
  verifiedByUserId: json['verifiedByUserId'] as String?,
  verifiedAt: const ChampionshipNullableTimestampConverter().fromJson(
    json['verifiedAt'],
  ),
  adminDecision: const AdminDecisionConverter().fromJson(
    json['adminDecision'] as Map<String, dynamic>?,
  ),
);

Map<String, dynamic> _$$ChampionshipMatchModelImplToJson(
  _$ChampionshipMatchModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'round': instance.round,
  'teamAId': instance.teamAId,
  'teamBId': instance.teamBId,
  'deadline': const ChampionshipTimestampConverter().toJson(instance.deadline),
  'status': _$MatchStatusEnumMap[instance.status]!,
  'scheduledAt': const ChampionshipNullableTimestampConverter().toJson(
    instance.scheduledAt,
  ),
  'location': instance.location,
  'result': const MatchResultConverter().toJson(instance.result),
  'submittedByTeamId': instance.submittedByTeamId,
  'submittedByUserId': instance.submittedByUserId,
  'verifiedByTeamId': instance.verifiedByTeamId,
  'verifiedByUserId': instance.verifiedByUserId,
  'verifiedAt': const ChampionshipNullableTimestampConverter().toJson(
    instance.verifiedAt,
  ),
  'adminDecision': const AdminDecisionConverter().toJson(
    instance.adminDecision,
  ),
};

const _$MatchStatusEnumMap = {
  MatchStatus.pending: 'pending',
  MatchStatus.scheduled: 'scheduled',
  MatchStatus.played: 'played',
  MatchStatus.disputed: 'disputed',
  MatchStatus.adminDecided: 'admin_decided',
};

_$ChampionshipStandingsModelImpl _$$ChampionshipStandingsModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChampionshipStandingsModelImpl(
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

Map<String, dynamic> _$$ChampionshipStandingsModelImplToJson(
  _$ChampionshipStandingsModelImpl instance,
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

_$ChampionshipMessageModelImpl _$$ChampionshipMessageModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChampionshipMessageModelImpl(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  senderDisplayName: json['senderDisplayName'] as String,
  teamId: json['teamId'] as String,
  text: json['text'] as String,
  sentAt: const ChampionshipTimestampConverter().fromJson(
    json['sentAt'] as Object,
  ),
);

Map<String, dynamic> _$$ChampionshipMessageModelImplToJson(
  _$ChampionshipMessageModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'senderDisplayName': instance.senderDisplayName,
  'teamId': instance.teamId,
  'text': instance.text,
  'sentAt': const ChampionshipTimestampConverter().toJson(instance.sentAt),
};
