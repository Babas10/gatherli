// Unit tests for pure score-validation helpers (Story 30.6).
import { isSetValid, validateMatchResult, computeChampionshipPoints } from "../../src/scoreValidation";

describe("isSetValid", () => {
  describe("regular set (isDeciderSet: false)", () => {
    it("accepts 21-15 (standard win)", () => {
      expect(isSetValid({ teamAPoints: 21, teamBPoints: 15, setNumber: 1 }, false)).toBe(true);
    });

    it("accepts 22-20 (extended play)", () => {
      expect(isSetValid({ teamAPoints: 22, teamBPoints: 20, setNumber: 1 }, false)).toBe(true);
    });

    it("accepts 25-23 (extended play)", () => {
      expect(isSetValid({ teamAPoints: 25, teamBPoints: 23, setNumber: 1 }, false)).toBe(true);
    });

    it("rejects 21-20 (only 1 point gap)", () => {
      expect(isSetValid({ teamAPoints: 21, teamBPoints: 20, setNumber: 1 }, false)).toBe(false);
    });

    it("rejects 19-15 (winner did not reach 21)", () => {
      expect(isSetValid({ teamAPoints: 19, teamBPoints: 15, setNumber: 1 }, false)).toBe(false);
    });

    it("rejects 20-20 (tied)", () => {
      expect(isSetValid({ teamAPoints: 20, teamBPoints: 20, setNumber: 1 }, false)).toBe(false);
    });

    it("accepts 21-0 (shutout)", () => {
      expect(isSetValid({ teamAPoints: 21, teamBPoints: 0, setNumber: 1 }, false)).toBe(true);
    });
  });

  describe("decider set (isDeciderSet: true)", () => {
    it("accepts 15-10 (standard win)", () => {
      expect(isSetValid({ teamAPoints: 15, teamBPoints: 10, setNumber: 3 }, true)).toBe(true);
    });

    it("accepts 16-14 (extended play)", () => {
      expect(isSetValid({ teamAPoints: 16, teamBPoints: 14, setNumber: 3 }, true)).toBe(true);
    });

    it("rejects 15-14 (only 1 point gap)", () => {
      expect(isSetValid({ teamAPoints: 15, teamBPoints: 14, setNumber: 3 }, true)).toBe(false);
    });

    it("rejects 21-15 in decider (must reach 15, not 21)", () => {
      // 21 > 15, extended play check: 21 - 15 = 6 ≠ 2 → invalid
      expect(isSetValid({ teamAPoints: 21, teamBPoints: 15, setNumber: 3 }, true)).toBe(false);
    });

    it("rejects 12-8 (winner did not reach 15)", () => {
      expect(isSetValid({ teamAPoints: 12, teamBPoints: 8, setNumber: 3 }, true)).toBe(false);
    });
  });
});

describe("validateMatchResult", () => {
  it("accepts valid 2-0 result [21-15, 21-18]", () => {
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 18, setNumber: 2 },
    ]);
    expect(result.valid).toBe(true);
  });

  it("accepts valid 2-1 result [21-18, 17-21, 15-12]", () => {
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 18, setNumber: 1 },
      { teamAPoints: 17, teamBPoints: 21, setNumber: 2 },
      { teamAPoints: 15, teamBPoints: 12, setNumber: 3 },
    ]);
    expect(result.valid).toBe(true);
  });

  it("rejects empty array", () => {
    expect(validateMatchResult([]).valid).toBe(false);
  });

  it("rejects 1 set only", () => {
    expect(
      validateMatchResult([{ teamAPoints: 21, teamBPoints: 15, setNumber: 1 }]).valid
    ).toBe(false);
  });

  it("rejects 4 sets", () => {
    const set = { teamAPoints: 21, teamBPoints: 15, setNumber: 1 };
    expect(validateMatchResult([set, set, set, set]).valid).toBe(false);
  });

  it("rejects sets with wrong set numbers (e.g. 1 and 3 only)", () => {
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 15, setNumber: 3 },
    ]);
    expect(result.valid).toBe(false);
  });

  it("rejects duplicate set numbers", () => {
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
    ]);
    expect(result.valid).toBe(false);
  });

  it("rejects invalid set 1 score (21-20, only 1 gap)", () => {
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 20, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 15, setNumber: 2 },
    ]);
    expect(result.valid).toBe(false);
  });

  it("rejects when set 1 score doesn't reach target (19-15)", () => {
    const result = validateMatchResult([
      { teamAPoints: 19, teamBPoints: 15, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 15, setNumber: 2 },
    ]);
    expect(result.valid).toBe(false);
  });

  it("rejects invalid decider set score (21-10 in set 3 — too far above 15)", () => {
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 18, setNumber: 1 },
      { teamAPoints: 17, teamBPoints: 21, setNumber: 2 },
      { teamAPoints: 21, teamBPoints: 10, setNumber: 3 },
    ]);
    expect(result.valid).toBe(false);
  });

  it("rejects when no team wins 2 sets (both win 1)", () => {
    // Can't happen with valid scores and 2 sets, but test the guard explicitly
    const result = validateMatchResult([
      { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
      { teamAPoints: 15, teamBPoints: 21, setNumber: 2 },
    ]);
    // Neither team won 2 sets → invalid
    expect(result.valid).toBe(false);
  });

  it("rejects non-array input", () => {
    expect(validateMatchResult(null as any).valid).toBe(false);
  });
});

describe("computeChampionshipPoints", () => {
  it("2-0 win: winner gets 3 pts, loser gets 0 pts", () => {
    const sets = [
      { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 18, setNumber: 2 },
    ];
    const result = computeChampionshipPoints(sets);
    expect(result.winner).toBe("teamA");
    expect(result.teamAPoints).toBe(3);
    expect(result.teamBPoints).toBe(0);
  });

  it("2-0 win by teamB: winner gets 3 pts, loser gets 0 pts", () => {
    const sets = [
      { teamAPoints: 15, teamBPoints: 21, setNumber: 1 },
      { teamAPoints: 18, teamBPoints: 21, setNumber: 2 },
    ];
    const result = computeChampionshipPoints(sets);
    expect(result.winner).toBe("teamB");
    expect(result.teamBPoints).toBe(3);
    expect(result.teamAPoints).toBe(0);
  });

  it("2-1 win by teamA: winner gets 2 pts, loser gets 1 pt", () => {
    const sets = [
      { teamAPoints: 21, teamBPoints: 18, setNumber: 1 },
      { teamAPoints: 17, teamBPoints: 21, setNumber: 2 },
      { teamAPoints: 15, teamBPoints: 12, setNumber: 3 },
    ];
    const result = computeChampionshipPoints(sets);
    expect(result.winner).toBe("teamA");
    expect(result.teamAPoints).toBe(2);
    expect(result.teamBPoints).toBe(1);
  });

  it("2-1 win by teamB: winner gets 2 pts, loser gets 1 pt", () => {
    const sets = [
      { teamAPoints: 18, teamBPoints: 21, setNumber: 1 },
      { teamAPoints: 21, teamBPoints: 18, setNumber: 2 },
      { teamAPoints: 12, teamBPoints: 15, setNumber: 3 },
    ];
    const result = computeChampionshipPoints(sets);
    expect(result.winner).toBe("teamB");
    expect(result.teamBPoints).toBe(2);
    expect(result.teamAPoints).toBe(1);
  });
});
