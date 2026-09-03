import * as admin from "firebase-admin";
import { processGameEloUpdates } from "../src/elo";

/**
 * Migration: Backfill ELO for games skipped by the result.winner/
 * overallWinner validation regression.
 *
 * Date: 2026-09-01
 * Story: none — production hotfix (see functions/src/elo.ts fix in the
 * same PR, and functions/src/migrateBackfillMissingElo.ts for the prod
 * callable version of this same logic).
 *
 * What it changes:
 *   Before: `games/{gameId}` docs with status=="completed" that were never
 *           given `eloUpdates` / `eloCalculated: true` because
 *           `processGameEloUpdates` threw on `result.overallWinner`-only
 *           documents (it wrongly required `result.winner`, which only
 *           championship matches have).
 *   After:  Those games get reprocessed through the (now-fixed)
 *           `processGameEloUpdates`, updating player eloRating/streak/
 *           ratingHistory and setting `eloCalculated: true`.
 *
 * Safe to run multiple times? YES — only queries eloCalculated==false games;
 * a document that succeeds flips to eloCalculated:true and drops out of the
 * query on the next run. Games that fail for a different reason (e.g.
 * genuinely missing teams) will keep failing and keep showing up in the
 * failure log below until investigated separately.
 * Estimated documents affected: unknown until run — bounded by however many
 * regular group games completed between commit ba15dd7 deploying and this
 * fix deploying (~2 weeks).
 */

if (!admin.apps.length) {
  admin.initializeApp();
}
const db = admin.firestore();

async function migrate(): Promise<void> {
  let processed = 0;
  let updated = 0;
  const failed: { gameId: string; error: string }[] = [];

  const snapshot = await db
    .collection("games")
    .where("status", "==", "completed")
    .where("eloCalculated", "==", false)
    .get();

  for (const doc of snapshot.docs) {
    processed++;
    const gameData = doc.data();

    if (gameData.gameGenderType === "mix") continue;

    try {
      await processGameEloUpdates(doc.id, gameData);
      updated++;
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      failed.push({ gameId: doc.id, error: message });
    }
  }

  console.log("Migration complete:");
  console.log(`  Games processed: ${processed}`);
  console.log(`  Games updated:   ${updated}`);
  console.log(`  Games failed:    ${failed.length}`);
  if (failed.length > 0) {
    console.log("  Failures:", JSON.stringify(failed, null, 2));
  }
}

migrate().catch(e => {
  console.error(e);
  process.exit(1);
});
