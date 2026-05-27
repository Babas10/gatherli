import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'championship_standings_model.freezed.dart';
part 'championship_standings_model.g.dart';

@freezed
abstract class ChampionshipStandingsModel with _$ChampionshipStandingsModel {
  const factory ChampionshipStandingsModel({
    required String teamId,
    required String teamName,
    @Default(0) int played,
    @Default(0) int points,
    @Default(0) int wins20, // 2-0 wins (3 pts)
    @Default(0) int wins21, // 2-1 wins (2 pts)
    @Default(0) int losses12, // 1-2 losses (1 pt)
    @Default(0) int losses02, // 0-2 losses (0 pts)
    @Default(0) int setsWon,
    @Default(0) int setsLost,
    @Default(0) int position,
  }) = _ChampionshipStandingsModel;

  const ChampionshipStandingsModel._();

  factory ChampionshipStandingsModel.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipStandingsModelFromJson(json);

  factory ChampionshipStandingsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChampionshipStandingsModel.fromJson({...data, 'teamId': doc.id});
  }

  Map<String, dynamic> toFirestore() => toJson()..remove('teamId');

  int get setRatio => setsWon - setsLost;
}
