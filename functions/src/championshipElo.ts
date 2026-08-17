// Championship match ELO updates (Story ELO-4).
// Called from onChampionshipMatchVerified after standings are updated.
//
// Design decisions:
//   - Uses the SAME eloRating field as regular games (unified skill rating).
//   - The ratingHistory entry has source='championship' so future multi-ELO
//     migration can reconstruct separate ratings from history.
//   - Championship K-factor is slightly lower (K=20-32) because players play
//     many more matches per season in a round-robin vs casual group games.
//   - One ELO change per MATCH (not per set) — consistent with regular games.
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  DEFAULT_ELO,
  calculateTeamRating,
  calculateNewStreak,
  getExpectedScore,
  calculateRatingChange,
  getChampionshipKFactor,
} from "./eloMath";

export interface ChampionshipMatchEloInput {
  championshipId: string;
  matchId: string;
  teamAId: string;
  teamBId: string;
  winner: "teamA" | "teamB";
}

/**
 * Update player ELO ratings after a championship match is verified.
 * Fetches player IDs from championship teams, then applies Elo math.
 */
export async function processChampionshipMatchEloUpdates(
  input: ChampionshipMatchEloInput
): Promise<void> {
  const db = admin.firestore();
  const { championshipId, matchId, teamAId, teamBId, winner } = input;

  // 1. Fetch both teams to get player IDs
  const champRef = db.collection("championships").doc(championshipId);
  const [teamADoc, teamBDoc] = await Promise.all([
    champRef.collection("teams").doc(teamAId).get(),
    champRef.collection("teams").doc(teamBId).get(),
  ]);

  if (!teamADoc.exists || !teamBDoc.exists) {
    functions.logger.error("[championshipElo] One or both teams not found", { teamAId, teamBId });
    return;
  }

  const teamAPlayerIds: string[] = teamADoc.data()?.memberIds ?? [];
  const teamBPlayerIds: string[] = teamBDoc.data()?.memberIds ?? [];

  if (teamAPlayerIds.length === 0 || teamBPlayerIds.length === 0) {
    functions.logger.error("[championshipElo] Teams have no members", { teamAId, teamBId });
    return;
  }

  const teamAWon = winner === "teamA";
  const now = admin.firestore.FieldValue.serverTimestamp();
  const updates: any = {};

  try {
    await db.runTransaction(async (transaction) => {
      // 2. Fetch all player documents
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

      // 3. Team ratings using Weak-Link formula
      const getRating = (id: string) => playerMap.get(id)?.eloRating ?? DEFAULT_ELO;
      const teamARating = calculateTeamRating(teamAPlayerIds.map(getRating));
      const teamBRating = calculateTeamRating(teamBPlayerIds.map(getRating));
      const teamAExpected = getExpectedScore(teamARating, teamBRating);
      const teamBExpected = getExpectedScore(teamBRating, teamARating);

      // 4. Update each player
      const updatePlayer = (playerId: string, won: boolean) => {
        const data = playerMap.get(playerId);
        if (!data) return;

        const originalRating = data.eloRating ?? DEFAULT_ELO;
        const gamesPlayed = data.gamesPlayed ?? 0;
        const opponentIds = won ? teamBPlayerIds : teamAPlayerIds;

        // Championship K-factor (lower than regular games)
        const k = getChampionshipKFactor(gamesPlayed);
        const expected = won ? teamAExpected : teamBExpected;
        const change = calculateRatingChange(won ? 1 : 0, expected, k);
        const finalRating = originalRating + change;

        const newStreak = calculateNewStreak(data.currentStreak ?? 0, won);
        const currentPeak = data.eloPeak ?? originalRating;
        const newPeak = Math.max(currentPeak, finalRating);

        const userRef = db.collection("users").doc(playerId);
        transaction.update(userRef, {
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
        });

        updates[playerId] = { previousRating: originalRating, newRating: finalRating, change };

        // Rating history with source='championship' (ELO-3)
        const opponentNames = opponentIds
          .map((id) => displayNames.get(id) ?? "Unknown")
          .join(" & ");
        transaction.set(userRef.collection("ratingHistory").doc(), {
          gameId: matchId,
          source: "championship",         // Enables future multi-ELO migration
          championshipId,                  // Full traceability
          matchId,
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

      // 5. Mark match as ELO-processed (idempotency guard)
      transaction.update(
        champRef.collection("matches").doc(matchId),
        { eloCalculated: true, eloUpdates: updates, eloCalculatedAt: now }
      );
    });

    functions.logger.info("[championshipElo] ELO updated", {
      championshipId, matchId, winner, updates,
    });
  } catch (error) {
    functions.logger.error("[championshipElo] Failed", { championshipId, matchId, error });
    throw error;
  }
}
