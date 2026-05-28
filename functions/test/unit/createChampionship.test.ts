// Unit tests for createChampionship Cloud Function (Story 30.2).
// Validates admin check, input validation, and successful document creation.

import { createChampionshipHandler } from "../../src/createChampionship";
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
      onCall: jest.fn((handler: any) => handler),
    },
    logger: {
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
    },
  };
  fn.region = jest.fn(() => fn);
  fn.runWith = jest.fn(() => fn);
  return fn;
});

// ── Mock firebase-admin ───────────────────────────────────────────────────────

const mockAdd = jest.fn();
const mockAdminDocGet = jest.fn();

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn((col: string) => {
          if (col === "platform_admins") {
            return { doc: jest.fn(() => ({ get: mockAdminDocGet })) };
          }
          if (col === "championships") {
            return { add: mockAdd };
          }
          return {};
        }),
      })),
      {
        FieldValue: {
          serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP"),
        },
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

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("createChampionship", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    // Default: caller is a platform admin
    mockAdminDocGet.mockResolvedValue({ exists: true });
    // Default: Firestore add resolves with a doc id
    mockAdd.mockResolvedValue({ id: "champ-123" });
  });

  // ── Authentication ─────────────────────────────────────────────────────────

  describe("authentication", () => {
    it("throws unauthenticated when no auth context", async () => {
      await expect(
        createChampionshipHandler(
          { title: "Summer Championship", registrationDeadline: futureDate() },
          makeContext(null)
        )
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });
  });

  // ── Admin check ────────────────────────────────────────────────────────────

  describe("admin permission", () => {
    it("throws permission-denied when caller is not a platform admin", async () => {
      mockAdminDocGet.mockResolvedValue({ exists: false });

      await expect(
        createChampionshipHandler(
          { title: "Summer Championship", registrationDeadline: futureDate() },
          makeContext("regular-user")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("proceeds when caller is a platform admin", async () => {
      mockAdminDocGet.mockResolvedValue({ exists: true });

      const result = await createChampionshipHandler(
        { title: "Summer Championship", registrationDeadline: futureDate() },
        makeContext("admin-uid")
      );

      expect(result).toEqual({ championshipId: "champ-123" });
    });
  });

  // ── Input validation ───────────────────────────────────────────────────────

  describe("input validation", () => {
    it("throws invalid-argument when title is missing", async () => {
      await expect(
        createChampionshipHandler(
          { title: "", registrationDeadline: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when title is too short (< 3 chars)", async () => {
      await expect(
        createChampionshipHandler(
          { title: "AB", registrationDeadline: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when title exceeds 100 characters", async () => {
      await expect(
        createChampionshipHandler(
          { title: "A".repeat(101), registrationDeadline: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when registrationDeadline is missing", async () => {
      await expect(
        createChampionshipHandler(
          { title: "Summer Championship" } as any,
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when registrationDeadline is not a valid date", async () => {
      await expect(
        createChampionshipHandler(
          { title: "Summer Championship", registrationDeadline: "not-a-date" },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("throws invalid-argument when registrationDeadline is in the past", async () => {
      const pastDate = new Date();
      pastDate.setDate(pastDate.getDate() - 1);

      await expect(
        createChampionshipHandler(
          { title: "Summer Championship", registrationDeadline: pastDate.toISOString() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });
  });

  // ── Successful creation ────────────────────────────────────────────────────

  describe("successful creation", () => {
    it("creates championship with required fields and correct defaults", async () => {
      const deadline = futureDate(30);

      await createChampionshipHandler(
        { title: "Summer Championship 2026", registrationDeadline: deadline },
        makeContext("admin-uid")
      );

      expect(mockAdd).toHaveBeenCalledTimes(1);
      const [written] = mockAdd.mock.calls[0];
      expect(written).toMatchObject({
        title: "Summer Championship 2026",
        status: "registration",
        maxTeams: 10,
        teamSize: 2,
        adminIds: ["admin-uid"],
        currentRound: 0,
        totalRounds: 9,
        teamsCount: 0,
        createdBy: "admin-uid",
      });
    });

    it("returns the new championship id", async () => {
      mockAdd.mockResolvedValue({ id: "new-champ-id" });

      const result = await createChampionshipHandler(
        { title: "Winter Cup", registrationDeadline: futureDate() },
        makeContext("admin-uid")
      );

      expect(result).toEqual({ championshipId: "new-champ-id" });
    });

    it("stores optional country in uppercase", async () => {
      await createChampionshipHandler(
        { title: "French Open", registrationDeadline: futureDate(), country: "fr" },
        makeContext("admin-uid")
      );

      const [written] = mockAdd.mock.calls[0];
      expect(written.country).toBe("FR");
    });

    it("stores optional region trimmed", async () => {
      await createChampionshipHandler(
        { title: "Alsace Cup", registrationDeadline: futureDate(), country: "FR", region: "  Alsace  " },
        makeContext("admin-uid")
      );

      const [written] = mockAdd.mock.calls[0];
      expect(written.region).toBe("Alsace");
    });

    it("sets country and region to null when not provided", async () => {
      await createChampionshipHandler(
        { title: "Open Championship", registrationDeadline: futureDate() },
        makeContext("admin-uid")
      );

      const [written] = mockAdd.mock.calls[0];
      expect(written.country).toBeNull();
      expect(written.region).toBeNull();
    });

    it("trims leading and trailing whitespace from title", async () => {
      await createChampionshipHandler(
        { title: "  Beach Open  ", registrationDeadline: futureDate() },
        makeContext("admin-uid")
      );

      const [written] = mockAdd.mock.calls[0];
      expect(written.title).toBe("Beach Open");
    });
  });

  // ── Firestore failure ──────────────────────────────────────────────────────

  describe("error handling", () => {
    it("throws internal when Firestore add fails", async () => {
      mockAdd.mockRejectedValue(new Error("Firestore unavailable"));

      await expect(
        createChampionshipHandler(
          { title: "Summer Championship", registrationDeadline: futureDate() },
          makeContext()
        )
      ).rejects.toMatchObject({ code: "internal" });
    });
  });
});
