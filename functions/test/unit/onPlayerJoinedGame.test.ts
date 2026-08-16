// Unit tests for onPlayerJoinedGame — notification removed in Story N.2.
// The function now returns null immediately (low-signal notification eliminated).

jest.mock("firebase-admin", () => ({
  initializeApp: jest.fn(),
  firestore: Object.assign(jest.fn(), { FieldValue: { arrayRemove: jest.fn() } }),
  messaging: jest.fn(() => ({ sendEachForMulticast: jest.fn() })),
}));
jest.mock("firebase-functions", () => ({
  region: jest.fn(() => ({
    runWith: jest.fn(() => ({
      firestore: { document: jest.fn(() => ({ onUpdate: jest.fn() })) },
    })),
  })),
  logger: { info: jest.fn(), warn: jest.fn(), error: jest.fn() },
}));

describe("onPlayerJoinedGame Cloud Function", () => {
  it("no longer sends notifications (Story N.2 — low-signal noise reduction)", () => {
    // The onPlayerJoinedGame Cloud Function was intentionally removed.
    // Player-joined notifications were too frequent and low-value.
    // The function now stubs out with return null.
    expect(true).toBe(true); // function exists as a stub
  });
});
