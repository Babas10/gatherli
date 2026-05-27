// Validates MatchSetScore.isValid for regular sets (to 21) and the decider set (to 15).
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';

void main() {
  group('MatchSetScore.isValid', () {
    // ── Regular set (isDeciderSet: false) ──────────────────────────────────

    group('regular set (to 21)', () {
      test('21-0 is valid', () {
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 0, setNumber: 1)
              .isValid(isDeciderSet: false),
          isTrue,
        );
      });

      test('21-19 is valid', () {
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 19, setNumber: 1)
              .isValid(isDeciderSet: false),
          isTrue,
        );
      });

      test('23-21 is valid (extended play)', () {
        expect(
          const MatchSetScore(teamAPoints: 23, teamBPoints: 21, setNumber: 1)
              .isValid(isDeciderSet: false),
          isTrue,
        );
      });

      test('25-23 is valid (extended play)', () {
        expect(
          const MatchSetScore(teamAPoints: 25, teamBPoints: 23, setNumber: 1)
              .isValid(isDeciderSet: false),
          isTrue,
        );
      });

      test('20-18 is invalid (target not reached)', () {
        expect(
          const MatchSetScore(teamAPoints: 20, teamBPoints: 18, setNumber: 1)
              .isValid(isDeciderSet: false),
          isFalse,
        );
      });

      test('21-20 is invalid (not 2-point lead)', () {
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 20, setNumber: 1)
              .isValid(isDeciderSet: false),
          isFalse,
        );
      });

      test('22-19 is invalid (3-point gap at extended play)', () {
        expect(
          const MatchSetScore(teamAPoints: 22, teamBPoints: 19, setNumber: 2)
              .isValid(isDeciderSet: false),
          isFalse,
        );
      });

      test('0-21 is valid (teamB wins)', () {
        expect(
          const MatchSetScore(teamAPoints: 0, teamBPoints: 21, setNumber: 2)
              .isValid(isDeciderSet: false),
          isTrue,
        );
      });
    });

    // ── Decider set (isDeciderSet: true) ──────────────────────────────────

    group('decider set (to 15)', () {
      test('15-0 is valid', () {
        expect(
          const MatchSetScore(teamAPoints: 15, teamBPoints: 0, setNumber: 3)
              .isValid(isDeciderSet: true),
          isTrue,
        );
      });

      test('15-13 is valid', () {
        expect(
          const MatchSetScore(teamAPoints: 15, teamBPoints: 13, setNumber: 3)
              .isValid(isDeciderSet: true),
          isTrue,
        );
      });

      test('16-14 is valid (extended play)', () {
        expect(
          const MatchSetScore(teamAPoints: 16, teamBPoints: 14, setNumber: 3)
              .isValid(isDeciderSet: true),
          isTrue,
        );
      });

      test('14-12 is invalid (target not reached)', () {
        expect(
          const MatchSetScore(teamAPoints: 14, teamBPoints: 12, setNumber: 3)
              .isValid(isDeciderSet: true),
          isFalse,
        );
      });

      test('15-14 is invalid (not 2-point lead)', () {
        expect(
          const MatchSetScore(teamAPoints: 15, teamBPoints: 14, setNumber: 3)
              .isValid(isDeciderSet: true),
          isFalse,
        );
      });

      test('16-13 is invalid (3-point gap at extended play)', () {
        expect(
          const MatchSetScore(teamAPoints: 16, teamBPoints: 13, setNumber: 3)
              .isValid(isDeciderSet: true),
          isFalse,
        );
      });

      test('21-0 in decider is invalid (gap is not 2)', () {
        // 21 > 15 so falls into extended-play rule: 21 - 0 = 21 ≠ 2 → invalid
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 0, setNumber: 3)
              .isValid(isDeciderSet: true),
          isFalse,
        );
      });

      test('21-19 in decider is valid (extended play applies)', () {
        // No upper cap in decider — keep playing until 2-point lead
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 19, setNumber: 3)
              .isValid(isDeciderSet: true),
          isTrue,
        );
      });

      test('0-15 is valid (teamB wins decider)', () {
        expect(
          const MatchSetScore(teamAPoints: 0, teamBPoints: 15, setNumber: 3)
              .isValid(isDeciderSet: true),
          isTrue,
        );
      });
    });

    // ── winner helper ──────────────────────────────────────────────────────

    group('winner()', () {
      test('returns teamA when teamA wins regular set', () {
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 15, setNumber: 1)
              .winner(isDeciderSet: false),
          'teamA',
        );
      });

      test('returns teamB when teamB wins decider', () {
        expect(
          const MatchSetScore(teamAPoints: 13, teamBPoints: 15, setNumber: 3)
              .winner(isDeciderSet: true),
          'teamB',
        );
      });

      test('returns null for invalid score', () {
        expect(
          const MatchSetScore(teamAPoints: 21, teamBPoints: 20, setNumber: 1)
              .winner(isDeciderSet: false),
          isNull,
        );
      });
    });
  });
}
