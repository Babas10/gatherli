// Cloud Function for searching users with smart filtering
// Story 11.12: Search Users via Cloud Function
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { withLogging } from './utils/logger';

interface SearchUsersRequest {
  query: string;
}

interface UserResult {
  uid: string;
  displayName: string | null;
  email: string;
  photoUrl?: string | null;
}

interface SearchUsersResponse {
  users: UserResult[];
}

const RESULT_LIMIT = 20;
// Fetched per-field before self/friend/pending filtering, so that a query
// dominated by filtered-out candidates (e.g. many friends sharing an email
// domain) still has a reasonable chance of filling RESULT_LIMIT.
const QUERY_FETCH_LIMIT = 50;
// Highest possible Unicode code point — appending it to a prefix bounds a
// Firestore range query to "starts with that prefix" (standard pattern for
// prefix search, since Firestore has no native startsWith operator).
const UNICODE_MAX_SUFFIX = "";

/**
 * Handler function for searching users (exported for testing)
 *
 * Searches users by email or displayName **prefix** (case-insensitive) and
 * filters out:
 * - The current user (self)
 * - Already connected friends
 * - Users with pending friend requests
 *
 * Note: this is a prefix match, not a substring match — Firestore range
 * queries can only bound a field's prefix, not match anywhere within it.
 * `displayNameLower` is a denormalized lowercase copy of `displayName`
 * (Firestore range queries are case-sensitive); `email` is already
 * lowercase via Firebase Auth.
 *
 * @param data - Object containing { query: string }
 * @param context - Authentication context
 * @returns Object with { users: UserResult[] }
 */
export async function searchUsersHandler(
  data: SearchUsersRequest,
  context: functions.https.CallableContext
): Promise<SearchUsersResponse> {
  // Ensure user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated to search for users"
    );
  }

  // Validate input
  if (!data || typeof data.query !== "string") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Query parameter is required and must be a string"
    );
  }

  // Normalize query
  const query = data.query.toLowerCase().trim();

  // Validate minimum query length (per Story 11.12 requirements)
  if (query.length < 3) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Query must be at least 3 characters long"
    );
  }

  const currentUserId = context.auth.uid;
  const db = admin.firestore();

  try {
    // Get accepted friend IDs and pending request IDs in parallel
    const [acceptedFriendships1, acceptedFriendships2, pendingFriendships] = await Promise.all([
      db.collection("friendships")
        .where("initiatorId", "==", currentUserId)
        .where("status", "==", "accepted")
        .get(),
      db.collection("friendships")
        .where("recipientId", "==", currentUserId)
        .where("status", "==", "accepted")
        .get(),
      db.collection("friendships")
        .where("status", "==", "pending")
        .get(),
    ]);

    const friendIds = new Set<string>();
    acceptedFriendships1.docs.forEach(doc => friendIds.add(doc.data().recipientId));
    acceptedFriendships2.docs.forEach(doc => friendIds.add(doc.data().initiatorId));

    const pendingRequestIds = new Set<string>();
    for (const doc of pendingFriendships.docs) {
      const data = doc.data();
      if (data.initiatorId === currentUserId) {
        pendingRequestIds.add(data.recipientId);
      } else if (data.recipientId === currentUserId) {
        pendingRequestIds.add(data.initiatorId);
      }
    }

    // Indexed prefix-range queries on email and displayNameLower, run in
    // parallel — bounded reads instead of a full-collection scan. Firestore
    // covers each with its automatic single-field index (no composite index
    // needed since there's no additional where()/orderBy() on another field).
    const [emailSnapshot, nameSnapshot] = await Promise.all([
      db.collection("users")
        .where("email", ">=", query)
        .where("email", "<=", query + UNICODE_MAX_SUFFIX)
        .limit(QUERY_FETCH_LIMIT)
        .get(),
      db.collection("users")
        .where("displayNameLower", ">=", query)
        .where("displayNameLower", "<=", query + UNICODE_MAX_SUFFIX)
        .limit(QUERY_FETCH_LIMIT)
        .get(),
    ]);

    // Merge and dedupe candidates matched by either field.
    const candidates = new Map<string, FirebaseFirestore.DocumentData>();
    emailSnapshot.docs.forEach((doc) => candidates.set(doc.id, doc.data()));
    nameSnapshot.docs.forEach((doc) => candidates.set(doc.id, doc.data()));

    const results: UserResult[] = [];

    for (const [userId, userData] of candidates) {
      // Skip if user is self
      if (userId === currentUserId) {
        continue;
      }

      // Skip if already friends
      if (friendIds.has(userId)) {
        continue;
      }

      // Skip if has pending request
      if (pendingRequestIds.has(userId)) {
        continue;
      }

      results.push({
        uid: userId,
        displayName: userData.displayName || null,
        email: userData.email,
        photoUrl: userData.photoUrl || null,
      });

      // Limit results to prevent huge response sizes
      if (results.length >= RESULT_LIMIT) {
        break;
      }
    }

    functions.logger.info("Search users completed", {
      userId: currentUserId,
      query: query,
      resultCount: results.length,
    });

    return {
      users: results,
    };
  } catch (error) {
    functions.logger.error("Error searching users", {
      userId: currentUserId,
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    // Check if it's a permission error
    if ((error as any).code === "permission-denied") {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You don't have permission to search for users"
      );
    }

    // Generic error
    throw new functions.https.HttpsError(
      "internal",
      "An error occurred while searching for users"
    );
  }
}

/**
 * Cloud Function to search for users with smart filtering.
 *
 * This function provides a secure way to search users while automatically
 * filtering out users that shouldn't be shown (self, friends, pending requests).
 *
 * Following Epic 11's Cloud Function-first architecture.
 */
export const searchUsers = functions.region('europe-west6').https.onCall(withLogging('searchUsers', searchUsersHandler));
