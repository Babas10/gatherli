// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingSessionParticipantModel _$TrainingSessionParticipantModelFromJson(
  Map<String, dynamic> json,
) => _TrainingSessionParticipantModel(
  userId: json['userId'] as String,
  joinedAt: const TimestampConverter().fromJson(json['joinedAt'] as Object),
  status:
      $enumDecodeNullable(_$ParticipantStatusEnumMap, json['status']) ??
      ParticipantStatus.joined,
);

Map<String, dynamic> _$TrainingSessionParticipantModelToJson(
  _TrainingSessionParticipantModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'joinedAt': const TimestampConverter().toJson(instance.joinedAt),
  'status': _$ParticipantStatusEnumMap[instance.status]!,
};

const _$ParticipantStatusEnumMap = {
  ParticipantStatus.joined: 'joined',
  ParticipantStatus.left: 'left',
};
