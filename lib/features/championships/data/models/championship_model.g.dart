// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'championship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChampionshipModel _$ChampionshipModelFromJson(
  Map<String, dynamic> json,
) => _ChampionshipModel(
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
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  registrationDeadline: const TimestampConverter().fromJson(
    json['registrationDeadline'] as Object,
  ),
  currentRound: (json['currentRound'] as num?)?.toInt() ?? 0,
  totalRounds: (json['totalRounds'] as num?)?.toInt() ?? 9,
  teamsCount: (json['teamsCount'] as num?)?.toInt() ?? 0,
  startDate: const NullableTimestampConverter().fromJson(json['startDate']),
  country: json['country'] as String?,
  region: json['region'] as String?,
  genderCategory: $enumDecodeNullable(
    _$ChampionshipGenderCategoryEnumMap,
    json['genderCategory'],
  ),
);

Map<String, dynamic> _$ChampionshipModelToJson(
  _ChampionshipModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'status': _$ChampionshipStatusEnumMap[instance.status]!,
  'maxTeams': instance.maxTeams,
  'teamSize': instance.teamSize,
  'adminIds': instance.adminIds,
  'createdBy': instance.createdBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'registrationDeadline': const TimestampConverter().toJson(
    instance.registrationDeadline,
  ),
  'currentRound': instance.currentRound,
  'totalRounds': instance.totalRounds,
  'teamsCount': instance.teamsCount,
  'startDate': const NullableTimestampConverter().toJson(instance.startDate),
  'country': instance.country,
  'region': instance.region,
  'genderCategory':
      _$ChampionshipGenderCategoryEnumMap[instance.genderCategory],
};

const _$ChampionshipStatusEnumMap = {
  ChampionshipStatus.registration: 'registration',
  ChampionshipStatus.registrationClosed: 'registration_closed',
  ChampionshipStatus.active: 'active',
  ChampionshipStatus.completed: 'completed',
};

const _$ChampionshipGenderCategoryEnumMap = {
  ChampionshipGenderCategory.male: 'male',
  ChampionshipGenderCategory.female: 'female',
};
