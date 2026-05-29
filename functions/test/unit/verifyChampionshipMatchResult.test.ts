// Unit tests for verifyChampionshipMatchResult Cloud Function (Story 30.7).
import { verifyChampionshipMatchResultHandler } from "../../src/verifyChampionshipMatchResult";
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
          doc: jest.fn(() => ({
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

function makeContext(uid: string | null = "user-team-b"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

/** Match as stored after Story 30.6 — status 'played', submitted by team-a */
const playedMatch = {
  status: "played",
  teamAId: "team-a",
  teamBId: "team-b",
  submittedByTeamId: "team-a",
  submittedByUserId: "user-team-a",
};

function makeTeamDoc(memberIds: string[]) {
  return { exists: true, data: () => ({ memberIds }) };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("verifyChampionshipMatchResult", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    mockMatchGet.mockResolvedValue({ exists: true, data: () => playedMatch });
    mockTeamAGet.mockResolvedValue(makeTeamDoc(["user-team-a", "user-team-a-2"]));
    mockTeamBGet.mockResolvedValue(makeTeamDoc(["user-team-b", "user-team-b-2"]));
    mockMatchUpdate.mockResolvedValue(undefined);
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext(null)
        )
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Input validation ────────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when championshipId is missing", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "", matchId: "match-1", action: "verify" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when matchId is missing", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "", action: "verify" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when action is not verify or dispute", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "approve" as any },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when action is dispute but disputeReason is missing", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "dispute" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when disputeReason is blank whitespace", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "dispute", disputeReason: "   " },
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
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws failed-precondition when status is pending", async () => {
      mockMatchGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...playedMatch, status: "pending" }),
      });
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("throws failed-precondition when match is already verified", async () => {
      mockMatchGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...playedMatch, status: "verified" }),
      });
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });
  });

  // ── Permission checks ───────────────────────────────────────────────────────

  describe("permission checks", () => {
    it("throws permission-denied when caller is not in either team", async () => {
      mockTeamAGet.mockResolvedValue(makeTeamDoc(["someone-else-1"]));
      mockTeamBGet.mockResolvedValue(makeTeamDoc(["someone-else-2"]));
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext("outsider")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("throws permission-denied when caller is the submitting team (team-a trying to verify)", async () => {
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext("user-team-a") // team-a submitted, so team-a cannot verify
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("allows verify by teamB member (the non-submitting team)", async () => {
      const result = await verifyChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", action: "verify" },
        makeContext("user-team-b")
      );
      expect(result.status).toBe("verified");
    });
  });

  // ── Successful verification ─────────────────────────────────────────────────

  describe("successful verification", () => {
    it("returns { status: 'verified' } on verify action", async () => {
      const result = await verifyChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", action: "verify" },
        makeContext()
      );
      expect(result).toEqual({ status: "verified" });
    });

    it("sets status to 'verified' in Firestore", async () => {
      await verifyChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", action: "verify" },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({ status: "verified" })
      );
    });

    it("stores verifiedByTeamId and verifiedByUserId", async () => {
      await verifyChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", action: "verify" },
        makeContext("user-team-b")
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({
          verifiedByTeamId: "team-b",
          verifiedByUserId: "user-team-b",
        })
      );
    });

    it("stores a verifiedAt server timestamp", async () => {
      await verifyChampionshipMatchResultHandler(
        { championshipId: "champ-1", matchId: "match-1", action: "verify" },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({ verifiedAt: "MOCK_TIMESTAMP" })
      );
    });
  });

  // ── Successful dispute ──────────────────────────────────────────────────────

  describe("successful dispute", () => {
    it("returns { status: 'disputed' } on dispute action", async () => {
      const result = await verifyChampionshipMatchResultHandler(
        {
          championshipId: "champ-1",
          matchId: "match-1",
          action: "dispute",
          disputeReason: "The scores were recorded incorrectly",
        },
        makeContext()
      );
      expect(result).toEqual({ status: "disputed" });
    });

    it("sets status to 'disputed' in Firestore", async () => {
      await verifyChampionshipMatchResultHandler(
        {
          championshipId: "champ-1",
          matchId: "match-1",
          action: "dispute",
          disputeReason: "Wrong scores",
        },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({ status: "disputed" })
      );
    });

    it("stores the trimmed disputeReason in Firestore", async () => {
      await verifyChampionshipMatchResultHandler(
        {
          championshipId: "champ-1",
          matchId: "match-1",
          action: "dispute",
          disputeReason: "  Wrong scores  ",
        },
        makeContext()
      );
      expect(mockMatchUpdate).toHaveBeenCalledWith(
        expect.objectContaining({ disputeReason: "Wrong scores" })
      );
    });

    it("does NOT store verifiedByTeamId or verifiedAt on dispute", async () => {
      await verifyChampionshipMatchResultHandler(
        {
          championshipId: "champ-1",
          matchId: "match-1",
          action: "dispute",
          disputeReason: "Wrong scores",
        },
        makeContext()
      );
      const updateArg = mockMatchUpdate.mock.calls[0][0];
      expect(updateArg).not.toHaveProperty("verifiedByTeamId");
      expect(updateArg).not.toHaveProperty("verifiedAt");
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when match update fails", async () => {
      mockMatchUpdate.mockRejectedValue(new Error("Firestore unavailable"));
      await expect(
        verifyChampionshipMatchResultHandler(
          { championshipId: "champ-1", matchId: "match-1", action: "verify" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
