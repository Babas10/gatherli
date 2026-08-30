// Unit tests for the 48h championship deadline warning scheduled function (Story 30.13).
// Validates: warnings sent to both teams, idempotency flag prevents re-send,
// no active championships → early exit, empty team skipped.

import { checkChampionshipDeadlinesHandler } from "../../src/checkChampionshipDeadlines";

// ── Mocks ─────────────────────────────────────────────────────────────────────

jest.mock("firebase-functions", () => ({
  logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn() },
  region: jest.fn(() => ({
    runWith: jest.fn(() => ({
      pubsub: {
        schedule: jest.fn(() => ({
          timeZone: jest.fn(() => ({ onRun: jest.fn() })),
        })),
      },
    })),
  })),
}));

// Mock the notification helper so no real FCM calls are made.
jest.mock("../../src/championshipNotifications", () => ({
  sendChampionshipNotificationToUsers: jest.fn().mockResolvedValue(undefined),
}));

// eslint-disable-next-line no-var
var mockTimestampFromDate = jest.fn((d: Date) => ({
  toDate: () => d,
  seconds: Math.floor(d.getTime() / 1000),
}));

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(jest.fn(), {
      Timestamp: { fromDate: (d: Date) => mockTimestampFromDate(d) },
    }),
  };
});

// Import after mocks are registered.
import { sendChampionshipNotificationToUsers } from "../../src/championshipNotifications";

const mockSend = sendChampionshipNotificationToUsers as jest.Mock;

// ── Firestore mock builder ────────────────────────────────────────────────────

const mockRefUpdate = jest.fn();

type DocSpec = { id: string; data: Record<string, unknown> };

/**
 * Builds a minimal db mock covering the access patterns used by
 * checkChampionshipDeadlinesHandler:
 *  - collection("championships").where(...).get()         → active championships
 *  - .doc(champId).collection("matches").where(…).get()  → pending matches
 *  - .doc(champId).collection("teams").doc(teamId).get() → team doc
 *  - matchDoc.ref.update(flag)
 */
