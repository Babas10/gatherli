// Unit tests for championship push notification handlers (Story 30.13).
// Validates: result submitted → opposing team, disputed → admins,
// admin decision → both teams. All FCM sends and stale-token cleanup verified.

import {
  onChampionshipMatchResultSubmittedHandler,
  onChampionshipMatchDisputedHandler,
  onChampionshipAdminDecisionHandler,
  sendChampionshipNotificationToUsers,
} from "../../src/championshipNotifications";

// ── Mocks ─────────────────────────────────────────────────────────────────────

jest.mock("firebase-functions", () => {
  const fn: any = {
    logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn() },
  };
  fn.region = jest.fn(() => fn);
  fn.runWith = jest.fn(() => fn);
  fn.firestore = { document: jest.fn(() => ({ onUpdate: jest.fn() })) };
  return fn;
});

// Use var so these are hoisted (not in TDZ) when jest.mock factory runs.
// eslint-disable-next-line no-var
var mockSendEachForMulticast = jest.fn();
// eslint-disable-next-line no-var
var mockUpdate = jest.fn();
// eslint-disable-next-line no-var
var mockCollection = jest.fn();
// eslint-disable-next-line no-var
var mockArrayRemove = jest.fn((...args: string[]) => ({ type: "arrayRemove", args }));

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      // Lazy wrappers so the var references are resolved at call-time, not factory-time.
      jest.fn(() => ({
        collection: (...a: unknown[]) => mockCollection(...a),
      })),
      {
        FieldValue: { arrayRemove: (...a: string[]) => mockArrayRemove(...a) },
      }
    ),
    messaging: jest.fn(() => ({
      sendEachForMulticast: (...a: unknown[]) => mockSendEachForMulticast(...a),
    })),
  };
});

// ── Firestore mock builder ───────────────────────────────────────────────────

/** Build a chain: db.collection(c).doc(d).collection(c2).doc(d2).get() */
function buildDb(docs: Record<string, Record<string, unknown>>) {
  const getDoc = (path: string) => {
    const data = docs[path];
    return Promise.resolve({
      exists: !!data,
      id: path.split("/").pop() ?? path,
      data: () => data ?? null,
    });
  };

  const docFn = (path: string) => ({
    get: () => getDoc(path),
    update: mockUpdate,
    collection: (col: string) => ({
      doc: (id: string) => docFn(`${path}/${col}/${id}`),
    }),
  });

  const db: any = {
    collection: (col: string) => ({
      doc: (id: string) => docFn(`${col}/${id}`),
    }),
  };
  return db;
}

const CHAMPIONSHIP_ID = "champ-1";
const MATCH_ID = "match-1";
const PARAMS = { championshipId: CHAMPIONSHIP_ID, matchId: MATCH_ID };

// ── sendChampionshipNotificationToUsers tests ─────────────────────────────────

describe("sendChampionshipNotificationToUsers", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  test("sends to users with championship pref not set (default allowed)", async () => {
    mockSendEachForMulticast.mockResolvedValue({
      successCount: 1,
      failureCount: 0,
      responses: [{ success: true }],
    });

    const db = buildDb({
      "users/user-1": { fcmTokens: ["tok1"], notificationPreferences: {} },
    });

    await sendChampionshipNotificationToUsers(db, ["user-1"], {
      title: "Test",
      body: "Body",
      data: { type: "test" },
    });

    expect(mockSendEachForMulticast).toHaveBeenCalledTimes(1);
    const msg = mockSendEachForMulticast.mock.calls[0][0];
    expect(msg.tokens).toContain("tok1");
    expect(msg.notification.title).toBe("Test");
  });

  test("skips users with championship pref = false", async () => {
    const db = buildDb({
      "users/user-1": {
        fcmTokens: ["tok1"],
        notificationPreferences: { championship: false },
      },
    });

    await sendChampionshipNotificationToUsers(db, ["user-1"], {
      title: "Test",
      body: "Body",
      data: { type: "test" },
    });

    expect(mockSendEachForMulticast).not.toHaveBeenCalled();
  });

  test("removes stale tokens on failure", async () => {
    mockSendEachForMulticast.mockResolvedValue({
      successCount: 0,
      failureCount: 1,
      responses: [
        {
          success: false,
          error: { code: "messaging/registration-token-not-registered" },
        },
      ],
    });

    const db = buildDb({
      "users/user-1": { fcmTokens: ["stale-tok"], notificationPreferences: {} },
    });

    await sendChampionshipNotificationToUsers(db, ["user-1"], {
      title: "Test",
      body: "Body",
      data: { type: "test" },
    });

    expect(mockUpdate).toHaveBeenCalledWith(
      expect.objectContaining({
        fcmTokens: expect.objectContaining({ type: "arrayRemove", args: ["stale-tok"] }),
      })
    );
  });

  test("does nothing when userIds is empty", async () => {
    const db = buildDb({});
    await sendChampionshipNotificationToUsers(db, [], {
      title: "T",
      body: "B",
      data: { type: "t" },
    });
    expect(mockSendEachForMulticast).not.toHaveBeenCalled();
  });
});

// ── onChampionshipMatchResultSubmitted tests ──────────────────────────────────

