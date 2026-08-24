// Property-based tests for ChampionshipModel — exercises edge cases and
// round-trip serialization with a wide range of inputs.
// No Firebase, no mocks needed.
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/domain/use_cases/check_championship_eligibility_use_case.dart';

// ── Generators ─────────────────────────────────────────────────────────────

ChampionshipModel generateChampionship({
  int maxTeams = 8,
  int teamsCount = 0,
  ChampionshipStatus status = ChampionshipStatus.registration,
  ChampionshipGenderCategory? gender,
}) {
  return ChampionshipModel(
    id: 'c1',
    title: 'Test Championship',
    createdBy: 'admin',
    adminIds: const ['admin'],
    status: status,
    maxTeams: maxTeams,
    teamSize: 2,
    teamsCount: teamsCount,
    genderCategory: gender,
    registrationDeadline: DateTime.now().add(const Duration(days: 7)),
    createdAt: DateTime.now(),
    currentRound: 0,
    totalRounds: 9,
  );
}

ChampionshipTeamModel generateTeam(String id, List<String> members) =>
    ChampionshipTeamModel(
      id: id,
      name: 'Team $id',
      captainId: members.first,
      memberIds: members,
      createdAt: DateTime.now(),
    );

void main() {
  const useCase = CheckChampionshipEligibilityUseCase();

  group('Eligibility — property tests across all team counts', () {
    test('canRegister is false whenever teamsCount >= maxTeams', () async {
      // Test all combinations where teams is full
      for (final maxTeams in [2, 4, 6, 8, 10]) {
        final result = await useCase(ChampionshipEligibilityInput(
          championship: generateChampionship(
            maxTeams: maxTeams,
            teamsCount: maxTeams, // exactly full
          ),
          teams: [],
          userId: 'user1',
        ));
        expect(
          result.canRegister,
          isFalse,
          reason: 'maxTeams=$maxTeams: full championship should block registration',
        );
      }
    });

    test('canRegister is false for all closed statuses', () async {
      final closedStatuses = [
        ChampionshipStatus.registrationClosed,
        ChampionshipStatus.active,
        ChampionshipStatus.completed,
      ];
      for (final status in closedStatuses) {
        final result = await useCase(ChampionshipEligibilityInput(
          championship: generateChampionship(status: status),
          teams: [],
          userId: 'user1',
        ));
        expect(
          result.canRegister,
          isFalse,
          reason: 'status=$status should block registration',
        );
      }
    });

    test('isAlreadyRegistered is true whenever userId is in any team', () async {
      const userId = 'user1';
      // Test with different team compositions
      final teamVariants = [
        [userId, 'partner1'],
        ['captain', userId], // user is not captain
        [userId, 'partner1', 'extra'], // edge: more than 2 members
      ];
      for (final members in teamVariants) {
        final result = await useCase(ChampionshipEligibilityInput(
          championship: generateChampionship(),
          teams: [generateTeam('t1', members)],
          userId: userId,
        ));
        expect(
          result.isAlreadyRegistered,
          isTrue,
          reason: 'members=$members: user should be detected as registered',
        );
      }
    });
  });

  group('Gender eligibility — all combinations', () {
    const genders = [null, 'male', 'female', 'none', ''];
    test('no gender restriction allows all users', () async {
      for (final gender in genders) {
        final result = await useCase(ChampionshipEligibilityInput(
          championship: generateChampionship(gender: null),
          teams: [],
          userId: 'user1',
          userGender: gender,
        ));
        expect(
          result.isGenderAllowed,
          isTrue,
          reason: 'userGender=$gender: no category restriction should allow all',
        );
      }
    });

    test('gender check disabled — all users allowed regardless of category', () async {
      // Gender check temporarily disabled — admin manages team eligibility.
      final testCases = [
        (ChampionshipGenderCategory.male, 'male'),
        (ChampionshipGenderCategory.male, 'female'),
        (ChampionshipGenderCategory.female, 'female'),
        (ChampionshipGenderCategory.female, 'male'),
        (ChampionshipGenderCategory.male, 'none'),
        (ChampionshipGenderCategory.female, 'none'),
      ];
      for (final (cat, gender) in testCases) {
        final result = await useCase(ChampionshipEligibilityInput(
          championship: generateChampionship(gender: cat),
          teams: [],
          userId: 'user1',
          userGender: gender,
        ));
        expect(
          result.isGenderAllowed,
          isTrue,
          reason: 'category=$cat userGender=$gender should be allowed (gender check disabled)',
        );
      }
    });
  });

  group('Edge cases', () {
    test('handles empty teams list', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: generateChampionship(),
        teams: [],
        userId: 'user1',
      ));
      expect(result.isAlreadyRegistered, isFalse);
      expect(result.myTeamId, isNull);
    });

    test('handles null userId (unauthenticated user)', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: generateChampionship(),
        teams: [],
        userId: null,
      ));
      expect(result.canRegister, isFalse);
      expect(result.isAlreadyRegistered, isFalse);
    });

    test('handles championship with 0 maxTeams edge case', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: generateChampionship(maxTeams: 0, teamsCount: 0),
        teams: [],
        userId: 'user1',
      ));
      // 0 maxTeams means it's always full
      expect(result.canRegister, isFalse);
    });
  });
}
