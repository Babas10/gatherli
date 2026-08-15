// Feature flag service — gate features behind Firestore-controlled flags.
// Disabling a flag hides the feature without an app release.
//
// Flag document: /config/feature_flags (Firestore)
// Default: all flags are ENABLED if the document or field doesn't exist.
//
// Usage:
//   if (await FeatureFlags.isEnabled(FeatureFlags.scoreEntry)) { ... }
import 'package:cloud_firestore/cloud_firestore.dart';

class FeatureFlags {
  FeatureFlags._();

  // ── Known flag names ─────────────────────────────────────────────────────
  // Add new flags here when gating a feature. Never use raw strings inline.
  static const String scoreEntry              = 'score_entry_enabled';
  static const String championshipRegistration= 'championship_registration_enabled';
  static const String pickupGameCreation      = 'pickup_game_creation_enabled';
  static const String trainingFeedback        = 'training_feedback_enabled';
  static const String friendRequests          = 'friend_requests_enabled';

  // ── Internal ─────────────────────────────────────────────────────────────
  static final _collection = FirebaseFirestore.instance.collection('config');
  static const _doc = 'feature_flags';

  static Map<String, bool>? _cache;

  /// Returns true if [flag] is enabled.
  /// Defaults to true if the document or flag field does not exist.
  static Future<bool> isEnabled(String flag) async {
    _cache ??= await _fetch();
    return _cache![flag] ?? true;
  }

  /// Force-refreshes the cache (call on app resume or after admin changes).
  static Future<void> refresh() async {
    _cache = await _fetch();
  }

  static Future<Map<String, bool>> _fetch() async {
    try {
      final doc = await _collection.doc(_doc).get();
      if (!doc.exists) return {};
      return (doc.data() ?? {}).map(
        (key, value) => MapEntry(key, value == true),
      );
    } catch (_) {
      // If Firestore is unreachable, default all flags to enabled.
      return {};
    }
  }
}
