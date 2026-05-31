// Firestore triggers for championship push notifications (Story 30.13).
// Covers: result submitted → opposing team; disputed → admins; admin decision → both teams.
// The 'verified' notification is handled in onChampionshipMatchVerified.ts.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// ============================================================================
// Shared helpers
// ============================================================================

/** Returns member IDs for a team, or [] if the team doc doesn't exist. */
async function getTeamMemberIds(
  db: admin.firestore.Firestore,
  championshipId: string,
  teamId: string
): Promise<string[]> {
  const snap = await db
    .collection("championships")
    .doc(championshipId)
    .collection("teams")
    .doc(teamId)
    .get();
  return snap.exists ? (snap.data()?.memberIds ?? []) : [];
}

/** Returns the display name for a team, or the teamId as fallback. */
export async function getTeamName(
  db: admin.firestore.Firestore,
  championshipId: string,
  teamId: string
): Promise<string> {
  const snap = await db
    .collection("championships")
    .doc(championshipId)
    .collection("teams")
    .doc(teamId)
    .get();
  return snap.exists && snap.data()?.name ? snap.data()!.name : teamId;
}

interface FcmPayload {
  title: string;
  body: string;
  data: Record<string, string>;
}

/**
 * Sends an FCM notification to a list of users, respecting:
 * - `notificationPreferences.championship !== false`
 * - quiet hours
 * Stale tokens are cleaned up automatically.
 */
export async function sendChampionshipNotificationToUsers(
  db: admin.firestore.Firestore,
  userIds: string[],
  payload: FcmPayload
): Promise<void> {
  if (userIds.length === 0) return;

  // Load all user docs in parallel
  const userSnaps = await Promise.all(
    userIds.map((uid) => db.collection("users").doc(uid).get())
  );

  // Collect valid tokens per user
  const tokenToUserId = new Map<string, string>();

  for (const snap of userSnaps) {
    if (!snap.exists) continue;
    const uid = snap.id;
    const data = snap.data()!;

    const prefs = data.notificationPreferences ?? {};

    // Respect championship notification preference (opt-out)
    if (prefs.championship === false) {
      functions.logger.info(
        "[championshipNotifications] User opted out of championship notifications",
        { uid }
      );
      continue;
    }

    // Respect quiet hours
    if (isQuietHours(prefs.quietHours)) {
      functions.logger.info(
        "[championshipNotifications] User in quiet hours — skipping",
        { uid }
      );
      continue;
    }

    const tokens: string[] = data.fcmTokens ?? [];
    for (const token of tokens) {
      tokenToUserId.set(token, uid);
    }
  }

  const allTokens = Array.from(tokenToUserId.keys());
  if (allTokens.length === 0) return;

  const message: admin.messaging.MulticastMessage = {
    tokens: allTokens,
    notification: {
      title: payload.title,
      body: payload.body,
    },
    data: payload.data,
    android: {
      priority: "high",
      notification: {
        channelId: "high_importance_channel",
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    },
    apns: {
      payload: {
        aps: { badge: 1, sound: "default" },
      },
    },
  };

  const response = await admin.messaging().sendEachForMulticast(message);

  functions.logger.info("[championshipNotifications] Notifications sent", {
    successCount: response.successCount,
    failureCount: response.failureCount,
  });

  // Remove stale tokens
  if (response.failureCount > 0) {
    const staleByUser = new Map<string, string[]>();
    response.responses.forEach((resp, idx) => {
      if (
        !resp.success &&
        (resp.error?.code === "messaging/invalid-registration-token" ||
          resp.error?.code === "messaging/registration-token-not-registered")
      ) {
        const token = allTokens[idx];
        const uid = tokenToUserId.get(token);
        if (uid) {
          if (!staleByUser.has(uid)) staleByUser.set(uid, []);
          staleByUser.get(uid)!.push(token);
        }
      }
    });

    await Promise.all(
      Array.from(staleByUser.entries()).map(([uid, tokens]) =>
        db.collection("users").doc(uid).update({
          fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokens),
        })
      )
    );
  }
}

function isQuietHours(quietHours: unknown): boolean {
  if (
    !quietHours ||
    typeof quietHours !== "object" ||
    !(quietHours as Record<string, unknown>).enabled
  ) {
    return false;
  }
  const qh = quietHours as { start: string; end: string };
  const now = new Date();
  const currentMinutes = now.getHours() * 60 + now.getMinutes();
  const [sh, sm] = qh.start.split(":").map(Number);
  const [eh, em] = qh.end.split(":").map(Number);
  const startMin = sh * 60 + sm;
  const endMin = eh * 60 + em;
  return startMin <= endMin
    ? currentMinutes >= startMin && currentMinutes <= endMin
    : currentMinutes >= startMin || currentMinutes <= endMin;
}

// ============================================================================
// Shared inner handlers (exported for unit tests)
// ============================================================================

