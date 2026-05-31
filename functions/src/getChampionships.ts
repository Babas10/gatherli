// Returns all championships ordered by createdAt descending (Story 30.x fix).
// Uses Admin SDK so clients do not need collection-level Firestore read access.
// All fields are serialised to JSON-safe types (ISO strings for timestamps).
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// ============================================================================
// Types
// ============================================================================

interface ChampionshipData {
  id: string;
  title: string;
  status: string;
  maxTeams: number;
  teamSize: number;
  adminIds: string[];
  createdBy: string;
  createdAt: string;          // ISO 8601
  registrationDeadline: string; // ISO 8601
  currentRound: number;
  totalRounds: number;
  teamsCount: number;
  startDate: string | null;   // ISO 8601 or null
  country: string | null;
  region: string | null;
}

interface GetChampionshipsResponse {
  championships: ChampionshipData[];
}

// ============================================================================
// Inner handler (exported for unit tests)
// ============================================================================

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

  functions.logger.info("[getChampionships] Loading championships", {
    uid: context.auth.uid,
  });

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
    };
  });

  functions.logger.info("[getChampionships] Returning championships", {
    count: championships.length,
  });

  return {championships};
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const getChampionships = functions
  .region("europe-west6")
  .https.onCall(getChampionshipsHandler);
