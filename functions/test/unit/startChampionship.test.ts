// Unit tests for startChampionship Cloud Function (Story 30.4).
// Validates auth, admin check, precondition checks, and batch write on success.

import { startChampionshipHandler } from "../../src/startChampionship";
import type * as functionsTypes from "firebase-functions";

// ── Mock firebase-functions ───────────────────────────────────────────────────

jest.mock("firebase-functions", () => {
  const fn: any = {
    https: {
      HttpsError: class HttpsError extends Error {
        code: string;
        constructor(code: string, message: string) {
          super(message);
          this.code = code;
          this.name = "HttpsError";
        }
      },
      onCall: jest.fn((h: any) => h),
    },
    logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn() },
  };
  fn.region = jest.fn(() => fn);
  fn.runWith = jest.fn(() => fn);
  return fn;
});

// ── Mock roundRobinFixtures ───────────────────────────────────────────────────

jest.mock("../../src/roundRobinFixtures", () => ({
  generateRoundRobinFixtures: jest.fn(),
}));

import { generateRoundRobinFixtures } from "../../src/roundRobinFixtures";

// ── Mock firebase-admin ───────────────────────────────────────────────────────

const mockBatchSet = jest.fn();
const mockBatchUpdate = jest.fn();
const mockBatchCommit = jest.fn();
const mockBatch = {
  set: mockBatchSet,
  update: mockBatchUpdate,
  commit: mockBatchCommit,
};

const mockChampGet = jest.fn();
const mockTeamsGet = jest.fn();
const mockMatchesDoc = jest.fn(() => ({ id: "match-new" }));
const mockStandingsDoc = jest.fn(() => ({}));

const champRef = {
  get: mockChampGet,
  update: jest.fn(),
  collection: jest.fn((col: string) => {
    if (col === "teams") return { get: mockTeamsGet };
    if (col === "matches") return { doc: mockMatchesDoc };
    if (col === "standings") return { doc: mockStandingsDoc };
    return {};
  }),
};

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn(() => ({ doc: jest.fn(() => champRef) })),
        batch: jest.fn(() => mockBatch),
      })),
      {
        FieldValue: { serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP") },
        Timestamp: {
          fromDate: jest.fn((d: Date) => ({ _seconds: Math.floor(d.getTime() / 1000) })),
        },
      }
    ),
  };
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function makeContext(uid: string | null = "admin-uid"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

function futureDate(offsetDays = 30): string {
  const d = new Date();
  d.setDate(d.getDate() + offsetDays);
  return d.toISOString();
}

const openChamp = {
  status: "registration_closed",
  maxTeams: 10,
  teamsCount: 10,
  adminIds: ["admin-uid"],
};

function makeTeamDocs(n: number) {
  return Array.from({ length: n }, (_, i) => ({
    id: `team-${i}`,
    data: () => ({ name: `Team ${i}` }),
  }));
}

function makeFixtures(n: number) {
  const start = new Date();
  const deadline = new Date(start);
  deadline.setDate(deadline.getDate() + 21);
  return Array.from({ length: n }, (_, i) => ({
    round: Math.floor(i / 5) + 1,
    teamAId: `team-${i % 10}`,
    teamBId: `team-${(i + 1) % 10}`,
    roundStartDate: start,
    deadline,
  }));
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("startChampionship", () => {
  beforeEach(() => {
    jest.clearAllMocks();

    mockChampGet.mockResolvedValue({ exists: true, data: () => openChamp });
    mockTeamsGet.mockResolvedValue({
      size: 10,
      docs: makeTeamDocs(10),
    });
    (generateRoundRobinFixtures as jest.Mock).mockReturnValue(makeFixtures(45));
    mockBatchCommit.mockResolvedValue(undefined);
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth", async () => {
      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext(null)
        )
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Input validation ────────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when championshipId is missing", async () => {
      await expect(
        startChampionshipHandler(
          { championshipId: "", startDate: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when startDate is missing", async () => {
      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: "" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when startDate is not a valid date", async () => {
      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: "not-a-date" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });
  });

  // ── Championship validation ─────────────────────────────────────────────────

  describe("championship validation", () => {
    it("throws not-found when championship does not exist", async () => {
      mockChampGet.mockResolvedValue({ exists: false });

      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws permission-denied when caller is not in adminIds", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, adminIds: ["someone-else"] }),
      });

      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext("not-admin")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("throws failed-precondition when status is already active", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, status: "active" }),
      });

      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("throws failed-precondition when status is completed", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, status: "completed" }),
      });

      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("throws failed-precondition when teamsCount < maxTeams", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, teamsCount: 8, maxTeams: 10 }),
      });

      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("allows start when status is registration (not yet closed)", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, status: "registration" }),
      });

      const result = await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      expect(result.matchesCreated).toBe(45);
    });
  });

  // ── Successful start ────────────────────────────────────────────────────────

  describe("successful start", () => {
    it("returns matchesCreated: 45", async () => {
      const result = await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      expect(result).toEqual({ matchesCreated: 45 });
    });

    it("calls batch.commit once", async () => {
      await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      expect(mockBatchCommit).toHaveBeenCalledTimes(1);
    });

    it("batch-sets 45 match documents", async () => {
      await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      const matchSets = mockBatchSet.mock.calls.filter(
        ([, data]) => data.status === "pending"
      );
      expect(matchSets).toHaveLength(45);
    });

    it("batch-sets 10 standings documents (all zeros)", async () => {
      await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      const standingSets = mockBatchSet.mock.calls.filter(
        ([, data]) => data.points === 0 && data.played === 0
      );
      expect(standingSets).toHaveLength(10);
    });

    it("batch-updates championship to status active with currentRound 1", async () => {
      await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      expect(mockBatchUpdate).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ status: "active", currentRound: 1 })
      );
    });

    it("passes startDate to generateRoundRobinFixtures", async () => {
      const dateStr = "2026-09-01T00:00:00.000Z";

      await startChampionshipHandler(
        { championshipId: "champ-1", startDate: dateStr },
        makeContext()
      );

      expect(generateRoundRobinFixtures).toHaveBeenCalledWith(
        expect.any(Array),
        expect.objectContaining({ toISOString: expect.any(Function) })
      );
      const callArgs = (generateRoundRobinFixtures as jest.Mock).mock.calls[0];
      expect((callArgs[1] as Date).toISOString()).toBe(dateStr);
    });

    it("each match document has standingsUpdated: false", async () => {
      await startChampionshipHandler(
        { championshipId: "champ-1", startDate: futureDate() },
        makeContext()
      );

      const matchSets = mockBatchSet.mock.calls.filter(
        ([, data]) => data.status === "pending"
      );
      for (const [, data] of matchSets) {
        expect(data.standingsUpdated).toBe(false);
      }
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when batch.commit fails", async () => {
      mockBatchCommit.mockRejectedValue(new Error("Firestore unavailable"));

      await expect(
        startChampionshipHandler(
          { championshipId: "champ-1", startDate: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
