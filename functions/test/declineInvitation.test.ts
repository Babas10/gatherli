import functionsTest from "firebase-functions-test";
import {declineInvitationHandler} from "../src/declineInvitation";

// Mock admin.firestore()
jest.mock("firebase-admin", () => {
  const mockFieldValue = {
    serverTimestamp: jest.fn(() => "MOCK_TIMESTAMP"),
    arrayUnion: jest.fn((...elements) => ({_type: "arrayUnion", elements})),
    arrayRemove: jest.fn((...elements) => ({_type: "arrayRemove", elements})),
  };

  const mockFirestore = {
    collection: jest.fn(),
  };

  return {
    firestore: Object.assign(
      jest.fn(() => mockFirestore),
      {
        FieldValue: mockFieldValue,
      }
    ),
    initializeApp: jest.fn(),
  };
});

// Initialize Firebase Functions test environment
const test = functionsTest();

// Get mockFirestore reference for test setup
const admin = require("firebase-admin");
const mockFirestore = admin.firestore();

// Helper: mock the top-level `invitations` collection to return {exists: false}
// so tests that exercise the legacy subcollection path still work after the
// dual-aware refactor (Story 31.6).
function mockTopLevelNotFound() {
  return jest.fn().mockReturnValue({
    get: jest.fn().mockResolvedValue({exists: false}),
  });
}

