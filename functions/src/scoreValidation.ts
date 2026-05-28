// Pure score-validation helpers for championship match results (Story 30.6).
// Exported separately so they can be unit-tested without Firebase.

// ============================================================================
// Types
// ============================================================================

export interface SetInput {
  teamAPoints: number;
  teamBPoints: number;
  setNumber: number;
}

export interface ValidationResult {
  valid: boolean;
  error?: string;
}

// ============================================================================
// Set validation (mirrors MatchSetScore.isValid in Dart)
// ============================================================================

/**
 * Validates a single set score.
 * Regular sets (1 & 2): first to 21, win by 2, no cap.
 * Decider set (3):      first to 15, win by 2, no cap.
 */
export function isSetValid(set: SetInput, isDeciderSet: boolean): boolean {
  const target = isDeciderSet ? 15 : 21;
  const maxPts = Math.max(set.teamAPoints, set.teamBPoints);
  const minPts = Math.min(set.teamAPoints, set.teamBPoints);

  // One side must reach the target
  if (maxPts < target) return false;

  // At exactly target: loser must be at most target − 2 (standard win)
  if (maxPts === target) return minPts <= target - 2;

  // Extended play: gap must be exactly 2
  return maxPts - minPts === 2;
}

// ============================================================================
// Full match result validation
// ============================================================================

/**
 * Validates a complete match result (2 or 3 sets).
 * Rules:
 *   - Exactly 2 or 3 sets
 *   - Set numbers must be [1, 2] or [1, 2, 3] (no duplicates, no gaps)
 *   - Each set score is valid per the rules above
 *   - Exactly one team wins 2 sets
 */
export function validateMatchResult(sets: SetInput[]): ValidationResult {
  if (!Array.isArray(sets) || (sets.length !== 2 && sets.length !== 3)) {
    return { valid: false, error: "Result must have exactly 2 or 3 sets" };
  }

  const sortedSetNumbers = sets.map((s) => s.setNumber).sort((a, b) => a - b);
  const expectedSetNumbers = sets.length === 2 ? [1, 2] : [1, 2, 3];
  if (!expectedSetNumbers.every((n, i) => n === sortedSetNumbers[i])) {
    return {
      valid: false,
      error: "Set numbers must be 1 and 2 (plus 3 for a deciding set)",
    };
  }

  for (const set of sets) {
    const isDecider = set.setNumber === 3;
    if (!isSetValid(set, isDecider)) {
      return { valid: false, error: `Invalid score for set ${set.setNumber}` };
    }
  }

  const teamASetWins = sets.filter((s) => s.teamAPoints > s.teamBPoints).length;
  const teamBSetWins = sets.filter((s) => s.teamBPoints > s.teamAPoints).length;

  if (teamASetWins !== 2 && teamBSetWins !== 2) {
    return { valid: false, error: "One team must win exactly 2 sets" };
  }

  return { valid: true };
}

// ============================================================================
// Points calculation
// ============================================================================

/**
 * Returns championship points for both teams.
 * 2-0 win: winner 3 pts, loser 0 pts.
 * 2-1 win: winner 2 pts, loser 1 pt.
 * Assumes the result has already been validated.
 */
export function computeChampionshipPoints(sets: SetInput[]): {
  teamAPoints: number;
  teamBPoints: number;
  winner: "teamA" | "teamB";
} {
  const teamASetWins = sets.filter((s) => s.teamAPoints > s.teamBPoints).length;
  const totalSets = sets.length;

  const teamAWins = teamASetWins === 2;
  const isStraightSets = totalSets === 2;

  const teamAPoints = teamAWins ? (isStraightSets ? 3 : 2) : (isStraightSets ? 0 : 1);
  const teamBPoints = teamAWins ? (isStraightSets ? 0 : 1) : (isStraightSets ? 3 : 2);

  return {
    teamAPoints,
    teamBPoints,
    winner: teamAWins ? "teamA" : "teamB",
  };
}
