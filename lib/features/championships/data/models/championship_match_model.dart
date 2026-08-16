import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

part 'championship_match_model.freezed.dart';
part 'championship_match_model.g.dart';

enum ChampionshipMatchStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('played')
  played,
  @JsonValue('disputed')
  disputed,
  @JsonValue('admin_decided')
  adminDecided,
  @JsonValue('verified')
  verified,
}

// ── Set score ────────────────────────────────────────────────────────────────

@freezed
abstract class MatchSetScore with _$MatchSetScore {
  const factory MatchSetScore({
    required int teamAPoints,
    required int teamBPoints,
    required int setNumber,
  }) = _MatchSetScore;

  const MatchSetScore._();

  factory MatchSetScore.fromJson(Map<String, dynamic> json) =>
      _$MatchSetScoreFromJson(json);

  /// Validates a championship set score.
  ///
  /// Regular sets (sets 1 & 2): first to 21, win by 2 (no cap).
  /// Decider set (set 3): first to 15, win by 2 (no cap).
  bool isValid({required bool isDeciderSet}) {
    final target = isDeciderSet ? 15 : 21;
    final maxPts = teamAPoints > teamBPoints ? teamAPoints : teamBPoints;
    final minPts = teamAPoints < teamBPoints ? teamAPoints : teamBPoints;

    // One side must reach the target
    if (maxPts < target) return false;

    // Win-by-2 rule
    if (maxPts == target) return minPts <= target - 2;

    // Extended play (e.g. 16-14, 22-20): gap must be exactly 2
    return (maxPts - minPts) == 2;
  }

  /// 'teamA', 'teamB', or null if score is not yet valid.
  String? winner({required bool isDeciderSet}) {
    if (!isValid(isDeciderSet: isDeciderSet)) return null;
    return teamAPoints > teamBPoints ? 'teamA' : 'teamB';
  }
}

// ── Match result ─────────────────────────────────────────────────────────────

@freezed
abstract class MatchResult with _$MatchResult {
  const factory MatchResult({
    @MatchSetScoreListConverter() required List<MatchSetScore> sets,
    required String winner, // 'teamA' | 'teamB'
    /// Championship points awarded (3/2/1/0 system)
    required int teamAPoints,
    required int teamBPoints,
  }) = _MatchResult;

  const MatchResult._();

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);

  int get teamASetsWon =>
      sets.where((s) => s.teamAPoints > s.teamBPoints).length;

  int get teamBSetsWon =>
      sets.where((s) => s.teamBPoints > s.teamAPoints).length;
}

// ── Admin decision ───────────────────────────────────────────────────────────

@freezed
abstract class AdminDecision with _$AdminDecision {
  const factory AdminDecision({
    required String decidedBy,
    required String notes,
    @TimestampConverter() required DateTime decidedAt,
  }) = _AdminDecision;

  factory AdminDecision.fromJson(Map<String, dynamic> json) =>
      _$AdminDecisionFromJson(json);
}

// ── Match ────────────────────────────────────────────────────────────────────

@freezed
abstract class ChampionshipMatchModel with _$ChampionshipMatchModel {
  const factory ChampionshipMatchModel({
    required String id,
    required int round,
    required String teamAId,
    required String teamBId,
    @TimestampConverter() required DateTime deadline,
    @Default(ChampionshipMatchStatus.pending) ChampionshipMatchStatus status,
    @NullableTimestampConverter() DateTime? scheduledAt,
    String? location,
    /// The team ID that proposed the current schedule. Null once the opposing
    /// team accepts (confirmed). Reset to null when the schedule is rejected.
    String? scheduledByTeamId,
    @MatchResultConverter() MatchResult? result,
    String? submittedByTeamId,
    String? submittedByUserId,
    String? verifiedByTeamId,
    String? verifiedByUserId,
    @NullableTimestampConverter() DateTime? verifiedAt,
    @AdminDecisionConverter() AdminDecision? adminDecision,
    /// Idempotency guard — set to true by the standings trigger (Story 30.8).
    @Default(false) bool standingsUpdated,
  }) = _ChampionshipMatchModel;

  const ChampionshipMatchModel._();

  factory ChampionshipMatchModel.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipMatchModelFromJson(json);

  factory ChampionshipMatchModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChampionshipMatchModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  bool get isPastDeadline => DateTime.now().isAfter(deadline);

  bool isTeamMember(String userId, ChampionshipTeamModel teamA,
          ChampionshipTeamModel teamB) =>
      teamA.isMember(userId) || teamB.isMember(userId);
}

// ── Custom JSON converters ────────────────────────────────────────────────────

class MatchSetScoreListConverter
    implements JsonConverter<List<MatchSetScore>, List<dynamic>> {
  const MatchSetScoreListConverter();

  @override
  List<MatchSetScore> fromJson(List<dynamic> json) =>
      json.map((e) => MatchSetScore.fromJson(e as Map<String, dynamic>)).toList();

  @override
  List<dynamic> toJson(List<MatchSetScore> object) =>
      object.map((e) => e.toJson()).toList();
}

class MatchResultConverter
    implements JsonConverter<MatchResult?, Map<String, dynamic>?> {
  const MatchResultConverter();

  @override
  MatchResult? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : MatchResult.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MatchResult? object) => object?.toJson();
}

class AdminDecisionConverter
    implements JsonConverter<AdminDecision?, Map<String, dynamic>?> {
  const AdminDecisionConverter();

  @override
  AdminDecision? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : AdminDecision.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AdminDecision? object) => object?.toJson();
}
