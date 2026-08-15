// Cloud Function for listing all championships — authenticated callable (Story 30.x)
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

// ============================================================================
// Type Definitions
// ============================================================================

interface ChampionshipData {
  id: string;
  title: string;
  status: string;
  maxTeams: number;
  teamSize: number;
  adminIds: string[];
  createdBy: string;
  createdAt: string; // ISO 8601
  registrationDeadline: string; // ISO 8601
  currentRound: number;
  totalRounds: number;
  teamsCount: number;
  startDate: string | null; // ISO 8601
  country: string | null;
  region: string | null;
  genderCategory: string | null;
}

interface GetChampionshipsResponse {
  championships: ChampionshipData[];
}

// ============================================================================
// Main Cloud Function
// ============================================================================

/**
 * Inner handler — exported separately so unit tests can call it directly
 * without needing the full Firebase Functions wrapper.
 */
export async function getChampionshipsHandler(
  _data: unknown,
  context: functions.https.CallableContext
): Promise<GetChampionshipsResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to view championships."
    );
  }

  functions.logger.info("getChampionships called", { userId: context.auth.uid });

  const db = admin.firestore();
  const snap = await db
    .collection("championships")
    .orderBy("createdAt", "desc")
    .get();

  const championships: ChampionshipData[] = snap.docs.map((doc) => {
    const d = doc.data();
    return {
      id: doc.id,
      title: (d.title as string) ?? "",
      status: (d.status as string) ?? "registration",
      maxTeams: (d.maxTeams as number) ?? 10,
      teamSize: (d.teamSize as number) ?? 2,
      adminIds: (d.adminIds as string[]) ?? [],
      createdBy: (d.createdBy as string) ?? "",
      createdAt: d.createdAt?.toDate?.()?.toISOString() ?? new Date(0).toISOString(),
      registrationDeadline:
        d.registrationDeadline?.toDate?.()?.toISOString() ?? new Date(0).toISOString(),
      currentRound: (d.currentRound as number) ?? 0,
      totalRounds: (d.totalRounds as number) ?? 9,
      teamsCount: (d.teamsCount as number) ?? 0,
      startDate: d.startDate?.toDate?.()?.toISOString() ?? null,
      country: (d.country as string | null) ?? null,
      region: (d.region as string | null) ?? null,
      genderCategory: (d.genderCategory as string | null) ?? null,
    };
  });

  return { championships };
}

/**
 * Returns all championships ordered by creation date (newest first).
 * Any authenticated user may call this function.
 *
 * Security:
 * - Validates authentication
 * - Uses Admin SDK to read from Firestore (bypasses security rules)
 */
export const getChampionships = functions
  .region("europe-west6")
  .runWith({
    timeoutSeconds: 30,
    memory: "256MB",
  })
  .https.onCall(withLogging('getChampionships', getChampionshipsHandler));
