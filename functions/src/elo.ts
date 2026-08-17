import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { processStatsTracking } from "./statsTracking";
import {
  DEFAULT_ELO,
  GameSource,
  calculateTeamRating,
  calculateNewStreak,
  getExpectedScore,
  calculateRatingChange,
  getKFactor,
} from "./eloMath";

// Re-export for backward compatibility with any callers
export { calculateTeamRating, getExpectedScore, calculateRatingChange };

/**
 * Process a regular game's ELO update.
 *
 * Key fix (ELO-1): ELO is calculated ONCE per match using the overall
 * win/loss result — not sequentially per set. This ensures a 2-0 and 2-1
 * win against the same opponent produce the same ELO swing.
 *
 * ARCHITECTURE RULE: Only called for competitive games in the games/ collection.
 * Training sessions are never processed here.
 */
export async function processGameEloUpdates(
  gameId: string,
  gameData: any,
  source: GameSource = "group_game"
): Promise<void> {
  const db = admin.firestore();

  if (!gameData.teams?.teamAPlayerIds || !gameData.teams?.teamBPlayerIds) {
    throw new Error("Invalid game data: Missing teams information");
  }
  if (!gameData.result?.winner) {
    throw new Error("Invalid game data: Missing result winner");
  }

  // Defensive: verify document lives in the games collection
  const gameRef = db.collection("games").doc(gameId);
  const gameDoc = await gameRef.get();
  if (!gameDoc.exists || gameDoc.ref.parent.id !== "games") {
    throw new Error("ELO can only be processed for competitive games");
  }

  const teamAPlayerIds: string[] = gameData.teams.teamAPlayerIds;
  const teamBPlayerIds: string[] = gameData.teams.teamBPlayerIds;
  const overallWinner: string = gameData.result.winner ?? gameData.result.overallWinner; // support both field names
  const setsPlayed = gameData.result?.games ?? [];

  try {
    await db.runTransaction(async (transaction) => {
      // 1. Fetch all player documents
      const playerIds = [...teamAPlayerIds, ...teamBPlayerIds];
      const playerDocs = await Promise.all(
        playerIds.map((id) => transaction.get(db.collection("users").doc(id)))
      );

      const playerMap = new Map<string, any>();
      const displayNames = new Map<string, string>();
      playerDocs.forEach((doc) => {
        if (doc.exists) {
          playerMap.set(doc.id, doc.data());
          displayNames.set(doc.id, doc.data()?.displayName ?? doc.data()?.email ?? "Unknown");
        }
      });

      // 2. Calculate team ratings from stored ELO values
      const getRating = (id: string) => playerMap.get(id)?.eloRating ?? DEFAULT_ELO;
      const teamARating = calculateTeamRating(teamAPlayerIds.map(getRating));
      const teamBRating = calculateTeamRating(teamBPlayerIds.map(getRating));

      // 3. Single match-level ELO change (ELO-1 fix)
      const teamAWon = overallWinner === "teamA";
      const teamAExpected = getExpectedScore(teamARating, teamBRating);
      const teamBExpected = getExpectedScore(teamBRating, teamARating);

      const now = admin.firestore.FieldValue.serverTimestamp();
      const timestampNow = admin.firestore.Timestamp.now();
      const updates: any = {};

      const updatePlayer = (playerId: string, won: boolean) => {
        const data = playerMap.get(playerId);
        if (!data) return;

        const originalRating = data.eloRating ?? DEFAULT_ELO;
        const gamesPlayed = data.gamesPlayed ?? 0;
        const opponentIds = won ? teamBPlayerIds : teamAPlayerIds;

        // Variable K-factor (ELO-2 fix)
        const k = getKFactor(gamesPlayed);
        const expected = won ? teamAExpected : teamBExpected;
        const change = calculateRatingChange(won ? 1 : 0, expected, k);
        const finalRating = originalRating + change;

        // Streak
        const newStreak = calculateNewStreak(data.currentStreak ?? 0, won);

        // Peak ELO
        const currentPeak = data.eloPeak ?? originalRating;
        const newPeak = Math.max(currentPeak, finalRating);

        // Best win tracking
        let bestWinUpdate: any = undefined;
        if (won && change > 0) {
          const opponentRatings = opponentIds.map(getRating);
          const opponentTeamElo = calculateTeamRating(opponentRatings);
          const currentBestWin = data.bestWin;
          if (!currentBestWin || opponentTeamElo > (currentBestWin.opponentTeamElo ?? 0)) {
            const opponentNames = opponentIds
              .map((id) => displayNames.get(id) ?? "Unknown")
              .join(" & ");
            bestWinUpdate = {
              gameId,
              opponentTeamElo,
              opponentTeamAvgElo: opponentRatings.reduce((a, b) => a + b, 0) / opponentRatings.length,
              eloGained: change,
              date: timestampNow,
              gameTitle: `vs ${opponentNames}`,
              opponentNames,
            };
          }
        }

        // User document update — 1 win OR 1 loss per match (ELO-1 fix)
        const userRef = db.collection("users").doc(playerId);
        const updateData: any = {
          eloRating: finalRating,
          eloLastUpdated: now,
          eloPeak: newPeak,
          eloPeakDate: finalRating > currentPeak ? now : (data.eloPeakDate ?? null),
          gamesPlayed: admin.firestore.FieldValue.increment(1),
          eloGamesPlayed: admin.firestore.FieldValue.increment(1),
          gamesWon: admin.firestore.FieldValue.increment(won ? 1 : 0),
          gamesLost: admin.firestore.FieldValue.increment(won ? 0 : 1),
          wins: admin.firestore.FieldValue.increment(won ? 1 : 0),
          losses: admin.firestore.FieldValue.increment(won ? 0 : 1),
          currentStreak: newStreak,
          lastGameDate: now,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };
        if (bestWinUpdate) updateData.bestWin = bestWinUpdate;
        transaction.update(userRef, updateData);

        updates[playerId] = { previousRating: originalRating, newRating: finalRating, change };

        // Rating history — with source field (ELO-3)
        const opponentNames = opponentIds
          .map((id) => displayNames.get(id) ?? "Unknown")
          .join(" & ");
        transaction.set(userRef.collection("ratingHistory").doc(), {
          gameId,
          source,                   // ELO-3: group_game | championship | pickup
          oldRating: originalRating,
          newRating: finalRating,
          ratingChange: change,
          opponentTeam: opponentNames,
          won,
          kFactor: k,
          timestamp: now,
        });
      };

      teamAPlayerIds.forEach((id) => updatePlayer(id, teamAWon));
      teamBPlayerIds.forEach((id) => updatePlayer(id, !teamAWon));

      // Stats tracking (cumulative changes map for backward compat)
      const cumulativeChanges = new Map<string, number>();
      playerIds.forEach((id) => {
        cumulativeChanges.set(id, updates[id]?.change ?? 0);
      });

      await processStatsTracking(
        transaction,
        gameId,
        teamAPlayerIds,
        teamBPlayerIds,
        teamAWon,
        setsPlayed,
        cumulativeChanges,
        playerMap
      );

      transaction.update(db.collection("games").doc(gameId), {
        eloUpdates: updates,
        eloCalculated: true,
        eloCalculatedAt: now,
      });
    });

    functions.logger.info(`[processGameEloUpdates] Updated ELO for game ${gameId}`, { source });
  } catch (error) {
    functions.logger.error(`[processGameEloUpdates] Failed for game ${gameId}`, error);
    throw error;
  }
}