export async function onChampionshipMatchResultSubmittedHandler(
  before: admin.firestore.DocumentData,
  after: admin.firestore.DocumentData,
  params: { championshipId: string; matchId: string },
  db: admin.firestore.Firestore
): Promise<void> {
  // Only fire when status transitions to 'played'
  if (before.status === after.status || after.status !== "played") return;

  const { championshipId, matchId } = params;

  functions.logger.info("[onChampionshipMatchResultSubmitted] Processing", {
    championshipId,
    matchId,
  });

  // Load both team member IDs and names in parallel
  const [teamAMembers, teamBMembers, teamAName, teamBName] = await Promise.all([
    getTeamMemberIds(db, championshipId, after.teamAId),
    getTeamMemberIds(db, championshipId, after.teamBId),
    getTeamName(db, championshipId, after.teamAId),
    getTeamName(db, championshipId, after.teamBId),
  ]);

  // Notify the opposing team (those who did NOT submit)
  const submittedByTeamId = after.submittedByTeamId;
  const opposingMembers =
    submittedByTeamId === after.teamAId ? teamBMembers : teamAMembers;

  if (opposingMembers.length === 0) return;

  await sendChampionshipNotificationToUsers(db, opposingMembers, {
    title: `Result to verify — ${teamAName} vs ${teamBName}`,
    body: `${submittedByTeamId === after.teamAId ? teamAName : teamBName} submitted the result. Tap to verify.`,
    data: {
      type: "championship_result_submitted",
      championshipId,
      matchId,
    },
  });
}

export async function onChampionshipMatchDisputedHandler(
  before: admin.firestore.DocumentData,
  after: admin.firestore.DocumentData,
  params: { championshipId: string; matchId: string },
  db: admin.firestore.Firestore
): Promise<void> {
  // Only fire when status transitions to 'disputed'
  if (before.status === after.status || after.status !== "disputed") return;

  const { championshipId, matchId } = params;

  functions.logger.info("[onChampionshipMatchDisputed] Processing", {
    championshipId,
    matchId,
  });

  // Load championship admins and team names in parallel
  const champSnap = await db.collection("championships").doc(championshipId).get();
  if (!champSnap.exists) return;

  const adminIds: string[] = champSnap.data()?.adminIds ?? [];
  if (adminIds.length === 0) return;

  const [teamAName, teamBName] = await Promise.all([
    getTeamName(db, championshipId, after.teamAId),
    getTeamName(db, championshipId, after.teamBId),
  ]);

  await sendChampionshipNotificationToUsers(db, adminIds, {
    title: "Match disputed 🚨",
    body: `${teamBName} disputed the result of ${teamAName} vs ${teamBName}. Admin action required.`,
    data: {
      type: "championship_match_disputed",
      championshipId,
      matchId,
    },
  });
}

export async function onChampionshipAdminDecisionHandler(
  before: admin.firestore.DocumentData,
  after: admin.firestore.DocumentData,
  params: { championshipId: string; matchId: string },
  db: admin.firestore.Firestore
): Promise<void> {
  // Only fire when status transitions to 'admin_decided'
  if (before.status === after.status || after.status !== "admin_decided") return;

  const { championshipId, matchId } = params;

  functions.logger.info("[onChampionshipAdminDecision] Processing", {
    championshipId,
    matchId,
  });

  const [teamAMembers, teamBMembers, teamAName, teamBName] = await Promise.all([
    getTeamMemberIds(db, championshipId, after.teamAId),
    getTeamMemberIds(db, championshipId, after.teamBId),
    getTeamName(db, championshipId, after.teamAId),
    getTeamName(db, championshipId, after.teamBId),
  ]);

  const allMembers = [...new Set([...teamAMembers, ...teamBMembers])];
  if (allMembers.length === 0) return;

  await sendChampionshipNotificationToUsers(db, allMembers, {
    title: "Match decided by admin",
    body: `Admin set the result for ${teamAName} vs ${teamBName}.`,
    data: {
      type: "championship_admin_decision",
      championshipId,
      matchId,
    },
  });
}

// ============================================================================
// Cloud Function exports
// ============================================================================

const matchDocument =
  "championships/{championshipId}/matches/{matchId}";

export const onChampionshipMatchResultSubmitted = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .firestore.document(matchDocument)
  .onUpdate(async (change, context) => {
    const db = admin.firestore();
    await onChampionshipMatchResultSubmittedHandler(
      change.before.data()!,
      change.after.data()!,
      {
        championshipId: context.params.championshipId,
        matchId: context.params.matchId,
      },
      db
    );
  });

export const onChampionshipMatchDisputed = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .firestore.document(matchDocument)
  .onUpdate(async (change, context) => {
    const db = admin.firestore();
    await onChampionshipMatchDisputedHandler(
      change.before.data()!,
      change.after.data()!,
      {
        championshipId: context.params.championshipId,
        matchId: context.params.matchId,
      },
      db
    );
  });

export const onChampionshipAdminDecision = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .firestore.document(matchDocument)
  .onUpdate(async (change, context) => {
    const db = admin.firestore();
    await onChampionshipAdminDecisionHandler(
      change.before.data()!,
      change.after.data()!,
      {
        championshipId: context.params.championshipId,
        matchId: context.params.matchId,
      },
      db
    );
  });
