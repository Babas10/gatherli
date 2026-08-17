// Shared ELO calculation utilities.
// Used by both regular game ELO (elo.ts) and championship match ELO.
//
// Key design decisions:
//   - Team rating: Weak-Link formula (0.7 * min + 0.3 * max) — the weaker
//     player is the tactical target in beach volleyball 2v2.
//   - K-factor: variable by games played — new players converge faster,
//     established players have stable ratings.
//   - One ELO change per match (not per set) — standard Elo practice.

export const DEFAULT_ELO = 1200;

/** Source of a game for ratingHistory entries. Enables future multi-ELO migration. */
export type GameSource = "group_game" | "championship" | "pickup";

/**
 * Variable K-factor based on total games played.
 * - < 30 games  → K=40  (new player, fast convergence)
 * - 30–99 games → K=32  (standard)
 * - 100+ games  → K=24  (established, stable rating)
 */
export function getKFactor(gamesPlayed: number): number {
  if (gamesPlayed < 30) return 40;
  if (gamesPlayed < 100) return 32;
  return 24;
}

/**
 * Championship K-factor: slightly lower than regular games because
 * players play many more matches per season in a round-robin.
 */
export function getChampionshipKFactor(gamesPlayed: number): number {
  if (gamesPlayed < 30) return 32;
  if (gamesPlayed < 100) return 26;
  return 20;
}

/**
 * Team rating using the Weak-Link formula.
 * In beach volleyball 2v2, the weaker player is the tactical target,
 * so the team's effective rating is weighted toward the lower ELO.
 *   teamRating = 0.7 * min(elos) + 0.3 * max(elos)
 */
export function calculateTeamRating(elos: number[]): number {
  if (elos.length === 0) return DEFAULT_ELO;
  if (elos.length === 1) return elos[0];
  const min = Math.min(...elos);
  const max = Math.max(...elos);
  return 0.7 * min + 0.3 * max;
}

/**
 * Expected win probability using the standard Elo formula.
 */
export function getExpectedScore(teamRating: number, opponentRating: number): number {
  return 1 / (1 + Math.pow(10, (opponentRating - teamRating) / 400));
}

/**
 * ELO rating change for a single match result.
 * actualScore: 1 = win, 0 = loss (draws not supported in beach volleyball).
 */
export function calculateRatingChange(
  actualScore: number,
  expectedScore: number,
  kFactor: number
): number {
  return Math.round(kFactor * (actualScore - expectedScore));
}

/**
 * Streak calculation: consecutive wins (+N) or losses (-N).
 */
export function calculateNewStreak(currentStreak: number, won: boolean): number {
  if (won) return currentStreak >= 0 ? currentStreak + 1 : 1;
  return currentStreak <= 0 ? currentStreak - 1 : -1;
}
