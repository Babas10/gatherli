// Freezed data models for the Championship System (Epic 30 — Story 30.1).
// Covers championships, teams, matches (with result & set-score validation),
// standings, and per-match coordination messages.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'championship_model.freezed.dart';
part 'championship_model.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Timestamp Converters
// ─────────────────────────────────────────────────────────────────────────────

/// Converts a non-nullable [DateTime] to/from a Firestore [Timestamp].
class ChampionshipTimestampConverter
    implements JsonConverter<DateTime, Object> {
  const ChampionshipTimestampConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    throw Exception(
      'ChampionshipTimestampConverter: unsupported type ${json.runtimeType}',
    );
  }

  @override
  Object toJson(DateTime object) => Timestamp.fromDate(object);
}

/// Converts a nullable [DateTime] to/from a Firestore [Timestamp].
class ChampionshipNullableTimestampConverter
    implements JsonConverter<DateTime?, Object?> {
  const ChampionshipNullableTimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    if (object == null) return null;
    return Timestamp.fromDate(object);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Enums
// ─────────────────────────────────────────────────────────────────────────────

enum ChampionshipStatus {
  @JsonValue('registration')
  registration,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

enum MatchStatus {
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
}

// ─────────────────────────────────────────────────────────────────────────────
// ChampionshipModel  — championships/{championshipId}
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class ChampionshipModel with _$ChampionshipModel {
  const factory ChampionshipModel({
    required String id,
    required String title,
    @Default(ChampionshipStatus.registration) ChampionshipStatus status,
    @Default(10) int maxTeams,
    @Default(2) int teamSize,
    @Default([]) List<String> adminIds,
    required String createdBy,
    @ChampionshipTimestampConverter() required DateTime createdAt,
    @ChampionshipTimestampConverter() required DateTime registrationDeadline,
    @Default(0) int currentRound,
    // totalRounds = maxTeams - 1 (single round-robin)
    required int totalRounds,
    @ChampionshipNullableTimestampConverter() DateTime? startDate,
    String? country,
    String? region,
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

  bool isAdmin(String userId) => adminIds.contains(userId);
}

// ─────────────────────────────────────────────────────────────────────────────
// ChampionshipTeamModel  — championships/{id}/teams/{teamId}
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class ChampionshipTeamModel with _$ChampionshipTeamModel {
  const factory ChampionshipTeamModel({
    required String id,
    required String name,
    required String captainId,
    required List<String> memberIds, // exactly 2
    @ChampionshipTimestampConverter() required DateTime createdAt,
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

  bool hasMember(String userId) => memberIds.contains(userId);
}

// ─────────────────────────────────────────────────────────────────────────────
// MatchSetScore  — a single set within a championship match
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class MatchSetScore with _$MatchSetScore {
  const factory MatchSetScore({
    required int setNumber,
    required int teamAPoints,
    required int teamBPoints,
  }) = _MatchSetScore;

  const MatchSetScore._();

  factory MatchSetScore.fromJson(Map<String, dynamic> json) =>
      _$MatchSetScoreFromJson(json);

  /// Validates the set score according to beach-volleyball championship rules.
  ///
  /// Regular set (isDeciderSet: false): first to 21, win by 2.
  /// Decider set  (isDeciderSet: true):  first to 15, win by 2.
  bool isValid({required bool isDeciderSet}) {
    final target = isDeciderSet ? 15 : 21;
    final maxPts = teamAPoints > teamBPoints ? teamAPoints : teamBPoints;
    final minPts = teamAPoints < teamBPoints ? teamAPoints : teamBPoints;

    // Must reach the target
    if (maxPts < target) return false;

    // Exactly at target → loser must be at most target - 2
    if (maxPts == target) return minPts <= target - 2;

    // Extended play: winner leads by exactly 2
    return (maxPts - minPts) == 2;
  }

  /// Returns the winning side based on raw point comparison.
  /// Caller should validate first via [isValid].
  String? get winner {
    if (teamAPoints == teamBPoints) return null;
    return teamAPoints > teamBPoints ? 'teamA' : 'teamB';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MatchResult — aggregated result of a championship match (best-of-3 sets)
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class MatchResult with _$MatchResult {
  const factory MatchResult({
    @MatchSetScoreListConverter() required List<MatchSetScore> sets,
    required String winner, // 'teamA' or 'teamB'
  }) = _MatchResult;

  const MatchResult._();

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);

  /// Championship matches are best-of-3 sets (first to 2 set wins).
  /// Set 3 (index 2) is the decider → first to 15 points.
  bool isValid() {
    if (sets.isEmpty) return false;

    for (int i = 0; i < sets.length; i++) {
      final isDecider = i == 2;
      if (!sets[i].isValid(isDeciderSet: isDecider)) return false;
    }

    int teamASetWins = 0;
    int teamBSetWins = 0;
    for (final s in sets) {
      if (s.winner == 'teamA') teamASetWins++;
      if (s.winner == 'teamB') teamBSetWins++;
    }

    if (winner == 'teamA') return teamASetWins == 2;
    if (winner == 'teamB') return teamBSetWins == 2;
    return false;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AdminDecision — admin override for a disputed match
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class AdminDecision with _$AdminDecision {
  const factory AdminDecision({
    required String adminId,
    required String winner, // 'teamA' or 'teamB'
    required String reason,
    @ChampionshipTimestampConverter() required DateTime decidedAt,
  }) = _AdminDecision;

  const AdminDecision._();

  factory AdminDecision.fromJson(Map<String, dynamic> json) =>
      _$AdminDecisionFromJson(json);
}

// ─────────────────────────────────────────────────────────────────────────────
// ChampionshipMatchModel  — championships/{id}/matches/{matchId}
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class ChampionshipMatchModel with _$ChampionshipMatchModel {
  const factory ChampionshipMatchModel({
    required String id,
    required int round,
    required String teamAId,
    required String teamBId,
    @ChampionshipTimestampConverter() required DateTime deadline,
    @Default(MatchStatus.pending) MatchStatus status,
    @ChampionshipNullableTimestampConverter() DateTime? scheduledAt,
    String? location,
    @MatchResultConverter() MatchResult? result,
    String? submittedByTeamId,
    String? submittedByUserId,
    String? verifiedByTeamId,
    String? verifiedByUserId,
    @ChampionshipNullableTimestampConverter() DateTime? verifiedAt,
    @AdminDecisionConverter() AdminDecision? adminDecision,
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
}

// ─────────────────────────────────────────────────────────────────────────────
// ChampionshipStandingsModel  — championships/{id}/standings/{teamId}
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class ChampionshipStandingsModel with _$ChampionshipStandingsModel {
  const factory ChampionshipStandingsModel({
    required String teamId,
    required String teamName,
    @Default(0) int played,
    @Default(0) int points,
    @Default(0) int wins20, // 2-0 wins  (3 pts)
    @Default(0) int wins21, // 2-1 wins  (2 pts)
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

  Map<String, dynamic> toFirestore() => toJson();

  int get setDifference => setsWon - setsLost;
}

// ─────────────────────────────────────────────────────────────────────────────
// ChampionshipMessageModel  — championships/{id}/matches/{id}/messages/{msgId}
// ─────────────────────────────────────────────────────────────────────────────

@freezed
class ChampionshipMessageModel with _$ChampionshipMessageModel {
  const factory ChampionshipMessageModel({
    required String id,
    required String senderId,
    required String senderDisplayName,
    required String teamId,
    required String text,
    @ChampionshipTimestampConverter() required DateTime sentAt,
  }) = _ChampionshipMessageModel;

  const ChampionshipMessageModel._();

  factory ChampionshipMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipMessageModelFromJson(json);

  factory ChampionshipMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChampionshipMessageModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// JSON Converters
// ─────────────────────────────────────────────────────────────────────────────

class MatchSetScoreListConverter
    implements JsonConverter<List<MatchSetScore>, List<dynamic>> {
  const MatchSetScoreListConverter();

  @override
  List<MatchSetScore> fromJson(List<dynamic> json) => json
      .map((e) => MatchSetScore.fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  List<dynamic> toJson(List<MatchSetScore> object) =>
      object.map((e) => e.toJson()).toList();
}

class MatchResultConverter
    implements JsonConverter<MatchResult?, Map<String, dynamic>?> {
  const MatchResultConverter();

  @override
  MatchResult? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return MatchResult.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MatchResult? object) => object?.toJson();
}

class AdminDecisionConverter
    implements JsonConverter<AdminDecision?, Map<String, dynamic>?> {
  const AdminDecisionConverter();

  @override
  AdminDecision? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return AdminDecision.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AdminDecision? object) => object?.toJson();
}
