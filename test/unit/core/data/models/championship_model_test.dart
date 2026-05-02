// Unit tests for championship Dart models: serialisation, equality, and
// MatchSetScore.isValid({required bool isDeciderSet}) validation logic.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/data/models/championship_model.dart';

void main() {
  final now = DateTime(2026, 6, 1, 12, 0);
  final deadline = DateTime(2026, 12, 31, 23, 59);

  // ──────────────────────────────────────────────────────────────────────────
  // MatchSetScore
  // ──────────────────────────────────────────────────────────────────────────

  group('MatchSetScore', () {
    group('isValid — regular set (isDeciderSet: false)', () {
      test('21-0 is valid', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 0);
        expect(s.isValid(isDeciderSet: false), isTrue);
      });

      test('21-19 is valid', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 19);
        expect(s.isValid(isDeciderSet: false), isTrue);
      });

      test('22-20 extended is valid', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 22, teamBPoints: 20);
        expect(s.isValid(isDeciderSet: false), isTrue);
      });

      test('25-23 extended is valid', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 25, teamBPoints: 23);
        expect(s.isValid(isDeciderSet: false), isTrue);
      });

      test('21-20 is invalid — not win by 2', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 20);
        expect(s.isValid(isDeciderSet: false), isFalse);
      });

      test('20-18 is invalid — not reached 21', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 20, teamBPoints: 18);
        expect(s.isValid(isDeciderSet: false), isFalse);
      });

      test('23-22 is invalid — leads by only 1', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 23, teamBPoints: 22);
        expect(s.isValid(isDeciderSet: false), isFalse);
      });

      test('15-0 is invalid for regular set — not reached 21', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 15, teamBPoints: 0);
        expect(s.isValid(isDeciderSet: false), isFalse);
      });
    });

    group('isValid — decider set (isDeciderSet: true)', () {
      test('15-0 is valid', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 15, teamBPoints: 0);
        expect(s.isValid(isDeciderSet: true), isTrue);
      });

      test('15-13 is valid', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 15, teamBPoints: 13);
        expect(s.isValid(isDeciderSet: true), isTrue);
      });

      test('16-14 extended is valid', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 16, teamBPoints: 14);
        expect(s.isValid(isDeciderSet: true), isTrue);
      });

      test('18-16 extended is valid', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 18, teamBPoints: 16);
        expect(s.isValid(isDeciderSet: true), isTrue);
      });

      test('15-14 is invalid — not win by 2', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 15, teamBPoints: 14);
        expect(s.isValid(isDeciderSet: true), isFalse);
      });

      test('14-12 is invalid — not reached 15', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 14, teamBPoints: 12);
        expect(s.isValid(isDeciderSet: true), isFalse);
      });

      test('16-15 is invalid — leads by only 1', () {
        final s = MatchSetScore(setNumber: 3, teamAPoints: 16, teamBPoints: 15);
        expect(s.isValid(isDeciderSet: true), isFalse);
      });

      test('21-19 is valid for decider (reached 15, leads by 2)', () {
        // Extended decider can go past 15 as long as win-by-2 holds
        final s = MatchSetScore(setNumber: 3, teamAPoints: 21, teamBPoints: 19);
        expect(s.isValid(isDeciderSet: true), isTrue);
      });
    });

    group('winner', () {
      test('returns teamA when teamA has more points', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 15);
        expect(s.winner, 'teamA');
      });

      test('returns teamB when teamB has more points', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 10, teamBPoints: 21);
        expect(s.winner, 'teamB');
      });

      test('returns null when points are equal', () {
        final s = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 21);
        expect(s.winner, isNull);
      });
    });

    group('JSON serialisation', () {
      test('toJson / fromJson round-trip', () {
        final s = MatchSetScore(setNumber: 2, teamAPoints: 21, teamBPoints: 17);
        final restored = MatchSetScore.fromJson(s.toJson());
        expect(restored, s);
      });
    });

    group('equality', () {
      test('identical sets are equal', () {
        final a = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 19);
        final b = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 19);
        expect(a, b);
        expect(a.hashCode, b.hashCode);
      });

      test('sets with different points are not equal', () {
        final a = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 19);
        final b = MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 15);
        expect(a, isNot(b));
      });
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // MatchResult
  // ──────────────────────────────────────────────────────────────────────────

  group('MatchResult', () {
    group('isValid', () {
      test('valid 2-0 result', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 15),
            MatchSetScore(setNumber: 2, teamAPoints: 21, teamBPoints: 18),
          ],
          winner: 'teamA',
        );
        expect(r.isValid(), isTrue);
      });

      test('valid 2-1 result with decider set to 15', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 19),
            MatchSetScore(setNumber: 2, teamAPoints: 18, teamBPoints: 21),
            MatchSetScore(setNumber: 3, teamAPoints: 15, teamBPoints: 12),
          ],
          winner: 'teamA',
        );
        expect(r.isValid(), isTrue);
      });

      test('valid 0-2 result for teamB', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 15, teamBPoints: 21),
            MatchSetScore(setNumber: 2, teamAPoints: 18, teamBPoints: 21),
          ],
          winner: 'teamB',
        );
        expect(r.isValid(), isTrue);
      });

      test('invalid — empty sets', () {
        final r = MatchResult(sets: [], winner: 'teamA');
        expect(r.isValid(), isFalse);
      });

      test('invalid — winner does not match set wins', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 15),
            MatchSetScore(setNumber: 2, teamAPoints: 21, teamBPoints: 18),
          ],
          winner: 'teamB', // teamA won both sets
        );
        expect(r.isValid(), isFalse);
      });

      test('invalid — decider set score wrong (15-14 not win by 2)', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 19),
            MatchSetScore(setNumber: 2, teamAPoints: 18, teamBPoints: 21),
            MatchSetScore(setNumber: 3, teamAPoints: 15, teamBPoints: 14),
          ],
          winner: 'teamA',
        );
        expect(r.isValid(), isFalse);
      });

      test('invalid — regular set score wrong (21-20 not win by 2)', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 20),
            MatchSetScore(setNumber: 2, teamAPoints: 21, teamBPoints: 18),
          ],
          winner: 'teamA',
        );
        expect(r.isValid(), isFalse);
      });
    });

    group('JSON serialisation', () {
      test('toJson / fromJson round-trip', () {
        final r = MatchResult(
          sets: [
            MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 15),
            MatchSetScore(setNumber: 2, teamAPoints: 21, teamBPoints: 18),
          ],
          winner: 'teamA',
        );
        final restored = MatchResult.fromJson(r.toJson());
        expect(restored, r);
      });
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // AdminDecision
  // ──────────────────────────────────────────────────────────────────────────

  group('AdminDecision', () {
    test('JSON serialisation round-trip with Timestamp', () {
      final d = AdminDecision(
        adminId: 'admin-1',
        winner: 'teamB',
        reason: 'Team A forfeited',
        decidedAt: now,
      );
      final json = d.toJson();
      final restored = AdminDecision.fromJson(json);
      expect(restored.adminId, d.adminId);
      expect(restored.winner, d.winner);
      expect(restored.reason, d.reason);
      expect(restored.decidedAt, d.decidedAt);
    });

    test('equality', () {
      final a = AdminDecision(
        adminId: 'admin-1',
        winner: 'teamA',
        reason: 'No show',
        decidedAt: now,
      );
      final b = AdminDecision(
        adminId: 'admin-1',
        winner: 'teamA',
        reason: 'No show',
        decidedAt: now,
      );
      expect(a, b);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ChampionshipModel
  // ──────────────────────────────────────────────────────────────────────────

  group('ChampionshipModel', () {
    ChampionshipModel buildModel({String? id, List<String>? adminIds}) =>
        ChampionshipModel(
          id: id ?? 'champ-1',
          title: 'Summer Open 2026',
          createdBy: 'user-1',
          createdAt: now,
          registrationDeadline: deadline,
          totalRounds: 9,
          adminIds: adminIds ?? ['user-1'],
        );

    test('default values', () {
      final c = buildModel();
      expect(c.status, ChampionshipStatus.registration);
      expect(c.maxTeams, 10);
      expect(c.teamSize, 2);
      expect(c.currentRound, 0);
      expect(c.country, isNull);
      expect(c.region, isNull);
      expect(c.startDate, isNull);
    });

    test('isAdmin returns true for admin user', () {
      final c = buildModel(adminIds: ['user-1', 'user-2']);
      expect(c.isAdmin('user-1'), isTrue);
      expect(c.isAdmin('user-2'), isTrue);
      expect(c.isAdmin('user-3'), isFalse);
    });

    test('JSON serialisation — Timestamp fields', () {
      final c = buildModel();
      final json = c.toJson();
      expect(json['id'], 'champ-1');
      expect(json['createdAt'], isA<Timestamp>());
      expect(json['registrationDeadline'], isA<Timestamp>());
    });

    test('toFirestore excludes id', () {
      final c = buildModel();
      final fs = c.toFirestore();
      expect(fs.containsKey('id'), isFalse);
      expect(fs['title'], 'Summer Open 2026');
    });

    test('fromJson with Timestamp', () {
      final c = buildModel();
      final json = {
        ...c.toJson(),
        'createdAt': Timestamp.fromDate(now),
        'registrationDeadline': Timestamp.fromDate(deadline),
      };
      final restored = ChampionshipModel.fromJson(json);
      expect(restored.title, c.title);
      expect(restored.createdAt, c.createdAt);
    });

    test('equality', () {
      expect(buildModel(), buildModel());
      expect(buildModel(id: 'champ-1'), isNot(buildModel(id: 'champ-2')));
    });

    test('copyWith', () {
      final c = buildModel();
      final updated = c.copyWith(status: ChampionshipStatus.active, currentRound: 1);
      expect(updated.status, ChampionshipStatus.active);
      expect(updated.currentRound, 1);
      expect(updated.title, c.title);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ChampionshipTeamModel
  // ──────────────────────────────────────────────────────────────────────────

  group('ChampionshipTeamModel', () {
    ChampionshipTeamModel buildModel() => ChampionshipTeamModel(
          id: 'team-1',
          name: 'Beach Warriors',
          captainId: 'user-1',
          memberIds: ['user-1', 'user-2'],
          createdAt: now,
        );

    test('hasMember', () {
      final t = buildModel();
      expect(t.hasMember('user-1'), isTrue);
      expect(t.hasMember('user-2'), isTrue);
      expect(t.hasMember('user-3'), isFalse);
    });

    test('toFirestore excludes id', () {
      final t = buildModel();
      final fs = t.toFirestore();
      expect(fs.containsKey('id'), isFalse);
      expect(fs['name'], 'Beach Warriors');
    });

    test('JSON round-trip', () {
      final t = buildModel();
      final restored = ChampionshipTeamModel.fromJson(t.toJson());
      expect(restored.name, t.name);
      expect(restored.captainId, t.captainId);
      expect(restored.memberIds, t.memberIds);
    });

    test('equality', () {
      expect(buildModel(), buildModel());
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ChampionshipMatchModel
  // ──────────────────────────────────────────────────────────────────────────

  group('ChampionshipMatchModel', () {
    ChampionshipMatchModel buildModel({MatchResult? result, AdminDecision? adminDecision}) =>
        ChampionshipMatchModel(
          id: 'match-1',
          round: 1,
          teamAId: 'team-1',
          teamBId: 'team-2',
          deadline: deadline,
          result: result,
          adminDecision: adminDecision,
        );

    test('default values', () {
      final m = buildModel();
      expect(m.status, MatchStatus.pending);
      expect(m.result, isNull);
      expect(m.adminDecision, isNull);
      expect(m.scheduledAt, isNull);
    });

    test('toFirestore excludes id', () {
      final m = buildModel();
      final fs = m.toFirestore();
      expect(fs.containsKey('id'), isFalse);
      expect(fs['round'], 1);
    });

    test('JSON round-trip with result', () {
      final result = MatchResult(
        sets: [
          MatchSetScore(setNumber: 1, teamAPoints: 21, teamBPoints: 15),
          MatchSetScore(setNumber: 2, teamAPoints: 21, teamBPoints: 18),
        ],
        winner: 'teamA',
      );
      final m = buildModel(result: result);
      final restored = ChampionshipMatchModel.fromJson(m.toJson());
      expect(restored.result, isNotNull);
      expect(restored.result!.winner, 'teamA');
      expect(restored.result!.sets.length, 2);
    });

    test('JSON round-trip with adminDecision', () {
      final decision = AdminDecision(
        adminId: 'admin-1',
        winner: 'teamB',
        reason: 'Forfeit',
        decidedAt: now,
      );
      final m = buildModel(adminDecision: decision);
      final restored = ChampionshipMatchModel.fromJson(m.toJson());
      expect(restored.adminDecision, isNotNull);
      expect(restored.adminDecision!.winner, 'teamB');
    });

    test('equality', () {
      expect(buildModel(), buildModel());
    });

    test('MatchStatus enum serialisation', () {
      final m = buildModel().copyWith(status: MatchStatus.adminDecided);
      final json = m.toJson();
      expect(json['status'], 'admin_decided');
      final restored = ChampionshipMatchModel.fromJson(json);
      expect(restored.status, MatchStatus.adminDecided);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ChampionshipStandingsModel
  // ──────────────────────────────────────────────────────────────────────────

  group('ChampionshipStandingsModel', () {
    ChampionshipStandingsModel buildModel({int setsWon = 0, int setsLost = 0}) =>
        ChampionshipStandingsModel(
          teamId: 'team-1',
          teamName: 'Beach Warriors',
          setsWon: setsWon,
          setsLost: setsLost,
        );

    test('default values are all zero', () {
      final s = buildModel();
      expect(s.played, 0);
      expect(s.points, 0);
      expect(s.wins20, 0);
      expect(s.wins21, 0);
      expect(s.losses12, 0);
      expect(s.losses02, 0);
      expect(s.position, 0);
    });

    test('setDifference is setsWon - setsLost', () {
      expect(buildModel(setsWon: 10, setsLost: 3).setDifference, 7);
      expect(buildModel(setsWon: 2, setsLost: 5).setDifference, -3);
    });

    test('JSON round-trip', () {
      final s = ChampionshipStandingsModel(
        teamId: 'team-1',
        teamName: 'Beach Warriors',
        played: 5,
        points: 12,
        wins20: 3,
        wins21: 1,
        losses12: 1,
        losses02: 0,
        setsWon: 8,
        setsLost: 3,
        position: 1,
      );
      final restored = ChampionshipStandingsModel.fromJson(s.toJson());
      expect(restored, s);
    });

    test('equality', () {
      expect(buildModel(), buildModel());
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ChampionshipMessageModel
  // ──────────────────────────────────────────────────────────────────────────

  group('ChampionshipMessageModel', () {
    ChampionshipMessageModel buildModel() => ChampionshipMessageModel(
          id: 'msg-1',
          senderId: 'user-1',
          senderDisplayName: 'Alice',
          teamId: 'team-1',
          text: 'See you Saturday?',
          sentAt: now,
        );

    test('toFirestore excludes id', () {
      final m = buildModel();
      final fs = m.toFirestore();
      expect(fs.containsKey('id'), isFalse);
      expect(fs['text'], 'See you Saturday?');
      expect(fs['teamId'], 'team-1');
    });

    test('JSON round-trip', () {
      final m = buildModel();
      final restored = ChampionshipMessageModel.fromJson(m.toJson());
      expect(restored.senderId, m.senderId);
      expect(restored.teamId, m.teamId);
      expect(restored.text, m.text);
    });

    test('equality', () {
      expect(buildModel(), buildModel());
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ChampionshipStatus enum serialisation
  // ──────────────────────────────────────────────────────────────────────────

  group('ChampionshipStatus enum', () {
    test('serialises to correct string values', () {
      final c = ChampionshipModel(
        id: 'c',
        title: 'T',
        createdBy: 'u',
        createdAt: now,
        registrationDeadline: deadline,
        totalRounds: 9,
        status: ChampionshipStatus.active,
      );
      expect(c.toJson()['status'], 'active');
    });

    test('deserialises completed status', () {
      final json = {
        'id': 'c',
        'title': 'T',
        'createdBy': 'u',
        'createdAt': Timestamp.fromDate(now),
        'registrationDeadline': Timestamp.fromDate(deadline),
        'totalRounds': 9,
        'status': 'completed',
        'adminIds': <String>[],
        'maxTeams': 10,
        'teamSize': 2,
        'currentRound': 0,
      };
      final c = ChampionshipModel.fromJson(json);
      expect(c.status, ChampionshipStatus.completed);
    });
  });
}
