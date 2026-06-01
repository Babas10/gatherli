import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_message_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

/// Repository for championship data.
/// Championships are independent of Groups — read access is public for authenticated users.
/// All writes go through Cloud Functions.
abstract class ChampionshipRepository {
  /// Real-time stream of championships in `registration` status.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipModel>> getOpenChampionships();

  /// Real-time stream of all championships ordered by createdAt descending.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipModel>> getChampionships();

  /// Real-time stream of a single championship by ID.
  /// Throws [ChampionshipException] on error or if not found.
  Stream<ChampionshipModel> getChampionshipById(String championshipId);

  /// Real-time stream of standings for [championshipId], ordered by position ascending.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipStandingsModel>> getStandings(String championshipId);

  /// Real-time stream of all registered teams for [championshipId], ordered by createdAt ascending.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipTeamModel>> getTeams(String championshipId);

  /// Real-time stream of matches for [round] in [championshipId].
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipMatchModel>> getMatchesForRound({
    required String championshipId,
    required int round,
  });

  /// Returns the team the [userId] belongs to in [championshipId], or null if none.
  /// Throws [ChampionshipException] on error.
  Future<ChampionshipTeamModel?> getMyTeam({
    required String championshipId,
    required String userId,
  });

  /// Creates a team via Cloud Function.
  /// Returns the new team ID.
  /// Throws [ChampionshipException] on error.
  Future<String> createTeam({
    required String championshipId,
    required String teamName,
    required String partnerId,
  });

  /// Deletes a team via Cloud Function (registration phase only).
  /// Throws [ChampionshipException] on error.
  Future<void> leaveTeam({
    required String championshipId,
    required String teamId,
  });

  /// Starts the championship and generates all round-robin fixtures (admin only).
  /// Returns the number of match documents created (45 for 10 teams).
  /// Throws [ChampionshipException] on error.
  Future<int> startChampionship({
    required String championshipId,
    required DateTime startDate,
  });

  /// Submits a match result via Cloud Function.
  /// [sets] must contain 2 or 3 [MatchSetScore] items.
  /// Throws [ChampionshipException] on error.
  Future<void> submitMatchResult({
    required String championshipId,
    required String matchId,
    required List<MatchSetScore> sets,
  });

  /// Verifies or disputes a match result via Cloud Function.
  /// [action] must be 'verify' or 'dispute'. [disputeReason] is required
  /// when action is 'dispute'.
  /// Returns the resulting match status ('verified' or 'disputed').
  /// Throws [ChampionshipException] on error.
  Future<String> verifyMatchResult({
    required String championshipId,
    required String matchId,
    required String action,
    String? disputeReason,
  });

  /// Real-time stream of a single match by ID.
  /// Throws [ChampionshipException] on error or if not found.
  Stream<ChampionshipMatchModel> getMatch({
    required String championshipId,
    required String matchId,
  });

  /// Real-time stream of coordination chat messages for [matchId],
  /// ordered by sentAt ascending.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipMessageModel>> getMatchMessages({
    required String championshipId,
    required String matchId,
  });

  /// Sends a coordination chat message directly to Firestore.
  /// Allowed only for team members (enforced by Firestore rules).
  /// Throws [ChampionshipException] on error.
  Future<void> sendMatchMessage({
    required String championshipId,
    required String matchId,
    required String senderId,
    required String senderDisplayName,
    required String teamId,
    required String text,
  });

  /// Proposes a match schedule (date/time/location) via Cloud Function.
  /// Sets match status to 'scheduled' and adds a system message to chat.
  /// Throws [ChampionshipException] on error.
  Future<void> proposeMatchSchedule({
    required String championshipId,
    required String matchId,
    required DateTime scheduledAt,
    String? location,
  });

  /// Loads a team by ID. Returns null if not found.
  /// Throws [ChampionshipException] on error.
  Future<ChampionshipTeamModel?> getTeamById({
    required String championshipId,
    required String teamId,
  });

  /// Real-time stream of all matches for [championshipId], ordered by round.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipMatchModel>> getAllMatches(String championshipId);

  /// Admin-only: applies an admin decision to a match via Cloud Function.
  /// [decision] must be 'set_result', 'award_walkover', or 'cancel'.
  /// [winnerId] is required for 'award_walkover'.
  /// [sets] is required for 'set_result'.
  /// [notes] is always required.
  /// Throws [ChampionshipException] on error.
  Future<void> adminDecideMatch({
    required String championshipId,
    required String matchId,
    required String decision,
    String? winnerId,
    List<MatchSetScore>? sets,
    required String notes,
  });

  /// Creates a championship via Cloud Function (platform admins only).
  /// Returns the new championship ID.
  /// Throws [ChampionshipException] on error.
  Future<String> createChampionship({
    required String title,
    required DateTime registrationDeadline,
    DateTime? startDate,
    DateTime? endDate,
    String? country,
    String? region,
    ChampionshipGenderCategory? genderCategory,
  });

  /// Returns true if [userId] has a document in the platform_admins collection.
  /// Direct Firestore read — safe because a user only checks their own status.
  Future<bool> isAdmin(String userId);
}
