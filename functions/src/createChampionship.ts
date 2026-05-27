// Cloud Function for creating championships — admin-only callable (Story 30.2)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// ============================================================================
// Type Definitions
// ============================================================================

interface CreateChampionshipRequest {
  title: string;
  registrationDeadline: string; // ISO 8601 date
  country?: string; // ISO 3166-1 alpha-2
  region?: string;
}

interface CreateChampionshipResponse {
  championshipId: string;
}

// ============================================================================
// Helper Functions
// ============================================================================

/**
 * Checks whether the given uid is a platform admin.
 * Looks up the `platform_admins/{uid}` document — if it exists the caller is an admin.
 */
async function isPlatformAdmin(uid: string): Promise<boolean> {
  const db = admin.firestore();
  const adminDoc = await db.collection("platform_admins").doc(uid).get();
  return adminDoc.exists;
}

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
  // 2. Admin Permission Check
  // ========================================
  const adminCheck = await isPlatformAdmin(userId);
  if (!adminCheck) {
    functions.logger.warn("Non-admin attempted to create championship", { userId });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only platform admins can create championships"
    );
  }

  // ========================================
  // 3. Input Validation
  // ========================================
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
  // 4. Create Championship Document
  // ========================================
  const db = admin.firestore();

  try {
    const championshipData = {
      title: data.title.trim(),
      status: "registration",
      maxTeams: 10,
      teamSize: 2,
      adminIds: [userId],
      currentRound: 0,
      totalRounds: 9,
      teamsCount: 0,
      registrationDeadline: admin.firestore.Timestamp.fromDate(deadline),
      country: data.country?.toUpperCase() ?? null,
      region: data.region?.trim() ?? null,
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
 * Creates a new championship. Only platform admins may call this function.
 *
 * Security:
 * - Validates authentication
 * - Validates caller is a platform admin (platform_admins/{uid} doc must exist)
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
