import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

export type GameGenderType = "male" | "female" | "mix";

/**
 * Classifies a game's gender type based on the current player list.
 *
 * Rules:
 * - Returns null when playerIds is empty or no player has a set gender field
 * - Returns 'mix' immediately when any player explicitly chose 'none' or
 *   'prefer_not_to_say' — these mean "neither male nor female" and make the
 *   game unclassifiable as single-gender
 * - Returns 'male' when all players with a gender set have gender = 'male'
 * - Returns 'female' when all players with a gender set have gender = 'female'
 * - Returns 'mix' when players include both male and female
 *
 * Players whose gender field is missing entirely (never set — e.g. registered
 * before gender onboarding was added) are skipped and do not influence the result.
 *
 * Story 26.4 / fix #726
 */
export async function classifyGameGenderType(
  playerIds: string[]
): Promise<GameGenderType | null> {
  if (playerIds.length === 0) {
    return null;
  }

  const db = admin.firestore();
  const genders = new Set<string>();

  for (const playerId of playerIds) {
    const userDoc = await db.collection("users").doc(playerId).get();
    const userData = userDoc.data();
    const gender: string | undefined = userData?.gender;

    if (gender === undefined || gender === null) {
      // Gender field was never set (e.g. registered before gender onboarding) — skip
      functions.logger.debug("[classifyGameGenderType] Skipping player with missing gender field", {
        playerId,
      });
      continue;
    }

    if (gender === "none" || gender === "prefer_not_to_say") {
      // Explicit non-binary choice — game cannot be classified as single-gender
      functions.logger.debug("[classifyGameGenderType] Player chose non-binary gender → mix", {
        playerId,
        gender,
      });
      return "mix";
    }

    genders.add(gender);
  }

  // No players had a gender field set → cannot determine type
  if (genders.size === 0) {
    return null;
  }

  if (genders.size === 1) {
    return genders.has("male") ? "male" : "female";
  }

  return "mix";
}
