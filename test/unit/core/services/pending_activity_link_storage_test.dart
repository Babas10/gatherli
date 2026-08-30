// Validates PendingActivityLinkStorage stores, retrieves, clears, and tracks
// consumption of encoded activity-link targets correctly.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:play_with_me/core/services/pending_activity_link_storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late PendingActivityLinkStorage storage;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    storage = PendingActivityLinkStorage(prefs: mockPrefs);
  });

  group('PendingActivityLinkStorage', () {
    const testEncoded = 'game:abc123';
    const key = 'pending_activity_link';
    const consumedKey = 'consumed_activity_link';

    group('store', () {
      test('stores encoded target in SharedPreferences', () async {
        when(
          () => mockPrefs.setString(key, testEncoded),
        ).thenAnswer((_) async => true);

        await storage.store(testEncoded);

        verify(() => mockPrefs.setString(key, testEncoded)).called(1);
      });
    });

    group('retrieve', () {
      test('returns stored encoded target when one exists', () async {
        when(() => mockPrefs.getString(key)).thenReturn(testEncoded);

        final result = await storage.retrieve();

        expect(result, testEncoded);
        verify(() => mockPrefs.getString(key)).called(1);
      });

      test('returns null when nothing is stored', () async {
        when(() => mockPrefs.getString(key)).thenReturn(null);

        final result = await storage.retrieve();

        expect(result, isNull);
      });
    });

    group('clear', () {
      test('removes encoded target from SharedPreferences', () async {
        when(() => mockPrefs.remove(key)).thenAnswer((_) async => true);

        await storage.clear();

        verify(() => mockPrefs.remove(key)).called(1);
      });
    });

    group('markConsumed / isConsumed', () {
      test('markConsumed stores the encoded target under the consumed key', () async {
        when(
          () => mockPrefs.setString(consumedKey, testEncoded),
        ).thenAnswer((_) async => true);

        await storage.markConsumed(testEncoded);

        verify(() => mockPrefs.setString(consumedKey, testEncoded)).called(1);
      });

      test('isConsumed returns true when the target matches the consumed key', () {
        when(() => mockPrefs.getString(consumedKey)).thenReturn(testEncoded);

        expect(storage.isConsumed(testEncoded), isTrue);
      });

      test('isConsumed returns false when the target does not match', () {
        when(() => mockPrefs.getString(consumedKey)).thenReturn('training:other');

        expect(storage.isConsumed(testEncoded), isFalse);
      });

      test('isConsumed returns false when nothing has been consumed', () {
        when(() => mockPrefs.getString(consumedKey)).thenReturn(null);

        expect(storage.isConsumed(testEncoded), isFalse);
      });
    });
  });
}
