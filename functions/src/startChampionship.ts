// Admin-only Cloud Function that starts a championship and generates all round-robin fixtures (Story 30.4).
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { generateRoundRobinFixtures } from "./roundRobinFixtures";
import { sendChampionshipNotificationToUsers } from "./championshipNotifications";
import { withLogging } from './utils/logger';

// ============================================================================
// Type Definitions
// ============================================================================

interface StartChampionshipRequest {
  championshipId: string;
  startDate: string; // ISO 8601 date
}

interface StartChampionshipResponse {
  matchesCreated: number; // should be 45 for 10 teams
}

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function startChampionshipHandler(
  data: StartChampionshipRequest,
  context: functions.https.CallableContext
): Promise<StartChampionshipResponse> {
  // ── 1. Auth ────────────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to start a championship"
    );
  }

  const callerId = context.auth.uid;
  functions.logger.info("[startChampionship] Start", {
    callerId,
    championshipId: data?.championshipId,
  });

  // ── 2. Input Validation ────────────────────────────────────────────────────
  if (!data?.championshipId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: championshipId"
    );
  }

  if (!data?.startDate) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required field: startDate"
    );
  }

  const startDate = new Date(data.startDate);
  if (isNaN(startDate.getTime())) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "startDate must be a valid ISO 8601 date"
    );
  }

  const db = admin.firestore();
  const champRef = db.collection("championships").doc(data.championshipId);

  // ── 3. Championship Validation ─────────────────────────────────────────────
  const champSnap = await champRef.get();
  if (!champSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Championship not found");
  }

  const champ = champSnap.data()!;

  // Only championship admins may start it
  if (!Array.isArray(champ.adminIds) || !champ.adminIds.includes(callerId)) {
    functions.logger.warn("[startChampionship] Permission denied", { callerId });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only championship admins can start the championship"
    );
  }

  const validStatuses = ["registration", "registration_closed"];
  if (!validStatuses.includes(champ.status)) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Championship must be in registration status to start (current: ${champ.status})`
    );
  }

  if (champ.teamsCount !== champ.maxTeams) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Championship requires ${champ.maxTeams} teams to start (current: ${champ.teamsCount})`
    );
  }

  // ── 4. Load Team IDs ───────────────────────────────────────────────────────
  const teamsSnap = await champRef.collection("teams").get();
  if (teamsSnap.size !== champ.maxTeams) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Expected ${champ.maxTeams} teams, found ${teamsSnap.size}`
    );
  }

  const teamIds = teamsSnap.docs.map((d) => d.id);

  // ── 5. Generate Fixtures ───────────────────────────────────────────────────
  let fixtures;
  try {
    fixtures = generateRoundRobinFixtures(teamIds, startDate);
  } catch (err) {
    functions.logger.error("[startChampionship] Fixture generation failed", { err });
    throw new functions.https.HttpsError("internal", "Failed to generate fixtures");
  }

  // ── 6. Write Everything in Batches ─────────────────────────────────────────
  // Firestore batch limit is 500 operations. 45 matches + 10 standings + 1 champ = 56 ops — one batch is fine.
  const batch = db.batch();
  const matchesRef = champRef.collection("matches");

  for (const fixture of fixtures) {
    const matchRef = matchesRef.doc();
    batch.set(matchRef, {
      round: fixture.round,
      teamAId: fixture.teamAId,
      teamBId: fixture.teamBId,
      roundStartDate: admin.firestore.Timestamp.fromDate(fixture.roundStartDate),
      deadline: admin.firestore.Timestamp.fromDate(fixture.deadline),
      status: "pending",
      result: null,
      adminDecision: null,
      standingsUpdated: false,
    });
  }

  // Initialise standings (all zeros) for every team
  const standingsRef = champRef.collection("standings");
  for (const doc of teamsSnap.docs) {
    const standingRef = standingsRef.doc(doc.id);
    batch.set(standingRef, {
      teamName: doc.data().name ?? "",
      played: 0,
      points: 0,
      wins20: 0,
      wins21: 0,
      losses12: 0,
      losses02: 0,
      setsWon: 0,
      setsLost: 0,
      position: 0,
    });
  }

  // Update championship document
  batch.update(champRef, {
    status: "active",
    currentRound: 1,
    startDate: admin.firestore.Timestamp.fromDate(startDate),
  });

  try {
    await batch.commit();
  } catch (err) {
    functions.logger.error("[startChampionship] Batch write failed", { err });
    throw new functions.https.HttpsError(
      "internal",
      "Failed to write championship data. Please try again."
    );
  }

  functions.logger.info("[startChampionship] Championship started", {
    championshipId: data.championshipId,
    matchesCreated: fixtures.length,
  });

  // ── 7. Notify all registered team members (non-fatal) ─────────────────────
  try {
    const allMemberIds = teamsSnap.docs.flatMap(
      (doc) => (doc.data().memberIds ?? []) as string[]
    );
    const uniqueMemberIds = [...new Set(allMemberIds)];

    await sendChampionshipNotificationToUsers(db, uniqueMemberIds, {
      title: "Championship started! 🏐",
      body: "Your championship is now active. Start coordinating your first matches.",
      data: {
        type: "championship",
        championshipId: data.championshipId,
      },
    });
  } catch (notifErr) {
    // Non-fatal — the championship is already started.
    functions.logger.error("[startChampionship] Notification failed (non-fatal)", {
      notifErr,
      championshipId: data.championshipId,
    });
  }

  return { matchesCreated: fixtures.length };
}

export const startChampionship = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 60, memory: "256MB" })
  .https.onCall(withLogging('startChampionship', startChampionshipHandler));
