// Unit tests for deleteChampionship Cloud Function.
// Validates auth, admin check, status guard, and batched deletion of the
// championship doc plus its registered teams.

import { deleteChampionshipHandler } from "../../src/deleteChampionship";
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

const mockChampGet = jest.fn();
const mockTeamsGet = jest.fn();
const mockBatchDelete = jest.fn();
const mockBatchCommit = jest.fn();

const champRef = {
  get: mockChampGet,
  collection: jest.fn(() => ({ get: mockTeamsGet })),
};

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn(() => ({
          doc: jest.fn(() => champRef),
        })),
        batch: jest.fn(() => ({
          delete: mockBatchDelete,
          commit: mockBatchCommit,
        })),
      })),
      {
        FieldValue: { serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP") },
      }
    ),
  };
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function makeContext(uid: string | null = "admin-uid"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

const validData = { championshipId: "champ-123" };

const registrationChamp = { status: "registration", adminIds: ["admin-uid"] };
const closedChamp = { status: "registration_closed", adminIds: ["admin-uid"] };

function makeTeamsSnap(teamIds: string[]) {
  return {
    docs: teamIds.map((id) => ({ id, ref: { id } })),
  };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("deleteChampionship", () => {
  beforeEach(() => {
    jest.clearAllMocks();

    mockChampGet.mockResolvedValue({ exists: true, data: () => registrationChamp });
    mockTeamsGet.mockResolvedValue(makeTeamsSnap([]));
    mockBatchCommit.mockResolvedValue(undefined);
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth", async () => {
      await expect(
        deleteChampionshipHandler(validData, makeContext(null))
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Input validation ────────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when championshipId is missing", async () => {
      await expect(
        deleteChampionshipHandler({ championshipId: "" }, makeContext())
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });
  });

  // ── Championship validation ─────────────────────────────────────────────────

  describe("championship validation", () => {
    it("throws not-found when championship does not exist", async () => {
      mockChampGet.mockResolvedValue({ exists: false });

      await expect(
        deleteChampionshipHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "not-found" });
    });

    it("throws permission-denied when caller is not an admin", async () => {
      await expect(
        deleteChampionshipHandler(validData, makeContext("not-admin"))
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("throws failed-precondition when championship is active", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ status: "active", adminIds: ["admin-uid"] }),
      });

      await expect(
        deleteChampionshipHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("throws failed-precondition when championship is completed", async () => {
      mockChampGet.mockResolvedValue({
        exists: true,
        data: () => ({ status: "completed", adminIds: ["admin-uid"] }),
      });

      await expect(
        deleteChampionshipHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "failed-precondition" });
    });

    it("allows deletion when status is registration_closed", async () => {
      mockChampGet.mockResolvedValue({ exists: true, data: () => closedChamp });

      const result = await deleteChampionshipHandler(validData, makeContext());
      expect(result).toEqual({ championshipId: "champ-123" });
    });
  });

  // ── Successful deletion ──────────────────────────────────────────────────────

  describe("successful deletion", () => {
    it("returns the championshipId", async () => {
      const result = await deleteChampionshipHandler(validData, makeContext());
      expect(result).toEqual({ championshipId: "champ-123" });
    });

    it("deletes the championship doc", async () => {
      await deleteChampionshipHandler(validData, makeContext());
      expect(mockBatchDelete).toHaveBeenCalledWith(champRef);
    });

    it("deletes every registered team doc", async () => {
      mockTeamsGet.mockResolvedValue(makeTeamsSnap(["team-1", "team-2"]));

      await deleteChampionshipHandler(validData, makeContext());

      expect(mockBatchDelete).toHaveBeenCalledWith({ id: "team-1" });
      expect(mockBatchDelete).toHaveBeenCalledWith({ id: "team-2" });
      // + 1 for the championship doc itself
      expect(mockBatchDelete).toHaveBeenCalledTimes(3);
    });

    it("commits the batch", async () => {
      await deleteChampionshipHandler(validData, makeContext());
      expect(mockBatchCommit).toHaveBeenCalledTimes(1);
    });
  });

  // ── Error handling ──────────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when the batch commit fails", async () => {
      mockBatchCommit.mockRejectedValue(new Error("Firestore down"));

      await expect(
        deleteChampionshipHandler(validData, makeContext())
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
