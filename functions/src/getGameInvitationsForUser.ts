// getGameInvitationsForUser — Story 28.7
// Returns all pending game invitations for the authenticated user, enriched
// with game title, scheduled date, location, group name, and inviter display name.
// Invitees cannot read game/group/user docs directly (Firestore rules), so this
// function uses the Admin SDK to join the data server-side.

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

const db = () => admin.firestore();

interface EnrichedInvitation {
  invitationId: string;
  gameId: string;
  groupId: string;
  inviterId: string;
  status: string;
  type: string; // "guest" | "group_game"
  createdAt: string;
  expiresAt: string | null;
  gameTitle: string;
  gameScheduledAt: string;
  gameLocationName: string;
  groupName: string;
  inviterDisplayName: string;
}

export const getGameInvitationsForUserHandler = async (
  data: unknown,
  context: functions.https.CallableContext
): Promise<{ invitations: EnrichedInvitation[] }> => {
  // ── Authentication ────────────────────────────────────────────────────────
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be logged in to view your invitations."
    );
  }

  const uid = context.auth.uid;

  try {
    // ── Fetch pending invitations from both collections ─────────────────────
    // Legacy `gameInvitations`: group-game notifications written by onGameCreated
    //   trigger (field: inviteeId, inviterId).
    // Unified `invitations`: written by sendInvitation CF (Story 31.6+), covers
    //   guest and pickup-game invitations (field: invitedUserId, invitedBy).
    const [legacySnap, unifiedSnap] = await Promise.all([
      db()
        .collection("gameInvitations")
        .where("inviteeId", "==", uid)
        .where("status", "==", "pending")
        .orderBy("createdAt", "desc")
        .get(),
      db()
        .collection("invitations")
        .where("type", "==", "game")
        .where("invitedUserId", "==", uid)
        .where("status", "==", "pending")
        .orderBy("createdAt", "desc")
        .get(),
    ]);

    if (legacySnap.empty && unifiedSnap.empty) {
      return { invitations: [] };
    }

    // Normalise unified-collection docs to the same shape as legacy ones so
    // the rest of the pipeline is collection-agnostic.
    const normalisedUnified = unifiedSnap.docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        data: () => ({
          gameId: d.gameId,
          groupId: d.groupId ?? null,
          inviteeId: d.invitedUserId,
          inviterId: d.invitedBy,
          status: d.status,
          type: d.type ?? "guest",
          createdAt: d.createdAt,
          expiresAt: d.expiresAt ?? null,
        }),
      };
    });

    const allDocs = [...legacySnap.docs, ...normalisedUnified];

    // ── Filter out expired invitations ──────────────────────────────────────
    const now = new Date();
    const invDocs = allDocs.filter((doc) => {
      const expiresAt = doc.data().expiresAt as admin.firestore.Timestamp | undefined;
      return !expiresAt || expiresAt.toDate() > now;
    });

    if (invDocs.length === 0) {
      return { invitations: [] };
    }

    // ── Collect unique IDs for batch fetching ───────────────────────────────
    const gameIds = [...new Set(invDocs.map((d) => d.data().gameId as string))];
    const groupIds = [
      ...new Set(
        invDocs
          .map((d) => d.data().groupId as string | null)
          .filter((id): id is string => !!id)
      ),
    ];
    const inviterIds = [...new Set(invDocs.map((d) => d.data().inviterId as string))];

    // ── Parallel batch fetches ──────────────────────────────────────────────
    const [gameDocs, groupDocs, inviterDocs] = await Promise.all([
      Promise.all(gameIds.map((id) => db().collection("games").doc(id).get())),
      Promise.all(groupIds.map((id) => db().collection("groups").doc(id).get())),
      Promise.all(inviterIds.map((id) => db().collection("users").doc(id).get())),
    ]);

    // Build lookup maps
    const gameMap = new Map(gameDocs.map((d) => [d.id, d.data()]));
    const groupMap = new Map(groupDocs.map((d) => [d.id, d.data()]));
    const inviterMap = new Map(inviterDocs.map((d) => [d.id, d.data()]));

    // ── Enrich and return ───────────────────────────────────────────────────
    const enriched = invDocs.map((doc) => {
      const inv = doc.data();
      const game = gameMap.get(inv.gameId) ?? {};
      const group = inv.groupId ? (groupMap.get(inv.groupId) ?? {}) : {};
      const inviter = inviterMap.get(inv.inviterId) ?? {};

      // Skip if the user has already joined this game (badge should disappear).
      const playerIds: string[] = (game.playerIds as string[]) ?? [];
      if (playerIds.includes(uid)) return null;

      const scheduledAt: admin.firestore.Timestamp | undefined = game.scheduledAt;
      const createdAt: admin.firestore.Timestamp | undefined = inv.createdAt;
      const expiresAt: admin.firestore.Timestamp | undefined = inv.expiresAt;

      return {
        invitationId: doc.id,
        gameId: inv.gameId,
        groupId: inv.groupId,
        inviterId: inv.inviterId,
        status: inv.status,
        type: (inv.type as string) ?? "guest",
        createdAt: createdAt?.toDate().toISOString() ?? new Date().toISOString(),
        expiresAt: expiresAt ? expiresAt.toDate().toISOString() : null,
        gameTitle: (game.title as string) ?? "Game",
        gameScheduledAt: scheduledAt?.toDate().toISOString() ?? new Date().toISOString(),
        gameLocationName: (game.location as { name?: string })?.name ?? "",
        groupName: (group.name as string) ?? "",
        inviterDisplayName: (inviter.displayName as string) ?? (inviter.email as string) ?? "",
      } satisfies EnrichedInvitation;
    });

    const invitations = enriched.filter((inv): inv is EnrichedInvitation => inv !== null);

    functions.logger.info("[getGameInvitationsForUser] success", {
      uid,
      count: invitations.length,
    });

    return { invitations };
  } catch (error) {
    functions.logger.error("[getGameInvitationsForUser] error", { uid, error });
    if (error instanceof functions.https.HttpsError) throw error;
    throw new functions.https.HttpsError(
      "internal",
      "Failed to load game invitations. Please try again."
    );
  }
};

export const getGameInvitationsForUser = functions
  .region("europe-west6")
  .https.onCall(withLogging('getGameInvitationsForUser', getGameInvitationsForUserHandler));
