// Unit tests for the circle-method round-robin fixture generator (Story 30.4).
// Validates: correct counts, no team plays twice per round, every pair meets exactly once,
// correct deadline calculation (round start + 3 weeks).

import { generateRoundRobinFixtures } from "../../src/roundRobinFixtures";

// ── Helpers ───────────────────────────────────────────────────────────────────

/** Build N team IDs: ["team-0", "team-1", ..., "team-N-1"] */
function makeTeams(n: number): string[] {
  return Array.from({ length: n }, (_, i) => `team-${i}`);
}

const TEAMS_10 = makeTeams(10);
const START = new Date("2026-08-01T00:00:00.000Z");

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("generateRoundRobinFixtures", () => {
  describe("for 10 teams (standard championship)", () => {
    let fixtures: ReturnType<typeof generateRoundRobinFixtures>;

    beforeAll(() => {
      fixtures = generateRoundRobinFixtures(TEAMS_10, START);
    });

    // ── Counts ──────────────────────────────────────────────────────────────

    it("produces exactly 45 matches total", () => {
      expect(fixtures).toHaveLength(45);
    });

    it("produces exactly 9 rounds", () => {
      const rounds = new Set(fixtures.map((f) => f.round));
      expect(rounds.size).toBe(9);
    });

    it("produces exactly 5 matches per round", () => {
      for (let round = 1; round <= 9; round++) {
        const roundMatches = fixtures.filter((f) => f.round === round);
        expect(roundMatches).toHaveLength(5);
      }
    });

    // ── No team plays twice in the same round ───────────────────────────────

    it("no team appears more than once per round", () => {
      for (let round = 1; round <= 9; round++) {
        const roundMatches = fixtures.filter((f) => f.round === round);
        const teamsSeen = new Set<string>();
        for (const m of roundMatches) {
          expect(teamsSeen.has(m.teamAId)).toBe(false);
          expect(teamsSeen.has(m.teamBId)).toBe(false);
          teamsSeen.add(m.teamAId);
          teamsSeen.add(m.teamBId);
        }
      }
    });

    // ── Every pair meets exactly once ───────────────────────────────────────

    it("every pair of teams meets exactly once", () => {
      const pairCounts = new Map<string, number>();

      for (const f of fixtures) {
        // Canonical pair key (sort so order doesn't matter)
        const pair = [f.teamAId, f.teamBId].sort().join(":");
        pairCounts.set(pair, (pairCounts.get(pair) ?? 0) + 1);
      }

      // Expected: C(10,2) = 45 unique pairs
      expect(pairCounts.size).toBe(45);

      for (const count of pairCounts.values()) {
        expect(count).toBe(1); // each pair meets exactly once
      }
    });

    // ── All 10 teams appear in every round ──────────────────────────────────

    it("all 10 teams appear in every round", () => {
      for (let round = 1; round <= 9; round++) {
        const roundMatches = fixtures.filter((f) => f.round === round);
        const teams = new Set<string>();
        for (const m of roundMatches) {
          teams.add(m.teamAId);
          teams.add(m.teamBId);
        }
        expect(teams.size).toBe(10);
      }
    });

    // ── Date calculations ───────────────────────────────────────────────────

    it("round 1 starts on the provided startDate", () => {
      const round1Matches = fixtures.filter((f) => f.round === 1);
      for (const m of round1Matches) {
        expect(m.roundStartDate.toISOString()).toBe(START.toISOString());
      }
    });

    it("round 2 starts exactly 7 days after round 1", () => {
      const r1 = fixtures.find((f) => f.round === 1)!.roundStartDate;
      const r2 = fixtures.find((f) => f.round === 2)!.roundStartDate;
      const diffDays = (r2.getTime() - r1.getTime()) / (1000 * 60 * 60 * 24);
      expect(diffDays).toBe(7);
    });

    it("round 9 starts exactly 8 weeks after round 1", () => {
      const r1 = fixtures.find((f) => f.round === 1)!.roundStartDate;
      const r9 = fixtures.find((f) => f.round === 9)!.roundStartDate;
      const diffDays = (r9.getTime() - r1.getTime()) / (1000 * 60 * 60 * 24);
      expect(diffDays).toBe(56); // 8 × 7
    });

    it("deadline is exactly 21 days after round start", () => {
      for (const f of fixtures) {
        const diffDays =
          (f.deadline.getTime() - f.roundStartDate.getTime()) /
          (1000 * 60 * 60 * 24);
        expect(diffDays).toBe(21);
      }
    });

    // ── Team IDs preserved ──────────────────────────────────────────────────

    it("only uses the supplied team IDs", () => {
      const teamSet = new Set(TEAMS_10);
      for (const f of fixtures) {
        expect(teamSet.has(f.teamAId)).toBe(true);
        expect(teamSet.has(f.teamBId)).toBe(true);
      }
    });

    it("teamAId and teamBId are never the same", () => {
      for (const f of fixtures) {
        expect(f.teamAId).not.toBe(f.teamBId);
      }
    });
  });

  // ── Works for other even team counts ───────────────────────────────────────

  describe("for 4 teams (minimal even case)", () => {
    const teams4 = makeTeams(4);
    let fixtures: ReturnType<typeof generateRoundRobinFixtures>;

    beforeAll(() => {
      fixtures = generateRoundRobinFixtures(teams4, START);
    });

    it("produces 6 matches (C(4,2))", () => {
      expect(fixtures).toHaveLength(6);
    });

    it("produces 3 rounds", () => {
      const rounds = new Set(fixtures.map((f) => f.round));
      expect(rounds.size).toBe(3);
    });

    it("every pair meets exactly once", () => {
      const pairCounts = new Map<string, number>();
      for (const f of fixtures) {
        const pair = [f.teamAId, f.teamBId].sort().join(":");
        pairCounts.set(pair, (pairCounts.get(pair) ?? 0) + 1);
      }
      expect(pairCounts.size).toBe(6);
      for (const count of pairCounts.values()) {
        expect(count).toBe(1);
      }
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error cases", () => {
    it("throws when team count is odd", () => {
      expect(() => generateRoundRobinFixtures(makeTeams(5), START)).toThrow();
    });

    it("throws when fewer than 2 teams provided", () => {
      expect(() => generateRoundRobinFixtures(["only-one"], START)).toThrow();
    });
  });
});
