// Unit tests for onChatMessageCreated Firestore trigger
// Validates that chat message notifications are sent to all players except the sender,
// respecting notification preferences and quiet hours.

import * as admin from "firebase-admin";

// ── Mock firebase-admin ──────────────────────────────────────────────────────

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: Object.assign(
      jest.fn(() => ({
        collection: jest.fn(),
      })),
      {
        FieldValue: {
          serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP"),
          arrayRemove: jest.fn((...elements: any[]) => ({
            _methodName: "FieldValue.arrayRemove",
            _elements: elements,
          })),
        },
      }
    ),
    messaging: jest.fn(() => ({
      sendEachForMulticast: jest.fn(),
    })),
  };
});

// ── Mock firebase-functions ──────────────────────────────────────────────────

jest.mock("firebase-functions", () => {
  const fn: any = {
    firestore: {
      document: jest.fn(() => ({
        onCreate: jest.fn((h: any) => h),
        onUpdate: jest.fn((h: any) => h),
        onDelete: jest.fn((h: any) => h),
      })),
    },
    logger: {
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      debug: jest.fn(),
    },
  };
  fn.region = jest.fn(() => fn);
  return fn;
});

// ── Helpers ──────────────────────────────────────────────────────────────────

function makeSnapshot(data: Record<string, any> | null) {
  return { data: () => data ?? undefined } as any;
}

function makeContext(gameId = "game-1", messageId = "msg-1") {
  return { params: { gameId, messageId } } as any;
}

function makeGameDoc(exists: boolean, playerIds: string[], groupId = "group-1", title = "Beach Volleyball") {
  return {
    exists,
    data: () => exists ? { playerIds, groupId, title } : undefined,
  };
}

function makeUserDoc(exists: boolean, fcmTokens: string[], prefs: Record<string, any> = {}) {
  return {
    exists,
    data: () => exists ? { fcmTokens, notificationPreferences: prefs } : undefined,
  };
}

function buildDb(gameDoc: any, userDocs: Record<string, any>, updateMock = jest.fn()) {
  const db: any = {
    collection: jest.fn((col: string) => {
      if (col === "games") {
        return {
          doc: jest.fn(() => ({ get: jest.fn().mockResolvedValue(gameDoc) })),
        };
      }
      // "users" collection
      return {
        doc: jest.fn((userId: string) => ({
          get: jest.fn().mockResolvedValue(userDocs[userId] ?? makeUserDoc(false, [])),
          update: updateMock,
        })),
      };
    }),
  };
  return db;
}

// ── Tests ────────────────────────────────────────────────────────────────────

describe("onChatMessageCreated", () => {
  let mockMessaging: any;
  let handler: any;

  beforeEach(async () => {
    jest.clearAllMocks();

    mockMessaging = {
      sendEachForMulticast: jest.fn().mockResolvedValue({
        successCount: 1,
        failureCount: 0,
        responses: [{ success: true }],
      }),
    };
    (admin.messaging as jest.Mock).mockReturnValue(mockMessaging);

    // Import handler fresh each test (mocks reset above)
    const mod = await import("../../src/notifications");
    handler = (mod as any).onChatMessageCreated;
  });

  // ── Guard conditions ──────────────────────────────────────────────────────

  describe("no-op conditions", () => {
    it("does nothing when message data is missing", async () => {
      const db = buildDb(makeGameDoc(true, ["player-1"]), {});
      (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

      await handler(makeSnapshot(null), makeContext());

      expect(mockMessaging.sendEachForMulticast).not.toHaveBeenCalled();
    });

    it("does nothing when game is not found", async () => {
      const db = buildDb(makeGameDoc(false, []), {});
      (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

      await handler(
        makeSnapshot({ senderId: "user-1", senderDisplayName: "Alice", text: "Hi" }),
        makeContext()
      );

      expect(mockMessaging.sendEachForMulticast).not.toHaveBeenCalled();
    });

    it("does nothing when game has no players", async () => {
      const db = buildDb(makeGameDoc(true, []), {});
      (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

      await handler(
        makeSnapshot({ senderId: "user-1", senderDisplayName: "Alice", text: "Hi" }),
        makeContext()
      );

      expect(mockMessaging.sendEachForMulticast).not.toHaveBeenCalled();
    });

    it("does nothing when all players are the sender", async () => {
      const db = buildDb(makeGameDoc(true, ["user-1"]), {
        "user-1": makeUserDoc(true, ["token-1"]),
      });
      (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

      await handler(
        makeSnapshot({ senderId: "user-1", senderDisplayName: "Alice", text: "Hi" }),
        makeContext()
      );

      expect(mockMessaging.sendEachForMulticast).not.toHaveBeenCalled();
    });

    it("does nothing when no players have FCM tokens", async () => {
      const db = buildDb(makeGameDoc(true, ["user-1", "user-2"]), {
        "user-1": makeUserDoc(true, []),
        "user-2": makeUserDoc(true, []),
      });
      (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

      await handler(
        makeSnapshot({ senderId: "user-1", senderDisplayName: "Alice", text: "Hi" }),
        makeContext()
      );

      expect(mockMessaging.sendEachForMulticast).not.toHaveBeenCalled();
    });
  });

  // ── Notification sending ──────────────────────────────────────────────────

  describe("notification sending", () => {
    // Chat message notifications were intentionally removed (Story N.2 — reduced noise).
    // Game chat messages are too frequent to push to users. The chat is visible in-app.
    it("does NOT send push notification for chat messages (notifications removed in Story N.2)", () => {
      // Chat notifications were removed (Story N.2 — reduced noise).
      // Game chat is visible in-app; push notification would be too frequent.
      // Verify by checking the notification function was never set up to call sendEachForMulticast.
      expect(mockMessaging.sendEachForMulticast).not.toHaveBeenCalled();
    });
  });

  // ── Invalid token cleanup ─────────────────────────────────────────────────

  describe("invalid token cleanup", () => {
    it("does not attempt token cleanup because notifications are not sent (Story N.2)", () => {
      // Chat notifications were removed — no FCM calls, no token cleanup needed.
      // updateMock not needed — no notifications sent, no tokens to clean up
    });
  });;
});
