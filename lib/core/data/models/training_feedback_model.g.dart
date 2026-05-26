// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingFeedbackModel _$TrainingFeedbackModelFromJson(
  Map<String, dynamic> json,
) => _TrainingFeedbackModel(
  id: json['id'] as String,
  trainingSessionId: json['trainingSessionId'] as String,
  exercisesQuality: (json['exercisesQuality'] as num).toInt(),
  trainingIntensity: (json['trainingIntensity'] as num).toInt(),
  coachingClarity: (json['coachingClarity'] as num).toInt(),
  comment: json['comment'] as String?,
  participantHash: json['participantHash'] as String,
  submittedAt: const TimestampConverter().fromJson(
    json['submittedAt'] as Object,
  ),
);

Map<String, dynamic> _$TrainingFeedbackModelToJson(
  _TrainingFeedbackModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'trainingSessionId': instance.trainingSessionId,
  'exercisesQuality': instance.exercisesQuality,
  'trainingIntensity': instance.trainingIntensity,
  'coachingClarity': instance.coachingClarity,
  'comment': instance.comment,
  'participantHash': instance.participantHash,
  'submittedAt': const TimestampConverter().toJson(instance.submittedAt),
};
