// Cloud Function for creating championships — any authenticated user (Story 30.2, updated)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// ============================================================================
// Type Definitions
// ============================================================================

interface CreateChampionshipRequest {
  title: string;
  registrationDeadline: string; // ISO 8601 date
  startDate?: string; // ISO 8601 date — when matches begin
  endDate?: string; // ISO 8601 date — last day of the championship
  country?: string; // ISO 3166-1 alpha-2
  region?: string;
  genderCategory?: "male" | "female"; // null = no restriction
  maxTeams?: number; // allowed: 4, 6, 8, 10 — default 10
  teamSize?: number; // allowed: 2 or 3 — default 2
}

interface CreateChampionshipResponse {
  championshipId: string;
}

// ============================================================================
// Helper Functions
// ============================================================================

/**
 * Validates the championship title.
 */
function validateTitle(title: string): string | null {
  if (!title || title.trim().length === 0) {
    return "Title is required";
  }
  if (title.trim().length < 3) {
    return "Title must be at least 3 characters";
  }
  if (title.trim().length > 100) {
    return "Title must be less than 100 characters";
  }
  return null;
}

/**
 * Validates the registration deadline — must be a valid ISO 8601 date in the future.
 */
function validateDeadline(registrationDeadline: string): { date: Date; error: string | null } {
  const date = new Date(registrationDeadline);
  if (isNaN(date.getTime())) {
    return { date, error: "registrationDeadline must be a valid ISO 8601 date" };
  }
  if (date <= new Date()) {
    return { date, error: "registrationDeadline must be in the future" };
  }
  return { date, error: null };
}

// ============================================================================
// Main Cloud Function
// ============================================================================

/**
 * Inner handler — exported separately so unit tests can call it directly
 * without needing the full Firebase Functions wrapper.
 */
export async function createChampionshipHandler(
  data: CreateChampionshipRequest,
  context: functions.https.CallableContext
): Promise<CreateChampionshipResponse> {
  // ========================================
  // 1. Authentication Check
  // ========================================
  if (!context.auth) {
    functions.logger.warn("Unauthenticated attempt to create championship");
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to create a championship"
    );
  }

  const userId = context.auth.uid;

  functions.logger.info("createChampionship called", {
    userId,
    title: data?.title,
  });

  // ========================================
  // 2. Input Validation
  // ========================================
  const allowedMaxTeams = [4, 6, 8, 10];
  const allowedTeamSizes = [2, 3];
  const maxTeams = data?.maxTeams ?? 10;
  const teamSize = data?.teamSize ?? 2;

  if (!allowedMaxTeams.includes(maxTeams)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `maxTeams must be one of: ${allowedMaxTeams.join(", ")}`
    );
  }
  if (!allowedTeamSizes.includes(teamSize)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `teamSize must be 2 or 3`
    );
  }

  if (!data || !data.title || !data.registrationDeadline) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: title, registrationDeadline"
    );
  }

  const titleError = validateTitle(data.title);
  if (titleError) {
    throw new functions.https.HttpsError("invalid-argument", titleError);
  }

  const { date: deadline, error: deadlineError } = validateDeadline(data.registrationDeadline);
  if (deadlineError) {
    throw new functions.https.HttpsError("invalid-argument", deadlineError);
  }

  // ========================================
  // 3. Create Championship Document
  // ========================================
  const db = admin.firestore();

  try {
    const startDate = data.startDate ? new Date(data.startDate) : null;
    const endDate = data.endDate ? new Date(data.endDate) : null;

    // Round-robin: N teams → N-1 rounds, N/2 matches per round.
    const totalRounds = maxTeams - 1;

    const championshipData = {
      title: data.title.trim(),
      status: "registration",
      maxTeams,
      teamSize,
      adminIds: [userId],
      currentRound: 0,
      totalRounds,
      teamsCount: 0,
      registrationDeadline: admin.firestore.Timestamp.fromDate(deadline),
      startDate: startDate ? admin.firestore.Timestamp.fromDate(startDate) : null,
      endDate: endDate ? admin.firestore.Timestamp.fromDate(endDate) : null,
      country: data.country?.toUpperCase() ?? null,
      region: data.region?.trim() ?? null,
      genderCategory: data.genderCategory ?? null,
      createdBy: userId,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const docRef = await db.collection("championships").add(championshipData);

    functions.logger.info("Championship created successfully", {
      championshipId: docRef.id,
      userId,
    });

    return { championshipId: docRef.id };
  } catch (error) {
    functions.logger.error("Failed to create championship", { userId, error });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to create championship. Please try again."
    );
  }
}

/**
 * Creates a new championship. Any authenticated user may call this function.
 * The caller becomes the championship admin (stored in adminIds and createdBy).
 *
 * Security:
 * - Validates authentication
 * - Validates all input parameters
 * - Uses Admin SDK to write to Firestore (bypasses security rules)
 */
export const createChampionship = functions
  .region("europe-west6")
  .runWith({
    timeoutSeconds: 30,
    memory: "256MB",
  })
  .https.onCall(createChampionshipHandler);
