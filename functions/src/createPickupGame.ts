// Cloud Function for creating pickup games (no group context).
// Direct Firestore writes for pickup games are blocked by security rules;
// all creation goes through this callable so the Admin SDK can write server-side.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// ============================================================================
// Type Definitions
// ============================================================================

interface CreatePickupGameRequest {
  title: string;
  description?: string | null;
  scheduledAt: string; // ISO 8601 UTC string
  locationName: string;
  locationAddress?: string | null;
  maxPlayers?: number;
  minPlayers?: number;
  gameType?: string | null;
}

interface CreatePickupGameResponse {
  gameId: string;
}

// ============================================================================
// Input Validation
// ============================================================================

function validateRequest(data: unknown): CreatePickupGameRequest {
  const d = data as Record<string, unknown>;

  if (!d.title || typeof d.title !== "string" || d.title.trim().length === 0) {
    throw new functions.https.HttpsError("invalid-argument", "title is required.");
  }
  if (!d.scheduledAt || typeof d.scheduledAt !== "string") {
    throw new functions.https.HttpsError("invalid-argument", "scheduledAt (ISO 8601) is required.");
  }
  const scheduledDate = new Date(d.scheduledAt as string);
  if (isNaN(scheduledDate.getTime())) {
    throw new functions.https.HttpsError("invalid-argument", "scheduledAt is not a valid ISO 8601 date.");
  }
  if (!d.locationName || typeof d.locationName !== "string" || d.locationName.trim().length === 0) {
    throw new functions.https.HttpsError("invalid-argument", "locationName is required.");
  }

  return {
    title: (d.title as string).trim(),
    description: typeof d.description === "string" ? d.description.trim() : null,
    scheduledAt: d.scheduledAt as string,
    locationName: (d.locationName as string).trim(),
    locationAddress: typeof d.locationAddress === "string" ? d.locationAddress.trim() : null,
    maxPlayers: typeof d.maxPlayers === "number" ? d.maxPlayers : 10,
    minPlayers: typeof d.minPlayers === "number" ? d.minPlayers : 2,
    gameType: typeof d.gameType === "string" ? d.gameType : null,
  };
}

// ============================================================================
// Cloud Function
// ============================================================================

export const createPickupGame = functions
  .region("europe-west6")
  .https.onCall(async (data, context): Promise<CreatePickupGameResponse> => {
    // Auth guard
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "You must be logged in to create a pickup game."
      );
    }

    const uid = context.auth.uid;
    functions.logger.info("[createPickupGame] Start", { uid });

    const req = validateRequest(data);

    const gameDoc = {
      title: req.title,
      description: req.description,
      groupId: null,
      contextType: "pickup",
      createdBy: uid,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      scheduledAt: admin.firestore.Timestamp.fromDate(new Date(req.scheduledAt)),
      location: {
        name: req.locationName,
        address: req.locationAddress,
      },
      maxPlayers: req.maxPlayers,
      minPlayers: req.minPlayers,
      playerIds: [uid],
      gameType: req.gameType,
      status: "scheduled",
      pendingInviteeIds: [],
    };

    try {
      const docRef = await admin.firestore().collection("games").add(gameDoc);
      functions.logger.info("[createPickupGame] Game created", { gameId: docRef.id, uid });
      return { gameId: docRef.id };
    } catch (err) {
      functions.logger.error("[createPickupGame] Firestore write failed", { uid, err });
      throw new functions.https.HttpsError("internal", "Failed to create game. Please try again.");
    }
  });
