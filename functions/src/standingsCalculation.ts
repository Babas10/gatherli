// Pure standings calculation helpers for championship standings recalculation (Story 30.8).
// Exported separately so they can be unit-tested without Firebase.

// ============================================================================
// Types
// ============================================================================

export interface SetScore {
  teamAPoints: number;
  teamBPoints: number;
}

export interface MatchResultData {
  teamAId: string;
  teamBId: string;
  result: {
    sets: SetScore[];
    /** 'teamA' or 'teamB' — the team that won 2 sets */
    winner: "teamA" | "teamB";
    /** Championship points earned by teamA (0, 1, 2 or 3) */
    teamAPoints: number;
    /** Championship points earned by teamB (0, 1, 2 or 3) */
    teamBPoints: number;
  };
}

export interface StandingsDelta {
  played: number;
  points: number;
  wins20: number;
  wins21: number;
  losses12: number;
  losses02: number;
  setsWon: number;
  setsLost: number;
}

export interface StandingsRow {
  teamId: string;
  teamName: string;
  played: number;
  points: number;
  wins20: number;
  wins21: number;
  losses12: number;
  losses02: number;
  setsWon: number;
  setsLost: number;
  position: number;
}

// ============================================================================
// Standings delta computation
// ============================================================================

/**
 * Computes the standings delta (increments) for both teams from a single
 * verified match result.
 *
 * Win/loss buckets:
 *   wins20  — won 2-0 (3 pts for winner)
 *   wins21  — won 2-1 (2 pts for winner)
 *   losses12 — lost 1-2 (1 pt for loser)
 *   losses02 — lost 0-2 (0 pts for loser)
 */
export function computeStandingsDeltas(match: MatchResultData): {
  teamA: StandingsDelta;
  teamB: StandingsDelta;
} {
  const { sets, winner, teamAPoints, teamBPoints } = match.result;

  const teamASetsWon = sets.filter((s) => s.teamAPoints > s.teamBPoints).length;
  const teamBSetsWon = sets.filter((s) => s.teamBPoints > s.teamAPoints).length;

  // Classify win/loss bucket
  // 2-0: winner earns 3 pts (straight sets), loser earns 0
  // 2-1: winner earns 2 pts (deciding set), loser earns 1
  const teamAWins = winner === "teamA";
  const isStraightSets = sets.length === 2;

  const teamADelta: StandingsDelta = {
    played: 1,
    points: teamAPoints,
    wins20: teamAWins && isStraightSets ? 1 : 0,
    wins21: teamAWins && !isStraightSets ? 1 : 0,
    losses12: !teamAWins && !isStraightSets ? 1 : 0,
    losses02: !teamAWins && isStraightSets ? 1 : 0,
    setsWon: teamASetsWon,
    setsLost: teamBSetsWon,
  };

  const teamBDelta: StandingsDelta = {
    played: 1,
    points: teamBPoints,
    wins20: !teamAWins && isStraightSets ? 1 : 0,
    wins21: !teamAWins && !isStraightSets ? 1 : 0,
    losses12: teamAWins && !isStraightSets ? 1 : 0,
    losses02: teamAWins && isStraightSets ? 1 : 0,
    setsWon: teamBSetsWon,
    setsLost: teamASetsWon,
  };

  return { teamA: teamADelta, teamB: teamBDelta };
}

// ============================================================================
// Delta application
// ============================================================================

/** Returns a new StandingsRow with the delta added to the existing values. */
export function applyDelta(row: StandingsRow, delta: StandingsDelta): StandingsRow {
  return {
    ...row,
    played: row.played + delta.played,
    points: row.points + delta.points,
    wins20: row.wins20 + delta.wins20,
    wins21: row.wins21 + delta.wins21,
    losses12: row.losses12 + delta.losses12,
    losses02: row.losses02 + delta.losses02,
    setsWon: row.setsWon + delta.setsWon,
    setsLost: row.setsLost + delta.setsLost,
  };
}

// ============================================================================
// Position recalculation
// ============================================================================

/**
 * Recalculates `position` for all teams based on:
 *   1. `points` descending
 *   2. Head-to-head winner (for teams tied on points)
 *   3. Set ratio (`setsWon - setsLost`) descending as final tiebreaker
 *
 * @param standings  Current standings rows (positions will be overwritten).
 * @param headToHead Function returning the winning teamId for a pair of teams,
 *                   or null if no completed match exists between them.
 * @returns New array of standings rows with updated `position` (1-indexed).
 */
export function recalculatePositions(
  standings: StandingsRow[],
  headToHead: (teamAId: string, teamBId: string) => string | null
): StandingsRow[] {
  const sorted = [...standings].sort((a, b) => {
    // 1. Points descending
    if (b.points !== a.points) return b.points - a.points;

    // 2. Head-to-head
    const h2hWinner = headToHead(a.teamId, b.teamId);
    if (h2hWinner === a.teamId) return -1; // a ranks higher
    if (h2hWinner === b.teamId) return 1;  // b ranks higher

    // 3. Set ratio descending
    const ratioA = a.setsWon - a.setsLost;
    const ratioB = b.setsWon - b.setsLost;
    return ratioB - ratioA;
  });

  return sorted.map((row, index) => ({ ...row, position: index + 1 }));
}
