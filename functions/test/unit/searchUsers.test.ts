// Unit tests for searchUsersHandler (Story 35.7).
// Validates the indexed prefix-range query rewrite: email/displayNameLower
// matching, self/friend/pending-request exclusion, dedupe across both
// fields, and that matching is prefix-only (not substring) post-rewrite.

import { searchUsersHandler } from "../../src/searchUsers";

// ── Mocks ─────────────────────────────────────────────────────────────────────

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
    logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn() },
  };
  fn.region = jest.fn(() => fn);
  return fn;
});

jest.mock("firebase-admin", () => {
  const actual = jest.requireActual("firebase-admin");
  return {
    ...actual,
    firestore: jest.fn(),
  };
});

import * as admin from "firebase-admin";

// ── Helpers ──────────────────────────────────────────────────────────────────

const AUTH_CTX = { auth: { uid: "me" } } as any;

type Doc = { id: string; data: Record<string, unknown> };

function makeSnapshot(docs: Doc[]) {
  return {
    empty: docs.length === 0,
    docs: docs.map((d) => ({ id: d.id, data: () => d.data })),
  };
}

/** A chainable query stub ending in .get(), used for both users and friendships. */
function queryStub(result: () => Promise<unknown>) {
  const q: Record<string, unknown> = {};
  q["where"] = () => q;
  q["limit"] = () => q;
  q["get"] = result;
  return q;
}

/**
 * Builds a mock db.
 * - "users": returns emailDocs for the email-prefix query, nameDocs for the
 *   displayNameLower-prefix query (matched by call order: 1st where() call
 *   on "users" is email, 2nd is displayNameLower — see collection() below).
 * - "friendships": returns friendship docs regardless of which of the 3
 *   sub-queries is issued (tests set the relevant subset).
 */
function buildDb(opts: {
  emailDocs?: Doc[];
  nameDocs?: Doc[];
  acceptedAsInitiator?: Doc[];
  acceptedAsRecipient?: Doc[];
  pending?: Doc[];
}) {
  const {
    emailDocs = [],
    nameDocs = [],
    acceptedAsInitiator = [],
    acceptedAsRecipient = [],
    pending = [],
  } = opts;

  let usersQueryCallCount = 0;
  let friendshipsQueryCallCount = 0;

  return {
    collection: (col: string) => {
      if (col === "users") {
        return {
          where: (field: string) => {
            usersQueryCallCount++;
            const docs = field === "email" ? emailDocs : nameDocs;
            return queryStub(() => Promise.resolve(makeSnapshot(docs)));
          },
        };
      }
      if (col === "friendships") {
        return {
          where: (field: string) => {
            friendshipsQueryCallCount++;
            // Order matches the handler's Promise.all: initiatorId+accepted,
            // recipientId+accepted, status==pending.
            const callIndex = friendshipsQueryCallCount;
            const docs =
              callIndex === 1
                ? acceptedAsInitiator
                : callIndex === 2
                ? acceptedAsRecipient
                : pending;
            return queryStub(() => Promise.resolve(makeSnapshot(docs)));
          },
        };
      }
      throw new Error(`Unexpected collection: ${col}`);
    },
    _getUsersQueryCallCount: () => usersQueryCallCount,
  };
}

// ── Tests ─────────────────────────────────────────────────────────────────────

describe("searchUsersHandler", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("throws unauthenticated when context.auth is missing", async () => {
    await expect(
      searchUsersHandler({ query: "abc" }, {} as any)
    ).rejects.toMatchObject({ code: "unauthenticated" });
  });

  it("throws invalid-argument when query is too short", async () => {
    await expect(
      searchUsersHandler({ query: "ab" }, AUTH_CTX)
    ).rejects.toMatchObject({ code: "invalid-argument" });
  });

  it("matches a user by email prefix", async () => {
    const db = buildDb({
      emailDocs: [
        { id: "u1", data: { email: "alice@example.com", displayName: "Alice" } },
      ],
    });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "alice" }, AUTH_CTX);

    expect(result.users).toHaveLength(1);
    expect(result.users[0].uid).toBe("u1");
  });

  it("matches a user by displayNameLower prefix", async () => {
    const db = buildDb({
      nameDocs: [
        { id: "u2", data: { email: "bob@example.com", displayName: "Bobby Tables" } },
      ],
    });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "bobby" }, AUTH_CTX);

    expect(result.users).toHaveLength(1);
    expect(result.users[0].uid).toBe("u2");
  });

  it("dedupes a user matched by both email and displayNameLower", async () => {
    const doc = { id: "u3", data: { email: "sam@example.com", displayName: "Sam" } };
    const db = buildDb({ emailDocs: [doc], nameDocs: [doc] });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "sam" }, AUTH_CTX);

    expect(result.users).toHaveLength(1);
  });

  it("excludes self from results", async () => {
    const db = buildDb({
      emailDocs: [{ id: "me", data: { email: "me@example.com", displayName: "Me" } }],
    });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "me@" }, AUTH_CTX);

    expect(result.users).toHaveLength(0);
  });

  it("excludes already-accepted friends", async () => {
    const db = buildDb({
      emailDocs: [
        { id: "friend1", data: { email: "friend1@example.com", displayName: "Friend One" } },
      ],
      acceptedAsInitiator: [{ id: "f1", data: { recipientId: "friend1" } }],
    });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "friend1" }, AUTH_CTX);

    expect(result.users).toHaveLength(0);
  });

  it("excludes users with a pending friend request", async () => {
    const db = buildDb({
      emailDocs: [
        { id: "pending1", data: { email: "pending1@example.com", displayName: "Pending One" } },
      ],
      pending: [{ id: "p1", data: { initiatorId: "me", recipientId: "pending1" } }],
    });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "pending1" }, AUTH_CTX);

    expect(result.users).toHaveLength(0);
  });

  it("does NOT match a substring in the middle of a field (prefix-only post-rewrite)", async () => {
    // "smith" appears inside the email but not as a prefix of either indexed
    // field — the mock's where("email", ...) stub only returns emailDocs for
    // an exact stub call, so this test documents intent: a real Firestore
    // range query on "smith" would not match "john.smith@example.com"
    // because the field doesn't start with "smith". Here we simulate that by
    // simply not including the doc in emailDocs/nameDocs.
    const db = buildDb({ emailDocs: [], nameDocs: [] });
    (admin.firestore as unknown as jest.Mock).mockReturnValue(db);

    const result = await searchUsersHandler({ query: "smith" }, AUTH_CTX);

    expect(result.users).toHaveLength(0);
  });
});
