// Unit tests for pure standings calculation helpers (Story 30.8).
import {
  computeStandingsDeltas,
  applyDelta,
  recalculatePositions,
  StandingsRow,
  MatchResultData,
} from "../../src/standingsCalculation";

// ============================================================================
// Helpers
// ============================================================================

function makeRow(
  teamId: string,
  overrides: Partial<StandingsRow> = {}
): StandingsRow {
  return {
    teamId,
    teamName: `Team ${teamId}`,
    played: 0,
    points: 0,
    wins20: 0,
    wins21: 0,
    losses12: 0,
    losses02: 0,
    setsWon: 0,
    setsLost: 0,
    position: 0,
    ...overrides,
  };
}

const sets2_0: MatchResultData["result"]["sets"] = [
  { teamAPoints: 21, teamBPoints: 15 },
  { teamAPoints: 21, teamBPoints: 18 },
];

const sets2_1: MatchResultData["result"]["sets"] = [
  { teamAPoints: 21, teamBPoints: 15 },
  { teamAPoints: 18, teamBPoints: 21 },
  { teamAPoints: 15, teamBPoints: 12 },
];

const sets0_2: MatchResultData["result"]["sets"] = [
  { teamAPoints: 15, teamBPoints: 21 },
  { teamAPoints: 18, teamBPoints: 21 },
];

// ============================================================================
// computeStandingsDeltas
// ============================================================================

describe("computeStandingsDeltas", () => {
  test("2-0 win by teamA: winner gets 3 pts, wins20; loser gets 0 pts, losses02", () => {
    const match: MatchResultData = {
      teamAId: "a",
      teamBId: "b",
      result: { sets: sets2_0, winner: "teamA", teamAPoints: 3, teamBPoints: 0 },
    };

    const { teamA, teamB } = computeStandingsDeltas(match);

    expect(teamA.points).toBe(3);
    expect(teamA.wins20).toBe(1);
    expect(teamA.wins21).toBe(0);
    expect(teamA.losses12).toBe(0);
    expect(teamA.losses02).toBe(0);
    expect(teamA.setsWon).toBe(2);
    expect(teamA.setsLost).toBe(0);
    expect(teamA.played).toBe(1);

    expect(teamB.points).toBe(0);
    expect(teamB.wins20).toBe(0);
    expect(teamB.wins21).toBe(0);
    expect(teamB.losses12).toBe(0);
    expect(teamB.losses02).toBe(1);
    expect(teamB.setsWon).toBe(0);
    expect(teamB.setsLost).toBe(2);
    expect(teamB.played).toBe(1);
  });

  test("2-1 win by teamA: winner gets 2 pts, wins21; loser gets 1 pt, losses12", () => {
    const match: MatchResultData = {
      teamAId: "a",
      teamBId: "b",
      result: { sets: sets2_1, winner: "teamA", teamAPoints: 2, teamBPoints: 1 },
    };

    const { teamA, teamB } = computeStandingsDeltas(match);

    expect(teamA.points).toBe(2);
    expect(teamA.wins20).toBe(0);
    expect(teamA.wins21).toBe(1);
    expect(teamA.losses12).toBe(0);
    expect(teamA.losses02).toBe(0);
    expect(teamA.setsWon).toBe(2);
    expect(teamA.setsLost).toBe(1);

    expect(teamB.points).toBe(1);
    expect(teamB.wins20).toBe(0);
    expect(teamB.wins21).toBe(0);
    expect(teamB.losses12).toBe(1);
    expect(teamB.losses02).toBe(0);
    expect(teamB.setsWon).toBe(1);
    expect(teamB.setsLost).toBe(2);
  });

  test("0-2 loss by teamA (teamB wins 2-0): teamB gets 3 pts, wins20", () => {
    const match: MatchResultData = {
      teamAId: "a",
      teamBId: "b",
      result: { sets: sets0_2, winner: "teamB", teamAPoints: 0, teamBPoints: 3 },
    };

    const { teamA, teamB } = computeStandingsDeltas(match);

    expect(teamA.points).toBe(0);
    expect(teamA.losses02).toBe(1);
    expect(teamA.wins20).toBe(0);
    expect(teamA.setsWon).toBe(0);
    expect(teamA.setsLost).toBe(2);

    expect(teamB.points).toBe(3);
    expect(teamB.wins20).toBe(1);
    expect(teamB.losses02).toBe(0);
    expect(teamB.setsWon).toBe(2);
    expect(teamB.setsLost).toBe(0);
  });

  test("1-2 loss by teamA (teamB wins 2-1): teamB gets 2 pts, wins21; teamA gets 1 pt, losses12", () => {
    const sets1_2: MatchResultData["result"]["sets"] = [
      { teamAPoints: 21, teamBPoints: 18 },
      { teamAPoints: 14, teamBPoints: 21 },
      { teamAPoints: 12, teamBPoints: 15 },
    ];

    const match: MatchResultData = {
      teamAId: "a",
      teamBId: "b",
      result: { sets: sets1_2, winner: "teamB", teamAPoints: 1, teamBPoints: 2 },
    };

    const { teamA, teamB } = computeStandingsDeltas(match);

    expect(teamA.points).toBe(1);
    expect(teamA.losses12).toBe(1);
    expect(teamA.wins20).toBe(0);
    expect(teamA.wins21).toBe(0);
    expect(teamA.losses02).toBe(0);

    expect(teamB.points).toBe(2);
    expect(teamB.wins21).toBe(1);
    expect(teamB.wins20).toBe(0);
    expect(teamB.losses12).toBe(0);
    expect(teamB.losses02).toBe(0);
  });
});

