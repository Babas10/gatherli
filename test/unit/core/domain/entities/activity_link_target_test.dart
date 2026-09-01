// Validates ActivityLinkTarget's encode()/decode() round-trip for all
// subtypes, and that decode() rejects malformed/unrecognized input.
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';

void main() {
  group('ActivityLinkTarget', () {
    group('GameLinkTarget', () {
      test('encode/decode round-trip', () {
        const target = GameLinkTarget('game-123');
        final encoded = target.encode();

        expect(encoded, 'game:game-123');
        expect(ActivityLinkTarget.decode(encoded), target);
      });
    });

    group('TrainingSessionLinkTarget', () {
      test('encode/decode round-trip', () {
        const target = TrainingSessionLinkTarget('session-456');
        final encoded = target.encode();

        expect(encoded, 'training:session-456');
        expect(ActivityLinkTarget.decode(encoded), target);
      });
    });

    group('ChampionshipLinkTarget', () {
      test('encode/decode round-trip', () {
        const target = ChampionshipLinkTarget('champ-1');
        final encoded = target.encode();

        expect(encoded, 'championship:champ-1');
        expect(ActivityLinkTarget.decode(encoded), target);
      });
    });

    group('ChampionshipMatchLinkTarget', () {
      test('encode/decode round-trip', () {
        const target = ChampionshipMatchLinkTarget(
          championshipId: 'champ-1',
          matchId: 'match-2',
        );
        final encoded = target.encode();

        expect(encoded, 'championshipMatch:champ-1:match-2');
        expect(ActivityLinkTarget.decode(encoded), target);
      });
    });

    group('decode — malformed/unrecognized input', () {
      test('returns null for an empty string', () {
        expect(ActivityLinkTarget.decode(''), isNull);
      });

      test('returns null for an unknown type tag', () {
        expect(ActivityLinkTarget.decode('unknown:abc'), isNull);
      });

      test('returns null for game: with missing id', () {
        expect(ActivityLinkTarget.decode('game:'), isNull);
      });

      test('returns null for game: with too many parts', () {
        expect(ActivityLinkTarget.decode('game:abc:def'), isNull);
      });

      test('returns null for training: with missing id', () {
        expect(ActivityLinkTarget.decode('training:'), isNull);
      });

      test('returns null for championship: with missing id', () {
        expect(ActivityLinkTarget.decode('championship:'), isNull);
      });

      test('returns null for championship: with too many parts', () {
        expect(ActivityLinkTarget.decode('championship:abc:def'), isNull);
      });

      test('returns null for championshipMatch: with too few parts', () {
        expect(ActivityLinkTarget.decode('championshipMatch:champ-1'), isNull);
      });

      test('returns null for championshipMatch: with an empty id', () {
        expect(ActivityLinkTarget.decode('championshipMatch:champ-1:'), isNull);
        expect(ActivityLinkTarget.decode('championshipMatch::match-1'), isNull);
      });
    });

    group('equality', () {
      test('two GameLinkTargets with the same id are equal', () {
        expect(const GameLinkTarget('g1'), const GameLinkTarget('g1'));
      });

      test('a GameLinkTarget and a TrainingSessionLinkTarget with the same id are not equal', () {
        expect(
          const GameLinkTarget('same-id'),
          isNot(const TrainingSessionLinkTarget('same-id')),
        );
      });
    });
  });
}
