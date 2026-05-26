// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_project_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FirebaseProjectInfo _$FirebaseProjectInfoFromJson(Map<String, dynamic> json) =>
    _FirebaseProjectInfo(
      environment: json['environment'] as String,
      expectedProjectId: json['expectedProjectId'] as String,
      actualProjectId: json['actualProjectId'] as String?,
      status: $enumDecode(_$FirebaseProjectStatusEnumMap, json['status']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      matchesExpected: json['matchesExpected'] as bool? ?? false,
    );

Map<String, dynamic> _$FirebaseProjectInfoToJson(
  _FirebaseProjectInfo instance,
) => <String, dynamic>{
  'environment': instance.environment,
  'expectedProjectId': instance.expectedProjectId,
  'actualProjectId': instance.actualProjectId,
  'status': _$FirebaseProjectStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt?.toIso8601String(),
  'matchesExpected': instance.matchesExpected,
};

const _$FirebaseProjectStatusEnumMap = {
  FirebaseProjectStatus.notStarted: 'not_started',
  FirebaseProjectStatus.pending: 'pending',
  FirebaseProjectStatus.created: 'created',
  FirebaseProjectStatus.error: 'error',
};

_FirebaseProjectTracker _$FirebaseProjectTrackerFromJson(
  Map<String, dynamic> json,
) => _FirebaseProjectTracker(
  storyVersion: json['storyVersion'] as String,
  trackedAt: DateTime.parse(json['trackedAt'] as String),
  projects: (json['projects'] as List<dynamic>)
      .map((e) => FirebaseProjectInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FirebaseProjectTrackerToJson(
  _FirebaseProjectTracker instance,
) => <String, dynamic>{
  'storyVersion': instance.storyVersion,
  'trackedAt': instance.trackedAt.toIso8601String(),
  'projects': instance.projects,
};
