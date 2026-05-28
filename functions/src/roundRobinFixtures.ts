// Pure round-robin fixture generator using the circle method (Story 30.4).
// Exported as standalone functions so they can be unit-tested without Firebase.

export interface FixtureMatch {
  round: number;       // 1-based
  teamAId: string;
  teamBId: string;
  roundStartDate: Date;
  deadline: Date;      // roundStartDate + 3 weeks
}

/**
 * Generates a complete round-robin schedule for an even number of teams
 * using the circle (polygon) method:
 *  - Pin teamIds[0] in position 0.
 *  - Rotate the remaining N-1 teams one position clockwise each round.
 *  - In each round pair position i with position (N-1-i).
 *
 * Produces (N-1) rounds × (N/2) matches = N*(N-1)/2 total matches.
 *
 * @param teamIds   Ordered list of team IDs (must have even length ≥ 2).
 * @param startDate First round's start date.
 * @returns Flat array of FixtureMatch objects.
 */
export function generateRoundRobinFixtures(
  teamIds: string[],
  startDate: Date
): FixtureMatch[] {
  const n = teamIds.length;
  if (n < 2 || n % 2 !== 0) {
    throw new Error(`Team count must be even and ≥ 2, got ${n}`);
  }

  const rounds = n - 1;
  const matchesPerRound = n / 2;
  const fixtures: FixtureMatch[] = [];

  // Work on indices, not IDs, to keep the algorithm clean.
  // Slot 0 is always fixed; slots 1..N-1 rotate.
  const slots = Array.from({ length: n }, (_, i) => i); // [0,1,2,...,n-1]

  for (let round = 1; round <= rounds; round++) {
    const roundStartDate = new Date(startDate);
    roundStartDate.setDate(roundStartDate.getDate() + (round - 1) * 7);

    const deadline = new Date(roundStartDate);
    deadline.setDate(deadline.getDate() + 21); // +3 weeks

    for (let i = 0; i < matchesPerRound; i++) {
      const a = slots[i];
      const b = slots[n - 1 - i];
      fixtures.push({
        round,
        teamAId: teamIds[a],
        teamBId: teamIds[b],
        roundStartDate: new Date(roundStartDate),
        deadline: new Date(deadline),
      });
    }

    // Rotate slots 1..N-1 one position clockwise:
    // [fixed, s1, s2, ..., sN-1] → [fixed, sN-1, s1, s2, ..., sN-2]
    const last = slots[n - 1];
    for (let i = n - 1; i > 1; i--) {
      slots[i] = slots[i - 1];
    }
    slots[1] = last;
  }

  return fixtures;
}
