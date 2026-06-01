import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';

part 'championship_model.freezed.dart';
part 'championship_model.g.dart';

enum ChampionshipStatus {
  @JsonValue('registration')
  registration,
  @JsonValue('registration_closed')
  registrationClosed,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

/// Gender category for a championship — null means no gender restriction (legacy).
enum ChampionshipGenderCategory {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
}

@freezed
abstract class ChampionshipModel with _$ChampionshipModel {
  const factory ChampionshipModel({
    required String id,
    required String title,
    @Default(ChampionshipStatus.registration) ChampionshipStatus status,
    @Default(10) int maxTeams,
    @Default(2) int teamSize,
    @Default([]) List<String> adminIds,
    required String createdBy,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime registrationDeadline,
    @Default(0) int currentRound,
    @Default(9) int totalRounds,
    @Default(0) int teamsCount,
    @NullableTimestampConverter() DateTime? startDate,
    String? country,
    String? region,
    ChampionshipGenderCategory? genderCategory,
  }) = _ChampionshipModel;

  const ChampionshipModel._();

  factory ChampionshipModel.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipModelFromJson(json);

  factory ChampionshipModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChampionshipModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  bool get isOpen =>
      status == ChampionshipStatus.registration && teamsCount < maxTeams;

  bool get isFull => teamsCount >= maxTeams;

  int get availableSlots => maxTeams - teamsCount;
}
