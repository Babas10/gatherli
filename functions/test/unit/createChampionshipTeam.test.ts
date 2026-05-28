// Unit tests for createChampionshipTeam Cloud Function (Story 30.3).
// Validates auth, friendship check, duplicate membership, and atomic team creation.

import { createChampionshipTeamHandler } from "../../src/createChampionshipTeam";
import * as friendships from "../../src/friendships";
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

const mockTx = {
  get: jest.fn(),
  set: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
};
const mockRunTransaction = jest.fn();
const mockChampGet = jest.fn();
const mockTeamsWhere = jest.fn();
const mockTeamsDoc = jest.fn();

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
                get: mockChampGet,
                ref: { id: "champ-123" },
                collection: jest.fn(() => ({
                  where: mockTeamsWhere,
                  doc: mockTeamsDoc,
                })),
              })),
            };
          }
          return {};
        }),
        runTransaction: mockRunTransaction,
      })),
      {
        FieldValue: { serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP") },
      }
    ),
  };
});

// ── Mock friendships ──────────────────────────────────────────────────────────

jest.mock("../../src/friendships", () => ({
  checkFriendship: jest.fn(),
}));

// ── Helpers ───────────────────────────────────────────────────────────────────

function makeContext(uid: string | null = "caller-uid"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

const validData = {
  championshipId: "champ-123",
  teamName: "Beach Wolves",
  partnerId: "partner-uid",
};

const openChamp = {
  status: "registration",
  maxTeams: 10,
  teamsCount: 3,
};

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("createChampionshipTeam", () => {
  beforeEach(() => {
    jest.clearAllMocks();

    // Default: championship exists and is open
    mockChampGet.mockResolvedValue({ exists: true, data: () => openChamp, ref: { id: "champ-123" } });

    // Default: neither caller nor partner is in a team yet
    const emptySnapshot = { empty: true, docs: [] };
    mockTeamsWhere.mockReturnValue({
      where: mockTeamsWhere,
      limit: jest.fn().mockReturnValue({ get: jest.fn().mockResolvedValue(emptySnapshot) }),
    });

    // Default: checkFriendship returns true
    (friendships.checkFriendship as jest.Mock).mockResolvedValue(true);

    // Default: transaction succeeds
    mockRunTransaction.mockImplementation(async (fn: any) => {
      mockTx.get.mockResolvedValue({ data: () => openChamp });
      await fn(mockTx);
    });

    // Default: team doc ref with id
    mockTeamsDoc.mockReturnValue({ id: "team-abc", ref: {} });
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth", async () => {
      await expect(
        createChampionshipTeamHandler(validData, makeContext(null))
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Input validation ────────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when championshipId is missing", async () => {
      await expect(
        createChampionshipTeamHandler(
          { ...validData, championshipId: "" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when teamName is missing", async () => {
      await expect(
        createChampionshipTeamHandler(
          { ...validData, teamName: "" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when teamName is too short (1 char)", async () => {
      await expect(
        createChampionshipTeamHandler(
          { ...validData, teamName: "A" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when teamName exceeds 50 characters", async () => {
      await expect(
        createChampionshipTeamHandler(
          { ...validData, teamName: "A".repeat(51) },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when caller tries to invite themselves", async () => {
      await expect(
        createChampionshipTeamHandler(
          { ...validData, partnerId: "caller-uid" },
          makeContext("caller-uid")
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });
  });

  // ── Championship validation ─────────────────────────────────────────────────

  describe("championship validation", () => {
    it("throws not-found when championship does not exist", async () => {
      mockChampGet.mockResolvedValue({ exists: false });

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws failed-precondition when status is not registration", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, status: "active" }),
        ref: {},
      });

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("throws failed-precondition when championship is full", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...openChamp, teamsCount: 10, maxTeams: 10 }),
        ref: {},
      });

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });
  });

  // ── Friendship check ────────────────────────────────────────────────────────

  describe("friendship check", () => {
    it("throws permission-denied when partner is not a friend", async () => {
      (friendships.checkFriendship as jest.Mock).mockResolvedValue(false);

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "permission-denied" });
    });
  });

  // ── Duplicate membership ────────────────────────────────────────────────────

  describe("duplicate membership", () => {
    it("throws already-exists when caller is already in a team", async () => {
      const nonEmptySnapshot = { empty: false, docs: [{}] };
      // First where().limit().get() call (caller check) returns non-empty
      mockTeamsWhere.mockReturnValueOnce({
        limit: jest.fn().mockReturnValue({ get: jest.fn().mockResolvedValue(nonEmptySnapshot) }),
      });

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "already-exists" });
    });

    it("throws already-exists when partner is already in a team", async () => {
      const emptySnapshot = { empty: true, docs: [] };
      const nonEmptySnapshot = { empty: false, docs: [{}] };
      // First call (caller) → empty; second call (partner) → non-empty
      mockTeamsWhere
        .mockReturnValueOnce({
          limit: jest.fn().mockReturnValue({ get: jest.fn().mockResolvedValue(emptySnapshot) }),
        })
        .mockReturnValueOnce({
          limit: jest.fn().mockReturnValue({ get: jest.fn().mockResolvedValue(nonEmptySnapshot) }),
        });

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "already-exists" });
    });
  });

  // ── Successful creation ─────────────────────────────────────────────────────

  describe("successful creation", () => {
    it("returns teamId on success", async () => {
      const result = await createChampionshipTeamHandler(validData, makeContext());
      expect(result).toHaveProperty("teamId");
    });

    it("calls runTransaction to atomically create team and update championship", async () => {
      await createChampionshipTeamHandler(validData, makeContext());
      expect(mockRunTransaction).toHaveBeenCalledTimes(1);
    });

    it("sets status to registration_closed when this is the last team slot", async () => {
      // Championship has 9 teams, max is 10 → this team fills it
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ status: "registration", maxTeams: 10, teamsCount: 9 }),
        ref: {},
      });

      mockRunTransaction.mockImplementation(async (fn: any) => {
        mockTx.get.mockResolvedValue({
          data: () => ({ status: "registration", maxTeams: 10, teamsCount: 9 }),
        });
        await fn(mockTx);
      });

      await createChampionshipTeamHandler(validData, makeContext());

      expect(mockTx.update).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ status: "registration_closed", teamsCount: 10 })
      );
    });

    it("keeps status as registration when slots remain", async () => {
      mockRunTransaction.mockImplementation(async (fn: any) => {
        mockTx.get.mockResolvedValue({
          data: () => ({ status: "registration", maxTeams: 10, teamsCount: 3 }),
        });
        await fn(mockTx);
      });

      await createChampionshipTeamHandler(validData, makeContext());

      expect(mockTx.update).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ status: "registration", teamsCount: 4 })
      );
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when transaction fails with unexpected error", async () => {
      mockRunTransaction.mockRejectedValue(new Error("Firestore error"));

      await expect(
        createChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
