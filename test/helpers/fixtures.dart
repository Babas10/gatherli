// Model factories with sensible defaults for use across all test files.
//
// Each factory accepts named overrides so tests only specify what matters:
//   makeChampionship(title: 'Finals', status: ChampionshipStatus.active)
//   makeUser(uid: 'u1', displayName: 'Alice')
//   makeGame(id: 'g1', groupId: 'grp-1')
//   makeGroup(id: 'grp-1', name: 'Beach Volleyball')

import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/data/models/group_model.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_message_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

// ─── Championship ─────────────────────────────────────────────────────────────

ChampionshipModel makeChampionship({
  String id = 'c1',
  String title = 'Test Championship',
  ChampionshipStatus status = ChampionshipStatus.registration,
  int teamsCount = 0,
  int maxTeams = 10,
  int currentRound = 0,
  int totalRounds = 9,
  String createdBy = 'admin-uid',
  DateTime? createdAt,
  DateTime? registrationDeadline,
  DateTime? startDate,
  String? country,
  String? region,
  ChampionshipGenderCategory? genderCategory,
  List<String> adminIds = const [],
}) {
  return ChampionshipModel(
    id: id,
    title: title,
    status: status,
    teamsCount: teamsCount,
    maxTeams: maxTeams,
    currentRound: currentRound,
    totalRounds: totalRounds,
    createdBy: createdBy,
    adminIds: adminIds,
    createdAt: createdAt ?? DateTime(2026, 1, 1),
    registrationDeadline:
        registrationDeadline ?? DateTime.now().add(const Duration(days: 30)),
    startDate: startDate,
    country: country,
    region: region,
    genderCategory: genderCategory,
  );
}

ChampionshipTeamModel makeTeam({
  String id = 't1',
  String name = 'Team Alpha',
  String captainId = 'user-1',
  List<String>? memberIds,
  DateTime? createdAt,
}) {
  return ChampionshipTeamModel(
    id: id,
    name: name,
    captainId: captainId,
    memberIds: memberIds ?? [captainId, 'user-2'],
    createdAt: createdAt ?? DateTime(2026, 2, 1),
  );
}

ChampionshipMatchModel makeMatch({
  String id = 'm1',
  int round = 1,
  String teamAId = 't1',
  String teamBId = 't2',
  ChampionshipMatchStatus status = ChampionshipMatchStatus.pending,
  DateTime? deadline,
  MatchResult? result,
  String? submittedByTeamId,
}) {
  return ChampionshipMatchModel(
    id: id,
    round: round,
    teamAId: teamAId,
    teamBId: teamBId,
    status: status,
    deadline: deadline ?? DateTime.now().add(const Duration(days: 21)),
    result: result,
    submittedByTeamId: submittedByTeamId,
  );
}

ChampionshipStandingsModel makeStandings({
  String teamId = 't1',
  String teamName = 'Team Alpha',
  int position = 1,
  int played = 0,
  int points = 0,
  int wins20 = 0,
  int wins21 = 0,
  int losses12 = 0,
  int losses02 = 0,
  int setsWon = 0,
  int setsLost = 0,
}) {
  return ChampionshipStandingsModel(
    teamId: teamId,
    teamName: teamName,
    position: position,
    played: played,
    points: points,
    wins20: wins20,
    wins21: wins21,
    losses12: losses12,
    losses02: losses02,
    setsWon: setsWon,
    setsLost: setsLost,
  );
}

ChampionshipMessageModel makeMessage({
  String id = 'msg1',
  String senderId = 'user-1',
  String senderDisplayName = 'Alice',
  String text = 'Hello',
  String? teamId,
  DateTime? sentAt,
}) {
  return ChampionshipMessageModel(
    id: id,
    senderId: senderId,
    senderDisplayName: senderDisplayName,
    text: text,
    teamId: teamId,
    sentAt: sentAt ?? DateTime(2026, 3, 1, 12, 0),
  );
}

// ─── User ─────────────────────────────────────────────────────────────────────

UserEntity makeUserEntity({
  String uid = 'user-1',
  String email = 'user@test.com',
  String? displayName = 'Test User',
  String? photoUrl,
  bool isEmailVerified = true,
  int friendCount = 0,
}) {
  return UserEntity(
    uid: uid,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    isEmailVerified: isEmailVerified,
    friendCount: friendCount,
  );
}

UserModel makeUserModel({
  String uid = 'user-1',
  String email = 'user@test.com',
  String? displayName = 'Test User',
  String? photoUrl,
  bool isEmailVerified = true,
}) {
  return UserModel(
    uid: uid,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    isEmailVerified: isEmailVerified,
  );
}

// ─── Group ────────────────────────────────────────────────────────────────────

GroupModel makeGroup({
  String id = 'grp-1',
  String name = 'Test Group',
  String? description,
  String createdBy = 'user-1',
  DateTime? createdAt,
  List<String> memberIds = const ['user-1'],
  List<String> adminIds = const ['user-1'],
}) {
  return GroupModel(
    id: id,
    name: name,
    description: description,
    createdBy: createdBy,
    createdAt: createdAt ?? DateTime(2026, 1, 1),
    memberIds: memberIds,
    adminIds: adminIds,
  );
}

// ─── Game ─────────────────────────────────────────────────────────────────────

GameModel makeGame({
  String id = 'game-1',
  String title = 'Test Game',
  String? groupId = 'grp-1',
  String createdBy = 'user-1',
  DateTime? createdAt,
  DateTime? scheduledAt,
  GameStatus status = GameStatus.scheduled,
  int maxPlayers = 4,
  int minPlayers = 2,
  List<String> playerIds = const [],
  String? description,
}) {
  return GameModel(
    id: id,
    title: title,
    groupId: groupId,
    createdBy: createdBy,
    createdAt: createdAt ?? DateTime(2026, 1, 1),
    scheduledAt: scheduledAt ?? DateTime(2026, 6, 1, 14, 0),
    location: const GameLocation(name: 'Test Court'),
    status: status,
    maxPlayers: maxPlayers,
    minPlayers: minPlayers,
    playerIds: playerIds,
    description: description,
  );
}
