// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingSessionModelImpl _$$TrainingSessionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TrainingSessionModelImpl(
  id: json['id'] as String,
  groupId: json['groupId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  location: GameLocation.fromJson(json['location'] as Map<String, dynamic>),
  startTime: const TimestampConverter().fromJson(json['startTime'] as Object),
  endTime: const TimestampConverter().fromJson(json['endTime'] as Object),
  minParticipants: (json['minParticipants'] as num).toInt(),
  maxParticipants: (json['maxParticipants'] as num).toInt(),
  createdBy: json['createdBy'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
  recurrenceRule: json['recurrenceRule'] == null
      ? null
      : RecurrenceRuleModel.fromJson(
          json['recurrenceRule'] as Map<String, dynamic>,
        ),
  parentSessionId: json['parentSessionId'] as String?,
  status:
      $enumDecodeNullable(_$TrainingStatusEnumMap, json['status']) ??
      TrainingStatus.scheduled,
  participantIds:
      (json['participantIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  notes: json['notes'] as String?,
  cancelledBy: json['cancelledBy'] as String?,
  cancelledAt: const NullableTimestampConverter().fromJson(json['cancelledAt']),
);

Map<String, dynamic> _$$TrainingSessionModelImplToJson(
  _$TrainingSessionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'groupId': instance.groupId,
  'title': instance.title,
  'description': instance.description,
  'location': instance.location,
  'startTime': const TimestampConverter().toJson(instance.startTime),
  'endTime': const TimestampConverter().toJson(instance.endTime),
  'minParticipants': instance.minParticipants,
  'maxParticipants': instance.maxParticipants,
  'createdBy': instance.createdBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
  'recurrenceRule': instance.recurrenceRule,
  'parentSessionId': instance.parentSessionId,
  'status': _$TrainingStatusEnumMap[instance.status]!,
  'participantIds': instance.participantIds,
  'notes': instance.notes,
  'cancelledBy': instance.cancelledBy,
  'cancelledAt': const NullableTimestampConverter().toJson(
    instance.cancelledAt,
  ),
};

const _$TrainingStatusEnumMap = {
  TrainingStatus.scheduled: 'scheduled',
  TrainingStatus.completed: 'completed',
  TrainingStatus.cancelled: 'cancelled',
};