function buildDb(opts: {
  championships?: DocSpec[];
  matchesByChampId?: Record<string, DocSpec[]>;
  teamDocs?: Record<string, Record<string, unknown>>; // key: "<champId>/teams/<teamId>"
}) {
  const {
    championships = [],
    matchesByChampId = {},
    teamDocs = {},
  } = opts;

  // A chainable where() stub that always returns this same object, ending in .get().
  const queryStub = (result: () => Promise<unknown>) => {
    const q: Record<string, unknown> = {};
    q["where"] = () => q;
    q["limit"] = () => q;
    q["get"] = result;
    return q as {
      where: () => typeof q;
      limit: () => typeof q;
      get: () => Promise<unknown>;
    };
  };

  const makeQuerySnap = (docs: DocSpec[], champId?: string) => ({
    empty: docs.length === 0,
    size: docs.length,
    docs: docs.map((d) => ({
      id: d.id,
      exists: true,
      data: () => d.data,
      ref: { update: mockRefUpdate },
      // expose champId for the handler to build sub-paths
    })),
  });

  return {
    collection: (col: string) => {
      if (col !== "championships") return {};
      return {
        // championship-level query (active championships)
        where: () =>
          queryStub(() =>
            Promise.resolve(makeQuerySnap(championships))
          ),
        doc: (champId: string) => ({
          collection: (subCol: string) => {
            if (subCol === "matches") {
              const matches = matchesByChampId[champId] ?? [];
              return queryStub(() =>
                Promise.resolve(makeQuerySnap(matches, champId))
              );
            }
            if (subCol === "teams") {
              return {
                doc: (teamId: string) => ({
                  get: () => {
                    const key = `${champId}/teams/${teamId}`;
                    const data = teamDocs[key] ?? null;
                    return Promise.resolve({
                      exists: !!data,
                      id: teamId,
                      data: () => data,
                    });
                  },
                }),
              };
            }
            return {};
          },
        }),
      };
    },
  };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

const NOW = new Date("2025-06-01T09:00:00Z");
const CHAMP_ID = "champ-1";
const MATCH_ID = "match-1";

describe("checkChampionshipDeadlinesHandler", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  test("does nothing when there are no active championships", async () => {
    const db = buildDb({ championships: [] });
    await checkChampionshipDeadlinesHandler(db as never, NOW);
    expect(mockSend).not.toHaveBeenCalled();
    expect(mockRefUpdate).not.toHaveBeenCalled();
  });

  test("sends 48h warning to both teams and marks flag", async () => {
    const db = buildDb({
      championships: [{ id: CHAMP_ID, data: { status: "active" } }],
      matchesByChampId: {
        [CHAMP_ID]: [
          {
            id: MATCH_ID,
            data: {
              status: "pending",
              teamAId: "tA",
              teamBId: "tB",
              deadline: { toDate: () => new Date("2025-06-02T10:00:00Z") },
              deadlineWarning48hSent: false,
            },
          },
        ],
      },
      teamDocs: {
        [`${CHAMP_ID}/teams/tA`]: { name: "Team Alpha", memberIds: ["user-a1"] },
        [`${CHAMP_ID}/teams/tB`]: { name: "Team Beta", memberIds: ["user-b1"] },
      },
    });

    await checkChampionshipDeadlinesHandler(db as never, NOW);

    // Two sendChampionshipNotificationToUsers calls — one per team
    expect(mockSend).toHaveBeenCalledTimes(2);

    const calls = mockSend.mock.calls;
    const teamACall = calls.find((c: unknown[]) =>
      (c[1] as string[]).includes("user-a1")
    );
    const teamBCall = calls.find((c: unknown[]) =>
      (c[1] as string[]).includes("user-b1")
    );

    expect(teamACall).toBeDefined();
    expect(teamACall![2].body).toContain("Team Beta");
    expect(teamBCall).toBeDefined();
    expect(teamBCall![2].body).toContain("Team Alpha");

    // Idempotency flag written
    expect(mockRefUpdate).toHaveBeenCalledWith({ deadlineWarning48hSent: true });
  });

  test("skips match where deadlineWarning48hSent is already true", async () => {
    const db = buildDb({
      championships: [{ id: CHAMP_ID, data: { status: "active" } }],
      matchesByChampId: {
        [CHAMP_ID]: [
          {
            id: MATCH_ID,
            data: {
              status: "pending",
              teamAId: "tA",
              teamBId: "tB",
              deadlineWarning48hSent: true,
            },
          },
        ],
      },
    });

    await checkChampionshipDeadlinesHandler(db as never, NOW);

    expect(mockSend).not.toHaveBeenCalled();
    expect(mockRefUpdate).not.toHaveBeenCalled();
  });

  test("sends only to team B when team A has no members", async () => {
    const db = buildDb({
      championships: [{ id: CHAMP_ID, data: { status: "active" } }],
      matchesByChampId: {
        [CHAMP_ID]: [
          {
            id: MATCH_ID,
            data: {
              status: "pending",
              teamAId: "tA",
              teamBId: "tB",
              deadlineWarning48hSent: false,
            },
          },
        ],
      },
      teamDocs: {
        [`${CHAMP_ID}/teams/tA`]: { name: "Team Alpha", memberIds: [] },
        [`${CHAMP_ID}/teams/tB`]: { name: "Team Beta", memberIds: ["user-b1"] },
      },
    });

    await checkChampionshipDeadlinesHandler(db as never, NOW);

    // Only team B notified (team A memberIds is empty)
    expect(mockSend).toHaveBeenCalledTimes(1);
    const [, userIds] = mockSend.mock.calls[0] as [unknown, string[], unknown];
    expect(userIds).toContain("user-b1");
    expect(mockRefUpdate).toHaveBeenCalledWith({ deadlineWarning48hSent: true });
  });

  test("processes multiple championships independently", async () => {
    const db = buildDb({
      championships: [
        { id: "champ-A", data: { status: "active" } },
        { id: "champ-B", data: { status: "active" } },
      ],
      matchesByChampId: {
        "champ-A": [
          {
            id: "match-A1",
            data: {
              status: "pending",
              teamAId: "tA",
              teamBId: "tB",
              deadlineWarning48hSent: false,
            },
          },
        ],
        "champ-B": [], // no pending matches
      },
      teamDocs: {
        "champ-A/teams/tA": { name: "Alpha", memberIds: ["u1"] },
        "champ-A/teams/tB": { name: "Beta", memberIds: ["u2"] },
      },
    });

    await checkChampionshipDeadlinesHandler(db as never, NOW);

    // Only champ-A has a match → 2 send calls
    expect(mockSend).toHaveBeenCalledTimes(2);
  });
});
