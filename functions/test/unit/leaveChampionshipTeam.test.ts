// Unit tests for leaveChampionshipTeam Cloud Function (Story 30.3).
// Validates auth, membership check, registration-phase guard, and atomic deletion.

import { leaveChampionshipTeamHandler } from "../../src/leaveChampionshipTeam";
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
  delete: jest.fn(),
  update: jest.fn(),
};
const mockRunTransaction = jest.fn();
const mockChampGet = jest.fn();
const mockTeamGet = jest.fn();

const champRef = { get: mockChampGet };
const teamRef = { get: mockTeamGet };

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn(() => ({
          doc: jest.fn(() => ({
            ...champRef,
            collection: jest.fn(() => ({
              doc: jest.fn(() => teamRef),
            })),
          })),
        })),
        runTransaction: mockRunTransaction,
      })),
      {
        FieldValue: { serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP") },
      }
    ),
  };
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function makeContext(uid: string | null = "caller-uid"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

const validData = { championshipId: "champ-123", teamId: "team-abc" };

const registrationChamp = { status: "registration", teamsCount: 5, maxTeams: 10 };
const closedChamp = { status: "registration_closed", teamsCount: 10, maxTeams: 10 };
const teamWithCaller = { memberIds: ["caller-uid", "partner-uid"] };

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("leaveChampionshipTeam", () => {
  beforeEach(() => {
    jest.clearAllMocks();

    mockChampGet.mockResolvedValue({ exists: true, data: () => registrationChamp });
    mockTeamGet.mockResolvedValue({ exists: true, data: () => teamWithCaller });

    mockRunTransaction.mockImplementation(async (fn: any) => {
      mockTx.get.mockResolvedValue({ data: () => registrationChamp });
      await fn(mockTx);
    });
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth", async () => {
      await expect(
        leaveChampionshipTeamHandler(validData, makeContext(null))
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Input validation ────────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when championshipId is missing", async () => {
      await expect(
        leaveChampionshipTeamHandler({ ...validData, championshipId: "" }, makeContext())
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when teamId is missing", async () => {
      await expect(
        leaveChampionshipTeamHandler({ ...validData, teamId: "" }, makeContext())
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });
  });

  // ── Championship & team validation ─────────────────────────────────────────

  describe("championship & team validation", () => {
    it("throws not-found when championship does not exist", async () => {
      mockChampGet.mockResolvedValue({ exists: false });

      await expect(
        leaveChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws not-found when team does not exist", async () => {
      mockTeamGet.mockResolvedValue({ exists: false });

      await expect(
        leaveChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws failed-precondition when championship is active", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ ...registrationChamp, status: "active" }),
      });

      await expect(
        leaveChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("allows leaving when status is registration_closed", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => closedChamp,
      });
      mockRunTransaction.mockImplementation(async (fn: any) => {
        mockTx.get.mockResolvedValue({ data: () => closedChamp });
        await fn(mockTx);
      });

      const result = await leaveChampionshipTeamHandler(validData, makeContext());
      expect(result).toEqual({ success: true });
    });

    it("throws permission-denied when caller is not a team member", async () => {
      mockTeamGet.mockResolvedValue({
        exists: true,
        data: () => ({ memberIds: ["someone-else", "another-person"] }),
      });

      await expect(
        leaveChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "permission-denied" });
    });
  });

  // ── Successful leave ────────────────────────────────────────────────────────

  describe("successful leave", () => {
    it("returns success: true", async () => {
      const result = await leaveChampionshipTeamHandler(validData, makeContext());
      expect(result).toEqual({ success: true });
    });

    it("calls runTransaction to atomically delete team and update championship", async () => {
      await leaveChampionshipTeamHandler(validData, makeContext());
      expect(mockRunTransaction).toHaveBeenCalledTimes(1);
    });

    it("resets status to registration even when it was registration_closed", async () => {
      mockChampGet.mockResolvedValue({ exists: true, data: () => closedChamp });
      mockTeamGet.mockResolvedValue({ exists: true, data: () => teamWithCaller });
      mockRunTransaction.mockImplementation(async (fn: any) => {
        mockTx.get.mockResolvedValue({ data: () => closedChamp });
        await fn(mockTx);
      });

      await leaveChampionshipTeamHandler(validData, makeContext());

      expect(mockTx.update).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ status: "registration" })
      );
    });

    it("decrements teamsCount by 1", async () => {
      await leaveChampionshipTeamHandler(validData, makeContext());

      expect(mockTx.update).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ teamsCount: 4 }) // was 5
      );
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when transaction fails with unexpected error", async () => {
      mockRunTransaction.mockRejectedValue(new Error("Firestore down"));

      await expect(
        leaveChampionshipTeamHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
