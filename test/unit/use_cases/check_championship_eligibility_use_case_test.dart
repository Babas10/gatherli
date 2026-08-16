// Unit tests for CheckChampionshipEligibilityUseCase — no Firebase, no mocks.
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/domain/use_cases/check_championship_eligibility_use_case.dart';

void main() {
  const useCase = CheckChampionshipEligibilityUseCase();

  ChampionshipModel makeChampionship({
    ChampionshipGenderCategory? gender,
    ChampionshipStatus status = ChampionshipStatus.registration,
    int maxTeams = 8,
    int teamsCount = 3,
  }) {
    return ChampionshipModel(
      id: 'c1',
      title: 'Test Championship',
      createdBy: 'admin1',
      adminIds: const ['admin1'],
      status: status,
      genderCategory: gender,
      maxTeams: maxTeams,
      teamSize: 2,
      teamsCount: teamsCount,
      registrationDeadline: DateTime.now().add(const Duration(days: 7)),
      createdAt: DateTime.now(),
      currentRound: 0,
      totalRounds: 0,
    );
  }

  ChampionshipTeamModel makeTeam(String id, List<String> memberIds) =>
      ChampionshipTeamModel(id: id, name: 'Team $id', memberIds: memberIds, captainId: memberIds.first, createdAt: DateTime.now());

  group('canRegister', () {
    test('allows registration when open and eligible', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(),
        teams: [],
        userId: 'user1',
        userGender: null,
      ));
      expect(result.canRegister, isTrue);
    });

    test('blocks when already registered', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(),
        teams: [makeTeam('t1', ['user1', 'user2'])],
        userId: 'user1',
      ));
      expect(result.canRegister, isFalse);
      expect(result.isAlreadyRegistered, isTrue);
    });

    test('blocks when championship is not in registration phase', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(status: ChampionshipStatus.active),
        teams: [],
        userId: 'user1',
      ));
      expect(result.canRegister, isFalse);
    });

    test('blocks when full (teamsCount == maxTeams)', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(maxTeams: 4, teamsCount: 4),
        teams: [],
        userId: 'user1',
      ));
      expect(result.canRegister, isFalse);
    });
  });

  group('gender eligibility', () {
    test('allows registration when no gender restriction', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(gender: null),
        teams: [],
        userId: 'user1',
        userGender: 'male',
      ));
      expect(result.isGenderAllowed, isTrue);
    });

    test('blocks male user from female championship', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(gender: ChampionshipGenderCategory.female),
        teams: [],
        userId: 'user1',
        userGender: 'male',
      ));
      expect(result.isGenderAllowed, isFalse);
      expect(result.genderBlockReason, isNotNull);
    });

    test('blocks user with no gender set', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(gender: ChampionshipGenderCategory.male),
        teams: [],
        userId: 'user1',
        userGender: 'none',
      ));
      expect(result.isGenderAllowed, isFalse);
    });

    test('allows female user into female championship', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(gender: ChampionshipGenderCategory.female),
        teams: [],
        userId: 'user1',
        userGender: 'female',
      ));
      expect(result.isGenderAllowed, isTrue);
    });
  });

  group('myTeamId', () {
    test('returns team id when user is registered', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(),
        teams: [makeTeam('team-abc', ['user1', 'user2'])],
        userId: 'user1',
      ));
      expect(result.myTeamId, equals('team-abc'));
    });

    test('returns null when user is not registered', () async {
      final result = await useCase(ChampionshipEligibilityInput(
        championship: makeChampionship(),
        teams: [makeTeam('team-abc', ['user2', 'user3'])],
        userId: 'user1',
      ));
      expect(result.myTeamId, isNull);
    });
  });
}
