// Stores and retrieves a pending shareable-activity-link target (encoded via
// ActivityLinkTarget.encode()) using SharedPreferences. Mirrors
// PendingInviteStorage's shape but is kept separate since the two concepts
// (invite token vs. activity link target) are handled independently
// throughout the deep-link pipeline.
import 'package:shared_preferences/shared_preferences.dart';

class PendingActivityLinkStorage {
  static const String _key = 'pending_activity_link';
  static const String _consumedKey = 'consumed_activity_link';

  final SharedPreferences _prefs;

  PendingActivityLinkStorage({required SharedPreferences prefs})
    : _prefs = prefs;

  Future<void> store(String encoded) async {
    await _prefs.setString(_key, encoded);
  }

  Future<String?> retrieve() async {
    return _prefs.getString(_key);
  }

  Future<void> clear() async {
    await _prefs.remove(_key);
  }

  /// Mark an encoded target as consumed so it won't be re-processed on hot restart.
  Future<void> markConsumed(String encoded) async {
    await _prefs.setString(_consumedKey, encoded);
  }

  /// Check if an encoded target has already been consumed.
  bool isConsumed(String encoded) {
    return _prefs.getString(_consumedKey) == encoded;
  }
}
