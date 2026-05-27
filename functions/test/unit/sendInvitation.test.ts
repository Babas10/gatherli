// Unit tests for sendInvitation Cloud Function (Story 31.6 / 31.8)
// Validates group and game invitation branches, including pickup-game friendship boundary.

import * as admin from "firebase-admin";
import { sendInvitationHandler } from "../../src/sendInvitation";

// ── Mock firebase-admin ──────────────────────────────────────────────────────
jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({ collection: jest.fn() })),
      {
        FieldValue: {
          serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP"),
          arrayUnion: jest.fn((...args: any[]) => ({ _type: "arrayUnion", args })),
        },
      }
    ),
  };
});

// ── Mock firebase-functions ──────────────────────────────────────────────────
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
    logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn(), debug: jest.fn() },
  };
  fn.region = jest.fn(() => fn);
  return fn;
});

// ── Mock friendships (checkFriendship) ───────────────────────────────────────
jest.mock("../../src/friendships", () => ({
  checkFriendship: jest.fn(),
}));

import { checkFriendship } from "../../src/friendships";
const mockCheckFriendship = checkFriendship as jest.Mock;

// ── Helpers ──────────────────────────────────────────────────────────────────

const makeContext = (uid: string) => ({ auth: { uid } } as any);

const makeGameDoc = (overrides: Record<string, any> = {}) => ({
  exists: true,
  data: () => ({
    createdBy: "creator-uid",
    playerIds: [],
    groupId: "group-abc",
    scheduledAt: null,
    ...overrides,
  }),
});

const makeInvitationRef = () => ({
  id: "inv-001",
});

function buildMockDb({
  gameDoc = makeGameDoc(),
  existingInvitations = { empty: true, docs: [] },
  callerGroups = { docs: [] },
  inviterProfile = { exists: true, data: () => ({ displayName: "Creator", email: "c@test.com" }) },
}: {
  gameDoc?: any;
  existingInvitations?: any;
  callerGroups?: any;
  inviterProfile?: any;
} = {}) {
  const invRef = makeInvitationRef();
  const batchMock = {
    set: jest.fn(),
    update: jest.fn(),
    commit: jest.fn().mockResolvedValue({}),
  };

  const mockDoc = jest.fn((docId?: string) => {
    if (docId === undefined) return invRef; // invitations.doc() → new ref
    return {
      get: jest.fn().mockResolvedValue(gameDoc),
    };
  });

  const mockCollection = jest.fn((name: string) => {
    if (name === "games") return { doc: jest.fn(() => ({ get: jest.fn().mockResolvedValue(gameDoc) })) };
    if (name === "invitations") return {
      doc: mockDoc,
      where: jest.fn().mockReturnThis(),
      limit: jest.fn().mockReturnThis(),
      get: jest.fn().mockResolvedValue(existingInvitations),
    };
    if (name === "groups") return {
      where: jest.fn().mockReturnThis(),
      get: jest.fn().mockResolvedValue(callerGroups),
    };
    if (name === "users") return {
      doc: jest.fn((userId: string) => ({
        get: jest.fn().mockResolvedValue(inviterProfile),
      })),
    };
    return { doc: jest.fn() };
  });

  (admin.firestore as unknown as jest.Mock).mockReturnValue({
    collection: mockCollection,
    batch: jest.fn(() => batchMock),
  });

  return { batchMock, invRef };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("sendInvitation — game branch", () => {
  beforeEach(() => jest.clearAllMocks());

  describe("Group game (groupId set)", () => {
    it("succeeds when invitee shares a group with creator", async () => {
      buildMockDb({
        callerGroups: {
          docs: [{ data: () => ({ memberIds: ["creator-uid", "invitee-uid"] }) }],
        },
      });

      const result = await sendInvitationHandler(
        { type: "game", gameId: "game-1", invitedUserId: "invitee-uid" },
        makeContext("creator-uid")
      );

      expect(result.success).toBe(true);
      expect(mockCheckFriendship).not.toHaveBeenCalled();
    });

    it("rejects when invitee shares no group with creator", async () => {
      buildMockDb({
        callerGroups: {
          docs: [{ data: () => ({ memberIds: ["creator-uid", "other-uid"] }) }],
        },
      });

      await expect(
        sendInvitationHandler(
          { type: "game", gameId: "game-1", invitedUserId: "invitee-uid" },
          makeContext("creator-uid")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });
  });

  describe("Pickup game (groupId null)", () => {
    it("succeeds when invitee is a friend of the creator", async () => {
      buildMockDb({
        gameDoc: makeGameDoc({ groupId: null }),
      });
      mockCheckFriendship.mockResolvedValue(true);

      const result = await sendInvitationHandler(
        { type: "game", gameId: "game-1", invitedUserId: "friend-uid" },
        makeContext("creator-uid")
      );

      expect(result.success).toBe(true);
      expect(mockCheckFriendship).toHaveBeenCalledWith("creator-uid", "friend-uid");
    });

    it("succeeds when invitee shares a group with creator (not a friend)", async () => {
      buildMockDb({
        gameDoc: makeGameDoc({ groupId: null }),
        callerGroups: {
          docs: [{ data: () => ({ memberIds: ["creator-uid", "groupmate-uid"] }) }],
        },
      });
      mockCheckFriendship.mockResolvedValue(false);

      const result = await sendInvitationHandler(
        { type: "game", gameId: "game-1", invitedUserId: "groupmate-uid" },
        makeContext("creator-uid")
      );

      expect(result.success).toBe(true);
    });

    it("rejects when invitee is neither a friend nor a group member", async () => {
      buildMockDb({
        gameDoc: makeGameDoc({ groupId: null }),
        callerGroups: {
          docs: [{ data: () => ({ memberIds: ["creator-uid", "other-uid"] }) }],
        },
      });
      mockCheckFriendship.mockResolvedValue(false);

      await expect(
        sendInvitationHandler(
          { type: "game", gameId: "game-1", invitedUserId: "stranger-uid" },
          makeContext("creator-uid")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });
  });

  describe("Common validations", () => {
    it("rejects unauthenticated callers", async () => {
      await expect(
        sendInvitationHandler(
          { type: "game", gameId: "game-1", invitedUserId: "uid" },
          { auth: undefined } as any
        )
      ).rejects.toMatchObject({ code: "unauthenticated" });
    });

    it("rejects self-invitation", async () => {
      buildMockDb();
      mockCheckFriendship.mockResolvedValue(true);

      await expect(
        sendInvitationHandler(
          { type: "game", gameId: "game-1", invitedUserId: "creator-uid" },
          makeContext("creator-uid")
        )
      ).rejects.toMatchObject({ code: "invalid-argument" });
    });

    it("rejects if caller is not the game creator", async () => {
      buildMockDb({
        gameDoc: makeGameDoc({ createdBy: "other-uid" }),
      });

      await expect(
        sendInvitationHandler(
          { type: "game", gameId: "game-1", invitedUserId: "invitee-uid" },
          makeContext("creator-uid")
        )
      ).rejects.toMatchObject({ code: "permission-denied" });
    });

    it("rejects if invitee is already a player", async () => {
      buildMockDb({
        gameDoc: makeGameDoc({ playerIds: ["invitee-uid"] }),
      });

      await expect(
        sendInvitationHandler(
          { type: "game", gameId: "game-1", invitedUserId: "invitee-uid" },
          makeContext("creator-uid")
        )
      ).rejects.toMatchObject({ code: "already-exists" });
    });
  });
});
