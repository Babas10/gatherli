// Firestore trigger: recalculates championship standings when a match is verified (Story 30.8).
// Also sends push notifications to both teams on verification (Story 30.13).
// Fires on championships/{championshipId}/matches/{matchId} when status → 'verified' or 'admin_decided'.
// Idempotency guard: skips if standingsUpdated is already true on the match doc.
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  StandingsRow,
  computeStandingsDeltas,
  applyDelta,
  recalculatePositions,
  MatchResultData,
} from "./standingsCalculation";
import {
  getTeamName,
  sendChampionshipNotificationToUsers,
} from "./championshipNotifications";

// ============================================================================
// Inner Handler (exported for unit tests)
// ============================================================================

export async function onChampionshipMatchVerifiedHandler(
  before: admin.firestore.DocumentSnapshot,
  after: admin.firestore.DocumentSnapshot,
  params: { championshipId: string; matchId: string }
): Promise<void> {
  const afterData = after.data();
  const beforeData = before.data();

  // ── 1. Guard: only handle verified or admin_decided status ─────────────────
  const relevantStatuses = ["verified", "admin_decided"];
  if (!afterData || !relevantStatuses.includes(afterData.status)) {
    return;
  }

  // ── 2. Idempotency: skip if standings already updated ─────────────────────
  if (afterData.standingsUpdated === true) {
    functions.logger.info(
      "[onChampionshipMatchVerified] Already processed — skipping",
      { matchId: params.matchId }
    );
    return;
  }

  // ── 3. Verify status actually changed (avoid processing non-status updates) ─
  if (beforeData?.status === afterData.status && beforeData?.standingsUpdated === afterData.standingsUpdated) {
    return;
  }

  const { championshipId, matchId } = params;

  functions.logger.info("[onChampionshipMatchVerified] Processing match", {
    championshipId,
    matchId,
    status: afterData.status,
  });

  // ── 4. Validate result data ────────────────────────────────────────────────
  const result = afterData.result;
  if (!result?.sets || !result?.winner) {
    functions.logger.error(
      "[onChampionshipMatchVerified] Match has no valid result — cannot update standings",
      { matchId }
    );
    return;
  }

  const matchData: MatchResultData = {
    teamAId: afterData.teamAId,
    teamBId: afterData.teamBId,
    result: {
      sets: result.sets,
      winner: result.winner,
      teamAPoints: result.teamAPoints,
      teamBPoints: result.teamBPoints,
    },
  };

  const db = admin.firestore();
  const champRef = db.collection("championships").doc(championshipId);
  const matchRef = champRef.collection("matches").doc(matchId);

  // ── 5. Load all standings and all completed matches (for H2H tiebreaker) ───
  const [standingsSnap, matchesSnap] = await Promise.all([
    champRef.collection("standings").get(),
    champRef
      .collection("matches")
      .where("status", "in", ["verified", "admin_decided"])
      .get(),
  ]);

  // ── 6. Build current standings map ────────────────────────────────────────
  const standingsMap = new Map<string, StandingsRow>();
  for (const doc of standingsSnap.docs) {
    const d = doc.data();
    standingsMap.set(doc.id, {
      teamId: doc.id,
      teamName: d.teamName ?? "",
      played: d.played ?? 0,
      points: d.points ?? 0,
      wins20: d.wins20 ?? 0,
      wins21: d.wins21 ?? 0,
      losses12: d.losses12 ?? 0,
      losses02: d.losses02 ?? 0,
      setsWon: d.setsWon ?? 0,
      setsLost: d.setsLost ?? 0,
      position: d.position ?? 0,
    });
  }

  // ── 7. Compute deltas and apply to teamA / teamB ───────────────────────────
  const { teamA: deltaA, teamB: deltaB } = computeStandingsDeltas(matchData);

  const rowA = standingsMap.get(matchData.teamAId);
  const rowB = standingsMap.get(matchData.teamBId);

  if (!rowA || !rowB) {
    functions.logger.error(
      "[onChampionshipMatchVerified] Standings rows missing for one or both teams",
      { teamAId: matchData.teamAId, teamBId: matchData.teamBId }
    );
    return;
  }

  standingsMap.set(matchData.teamAId, applyDelta(rowA, deltaA));
  standingsMap.set(matchData.teamBId, applyDelta(rowB, deltaB));

  // ── 8. Build head-to-head lookup (includes this match via the updated map) ─
  // We use completed matches from Firestore (not including current one yet)
  // plus the current match's result for a fresh lookup.
  const completedMatches = matchesSnap.docs
    .filter((d) => d.id !== matchId) // exclude current match to avoid double-count
    .map((d) => {
      const md = d.data();
      return {
        teamAId: md.teamAId as string,
        teamBId: md.teamBId as string,
        winner: md.result?.winner as string | undefined,
      };
    })
    .filter((m) => !!m.winner);

  // Also include the current match being processed
  completedMatches.push({
    teamAId: matchData.teamAId,
    teamBId: matchData.teamBId,
    winner: matchData.result.winner === "teamA" ? matchData.teamAId : matchData.teamBId,
  });

  function headToHead(idA: string, idB: string): string | null {
    const match = completedMatches.find(
      (m) =>
        (m.teamAId === idA && m.teamBId === idB) ||
        (m.teamAId === idB && m.teamBId === idA)
    );
    return match?.winner ?? null;
  }

  // ── 9. Recalculate positions ───────────────────────────────────────────────
  const updatedStandings = recalculatePositions(
    Array.from(standingsMap.values()),
    headToHead
  );

  // ── 10. Batch write all standings + set standingsUpdated flag ──────────────
  const batch = db.batch();

  for (const row of updatedStandings) {
    const ref = champRef.collection("standings").doc(row.teamId);
    batch.set(ref, {
      teamName: row.teamName,
      played: row.played,
      points: row.points,
      wins20: row.wins20,
      wins21: row.wins21,
      losses12: row.losses12,
      losses02: row.losses02,
      setsWon: row.setsWon,
      setsLost: row.setsLost,
      position: row.position,
    });
  }

  batch.update(matchRef, { standingsUpdated: true });

  try {
    await batch.commit();
    functions.logger.info(
      "[onChampionshipMatchVerified] Standings updated successfully",
      { championshipId, matchId, teamsUpdated: updatedStandings.length }
    );
  } catch (err) {
    functions.logger.error(
      "[onChampionshipMatchVerified] Batch write failed",
      { err, championshipId, matchId }
    );
    throw err;
  }

  // ── 11. Auto-advance currentRound when all matches in this round complete ──
  // A match counts as "done" when standingsUpdated === true (verified with a
  // result) OR when it is admin_decided (covers cancelled matches whose
  // standingsUpdated stays false because there is no result to process).
  try {
    const matchRound: number = afterData.round;
    const roundMatchesSnap = await champRef
      .collection("matches")
      .where("round", "==", matchRound)
      .get();

    const allDone = roundMatchesSnap.docs.every((doc) => {
      const d = doc.data();
      return d.standingsUpdated === true || d.status === "admin_decided";
    });

    if (allDone) {
      const champSnap = await champRef.get();
      if (champSnap.exists) {
        const champ = champSnap.data()!;
        const totalRounds: number = champ.totalRounds ?? 9;
        const nextRound = matchRound + 1;

        if (nextRound <= totalRounds) {
          await champRef.update({ currentRound: nextRound });
          functions.logger.info(
            "[onChampionshipMatchVerified] Round advanced",
            { championshipId, from: matchRound, to: nextRound }
          );
        } else {
          functions.logger.info(
            "[onChampionshipMatchVerified] Final round complete",
            { championshipId, round: matchRound }
          );
        }
      }
    }
  } catch (advanceErr) {
    // Non-fatal — standings are already saved; round pointer is cosmetic.
    functions.logger.error(
      "[onChampionshipMatchVerified] Round advancement failed (non-fatal)",
      { advanceErr, matchId }
    );
  }

  // ── 12. Notify the SUBMITTING team only (Story 30.13, refined) ───────────
  // The verifying team just did the verification — they don't need a push.
  // Only the submitting team needs to know their result was accepted.
  if (afterData.status === "verified") {
    try {
      const submittedByTeamId: string | undefined = afterData.submittedByTeamId;
      if (!submittedByTeamId) {
        functions.logger.warn(
          "[onChampionshipMatchVerified] submittedByTeamId missing — skipping notification",
          { matchId }
        );
      } else {
        const [submittingMembers, submittingTeamName, opposingTeamName] =
          await Promise.all([
            db
              .collection("championships")
              .doc(championshipId)
              .collection("teams")
              .doc(submittedByTeamId)
              .get()
              .then((s) => (s.exists ? (s.data()?.memberIds ?? []) : [])),
            getTeamName(db, championshipId, afterData.teamAId),
            getTeamName(db, championshipId, afterData.teamBId),
          ]);

        const winner =
          result.winner === "teamA" ? submittingTeamName : opposingTeamName;
        const loser =
          result.winner === "teamA" ? opposingTeamName : submittingTeamName;
        const scoreText = result.sets
          .map((s: { teamAPoints: number; teamBPoints: number }) =>
            `${s.teamAPoints}-${s.teamBPoints}`
          )
          .join(", ");

        await sendChampionshipNotificationToUsers(db, submittingMembers, {
          title: "Result confirmed ✓",
          body: `${winner} defeated ${loser} (${scoreText}) — standings updated.`,
          data: {
            type: "championship_match",
            championshipId,
            matchId,
          },
        });
      }
    } catch (notifErr) {
      // Notification failure must not fail the standings update
      functions.logger.error(
        "[onChampionshipMatchVerified] Notification failed (non-fatal)",
        { notifErr, matchId }
      );
    }
  }
}

// ============================================================================
// Cloud Function export
// ============================================================================

export const onChampionshipMatchVerified = functions
  .region("europe-west6")
  .runWith({ timeoutSeconds: 60, memory: "256MB" })
  .firestore.document("championships/{championshipId}/matches/{matchId}")
  .onUpdate(async (change, context) => {
    return onChampionshipMatchVerifiedHandler(
      change.before,
      change.after,
      {
        championshipId: context.params.championshipId,
        matchId: context.params.matchId,
      }
    );
  });
