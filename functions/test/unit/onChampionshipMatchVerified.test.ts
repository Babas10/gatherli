// Unit tests for onChampionshipMatchVerified Firestore trigger (Story 30.8).
import { onChampionshipMatchVerifiedHandler } from "../../src/onChampionshipMatchVerified";

// ── Mock firebase-functions ───────────────────────────────────────────────────

jest.mock("firebase-functions", () => {
  const fn: any = {
    logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn() },
  };
  fn.region = jest.fn(() => fn);
  fn.runWith = jest.fn(() => fn);
  fn.firestore = {
    document: jest.fn(() => ({
      onUpdate: jest.fn(),
    })),
  };
  return fn;
});

// ── Mock firebase-admin ───────────────────────────────────────────────────────

const mockBatchSet = jest.fn();
const mockBatchUpdate = jest.fn();
const mockBatchCommit = jest.fn();
const mockBatch = {
  set: mockBatchSet,
  update: mockBatchUpdate,
  commit: mockBatchCommit,
};

const mockStandingsGet = jest.fn();
const mockMatchesWhereGet = jest.fn();
const mockMatchesWhere = jest.fn(() => ({ get: mockMatchesWhereGet }));

// We need per-doc refs for standings and matches
const mockStandingsDocRefs: Record<string, any> = {};
const mockMatchDocRef = { update: jest.fn() };

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn((col: string) => {
          if (col === "championships") {
            return {
              doc: jest.fn(() => ({
                collection: jest.fn((subCol: string) => {
                  if (subCol === "standings") {
                    return {
                      get: mockStandingsGet,
                      doc: jest.fn((id: string) => {
                        if (!mockStandingsDocRefs[id]) {
                          mockStandingsDocRefs[id] = { id, set: jest.fn() };
                        }
                        return mockStandingsDocRefs[id];
                      }),
                    };
                  }
                  if (subCol === "matches") {
                    return {
                      where: mockMatchesWhere,
                      doc: jest.fn(() => mockMatchDocRef),
                    };
                  }
                  return {};
                }),
              })),
            };
          }
          return {};
        }),
        batch: jest.fn(() => mockBatch),
      })),
      actual.firestore
    ),
    initializeApp: jest.fn(),
  };
});

// ============================================================================
// Helpers
// ============================================================================

function makeSnapshot(data: Record<string, any> | null): any {
  return {
    data: () => data,
    exists: data !== null,
  };
}

function standingsDoc(
  id: string,
  overrides: Record<string, any> = {}
): { id: string; data: () => Record<string, any> } {
  return {
    id,
    data: () => ({
      teamName: `Team ${id}`,
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
    }),
  };
}

const defaultMatchData = {
  teamAId: "team-a",
  teamBId: "team-b",
  status: "verified",
  standingsUpdated: false,
  result: {
    sets: [
      { teamAPoints: 21, teamBPoints: 15 },
      { teamAPoints: 21, teamBPoints: 18 },
    ],
    winner: "teamA",
    teamAPoints: 3,
    teamBPoints: 0,
  },
};

const defaultParams = { championshipId: "champ-1", matchId: "match-1" };

function setupDefaultMocks(): void {
  mockStandingsGet.mockResolvedValue({
    docs: [standingsDoc("team-a"), standingsDoc("team-b")],
  });
  mockMatchesWhereGet.mockResolvedValue({ docs: [] });
  mockBatchCommit.mockResolvedValue(undefined);
}

// ============================================================================
// Tests
// ============================================================================

