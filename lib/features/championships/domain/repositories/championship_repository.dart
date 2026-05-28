import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

/// Repository for championship data.
/// Championships are independent of Groups — read access is public for authenticated users.
/// All writes go through Cloud Functions.
abstract class ChampionshipRepository {
  /// Real-time stream of championships in `registration` status.
  /// Throws [ChampionshipException] on error.
  Stream<List<ChampionshipModel>> getOpenChampionships();

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
}
