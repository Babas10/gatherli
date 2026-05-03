// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseModelImpl _$$ExerciseModelImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
      updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$ExerciseModelImplToJson(
  _$ExerciseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'durationMinutes': instance.durationMinutes,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};