describe("onChampionshipMatchVerifiedHandler", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  // ── Early return guards ────────────────────────────────────────────────────

  test("returns early if status is not verified or admin_decided", async () => {
    const before = makeSnapshot({ ...defaultMatchData, status: "played" });
    const after = makeSnapshot({ ...defaultMatchData, status: "played" });

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockStandingsGet).not.toHaveBeenCalled();
    expect(mockBatchCommit).not.toHaveBeenCalled();
  });

  test("returns early if after data is null", async () => {
    const before = makeSnapshot(defaultMatchData);
    const after = makeSnapshot(null);

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockStandingsGet).not.toHaveBeenCalled();
  });

  test("returns early if standingsUpdated is already true (idempotency)", async () => {
    const before = makeSnapshot({ ...defaultMatchData, standingsUpdated: true });
    const after = makeSnapshot({ ...defaultMatchData, standingsUpdated: true });

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockStandingsGet).not.toHaveBeenCalled();
    expect(mockBatchCommit).not.toHaveBeenCalled();
  });

  test("returns early if match result is missing", async () => {
    const before = makeSnapshot({ ...defaultMatchData, result: undefined, status: "played" });
    const after = makeSnapshot({ ...defaultMatchData, result: undefined });

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockBatchCommit).not.toHaveBeenCalled();
  });

  test("returns early if match result.winner is missing", async () => {
    const noWinner = { ...defaultMatchData, result: { ...defaultMatchData.result, winner: undefined } };
    const before = makeSnapshot({ ...noWinner, status: "played" });
    const after = makeSnapshot(noWinner);

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockBatchCommit).not.toHaveBeenCalled();
  });

  // ── Happy path: 2-0 win ────────────────────────────────────────────────────

  test("updates standings for a 2-0 win and marks standingsUpdated=true", async () => {
    setupDefaultMocks();
    const before = makeSnapshot({ ...defaultMatchData, status: "played" });
    const after = makeSnapshot(defaultMatchData);

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockBatchCommit).toHaveBeenCalledTimes(1);
    expect(mockBatchUpdate).toHaveBeenCalledWith(
      expect.anything(),
      { standingsUpdated: true }
    );

    // batch.set called for each standings row (2 teams)
    expect(mockBatchSet).toHaveBeenCalledTimes(2);

    // Verify teamA standings: 3 pts, wins20
    const teamASetCall = mockBatchSet.mock.calls.find(
      ([ref]) => ref.id === "team-a"
    );
    expect(teamASetCall).toBeDefined();
    const teamAData = teamASetCall![1];
    expect(teamAData.points).toBe(3);
    expect(teamAData.wins20).toBe(1);
    expect(teamAData.wins21).toBe(0);
    expect(teamAData.losses02).toBe(0);
    expect(teamAData.played).toBe(1);

    // Verify teamB standings: 0 pts, losses02
    const teamBSetCall = mockBatchSet.mock.calls.find(
      ([ref]) => ref.id === "team-b"
    );
    expect(teamBSetCall).toBeDefined();
    const teamBData = teamBSetCall![1];
    expect(teamBData.points).toBe(0);
    expect(teamBData.losses02).toBe(1);
    expect(teamBData.wins20).toBe(0);
    expect(teamBData.played).toBe(1);
  });

  // ── Happy path: 2-1 win ────────────────────────────────────────────────────

  test("updates standings for a 2-1 win: winner gets 2 pts wins21, loser gets 1 pt losses12", async () => {
    const match2_1 = {
      ...defaultMatchData,
      result: {
        sets: [
          { teamAPoints: 21, teamBPoints: 15 },
          { teamAPoints: 14, teamBPoints: 21 },
          { teamAPoints: 15, teamBPoints: 12 },
        ],
        winner: "teamA",
        teamAPoints: 2,
        teamBPoints: 1,
      },
    };

    mockStandingsGet.mockResolvedValue({
      docs: [standingsDoc("team-a"), standingsDoc("team-b")],
    });
    mockMatchesWhereGet.mockResolvedValue({ docs: [] });
    mockBatchCommit.mockResolvedValue(undefined);

    const before = makeSnapshot({ ...match2_1, status: "played" });
    const after = makeSnapshot(match2_1);

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockBatchCommit).toHaveBeenCalledTimes(1);

    const teamASetCall = mockBatchSet.mock.calls.find(([ref]) => ref.id === "team-a");
    const teamAData = teamASetCall![1];
    expect(teamAData.points).toBe(2);
    expect(teamAData.wins21).toBe(1);
    expect(teamAData.wins20).toBe(0);

    const teamBSetCall = mockBatchSet.mock.calls.find(([ref]) => ref.id === "team-b");
    const teamBData = teamBSetCall![1];
    expect(teamBData.points).toBe(1);
    expect(teamBData.losses12).toBe(1);
    expect(teamBData.losses02).toBe(0);
  });

  // ── admin_decided status ───────────────────────────────────────────────────

  test("also processes admin_decided status", async () => {
    setupDefaultMocks();
    const adminDecided = { ...defaultMatchData, status: "admin_decided" };
    const before = makeSnapshot({ ...adminDecided, status: "disputed" });
    const after = makeSnapshot(adminDecided);

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockBatchCommit).toHaveBeenCalledTimes(1);
  });

  // ── Missing standings rows ─────────────────────────────────────────────────

  test("returns early without writing if standings rows are missing for a team", async () => {
    // Only teamA standings exist, teamB is missing
    mockStandingsGet.mockResolvedValue({ docs: [standingsDoc("team-a")] });
    mockMatchesWhereGet.mockResolvedValue({ docs: [] });

    const before = makeSnapshot({ ...defaultMatchData, status: "played" });
    const after = makeSnapshot(defaultMatchData);

    await onChampionshipMatchVerifiedHandler(before, after, defaultParams);

    expect(mockBatchCommit).not.toHaveBeenCalled();
  });

  // ── Batch commit failure ───────────────────────────────────────────────────

  test("re-throws error if batch commit fails", async () => {
    setupDefaultMocks();
    mockBatchCommit.mockRejectedValue(new Error("Firestore write error"));

    const before = makeSnapshot({ ...defaultMatchData, status: "played" });
    const after = makeSnapshot(defaultMatchData);

    await expect(
      onChampionshipMatchVerifiedHandler(before, after, defaultParams)
    ).rejects.toThrow("Firestore write error");
  });
});
