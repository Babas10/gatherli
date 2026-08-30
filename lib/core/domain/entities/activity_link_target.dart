// Represents a deep-link target for a specific shareable activity (game,
// training session, or championship match). Mirrors the plain sealed-class
// style of DeepLinkEvent/DeepLinkState rather than freezed, since it is a
// simple, stable, low-field-count hierarchy.
import 'package:equatable/equatable.dart';

sealed class ActivityLinkTarget extends Equatable {
  const ActivityLinkTarget();

  /// Encodes this target to a single string for storage in
  /// PendingActivityLinkStorage (a SharedPreferences string slot).
  /// Firestore auto-generated IDs never contain ':', so a colon-delimited
  /// scheme is safe to split on.
  String encode();

  /// Decodes a string produced by [encode]. Returns null for any malformed
  /// or unrecognized input.
  static ActivityLinkTarget? decode(String raw) {
    final parts = raw.split(':');
    if (parts.isEmpty) return null;

    switch (parts[0]) {
      case 'game':
        if (parts.length != 2 || parts[1].isEmpty) return null;
        return GameLinkTarget(parts[1]);
      case 'training':
        if (parts.length != 2 || parts[1].isEmpty) return null;
        return TrainingSessionLinkTarget(parts[1]);
      case 'championshipMatch':
        if (parts.length != 3 || parts[1].isEmpty || parts[2].isEmpty) {
          return null;
        }
        return ChampionshipMatchLinkTarget(
          championshipId: parts[1],
          matchId: parts[2],
        );
      default:
        return null;
    }
  }
}

class GameLinkTarget extends ActivityLinkTarget {
  final String gameId;

  const GameLinkTarget(this.gameId);

  @override
  String encode() => 'game:$gameId';

  @override
  List<Object?> get props => [gameId];
}

class TrainingSessionLinkTarget extends ActivityLinkTarget {
  final String trainingSessionId;

  const TrainingSessionLinkTarget(this.trainingSessionId);

  @override
  String encode() => 'training:$trainingSessionId';

  @override
  List<Object?> get props => [trainingSessionId];
}

class ChampionshipMatchLinkTarget extends ActivityLinkTarget {
  final String championshipId;
  final String matchId;

  const ChampionshipMatchLinkTarget({
    required this.championshipId,
    required this.matchId,
  });

  @override
  String encode() => 'championshipMatch:$championshipId:$matchId';

  @override
  List<Object?> get props => [championshipId, matchId];
}
