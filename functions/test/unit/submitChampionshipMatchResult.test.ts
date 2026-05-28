// Unit tests for submitChampionshipMatchResult Cloud Function (Story 30.6).
import { submitChampionshipMatchResultHandler } from "../../src/submitChampionshipMatchResult";
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

// ── Mock scoreValidation (spy on real implementation) ────────────────────────

jest.mock("../../src/scoreValidation", () => {
  const actual = jest.requireActual("../../src/scoreValidation");
  return {
    ...actual,
    validateMatchResult: jest.fn(actual.validateMatchResult),
    computeChampionshipPoints: jest.fn(actual.computeChampionshipPoints),
  };
});

// ── Mock firebase-admin ───────────────────────────────────────────────────────

const mockMatchUpdate = jest.fn();
const mockMatchGet = jest.fn();
const mockTeamAGet = jest.fn();
const mockTeamBGet = jest.fn();

const matchRef = {
  get: mockMatchGet,
  update: mockMatchUpdate,
};

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn(() => ({
          doc: jest.fn((champId: string) => ({
            collection: jest.fn((col: string) => ({
              doc: jest.fn((id: string) => {
                if (col === "matches") return matchRef;
                if (col === "teams") {
                  if (id === "team-a") return { get: mockTeamAGet };
                  if (id === "team-b") return { get: mockTeamBGet };
                }
                return { get: jest.fn() };
              }),
            })),
          })),
        })),
      })),
      {
        FieldValue: { serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP") },
      }
    ),
  };
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function makeContext(uid: string | null = "user-team-a"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

const validSets2_0 = [
  { teamAPoints: 21, teamBPoints: 15, setNumber: 1 },
  { teamAPoints: 21, teamBPoints: 18, setNumber: 2 },
];

const validSets2_1 = [
  { teamAPoints: 21, teamBPoints: 18, setNumber: 1 },
  { teamAPoints: 17, teamBPoints: 21, setNumber: 2 },
  { teamAPoints: 15, teamBPoints: 12, setNumber: 3 },
];

const pendingMatch = {
  status: "pending",
  teamAId: "team-a",
  teamBId: "team-b",
};

function makeTeamDoc(memberIds: string[]) {
  return { exists: true, data: () => ({ memberIds }) };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("submitChampionshipMatchResult", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    mockMatchGet.mockResolvedValue({ exists: true, data: () => pendingMatch });
    mockTeamAGet.mockResolvedValue(makeTeamDoc(["user-team-a", "user-team-a-2"]));
    mockTeamBGet.mockResolvedValue(makeTeamDoc(["user-team-b", "user-team-b-2"]));
    mockMatchUpdate.mockResolvedValue(undefined);
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth", async () => {
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
          makeContext(null)
        )
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Input validation ────────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when championshipId is missing", async () => {
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "", matchId: "match-1", sets: validSets2_0 },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when matchId is missing", async () => {
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "", sets: validSets2_0 },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when sets is missing", async () => {
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: [] },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument for invalid set scores (21-20 gap)", async () => {
      await expect(
        submitChampionshipMatchResultHandler(
          {
            championshipId: "champ-1",
            matchId: "match-1",
            sets: [
              { teamAPoints: 21, teamBPoints: 20, setNumber: 1 },
              { teamAPoints: 21, teamBPoints: 15, setNumber: 2 },
            ],
          },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument for score not reaching target (19-15)", async () => {
      await expect(
        submitChampionshipMatchResultHandler(
          {
            championshipId: "champ-1",
            matchId: "match-1",
            sets: [
              { teamAPoints: 19, teamBPoints: 15, setNumber: 1 },
              { teamAPoints: 21, teamBPoints: 15, setNumber: 2 },
            ],
          },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });
  });

  // ── Match validation ────────────────────────────────────────────────────────

  describe("match validation", () => {
    it("throws not-found when match does not exist", async () => {
      mockMatchGet.mockResolvedValue({ exists: false });
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws failed-precondition when match is already played", async () => {
      mockMatchGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...pendingMatch, status: "played" }),
      });
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("throws failed-precondition when match is verified", async () => {
      mockMatchGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...pendingMatch, status: "verified" }),
      });
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("allows submission when match is scheduled", async () => {
      mockMatchGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...pendingMatch, status: "scheduled" }),
      });
      const result = await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext()
      );
      expect(result.pendingVerification).toBe(true);
    });
  });

  // ── Permission check ────────────────────────────────────────────────────────

  describe("permission check", () => {
    it("throws permission-denied when caller is not in either team", async () => {
      mockTeamAGet.mockResolvedValue(makeTeamDoc(["other-user-1", "other-user-2"]));
      mockTeamBGet.mockResolvedValue(makeTeamDoc(["other-user-3", "other-user-4"]));
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
          makeContext("not-a-member")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("allows submission by teamB member", async () => {
      const result = await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext("user-team-b")
      );
      expect(result.pendingVerification).toBe(true);
    });
  });

  // ── Successful submission ───────────────────────────────────────────────────

  describe("successful submission", () => {
    it("returns { matchId, pendingVerification: true } for 2-0 result", async () => {
      const result = await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext()
      );
      expect(result).toEqual({ matchId: "match-1", pendingVerification: true });
    });

    it("returns { matchId, pendingVerification: true } for 2-1 result", async () => {
      const result = await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_1 },
        makeContext()
      );
      expect(result).toEqual({ matchId: "match-1", pendingVerification: true });
    });

    it("updates match status to 'played'", async () => {
      await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({ status: "played" })
      );
    });

    it("stores submittedByTeamId and submittedByUserId", async () => {
      await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext("user-team-a")
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({
          submittedByTeamId: "team-a",
          submittedByUserId: "user-team-a",
        })
      );
    });

    it("stores correct result for 2-0 win by teamA (3 pts vs 0 pts)", async () => {
      await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({
          result: expect.objectContaining({
            winner: "teamA",
            teamAPoints: 3,
            teamBPoints: 0,
          }),
        })
      );
    });

    it("stores correct result for 2-1 win by teamA (2 pts vs 1 pt)", async () => {
      await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_1 },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({
          result: expect.objectContaining({
            winner: "teamA",
            teamAPoints: 2,
            teamBPoints: 1,
          }),
        })
      );
    });

    it("submittedByTeamId is teamB when submitted by teamB member", async () => {
      await submitChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
        makeContext("user-team-b")
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({ submittedByTeamId: "team-b" })
      );
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when match update fails", async () => {
      mockMatchUpdate.mockRejectedValue(new Error("Firestore unavailable"));
      await expect(
        submitChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", sets: validSets2_0 },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
