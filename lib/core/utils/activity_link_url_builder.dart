// Builds shareable HTTPS links for a specific game, training session, or
// championship match. No Cloud Function round-trip is needed to generate
// these — the Firestore doc ID itself is the capability (see firestore.rules
// get/list split for games/trainingSessions/championship matches), so the
// URL is just a deterministic string built from an ID the client already has.
class ActivityLinkUrlBuilder {
  ActivityLinkUrlBuilder._();

  static const String _baseUrl = 'https://gatherli.org';

  static String forGame(String gameId) => '$_baseUrl/game/$gameId';

  static String forTrainingSession(String trainingSessionId) =>
      '$_baseUrl/training/$trainingSessionId';

  static String forChampionshipMatch({
    required String championshipId,
    required String matchId,
  }) => '$_baseUrl/championship/$championshipId/match/$matchId';
}