// ============================================================================
// applyDelta
// ============================================================================

describe("applyDelta", () => {
  test("adds delta fields to existing row values", () => {
    const row = makeRow("a", { played: 2, points: 4, setsWon: 4, setsLost: 1, wins20: 1, wins21: 1 });
    const delta = {
      played: 1,
      points: 3,
      wins20: 1,
      wins21: 0,
      losses12: 0,
      losses02: 0,
      setsWon: 2,
      setsLost: 0,
    };

    const updated = applyDelta(row, delta);

    expect(updated.played).toBe(3);
    expect(updated.points).toBe(7);
    expect(updated.wins20).toBe(2);
    expect(updated.wins21).toBe(1);
    expect(updated.setsWon).toBe(6);
    expect(updated.setsLost).toBe(1);
    expect(updated.teamId).toBe("a"); // unchanged
    expect(updated.teamName).toBe("Team a"); // unchanged
  });
});

// ============================================================================
// recalculatePositions
// ============================================================================

describe("recalculatePositions", () => {
  const noHeadToHead = (_a: string, _b: string) => null;

  test("sorts teams by points descending", () => {
    const standings = [
      makeRow("c", { points: 1 }),
      makeRow("a", { points: 6 }),
      makeRow("b", { points: 3 }),
    ];

    const result = recalculatePositions(standings, noHeadToHead);

    expect(result[0].teamId).toBe("a");
    expect(result[0].position).toBe(1);
    expect(result[1].teamId).toBe("b");
    expect(result[1].position).toBe(2);
    expect(result[2].teamId).toBe("c");
    expect(result[2].position).toBe(3);
  });

  test("uses head-to-head tiebreaker when points are equal", () => {
    const standings = [
      makeRow("a", { points: 3 }),
      makeRow("b", { points: 3 }),
    ];

    // b beat a in their match
    const h2h = (idA: string, idB: string): string | null => {
      if ((idA === "a" && idB === "b") || (idA === "b" && idB === "a")) return "b";
      return null;
    };

    const result = recalculatePositions(standings, h2h);

    expect(result[0].teamId).toBe("b");
    expect(result[0].position).toBe(1);
    expect(result[1].teamId).toBe("a");
    expect(result[1].position).toBe(2);
  });

  test("uses set ratio as final tiebreaker when points equal and no H2H result", () => {
    const standings = [
      makeRow("a", { points: 3, setsWon: 4, setsLost: 3 }), // ratio: +1
      makeRow("b", { points: 3, setsWon: 6, setsLost: 2 }), // ratio: +4
    ];

    const result = recalculatePositions(standings, noHeadToHead);

    expect(result[0].teamId).toBe("b"); // better set ratio
    expect(result[1].teamId).toBe("a");
  });

  test("does not mutate the input array", () => {
    const standings = [
      makeRow("a", { points: 1 }),
      makeRow("b", { points: 3 }),
    ];
    const originalFirst = standings[0].teamId;

    recalculatePositions(standings, noHeadToHead);

    expect(standings[0].teamId).toBe(originalFirst);
  });

  test("assigns position 1 through N for all teams", () => {
    const standings = [
      makeRow("a", { points: 6 }),
      makeRow("b", { points: 3 }),
      makeRow("c", { points: 0 }),
    ];

    const result = recalculatePositions(standings, noHeadToHead);

    const positions = result.map((r) => r.position);
    expect(positions).toEqual([1, 2, 3]);
  });
});
