import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';

part 'championship_team_model.freezed.dart';
part 'championship_team_model.g.dart';

@freezed
abstract class ChampionshipTeamModel with _$ChampionshipTeamModel {
  const factory ChampionshipTeamModel({
    required String id,
    required String name,
    required String captainId,
    required List<String> memberIds, // always exactly 2
    @TimestampConverter() required DateTime createdAt,
  }) = _ChampionshipTeamModel;

  const ChampionshipTeamModel._();

  factory ChampionshipTeamModel.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipTeamModelFromJson(json);

  factory ChampionshipTeamModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChampionshipTeamModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  bool isMember(String userId) => memberIds.contains(userId);
}