describe("onChampionshipMatchResultSubmittedHandler", () => {
  beforeEach(() => jest.clearAllMocks());

  test("does nothing when status does not change to played", async () => {
    const db = buildDb({});
    await onChampionshipMatchResultSubmittedHandler(
      { status: "pending", teamAId: "tA", teamBId: "tB", submittedByTeamId: "tA" },
      { status: "pending", teamAId: "tA", teamBId: "tB", submittedByTeamId: "tA" },
      PARAMS,
      db
    );
    expect(mockSendEachForMulticast).not.toHaveBeenCalled();
  });

  test("sends to opposing team when result submitted", async () => {
    mockSendEachForMulticast.mockResolvedValue({
      successCount: 1,
      failureCount: 0,
      responses: [{ success: true }],
    });

    const db = buildDb({
      [`championships/${CHAMPIONSHIP_ID}/teams/tA`]: {
        name: "Team Alpha",
        memberIds: ["user-a1"],
      },
      [`championships/${CHAMPIONSHIP_ID}/teams/tB`]: {
        name: "Team Beta",
        memberIds: ["user-b1"],
      },
      "users/user-b1": { fcmTokens: ["tok-b1"], notificationPreferences: {} },
    });

    await onChampionshipMatchResultSubmittedHandler(
      { status: "pending" },
      { status: "played", teamAId: "tA", teamBId: "tB", submittedByTeamId: "tA" },
      PARAMS,
      db
    );

    expect(mockSendEachForMulticast).toHaveBeenCalledTimes(1);
    const msg = mockSendEachForMulticast.mock.calls[0][0];
    expect(msg.tokens).toContain("tok-b1");
    expect(msg.notification.title).toContain("Team Alpha");
    expect(msg.notification.title).toContain("Team Beta");
  });
});

// ── onChampionshipMatchDisputed tests ─────────────────────────────────────────

describe("onChampionshipMatchDisputedHandler", () => {
  beforeEach(() => jest.clearAllMocks());

  test("does nothing when status does not change to disputed", async () => {
    const db = buildDb({});
    await onChampionshipMatchDisputedHandler(
      { status: "played" },
      { status: "played", teamAId: "tA", teamBId: "tB" },
      PARAMS,
      db
    );
    expect(mockSendEachForMulticast).not.toHaveBeenCalled();
  });

  test("sends to admins when match is disputed", async () => {
    mockSendEachForMulticast.mockResolvedValue({
      successCount: 1,
      failureCount: 0,
      responses: [{ success: true }],
    });

    const db = buildDb({
      [`championships/${CHAMPIONSHIP_ID}`]: {
        adminIds: ["admin-1"],
      },
      [`championships/${CHAMPIONSHIP_ID}/teams/tA`]: {
        name: "Team Alpha",
        memberIds: ["user-a1"],
      },
      [`championships/${CHAMPIONSHIP_ID}/teams/tB`]: {
        name: "Team Beta",
        memberIds: ["user-b1"],
      },
      "users/admin-1": {
        fcmTokens: ["tok-admin"],
        notificationPreferences: {},
      },
    });

    await onChampionshipMatchDisputedHandler(
      { status: "played" },
      { status: "disputed", teamAId: "tA", teamBId: "tB" },
      PARAMS,
      db
    );

    expect(mockSendEachForMulticast).toHaveBeenCalledTimes(1);
    const msg = mockSendEachForMulticast.mock.calls[0][0];
    expect(msg.tokens).toContain("tok-admin");
    expect(msg.notification.title).toBe("Match disputed 🚨");
  });

  test("does nothing when championship has no admins", async () => {
    const db = buildDb({
      [`championships/${CHAMPIONSHIP_ID}`]: { adminIds: [] },
    });

    await onChampionshipMatchDisputedHandler(
      { status: "played" },
      { status: "disputed", teamAId: "tA", teamBId: "tB" },
      PARAMS,
      db
    );

    expect(mockSendEachForMulticast).not.toHaveBeenCalled();
  });
});

// ── onChampionshipAdminDecision tests ─────────────────────────────────────────

describe("onChampionshipAdminDecisionHandler", () => {
  beforeEach(() => jest.clearAllMocks());

  test("does nothing when status does not change to admin_decided", async () => {
    const db = buildDb({});
    await onChampionshipAdminDecisionHandler(
      { status: "disputed" },
      { status: "disputed", teamAId: "tA", teamBId: "tB" },
      PARAMS,
      db
    );
    expect(mockSendEachForMulticast).not.toHaveBeenCalled();
  });

  test("sends to both teams when admin decides", async () => {
    mockSendEachForMulticast.mockResolvedValue({
      successCount: 2,
      failureCount: 0,
      responses: [{ success: true }, { success: true }],
    });

    const db = buildDb({
      [`championships/${CHAMPIONSHIP_ID}/teams/tA`]: {
        name: "Team Alpha",
        memberIds: ["user-a1"],
      },
      [`championships/${CHAMPIONSHIP_ID}/teams/tB`]: {
        name: "Team Beta",
        memberIds: ["user-b1"],
      },
      "users/user-a1": { fcmTokens: ["tok-a1"], notificationPreferences: {} },
      "users/user-b1": { fcmTokens: ["tok-b1"], notificationPreferences: {} },
    });

    await onChampionshipAdminDecisionHandler(
      { status: "disputed" },
      { status: "admin_decided", teamAId: "tA", teamBId: "tB" },
      PARAMS,
      db
    );

    expect(mockSendEachForMulticast).toHaveBeenCalledTimes(1);
    const msg = mockSendEachForMulticast.mock.calls[0][0];
    expect(msg.tokens).toContain("tok-a1");
    expect(msg.tokens).toContain("tok-b1");
    expect(msg.notification.title).toBe("Match decided by admin");
  });
});
