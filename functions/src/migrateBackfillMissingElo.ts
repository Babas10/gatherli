import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';
import { processGameEloUpdates } from "./elo";

/**
 * Response interface for migrateBackfillMissingElo Cloud Function
 */
export interface MigrateBackfillMissingEloResponse {
  success: boolean;
  message: string;
  gamesProcessed: number;
  gamesUpdated: number;
  gamesFailed: { gameId: string; error: string }[];
}

/**
 * Handler function for migrateBackfillMissingElo (exported for testing)
 *
 * One-time backfill: reprocesses ELO for completed games that were silently
 * skipped by a regression in `processGameEloUpdates`.
 *
 * Background:
 * - Commit ba15dd7 ("feat(elo): fix ELO calculation + championship
 *   integration") changed the result-shape validation in elo.ts to require
 *   `gameData.result.winner`. Regular group games only ever write
 *   `result.overallWinner` (see GameResult in lib/core/data/models/
 *   game_model.dart) — `winner` is a championship-match-only field.
 * - As a result, `onGameStatusChanged` (functions/src/gameUpdates.ts) threw
 *   "Invalid game data: Missing result winner" for every group game that
 *   completed since that commit deployed, leaving `eloCalculated: false`
 *   permanently with no rating change and no retry.
 * - The validation itself is now fixed to accept either field. This
 *   migration backfills the games that were stuck during the affected
 *   window.
 *
 * Safety:
 * - Idempotent: only queries games with `eloCalculated == false`. Any game
 *   this migration successfully reprocesses flips to `eloCalculated: true`
 *   and drops out of the query on a re-run.
 * - Restricted to admin users only (uid must exist in the `appAdmins`
 *   collection).
 * - Reuses `processGameEloUpdates` directly — no duplicated ELO logic.
 * - Genuinely malformed games (e.g. missing teams) fail individually and
 *   are reported in `gamesFailed`, without aborting the rest of the batch.
 *
 * Deployment order:
 * 1. Deploy this function alongside the elo.ts fix, verify on dev.
 * 2. Deploy to prod.
 * 3. Run this migration once on prod to backfill affected games.
 * 4. Delete this function after the migration is confirmed complete.
 *
 * @param _data - Not used; no input required
 * @param context - Firebase Functions context with auth information
 * @returns Promise resolving to MigrateBackfillMissingEloResponse
 */
export async function migrateBackfillMissingEloHandler(
  _data: unknown,
  context: functions.https.CallableContext
): Promise<MigrateBackfillMissingEloResponse> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be authenticated to run this migration."
    );
  }

  const callerUid = context.auth.uid;

  const db = admin.firestore();
  const adminDoc = await db.collection("appAdmins").doc(callerUid).get();
  if (!adminDoc.exists) {
    functions.logger.warn("[migrateBackfillMissingElo] Unauthorized attempt", {
      callerUid,
    });
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only app admins can run data migrations."
    );
  }

  functions.logger.info("[migrateBackfillMissingElo] Migration started", {
    callerUid,
  });

  let gamesProcessed = 0;
  let gamesUpdated = 0;
  const gamesFailed: { gameId: string; error: string }[] = [];
  const batchSize = 100;

  try {
    let lastDoc: admin.firestore.QueryDocumentSnapshot | undefined;
    let hasMore = true;

    while (hasMore) {
      let query = db
        .collection("games")
        .where("status", "==", "completed")
        .where("eloCalculated", "==", false)
        .limit(batchSize);
      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const snapshot = await query.get();

      if (snapshot.empty) {
        hasMore = false;
        break;
      }

      for (const doc of snapshot.docs) {
        gamesProcessed++;
        const gameData = doc.data();

        // Mixed games are intentionally never processed for ELO — the
        // onGameStatusChanged trigger flips eloCalculated=true for them
        // immediately, so a mixed game should never appear in this query.
        // Skip defensively in case one slipped through some other path.
        if (gameData.gameGenderType === "mix") {
          continue;
        }

        try {
          await processGameEloUpdates(doc.id, gameData);
          gamesUpdated++;
        } catch (error) {
          const message = error instanceof Error ? error.message : String(error);
          gamesFailed.push({ gameId: doc.id, error: message });
          functions.logger.error(
            `[migrateBackfillMissingElo] Failed to reprocess game ${doc.id}`,
            { error: message }
          );
        }
      }

      lastDoc = snapshot.docs[snapshot.docs.length - 1];
      hasMore = snapshot.docs.length === batchSize;
    }

    functions.logger.info("[migrateBackfillMissingElo] Migration complete", {
      callerUid,
      gamesProcessed,
      gamesUpdated,
      gamesFailedCount: gamesFailed.length,
    });

    return {
      success: true,
      message: `Migration complete. Processed ${gamesProcessed} games, backfilled ELO for ${gamesUpdated}, ${gamesFailed.length} failed.`,
      gamesProcessed,
      gamesUpdated,
      gamesFailed,
    };
  } catch (error) {
    functions.logger.error("[migrateBackfillMissingElo] Migration failed", {
      callerUid,
      gamesProcessed,
      gamesUpdated,
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    throw new functions.https.HttpsError(
      "internal",
      `Migration failed after processing ${gamesProcessed} games (${gamesUpdated} updated). Error: ${
        error instanceof Error ? error.message : String(error)
      }`
    );
  }
}

/**
 * One-time callable Cloud Function to backfill ELO for completed games that
 * were silently skipped by the `result.winner`/`overallWinner` validation
 * regression (commit ba15dd7).
 *
 * See migrateBackfillMissingEloHandler for full documentation.
 *
 * Restricted to app admins only (caller uid must exist in `appAdmins` collection).
 */
export const migrateBackfillMissingElo = functions
  .region("europe-west6")
  .runWith({
    timeoutSeconds: 540, // Max 9 minutes
    memory: "512MB",
  })
  .https.onCall(withLogging('migrateBackfillMissingElo', migrateBackfillMissingEloHandler));