describe("declineInvitation", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  afterAll(() => {
    test.cleanup();
  });

  it("should throw unauthenticated error when user is not authenticated", async () => {
    const context = {
      auth: null,
    };

    const data = {
      invitationId: "invitation123",
    };

    await expect(
      declineInvitationHandler(data, context as any)
    ).rejects.toThrow("User must be authenticated to decline invitations");
  });

  it("should throw invalid-argument error when invitationId is missing", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {};

    await expect(
      declineInvitationHandler(data as any, context as any)
    ).rejects.toThrow("invitationId is required and must be a string");
  });

  it("should throw invalid-argument error when invitationId is not a string", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {
      invitationId: 123,
    };

    await expect(
      declineInvitationHandler(data as any, context as any)
    ).rejects.toThrow("invitationId is required and must be a string");
  });

  it("should throw not-found error when invitation does not exist", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {
      invitationId: "invitation123",
    };

    // Mock invitation not found in subcollection
    const mockGet = jest.fn().mockResolvedValue({
      exists: false,
    });

    const mockDoc = jest.fn().mockReturnValue({
      get: mockGet,
    });

    const mockCollection2 = jest.fn().mockReturnValue({
      doc: mockDoc,
    });

    const mockDoc2 = jest.fn().mockReturnValue({
      collection: mockCollection2,
    });

    mockFirestore.collection = jest.fn((collectionName: string) => {
      if (collectionName === "invitations") return {doc: mockTopLevelNotFound()};
      return {doc: mockDoc2};
    });

    await expect(
      declineInvitationHandler(data, context as any)
    ).rejects.toThrow("Invitation not found");
  });

  it("should throw failed-precondition error when invitation is not pending", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {
      invitationId: "invitation123",
    };

    // Mock invitation with non-pending status
    const mockGet = jest.fn().mockResolvedValue({
      exists: true,
      data: () => ({
        status: "declined",
        invitedUserId: "user123",
        groupId: "group456",
        groupName: "Test Group",
      }),
    });

    const mockDoc = jest.fn().mockReturnValue({
      get: mockGet,
    });

    const mockCollection2 = jest.fn().mockReturnValue({
      doc: mockDoc,
    });

    const mockDoc2 = jest.fn().mockReturnValue({
      collection: mockCollection2,
    });

    mockFirestore.collection = jest.fn((collectionName: string) => {
      if (collectionName === "invitations") return {doc: mockTopLevelNotFound()};
      return {doc: mockDoc2};
    });

    await expect(
      declineInvitationHandler(data, context as any)
    ).rejects.toThrow("Invitation is not pending");
  });

  it("should throw permission-denied error when invitation is for different user", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {
      invitationId: "invitation123",
    };

    // Mock invitation for different user
    const mockGet = jest.fn().mockResolvedValue({
      exists: true,
      data: () => ({
        status: "pending",
        invitedUserId: "differentUser",
        groupId: "group456",
        groupName: "Test Group",
      }),
    });

    const mockDoc = jest.fn().mockReturnValue({
      get: mockGet,
    });

    const mockCollection2 = jest.fn().mockReturnValue({
      doc: mockDoc,
    });

    const mockDoc2 = jest.fn().mockReturnValue({
      collection: mockCollection2,
    });

    mockFirestore.collection = jest.fn((collectionName: string) => {
      if (collectionName === "invitations") return {doc: mockTopLevelNotFound()};
      return {doc: mockDoc2};
    });

    await expect(
      declineInvitationHandler(data, context as any)
    ).rejects.toThrow("This invitation is not for you");
  });

  it("should successfully decline invitation without modifying group", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {
      invitationId: "invitation123",
    };

    // Mock invitation document
    const mockUpdate = jest.fn().mockResolvedValue(undefined);

    const mockInvitationRef = {
      get: jest.fn().mockResolvedValue({
        exists: true,
        data: () => ({
          status: "pending",
          invitedUserId: "user123",
          groupId: "group456",
          groupName: "Test Group",
        }),
      }),
      update: mockUpdate,
    };

    // Mock collection/doc structure
    const mockDoc = jest.fn((docId: string) => {
      if (docId === "invitation123") {
        return mockInvitationRef;
      }
      return {doc: jest.fn()};
    });

    const mockCollection2 = jest.fn().mockReturnValue({
      doc: mockDoc,
    });

    const mockDoc2 = jest.fn().mockReturnValue({
      collection: mockCollection2,
    });

    mockFirestore.collection = jest.fn((collectionName: string) => {
      if (collectionName === "invitations") return {doc: mockTopLevelNotFound()};
      return {doc: mockDoc2};
    });

    const result = await declineInvitationHandler(data, context as any);

    expect(result).toEqual({
      success: true,
      message: "Declined invitation to Test Group",
    });

    // Verify invitation was updated with status, respondedAt, and updatedAt
    expect(mockUpdate).toHaveBeenCalledTimes(1);
    expect(mockUpdate).toHaveBeenCalledWith(
      expect.objectContaining({
        status: "declined",
        respondedAt: expect.anything(),
        updatedAt: expect.anything(),
      })
    );
  });

  it("should handle update failure gracefully", async () => {
    const context = {
      auth: {uid: "user123"},
    };

    const data = {
      invitationId: "invitation123",
    };

    // Mock invitation document with update failure
    const mockUpdate = jest.fn().mockRejectedValue(new Error("Update failed"));

    const mockInvitationRef = {
      get: jest.fn().mockResolvedValue({
        exists: true,
        data: () => ({
          status: "pending",
          invitedUserId: "user123",
          groupId: "group456",
          groupName: "Test Group",
        }),
      }),
      update: mockUpdate,
    };

    // Mock collection/doc structure
    const mockDoc = jest.fn((docId: string) => {
      if (docId === "invitation123") {
        return mockInvitationRef;
      }
      return {doc: jest.fn()};
    });

    const mockCollection2 = jest.fn().mockReturnValue({
      doc: mockDoc,
    });

    const mockDoc2 = jest.fn().mockReturnValue({
      collection: mockCollection2,
    });

    mockFirestore.collection = jest.fn((collectionName: string) => {
      if (collectionName === "invitations") return {doc: mockTopLevelNotFound()};
      return {doc: mockDoc2};
    });

    await expect(
      declineInvitationHandler(data, context as any)
    ).rejects.toThrow("Failed to decline invitation");
  });
});
