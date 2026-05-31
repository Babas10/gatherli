// Unit tests for getChampionships Cloud Function.
// Validates auth check and correct serialisation of Firestore Timestamp fields.

import { getChampionshipsHandler } from "../../src/getChampionships";
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
  return fn;
});

// ── Mock firebase-admin ───────────────────────────────────────────────────────

var mockGet = jest.fn();
var mockOrderBy = jest.fn();

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn(() => ({
          orderBy: (...a: unknown[]) => mockOrderBy(...a),
        })),
      })),
      {
        FieldValue: actual.firestore.FieldValue,
        Timestamp: actual.firestore.Timestamp,
      }
    ),
  };
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function makeContext(uid: string | null = "user-uid"): functionsTypes.https.CallableContext {
  return uid ? ({ auth: { uid, token: {} as any } } as any) : ({ auth: undefined } as any);
}

function makeTimestamp(isoString: string) {
  const date = new Date(isoString);
  return {
    toDate: () => date,
  };
}

function makeDoc(id: string, data: Record<string, unknown>) {
  return { id, data: () => data };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("getChampionships", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    mockOrderBy.mockReturnValue({ get: mockGet });
  });

  // ── Authentication ──────────────────────────────────────────────────────────

  it("throws unauthenticated when no auth context", async () => {
    await expect(getChampionshipsHandler({}, makeContext(null))).rejects.toMatchObject({
      code: "unauthenticated",
    });
  });

  // ── Empty collection ────────────────────────────────────────────────────────

  it("returns empty array when no championships exist", async () => {
    mockGet.mockResolvedValue({ docs: [] });

    const result = await getChampionshipsHandler({}, makeContext());

    expect(result).toEqual({ championships: [] });
    expect(mockOrderBy).toHaveBeenCalledWith("createdAt", "desc");
  });

  // ── Timestamp serialisation ─────────────────────────────────────────────────

  it("serialises Timestamp fields to ISO 8601 strings", async () => {
    const createdAtDate = "2026-01-15T10:00:00.000Z";
    const deadlineDate = "2026-06-01T00:00:00.000Z";

    mockGet.mockResolvedValue({
      docs: [
        makeDoc("champ-1", {
          title: "Summer Open",
          status: "registration",
          maxTeams: 8,
          teamSize: 2,
          adminIds: ["admin-1"],
          createdBy: "admin-1",
          createdAt: makeTimestamp(createdAtDate),
          registrationDeadline: makeTimestamp(deadlineDate),
          currentRound: 0,
          totalRounds: 9,
          teamsCount: 3,
          startDate: null,
          country: "FR",
          region: "Alsace",
        }),
      ],
    });

    const result = await getChampionshipsHandler({}, makeContext());

    expect(result.championships).toHaveLength(1);
    const champ = result.championships[0];
    expect(champ.id).toBe("champ-1");
    expect(champ.createdAt).toBe(createdAtDate);
    expect(champ.registrationDeadline).toBe(deadlineDate);
    expect(champ.startDate).toBeNull();
    expect(champ.country).toBe("FR");
    expect(champ.region).toBe("Alsace");
  });

  it("serialises optional startDate Timestamp when present", async () => {
    const startDate = "2026-07-01T08:00:00.000Z";

    mockGet.mockResolvedValue({
      docs: [
        makeDoc("champ-2", {
          title: "Active Championship",
          status: "active",
          maxTeams: 10,
          teamSize: 2,
          adminIds: ["admin-1"],
          createdBy: "admin-1",
          createdAt: makeTimestamp("2026-01-01T00:00:00.000Z"),
          registrationDeadline: makeTimestamp("2026-06-01T00:00:00.000Z"),
          currentRound: 1,
          totalRounds: 9,
          teamsCount: 10,
          startDate: makeTimestamp(startDate),
          country: null,
          region: null,
        }),
      ],
    });

    const result = await getChampionshipsHandler({}, makeContext());

    expect(result.championships[0].startDate).toBe(startDate);
  });

  // ── Default values ──────────────────────────────────────────────────────────

  it("fills in defaults for missing fields", async () => {
    mockGet.mockResolvedValue({
      docs: [
        makeDoc("champ-3", {
          // minimal doc — only required Timestamps
          createdAt: makeTimestamp("2026-01-01T00:00:00.000Z"),
          registrationDeadline: makeTimestamp("2026-06-01T00:00:00.000Z"),
        }),
      ],
    });

    const result = await getChampionshipsHandler({}, makeContext());
    const champ = result.championships[0];

    expect(champ.title).toBe("");
    expect(champ.status).toBe("registration");
    expect(champ.maxTeams).toBe(10);
    expect(champ.teamSize).toBe(2);
    expect(champ.adminIds).toEqual([]);
    expect(champ.createdBy).toBe("");
    expect(champ.currentRound).toBe(0);
    expect(champ.totalRounds).toBe(9);
    expect(champ.teamsCount).toBe(0);
    expect(champ.startDate).toBeNull();
    expect(champ.country).toBeNull();
    expect(champ.region).toBeNull();
  });

  // ── Multiple championships ───────────────────────────────────────────────────

  it("returns all championships in order", async () => {
    mockGet.mockResolvedValue({
      docs: [
        makeDoc("champ-a", {
          title: "Champ A",
          status: "registration",
          createdAt: makeTimestamp("2026-03-01T00:00:00.000Z"),
          registrationDeadline: makeTimestamp("2026-06-01T00:00:00.000Z"),
        }),
        makeDoc("champ-b", {
          title: "Champ B",
          status: "active",
          createdAt: makeTimestamp("2026-01-01T00:00:00.000Z"),
          registrationDeadline: makeTimestamp("2026-05-01T00:00:00.000Z"),
        }),
      ],
    });

    const result = await getChampionshipsHandler({}, makeContext());

    expect(result.championships).toHaveLength(2);
    expect(result.championships[0].id).toBe("champ-a");
    expect(result.championships[1].id).toBe("champ-b");
  });
});
