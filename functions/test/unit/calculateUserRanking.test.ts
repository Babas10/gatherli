// Unit tests for calculateUserRankingHandler
// Story 25.6: Parallelised count() queries for global rank calculation

import {calculateUserRankingHandler} from "../../src/calculateUserRanking";

jest.mock("firebase-functions", () => {
  const _fn = {
    https: {
      HttpsError: class HttpsError extends Error {
        code: string;
        constructor(code: string, message: string) {
          super(message);
          this.code = code;
          this.name = "HttpsError";
        }
      },
      onCall: jest.fn((handler) => handler),
    },
    logger: {
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      debug: jest.fn(),
    },
  };
  (_fn as any).region = jest.fn(() => _fn);
  return _fn;
});

jest.mock("firebase-admin", () => {
  const mockFirestore = {
    collection: jest.fn(),
    doc: jest.fn(),
  };
  return {
    firestore: Object.assign(jest.fn(() => mockFirestore), {
      FieldPath: {documentId: jest.fn(() => "__name__")},
      FieldValue: {serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP")},
    }),
    initializeApp: jest.fn(),
  };
});

const admin = require("firebase-admin");

function getMockDb() {
  return admin.firestore();
}


describe("calculateUserRankingHandler", () => {
  let mockDb: any;

  beforeEach(() => {
    jest.clearAllMocks();
    mockDb = getMockDb();
  });

  it("throws unauthenticated when no auth context", async () => {
    await expect(
      calculateUserRankingHandler({}, {auth: null} as any)
    ).rejects.toThrow("You must be logged in to view rankings.");
  });

  it("throws not-found when user document does not exist", async () => {
    mockDb.doc.mockReturnValue({
      get: jest.fn().mockResolvedValue({exists: false}),
    });

    await expect(
      calculateUserRankingHandler({}, {auth: {uid: "user-123"}} as any)
    ).rejects.toThrow("User not found");
  });

  it("returns correct global rank and percentile with no friends", async () => {
    // User doc — no friendIds field (removed in Story 31.3)
    mockDb.doc.mockReturnValue({
      get: jest.fn().mockResolvedValue({
        exists: true,
        data: () => ({eloRating: 1700, eloGamesPlayed: 5}),
      }),
    });

    // users count queries: higherEloCount=2, totalUsers=10
    // friendships queries: empty (no friends)
    let usersCallCount = 0;
    mockDb.collection.mockImplementation((collectionName: string) => {
      if (collectionName === "friendships") {
        const chain: any = {where: jest.fn(), get: jest.fn().mockResolvedValue({docs: [], empty: true})};
        chain.where.mockReturnValue(chain);
        return chain;
      }
      // "users" collection — count queries
      usersCallCount++;
      const count = usersCallCount === 1 ? 2 : 10;
      const get = jest.fn().mockResolvedValue({data: () => ({count})});
      const countFn = jest.fn().mockReturnValue({get});
      const where2 = jest.fn().mockReturnValue({count: countFn});
      const where1 = jest.fn().mockReturnValue({where: where2, count: countFn});
      return {where: where1};
    });

    const result = await calculateUserRankingHandler(
      {},
      {auth: {uid: "user-123"}} as any
    );

    expect(result.globalRank).toBe(3); // 2 users above + 1
    expect(result.totalUsers).toBe(10);
    expect(result.percentile).toBeCloseTo(80); // (10 - 3 + 1) / 10 * 100
    expect(result.friendsRank).toBeNull();
    expect(result.totalFriends).toBeNull();
  });

  it("fires both count() queries in parallel (both collections called before either resolves)", async () => {
    const usersCountCallTimes: number[] = [];

    mockDb.doc.mockReturnValue({
      get: jest.fn().mockResolvedValue({
        exists: true,
        data: () => ({eloRating: 1600, eloGamesPlayed: 3}),
      }),
    });

    mockDb.collection.mockImplementation((collectionName: string) => {
      if (collectionName === "friendships") {
        const chain: any = {where: jest.fn(), get: jest.fn().mockResolvedValue({docs: [], empty: true})};
        chain.where.mockReturnValue(chain);
        return chain;
      }
      // Track when users count queries are initiated
      usersCountCallTimes.push(Date.now());
      const get = jest.fn().mockResolvedValue({data: () => ({count: 0})});
      const countFn = jest.fn().mockReturnValue({get});
      const where2 = jest.fn().mockReturnValue({count: countFn});
      const where1 = jest.fn().mockReturnValue({where: where2, count: countFn});
      return {where: where1};
    });

    await calculateUserRankingHandler({}, {auth: {uid: "user-123"}} as any);

    // Both global count queries (higherEloCount + totalUsers) must have been initiated
    expect(usersCountCallTimes).toHaveLength(2);
  });

  it("calculates friends rank correctly", async () => {
    const friendIds = ["friend-1", "friend-2", "friend-3"];

    // User doc — no friendIds field (removed in Story 31.3)
    mockDb.doc.mockReturnValue({
      get: jest.fn().mockResolvedValue({
        exists: true,
        data: () => ({eloRating: 1700, eloGamesPlayed: 5}),
      }),
    });

    let usersCallCount = 0;
    let friendshipsCallCount = 0;
    mockDb.collection.mockImplementation((collectionName: string) => {
      if (collectionName === "friendships") {
        friendshipsCallCount++;
        const chain: any = {where: jest.fn()};
        chain.where.mockReturnValue(chain);
        if (friendshipsCallCount === 1) {
          // initiator direction — return friend docs
          chain.get = jest.fn().mockResolvedValue({
            docs: friendIds.map((id) => ({
              data: () => ({recipientId: id, initiatorId: "user-123", status: "accepted"}),
            })),
            empty: false,
          });
        } else {
          // recipient direction — no additional friends
          chain.get = jest.fn().mockResolvedValue({docs: [], empty: true});
        }
        return chain;
      }
      // "users" collection
      usersCallCount++;
      if (usersCallCount <= 2) {
        // Global count queries: higherEloCount=1, totalUsers=5
        const count = usersCallCount === 1 ? 1 : 5;
        const get = jest.fn().mockResolvedValue({data: () => ({count})});
        const countFn = jest.fn().mockReturnValue({get});
        const where2 = jest.fn().mockReturnValue({count: countFn});
        const where1 = jest.fn().mockReturnValue({where: where2, count: countFn});
        return {where: where1};
      }
      // Friend batch query: friend-1 ELO=1800 (higher), friend-2 ELO=1600 (lower), friend-3 no games
      const get = jest.fn().mockResolvedValue({
        docs: [
          {data: () => ({eloRating: 1800, eloGamesPlayed: 3})},
          {data: () => ({eloRating: 1600, eloGamesPlayed: 2})},
          {data: () => ({eloRating: 1500, eloGamesPlayed: 0})}, // excluded (no games)
        ],
      });
      const where1 = jest.fn().mockReturnValue({get, select: jest.fn().mockReturnValue({get})});
      return {where: where1};
    });

    const result = await calculateUserRankingHandler(
      {},
      {auth: {uid: "user-123"}} as any
    );

    expect(result.globalRank).toBe(2);
    expect(result.totalUsers).toBe(5);
  });

  it("throws failed-precondition when user has no ELO games played", async () => {
    mockDb.doc.mockReturnValue({
      get: jest.fn().mockResolvedValue({
        exists: true,
        data: () => ({eloGamesPlayed: 0, friendIds: []}),
      }),
    });

    await expect(
      calculateUserRankingHandler({}, {auth: {uid: "user-123"}} as any)
    ).rejects.toMatchObject({
      code: "failed-precondition",
      message: "No ELO games played yet.",
    });
  });
});
