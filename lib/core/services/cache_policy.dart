// Data freshness policy — defines how long each data type stays valid in cache.
// When offline, Firestore automatically serves cached data. This class documents
// the intended TTL for each collection so engineers understand the trade-offs.
//
// Firestore offline persistence is enabled by default (unlimited cache size set
// in main_common.dart). This policy defines the LOGICAL freshness expectation,
// not a hard eviction — Firestore manages actual cache eviction internally.

class CachePolicy {
  CachePolicy._();

  // ── Collection freshness expectations ─────────────────────────────────────
  // These are guidelines for engineers, not technical limits.
  // Shorter TTL = more Firestore reads. Longer TTL = more stale data risk.

  /// Championship list — changes when new championships are created.
  /// Acceptable to show 5-minute-old data.
  static const Duration championships = Duration(minutes: 5);

  /// Group list — changes when user joins/leaves groups.
  /// Acceptable to show 10-minute-old data.
  static const Duration groups = Duration(minutes: 10);

  /// User profile — changes infrequently.
  /// Acceptable to show data until logout.
  static const Duration userProfile = Duration(hours: 24);

  /// Game list — changes when games are created or updated.
  /// Show relatively fresh data (2 minutes).
  static const Duration games = Duration(minutes: 2);

  /// Match detail — changes frequently (schedule, result, chat).
  /// Always fetch live when online; show cache offline.
  static const Duration matchDetail = Duration(minutes: 1);

  /// Standings — updated after each match result verification.
  /// Show live when online; cache is acceptable offline.
  static const Duration standings = Duration(minutes: 2);
}
