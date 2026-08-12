import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { writeAnalyticsEvent } from "./helpers/analytics";

/**
 * Helper function to check if current time is within quiet hours
 */
function isQuietHours(quietHours: any): boolean {
  if (!quietHours || !quietHours.enabled) {
    return false;
  }

  const now = new Date();
  const currentMinutes = now.getHours() * 60 + now.getMinutes();

  const [startHour, startMin] = quietHours.start.split(":").map(Number);
  const [endHour, endMin] = quietHours.end.split(":").map(Number);

  const startMinutes = startHour * 60 + startMin;
  const endMinutes = endHour * 60 + endMin;

  if (startMinutes <= endMinutes) {
    // Same day quiet hours (e.g., 14:00 to 18:00)
    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  } else {
    // Overnight quiet hours (e.g., 22:00 to 08:00)
    return currentMinutes >= startMinutes || currentMinutes <= endMinutes;
  }
}

/**
 * Send notification when user is invited to a group
 */
export const onInvitationCreated = functions.region('europe-west6').firestore
  .document("users/{userId}/invitations/{invitationId}")
  .onCreate(async (snapshot, context) => {
    const invitation = snapshot.data();
    const userId = context.params.userId;
    const invitationId = context.params.invitationId;

    functions.logger.info("Invitation created, processing notification", {
      userId,
      invitationId,
      groupId: invitation.groupId,
      invitedBy: invitation.invitedBy,
    });

    try {
      // Get user's FCM tokens
      const userDoc = await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .get();

      const userData = userDoc.data();
      if (!userData) {
        functions.logger.warn("User not found for invitation notification", {
          userId,
          invitationId,
        });
        return null;
      }

      const fcmTokens = userData.fcmTokens || [];
      if (fcmTokens.length === 0) {
        functions.logger.info("User has no FCM tokens", {
          userId,
          invitationId,
        });
        return null;
      }

      // Check notification preferences
      const prefs = userData.notificationPreferences || {};
      if (prefs.social === false) {
        functions.logger.info("User has disabled group invitation notifications", {
          userId,
          invitationId,
        });
        return null;
      }

      // Check quiet hours
      if (isQuietHours(prefs.quietHours)) {
        functions.logger.info("User is in quiet hours", {
          userId,
          invitationId,
        });
        return null;
      }

      // Get group details
      const groupDoc = await admin
        .firestore()
        .collection("groups")
        .doc(invitation.groupId)
        .get();

      const groupData = groupDoc.data();
      if (!groupData) {
        functions.logger.warn("Group not found for invitation notification", {
          userId,
          invitationId,
          groupId: invitation.groupId,
        });
        return null;
      }

      // Send notification
      const message: admin.messaging.MulticastMessage = {
        tokens: fcmTokens,
        notification: {
          title: "Group Invitation",
          body: `${invitation.inviterName} invited you to join ${groupData.name}`,
        },
        data: {
          type: "invitation",
          groupId: invitation.groupId,
          invitationId: snapshot.id,
        },
        android: {
          priority: "high",
          notification: {
            channelId: "high_importance_channel",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              badge: 1,
              sound: "default",
            },
          },
        },
      };

      const response = await admin.messaging().sendEachForMulticast(message);
      functions.logger.info("Invitation notification sent successfully", {
        userId,
        invitationId,
        successCount: response.successCount,
        failureCount: response.failureCount,
      });

      // Remove invalid tokens
      if (response.failureCount > 0) {
        const tokensToRemove: string[] = [];
        response.responses.forEach((resp, idx) => {
          if (
            !resp.success &&
            (resp.error?.code === "messaging/invalid-registration-token" ||
              resp.error?.code === "messaging/registration-token-not-registered")
          ) {
            tokensToRemove.push(fcmTokens[idx]);
          }
        });

        if (tokensToRemove.length > 0) {
          await admin
            .firestore()
            .collection("users")
            .doc(userId)
            .update({
              fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
            });
          functions.logger.info("Removed invalid FCM tokens", {
            userId,
            invitationId,
            removedCount: tokensToRemove.length,
          });
        }
      }

      await writeAnalyticsEvent("invitation_sent", { groupId: invitation.groupId });
      return null;
    } catch (error) {
      functions.logger.error("Error sending invitation notification", {
        userId,
        invitationId,
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
      });
      return null;
    }
  });

/**
 * Send notification when invitation is accepted
 */
export const onInvitationAccepted = functions.region('europe-west6').firestore
  .document("users/{userId}/invitations/{invitationId}")
  .onUpdate(async (_change, _context) => {
    // Notification removed (Story N.2 — low-signal noise reduction).
    // The inviter sees the new member in the group list — no push needed.
    return null;
   
  });
/**
 * Send notification when a new game is created
 * Notifies all group members except the creator
 */
export const onGameCreated = functions.region('europe-west6').firestore
  .document("games/{gameId}")
  .onCreate(async (snapshot, context) => {
    const game = snapshot.data();
    const gameId = context.params.gameId;
    const groupId = game.groupId ?? null; // null for pickup games (Story 31.8)

    functions.logger.info("Game created, processing notifications", {
      groupId,
      gameId,
      createdBy: game.createdBy,
      contextType: game.contextType,
    });

    // Pickup games have no group — skip group notification logic entirely.
    if (!groupId) {
      functions.logger.info("[onGameCreated] Pickup game — skipping group notifications", { gameId });
      return null;
    }

    try {
      // Get group details
      const groupDoc = await admin
        .firestore()
        .collection("groups")
        .doc(groupId)
        .get();

      const groupData = groupDoc.data();
      if (!groupData) {
        functions.logger.warn("Group not found for game notification", {
          groupId,
          gameId,
        });
        return null;
      }

      const members: string[] = groupData.memberIds || [];

      functions.logger.debug("Processing game notifications for members", {
        groupId,
        gameId,
        memberCount: members.length,
      });

      // ── Write gameInvitations for badge notifications ──────────────────────
      // One document per group member (except creator) drives the ball-icon
      // badge count so same-group game creation appears in the notification dot.
      const eligibleMembers = members.filter((id: string) => id !== game.createdBy);
      if (eligibleMembers.length > 0) {
        const invBatch = admin.firestore().batch();
        for (const memberId of eligibleMembers) {
          // Deterministic doc ID ensures idempotency if the trigger re-fires.
          const invRef = admin
            .firestore()
            .collection("gameInvitations")
            .doc(`${gameId}_group_${memberId}`);
          invBatch.set(invRef, {
            gameId,
            groupId,
            inviteeId: memberId,
            inviterId: game.createdBy,
            status: "pending",
            type: "group_game",
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            expiresAt: game.scheduledAt ?? null,
          });
        }
        await invBatch.commit();
        functions.logger.info("[onGameCreated] wrote group_game invitations", {
          groupId,
          gameId,
          count: eligibleMembers.length,
        });
      }

      // Get creator details for notification message
      const creatorDoc = await admin
        .firestore()
        .collection("users")
        .doc(game.createdBy)
        .get();

      const creatorData = creatorDoc.data();

      // Try to get creator name in order of preference
      let creatorName = "Someone";
      if (creatorData) {
        if (creatorData.firstName && creatorData.lastName) {
          creatorName = `${creatorData.firstName} ${creatorData.lastName}`;
        } else if (creatorData.displayName) {
          creatorName = creatorData.displayName;
        } else if (creatorData.email) {
          creatorName = creatorData.email;
        }
      }

      // Track notifications sent per user for cleanup
      const userTokenMap = new Map<string, string[]>();
      const allTokens: string[] = [];

      // Collect FCM tokens from all eligible members
      for (const memberId of members) {
        if (memberId === game.createdBy) {
          continue; // Don't notify creator
        }

        const memberDoc = await admin
          .firestore()
          .collection("users")
          .doc(memberId)
          .get();

        const memberData = memberDoc.data();
        if (!memberData) {
          functions.logger.debug("Member not found", {memberId, groupId, gameId});
          continue;
        }

        const fcmTokens = memberData.fcmTokens || [];
        if (fcmTokens.length === 0) {
          functions.logger.debug("Member has no FCM tokens", {memberId, groupId, gameId});
          continue;
        }

        const prefs = memberData.notificationPreferences || {};

        const shouldNotify = prefs.games !== false;

        if (!shouldNotify) {
          functions.logger.debug("Member has disabled game notifications", {
            memberId,
            groupId,
            gameId,
          });
          continue;
        }

        // Check quiet hours
        if (isQuietHours(prefs.quietHours)) {
          functions.logger.debug("Member is in quiet hours", {
            memberId,
            groupId,
            gameId,
          });
          continue;
        }

        // Add tokens to map for later cleanup if needed
        userTokenMap.set(memberId, fcmTokens);
        allTokens.push(...fcmTokens);
      }

      if (allTokens.length === 0) {
        functions.logger.info("No members to notify for new game", {
          groupId,
          gameId,
        });
        return null;
      }

      // Format the game date
      const gameDate = game.scheduledAt?.toDate();
      let dateStr = "";
      if (gameDate) {
        const options: Intl.DateTimeFormatOptions = {
          month: "short",
          day: "numeric",
          hour: "numeric",
          minute: "2-digit",
        };
        dateStr = ` on ${gameDate.toLocaleDateString("en-US", options)}`;
      }

      // Format the location
      const location = game.location?.name || "TBD";

      // Send notification
      const message: admin.messaging.MulticastMessage = {
        tokens: allTokens,
        notification: {
          title: `New Game: ${game.title || "Game"}`,
          body: `${creatorName} created a game${dateStr} at ${location}`,
        },
        data: {
          type: "game_created",
          groupId: groupId,
          gameId: gameId,
          creatorId: game.createdBy,
          scheduledAt: gameDate?.toISOString() || "",
        },
        android: {
          priority: "high",
          notification: {
            channelId: "high_importance_channel",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              badge: 1,
              sound: "default",
            },
          },
        },
      };

      const response = await admin.messaging().sendEachForMulticast(message);

      functions.logger.info("Game created notification sent successfully", {
        groupId,
        gameId,
        successCount: response.successCount,
        failureCount: response.failureCount,
      });

      // Remove invalid tokens
      if (response.failureCount > 0) {
        const invalidTokensByUser = new Map<string, string[]>();

        response.responses.forEach((resp, idx) => {
          if (
            !resp.success &&
            (resp.error?.code === "messaging/invalid-registration-token" ||
              resp.error?.code === "messaging/registration-token-not-registered")
          ) {
            const invalidToken = allTokens[idx];

            // Find which user this token belongs to
            for (const [userId, tokens] of userTokenMap.entries()) {
              if (tokens.includes(invalidToken)) {
                if (!invalidTokensByUser.has(userId)) {
                  invalidTokensByUser.set(userId, []);
                }
                invalidTokensByUser.get(userId)!.push(invalidToken);
                break;
              }
            }
          }
        });

        // Clean up invalid tokens per user
        for (const [userId, tokensToRemove] of invalidTokensByUser.entries()) {
          await admin
            .firestore()
            .collection("users")
            .doc(userId)
            .update({
              fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
            });

          functions.logger.info("Removed invalid FCM tokens", {
            userId,
            groupId,
            gameId,
            removedCount: tokensToRemove.length,
          });
        }
      }

      await writeAnalyticsEvent("game_created", { groupId, sport: game.sport ?? "unknown" });
      return null;
    } catch (error) {
      functions.logger.error("Error sending game created notification", {
        groupId,
        gameId,
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
      });
      return null;
    }
  });

/**
 * Send notification when a member joins the group
 */
export const onMemberJoined = functions.region('europe-west6').firestore
  .document("groups/{groupId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    const beforeMembers = before.memberIds || [];
    const afterMembers = after.memberIds || [];

    // Find new members
    const newMembers = afterMembers.filter((id: string) => !beforeMembers.includes(id));

    if (newMembers.length === 0) {
      return null;
    }

    const groupId = context.params.groupId;

    // Notification removed (Story N.2 — low-signal noise reduction).
    // Admins can see new members in the group view.
    await writeAnalyticsEvent("member_joined", { groupId, via: "unknown" });
    return null;
  });
/**
 * Send notification when a member leaves the group
 */
export const onMemberLeft = functions.region('europe-west6').firestore
  .document("groups/{groupId}")
  .onUpdate(async () => {
    // Notification removed (Story N.2 — low-signal noise reduction).
    return null;
  });
/**
 * Send notification when user's role changes (promoted to/demoted from admin)
 */
export const onRoleChanged = functions.region('europe-west6').firestore
  .document("groups/{groupId}")
  .onUpdate(async () => {
    // Notification removed (Story N.2 — low-signal noise reduction).
    return null;
  });
/**
 * Send notification when a friend request is sent
 */
export const onFriendRequestSent = functions.region('europe-west6').firestore
  .document("friendships/{friendshipId}")
  .onCreate(async (snapshot, context) => {
    const friendship = snapshot.data();

    // Only trigger for pending status (new friend requests)
    if (friendship.status !== "pending") {
      return null;
    }

    const recipientId = friendship.recipientId;
    const initiatorId = friendship.initiatorId;
    const friendshipId = context.params.friendshipId;

    functions.logger.info("Friend request sent, processing notification", {
      friendshipId,
      initiatorId,
      recipientId,
    });

    try {
      // Get recipient's FCM tokens
      const recipientDoc = await admin
        .firestore()
        .collection("users")
        .doc(recipientId)
        .get();

      const recipientData = recipientDoc.data();
      if (!recipientData) {
        functions.logger.warn("Recipient not found for friend request notification", {
          friendshipId,
          recipientId,
        });
        return null;
      }

      const fcmTokens = recipientData.fcmTokens || [];
      if (fcmTokens.length === 0) {
        functions.logger.info("Recipient has no FCM tokens", {
          friendshipId,
          recipientId,
        });
        return null;
      }

      // Check notification preferences
      const prefs = recipientData.notificationPreferences || {};
      if (prefs.social === false) {
        functions.logger.info("Recipient has disabled friend request notifications", {
          friendshipId,
          recipientId,
        });
        return null;
      }

      // Check quiet hours
      if (isQuietHours(prefs.quietHours)) {
        functions.logger.info("Recipient is in quiet hours", {
          friendshipId,
          recipientId,
        });
        return null;
      }

      // Get initiator details
      const initiatorDoc = await admin
        .firestore()
        .collection("users")
        .doc(initiatorId)
        .get();

      const initiatorData = initiatorDoc.data();
      const initiatorName =
        friendship.initiatorName ||
        initiatorData?.displayName ||
        "Someone";

      // Send notification
      const message: admin.messaging.MulticastMessage = {
        tokens: fcmTokens,
        notification: {
          title: "Friend Request",
          body: `${initiatorName} sent you a friend request`,
        },
        data: {
          type: "friend_request",
          friendshipId: friendshipId,
          initiatorId: initiatorId,
        },
        android: {
          priority: "high",
          notification: {
            channelId: "high_importance_channel",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              badge: 1,
              sound: "default",
            },
          },
        },
      };

      const response = await admin.messaging().sendEachForMulticast(message);
      functions.logger.info("Friend request notification sent successfully", {
        friendshipId,
        recipientId,
        successCount: response.successCount,
        failureCount: response.failureCount,
      });

      // Remove invalid tokens
      if (response.failureCount > 0) {
        const tokensToRemove: string[] = [];
        response.responses.forEach((resp, idx) => {
          if (
            !resp.success &&
            (resp.error?.code === "messaging/invalid-registration-token" ||
              resp.error?.code === "messaging/registration-token-not-registered")
          ) {
            tokensToRemove.push(fcmTokens[idx]);
          }
        });

        if (tokensToRemove.length > 0) {
          await admin
            .firestore()
            .collection("users")
            .doc(recipientId)
            .update({
              fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
            });
          functions.logger.info("Removed invalid FCM tokens", {
            friendshipId,
            recipientId,
            removedCount: tokensToRemove.length,
          });
        }
      }

      return null;
    } catch (error) {
      functions.logger.error("Error sending friend request notification", {
        friendshipId,
        recipientId,
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
      });
      return null;
    }
  });

/**
 * Send notification when a friend request is accepted
 */
export const onFriendRequestAccepted = functions.region('europe-west6').firestore
  .document("friendships/{friendshipId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    // Only trigger if status changed from pending to accepted
    if (before.status !== "pending" || after.status !== "accepted") {
      return null;
    }

    // Notification removed (reduced noise) — friend_accepted push is not
    // actionable enough to justify a ping. Only friendCount is updated.

    const initiatorId = after.initiatorId;
    const recipientId = after.recipientId;
    const friendshipId = context.params.friendshipId;

    try {
      const db = admin.firestore();
      await db.runTransaction(async (transaction) => {
        const initiatorRef = db.collection("users").doc(initiatorId);
        const recipientRef = db.collection("users").doc(recipientId);
        transaction.update(initiatorRef, {
          friendCount: admin.firestore.FieldValue.increment(1),
        });
        transaction.update(recipientRef, {
          friendCount: admin.firestore.FieldValue.increment(1),
        });
      });
      functions.logger.info("Updated friend caches on acceptance", {
        friendshipId,
        initiatorId,
        recipientId,
      });
    } catch (error) {
      functions.logger.error("Error updating friend caches", {
        friendshipId,
        error: error instanceof Error ? error.message : String(error),
      });
    }
    return null;
  });

/**
 * Silent cleanup when a friend request is declined
 */
export const onFriendRequestDeclined = functions.region('europe-west6').firestore
  .document("friendships/{friendshipId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    // Only trigger if status changed from pending to declined
    if (before.status !== "pending" || after.status !== "declined") {
      return null;
    }

    const friendshipId = context.params.friendshipId;

    // Silent cleanup - no notification sent
    // Log for analytics
    functions.logger.info("Friend request declined", {
      friendshipId,
      recipientId: after.recipientId,
      initiatorId: after.initiatorId,
    });

    return null;
  });

/**
 * Handle friend removal (cleanup caches)
 */
export const onFriendRemoved = functions.region('europe-west6').firestore
  .document("friendships/{friendshipId}")
  .onDelete(async (snapshot, context) => {
    const friendship = snapshot.data();
    const friendshipId = context.params.friendshipId;

    // Only process if friendship was accepted
    if (friendship.status !== "accepted") {
      functions.logger.info("Friendship deleted with non-accepted status, no cache cleanup needed", {
        friendshipId,
        status: friendship.status,
      });
      return null;
    }

    const initiatorId = friendship.initiatorId;
    const recipientId = friendship.recipientId;

    functions.logger.info("Friend removed, processing cache cleanup", {
      friendshipId,
      initiatorId,
      recipientId,
    });

    try {
      // Update both users' friendCount
      const db = admin.firestore();
      await db.runTransaction(async (transaction) => {
        const initiatorRef = db.collection("users").doc(initiatorId);
        const recipientRef = db.collection("users").doc(recipientId);

        // Get current user documents to safely decrement
        const initiatorDoc = await transaction.get(initiatorRef);
        const recipientDoc = await transaction.get(recipientRef);

        if (initiatorDoc.exists) {
          transaction.update(initiatorRef, {
            friendCount: admin.firestore.FieldValue.increment(-1),
          });
        }

        if (recipientDoc.exists) {
          transaction.update(recipientRef, {
            friendCount: admin.firestore.FieldValue.increment(-1),
          });
        }
      });

      functions.logger.info("Updated friend caches after removal", {
        friendshipId,
        initiatorId,
        recipientId,
      });

      // Optional: Notify the other user
      // For now, we'll skip notification as specified (friendRemoved default is false)
      // Future enhancement: Check both users' preferences and notify if enabled

      return null;
    } catch (error) {
      functions.logger.error("Error handling friend removal", {
        friendshipId,
        initiatorId,
        recipientId,
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
      });
      return null;
    }
  });

/**
 * Send notification when a player joins a game
 * Notifies all current players except the one who just joined
 */
export const onPlayerJoinedGame = functions.region('europe-west6').firestore
  .document("games/{gameId}")
  .onUpdate(async () => {
    // Notification removed (Story N.2 — low-signal noise reduction).
    return null;
  });
/**
 * Send notification when a player leaves a game
 * Notifies all remaining players except the one who left
 */
export const onPlayerLeftGame = functions.region('europe-west6').firestore
  .document("games/{gameId}")
  .onUpdate(async () => {
    // Notification removed (Story N.2 — low-signal noise reduction).
    return null;
  });
export const onWaitlistPromoted = functions.region('europe-west6').firestore
  .document("games/{gameId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    const gameId = context.params.gameId;
    const gameData = after;
    const groupId = gameData.groupId; // Get groupId from game document

    const beforePlayers = before.playerIds || [];
    const afterPlayers = after.playerIds || [];
    const beforeWaitlist = before.waitlistIds || [];
    const afterWaitlist = after.waitlistIds || [];

    // Find users who joined as players
    const newPlayers = afterPlayers.filter((id: string) => !beforePlayers.includes(id));

    // Find users who left the waitlist
    const removedFromWaitlist = beforeWaitlist.filter(
      (id: string) => !afterWaitlist.includes(id)
    );

    // Find users who were promoted (in both lists - new to players AND removed from waitlist)
    const promotedUsers = newPlayers.filter(
      (id: string) => removedFromWaitlist.includes(id)
    );

    if (promotedUsers.length === 0) {
      return null;
    }

    // Don't notify if game is cancelled
    if (after.status === "cancelled") {
      functions.logger.info("Game is cancelled, skipping waitlist promotion notifications", {
        groupId,
        gameId,
      });
      return null;
    }

    functions.logger.info("User(s) promoted from waitlist, processing notifications", {
      groupId,
      gameId,
      promotedCount: promotedUsers.length,
      promotedUsers,
    });

    try {
      // Process each promoted user
      for (const promotedId of promotedUsers) {
        // Get promoted user's details
        const promotedUserDoc = await admin
          .firestore()
          .collection("users")
          .doc(promotedId)
          .get();

        const promotedUserData = promotedUserDoc.data();

        // Try to get player name in order of preference: firstName + lastName, displayName, email, or "Someone"
        let playerName = "Someone";
        if (promotedUserData) {
          if (promotedUserData.firstName && promotedUserData.lastName) {
            playerName = `${promotedUserData.firstName} ${promotedUserData.lastName}`;
          } else if (promotedUserData.displayName) {
            playerName = promotedUserData.displayName;
          } else if (promotedUserData.email) {
            playerName = promotedUserData.email;
          }
        }

        // Calculate current player count
        const currentPlayers = afterPlayers.length;
        const maxPlayers = after.maxPlayers || 8;

        // 1. Notify the promoted user with "You's In!" message
        const promotedUserTokens = promotedUserData?.fcmTokens || [];
        if (promotedUserTokens.length > 0 && promotedUserData) {
          const promotedUserPrefs = promotedUserData.notificationPreferences || {};

          // Check games category preference (Story N.3)
          const shouldNotifyPromoted = promotedUserPrefs.games !== false;

          if (shouldNotifyPromoted && !isQuietHours(promotedUserPrefs.quietHours)) {
            const promotedMessage: admin.messaging.MulticastMessage = {
              tokens: promotedUserTokens,
              notification: {
                title: "You're In! 🎉",
                body: `A spot opened in ${after.title || "the game"}. You've been moved from the waitlist!`,
              },
              data: {
                type: "waitlist_promoted",
                groupId: groupId,
                gameId: gameId,
              },
              android: {
                priority: "high",
                notification: {
                  channelId: "high_importance_channel",
                  clickAction: "FLUTTER_NOTIFICATION_CLICK",
                },
              },
              apns: {
                payload: {
                  aps: {
                    badge: 1,
                    sound: "default",
                  },
                },
              },
            };

            const promotedResponse = await admin.messaging().sendEachForMulticast(promotedMessage);

            functions.logger.info("Waitlist promotion notification sent to promoted user", {
              groupId,
              gameId,
              promotedId,
              successCount: promotedResponse.successCount,
              failureCount: promotedResponse.failureCount,
            });

            // Remove invalid tokens for promoted user
            if (promotedResponse.failureCount > 0) {
              const tokensToRemove: string[] = [];
              promotedResponse.responses.forEach((resp, idx) => {
                if (
                  !resp.success &&
                  (resp.error?.code === "messaging/invalid-registration-token" ||
                    resp.error?.code === "messaging/registration-token-not-registered")
                ) {
                  tokensToRemove.push(promotedUserTokens[idx]);
                }
              });

              if (tokensToRemove.length > 0) {
                await admin
                  .firestore()
                  .collection("users")
                  .doc(promotedId)
                  .update({
                    fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
                  });

                functions.logger.info("Removed invalid FCM tokens from promoted user", {
                  userId: promotedId,
                  groupId,
                  gameId,
                  removedCount: tokensToRemove.length,
                });
              }
            }
          } else {
            functions.logger.debug("Promoted user has disabled waitlist notifications or is in quiet hours", {
              promotedId,
              groupId,
              gameId,
            });
          }
        }

        // 2. Notify existing players (excluding the promoted user)
        const existingPlayers = afterPlayers.filter((id: string) => id !== promotedId);

        if (existingPlayers.length === 0) {
          functions.logger.info("No existing players to notify (promoted user is first player)", {
            groupId,
            gameId,
            promotedId,
          });
          continue;
        }

        // Track tokens per user for cleanup
        const userTokenMap = new Map<string, string[]>();
        const allTokens: string[] = [];

        // Collect FCM tokens from existing players
        for (const existingPlayerId of existingPlayers) {
          const playerDoc = await admin
            .firestore()
            .collection("users")
            .doc(existingPlayerId)
            .get();

          const playerData = playerDoc.data();
          if (!playerData) {
            functions.logger.debug("Player not found", {
              existingPlayerId,
              groupId,
              gameId,
            });
            continue;
          }

          const fcmTokens = playerData.fcmTokens || [];
          if (fcmTokens.length === 0) {
            functions.logger.debug("Player has no FCM tokens", {
              existingPlayerId,
              groupId,
              gameId,
            });
            continue;
          }

          const prefs = playerData.notificationPreferences || {};

          const shouldNotify = prefs.games !== false;

          if (!shouldNotify) {
            functions.logger.debug("Player has disabled waitlist joined notifications", {
              existingPlayerId,
              groupId,
              gameId,
            });
            continue;
          }

          // Check quiet hours
          if (isQuietHours(prefs.quietHours)) {
            functions.logger.debug("Player is in quiet hours", {
              existingPlayerId,
              groupId,
              gameId,
            });
            continue;
          }

          // Add tokens to map for later cleanup if needed
          userTokenMap.set(existingPlayerId, fcmTokens);
          allTokens.push(...fcmTokens);
        }

        if (allTokens.length === 0) {
          functions.logger.info("No existing players to notify for this promotion", {
            groupId,
            gameId,
            promotedId,
          });
          continue;
        }

        // Send notification to existing players
        const message: admin.messaging.MulticastMessage = {
          tokens: allTokens,
          notification: {
            title: "Waitlist Player Joined!",
            body: `${playerName} was moved from waitlist to ${after.title || "the game"} (${currentPlayers}/${maxPlayers} players)`,
          },
          data: {
            type: "waitlist_joined",
            groupId: groupId,
            gameId: gameId,
            playerId: promotedId,
            playerName: playerName,
            currentPlayers: currentPlayers.toString(),
            maxPlayers: maxPlayers.toString(),
          },
          android: {
            priority: "high",
            notification: {
              channelId: "high_importance_channel",
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          },
          apns: {
            payload: {
              aps: {
                badge: 1,
                sound: "default",
              },
            },
          },
        };

        const response = await admin.messaging().sendEachForMulticast(message);

        functions.logger.info("Waitlist promotion notification sent to existing players", {
          groupId,
          gameId,
          promotedId,
          successCount: response.successCount,
          failureCount: response.failureCount,
        });

        // Log failures for debugging
        if (response.failureCount > 0) {
          response.responses.forEach((resp, idx) => {
            if (!resp.success) {
              functions.logger.error("Failed to send notification to token", {
                groupId,
                gameId,
                promotedId,
                tokenIndex: idx,
                error: resp.error?.code,
                errorMessage: resp.error?.message,
              });
            }
          });
        }

        // Remove invalid tokens
        if (response.failureCount > 0) {
          const invalidTokensByUser = new Map<string, string[]>();

          response.responses.forEach((resp, idx) => {
            if (
              !resp.success &&
              (resp.error?.code === "messaging/invalid-registration-token" ||
                resp.error?.code === "messaging/registration-token-not-registered")
            ) {
              const invalidToken = allTokens[idx];

              // Find which user this token belongs to
              for (const [userId, tokens] of userTokenMap.entries()) {
                if (tokens.includes(invalidToken)) {
                  if (!invalidTokensByUser.has(userId)) {
                    invalidTokensByUser.set(userId, []);
                  }
                  invalidTokensByUser.get(userId)!.push(invalidToken);
                  break;
                }
              }
            }
          });

          // Clean up invalid tokens per user
          for (const [userId, tokensToRemove] of invalidTokensByUser.entries()) {
            await admin
              .firestore()
              .collection("users")
              .doc(userId)
              .update({
                fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
              });

            functions.logger.info("Removed invalid FCM tokens", {
              userId,
              groupId,
              gameId,
              removedCount: tokensToRemove.length,
            });
          }
        }
      }

      await writeAnalyticsEvent("waitlist_promoted", { groupId, gameId });
      return null;
    } catch (error) {
      functions.logger.error("Error sending waitlist promotion notification", {
        groupId,
        gameId,
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
      });
      return null;
    }
  });

/**
 * Send notification when a game result is submitted for verification
 * Notifies all confirmed participants except the user who submitted the result
 * Story 14.15: Notifications for Game Result Verification
 */
export const onGameResultSubmitted = functions.region('europe-west6').firestore
  .document("games/{gameId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    const gameId = context.params.gameId;

    // Only trigger if status changed to 'verification'
    if (before.status === "verification" || after.status !== "verification") {
      return null;
    }

    const gameData = after;
    const groupId = gameData.groupId;
    const submitterId = gameData.resultSubmittedBy;

    functions.logger.info("Game result submitted for verification, processing notifications", {
      groupId,
      gameId,
      submitterId,
      gameTitle: gameData.title,
    });

    try {
      // Get all confirmed participants (players in the game)
      const playerIds: string[] = gameData.playerIds || [];

      if (playerIds.length === 0) {
        functions.logger.warn("No players found for game result notification", {
          groupId,
          gameId,
        });
        return null;
      }

      // Get submitter details for notification message
      const submitterDoc = await admin
        .firestore()
        .collection("users")
        .doc(submitterId)
        .get();

      const submitterData = submitterDoc.data();

      // Try to get submitter name in order of preference
      let submitterName = "Someone";
      if (submitterData) {
        if (submitterData.firstName && submitterData.lastName) {
          submitterName = `${submitterData.firstName} ${submitterData.lastName}`;
        } else if (submitterData.displayName) {
          submitterName = submitterData.displayName;
        } else if (submitterData.email) {
          submitterName = submitterData.email;
        }
      }

      // Track tokens per user for cleanup
      const userTokenMap = new Map<string, string[]>();
      const allTokens: string[] = [];

      // Collect FCM tokens from all participants except the submitter
      for (const playerId of playerIds) {
        // Skip the user who submitted the result
        if (playerId === submitterId) {
          continue;
        }

        const playerDoc = await admin
          .firestore()
          .collection("users")
          .doc(playerId)
          .get();

        const playerData = playerDoc.data();
        if (!playerData) {
          functions.logger.debug("Player not found", {
            playerId,
            groupId,
            gameId,
          });
          continue;
        }

        const fcmTokens = playerData.fcmTokens || [];
        if (fcmTokens.length === 0) {
          functions.logger.debug("Player has no FCM tokens", {
            playerId,
            groupId,
            gameId,
          });
          continue;
        }

        const prefs = playerData.notificationPreferences || {};

        const shouldNotify = prefs.games !== false;

        if (!shouldNotify) {
          functions.logger.debug("Player has disabled game result notifications", {
            playerId,
            groupId,
            gameId,
          });
          continue;
        }

        // Check quiet hours
        if (isQuietHours(prefs.quietHours)) {
          functions.logger.debug("Player is in quiet hours", {
            playerId,
            groupId,
            gameId,
          });
          continue;
        }

        // Add tokens to map for later cleanup if needed
        userTokenMap.set(playerId, fcmTokens);
        allTokens.push(...fcmTokens);
      }

      if (allTokens.length === 0) {
        functions.logger.info("No players to notify for game result submission", {
          groupId,
          gameId,
          submitterId,
        });
        return null;
      }

      // Send notification
      const message: admin.messaging.MulticastMessage = {
        tokens: allTokens,
        notification: {
          title: "Game Result Posted",
          body: `${submitterName} posted the score for ${gameData.title || "the game"}. Please confirm the result.`,
        },
        data: {
          type: "game_result_submitted",
          groupId: groupId,
          gameId: gameId,
          submitterId: submitterId,
          submitterName: submitterName,
        },
        android: {
          priority: "high",
          notification: {
            channelId: "high_importance_channel",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              badge: 1,
              sound: "default",
            },
          },
        },
      };

      const response = await admin.messaging().sendEachForMulticast(message);

      functions.logger.info("Game result verification notification sent successfully", {
        groupId,
        gameId,
        submitterId,
        successCount: response.successCount,
        failureCount: response.failureCount,
      });

      // Remove invalid tokens
      if (response.failureCount > 0) {
        const invalidTokensByUser = new Map<string, string[]>();

        response.responses.forEach((resp, idx) => {
          if (
            !resp.success &&
            (resp.error?.code === "messaging/invalid-registration-token" ||
              resp.error?.code === "messaging/registration-token-not-registered")
          ) {
            const invalidToken = allTokens[idx];

            // Find which user this token belongs to
            for (const [userId, tokens] of userTokenMap.entries()) {
              if (tokens.includes(invalidToken)) {
                if (!invalidTokensByUser.has(userId)) {
                  invalidTokensByUser.set(userId, []);
                }
                invalidTokensByUser.get(userId)!.push(invalidToken);
                break;
              }
            }
          }
        });

        // Clean up invalid tokens per user
        for (const [userId, tokensToRemove] of invalidTokensByUser.entries()) {
          await admin
            .firestore()
            .collection("users")
            .doc(userId)
            .update({
              fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
            });

          functions.logger.info("Removed invalid FCM tokens", {
            userId,
            groupId,
            gameId,
            removedCount: tokensToRemove.length,
          });
        }
      }

      return null;
    } catch (error) {
      functions.logger.error("Error sending game result submitted notification", {
        groupId,
        gameId,
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
      });
      return null;
    }
  });

/**
 * Send notification when a game is cancelled (e.g. auto-aborted due to insufficient players)
 */
export const onGameCancelled = functions.region('europe-west6').firestore
  .document("games/{gameId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    const gameId = context.params.gameId;
    const groupId = after.groupId;

    // Only trigger if status changed to 'cancelled'
    if (before.status === "cancelled" || after.status !== "cancelled") {
      return null;
    }

    functions.logger.info("Game cancelled, processing notifications", {
      groupId,
      gameId,
      reason: after.notes,
    });

    try {
      // Get all players and waitlist users to notify
      const playerIds = after.playerIds || [];
      const waitlistIds = after.waitlistIds || [];
      // Combine and deduplicate
      const usersToNotify = [...new Set([...playerIds, ...waitlistIds])] as string[];

      if (usersToNotify.length === 0) {
        functions.logger.info("No users to notify for cancelled game", {
          groupId,
          gameId,
        });
        return null;
      }

      // Prepare notification message
      const isAutoAborted = after.notes && after.notes.includes("auto-aborted");
      const title = isAutoAborted ? "Game Aborted" : "Game Cancelled";
      const body = isAutoAborted 
        ? `The game ${after.title || ""} was aborted due to insufficient players.`
        : `The game ${after.title || ""} has been cancelled.`;

      // Track tokens per user for cleanup
      const userTokenMap = new Map<string, string[]>();
      const allTokens: string[] = [];

      for (const userId of usersToNotify) {
        const userDoc = await admin
          .firestore()
          .collection("users")
          .doc(userId)
          .get();

        const userData = userDoc.data();
        if (!userData) continue;

        const fcmTokens = userData.fcmTokens || [];
        if (fcmTokens.length === 0) continue;

        const prefs = userData.notificationPreferences || {};
        // Use a generic 'gameUpdates' preference if specific 'gameCancelled' doesn't exist
        // or just default to true as cancellation is important
        if (prefs.games === false) continue;

        if (isQuietHours(prefs.quietHours)) continue;

        userTokenMap.set(userId, fcmTokens);
        allTokens.push(...fcmTokens);
      }

      if (allTokens.length === 0) {
        return null;
      }

      const message: admin.messaging.MulticastMessage = {
        tokens: allTokens,
        notification: {
          title: title,
          body: body,
        },
        data: {
          type: "game_cancelled",
          groupId: groupId,
          gameId: gameId,
        },
        android: {
          priority: "high",
          notification: {
            channelId: "high_importance_channel",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              badge: 1,
              sound: "default",
            },
          },
        },
      };

      const response = await admin.messaging().sendEachForMulticast(message);

      functions.logger.info("Game cancelled notification sent", {
        groupId,
        gameId,
        successCount: response.successCount,
      });

      // Cleanup invalid tokens
      if (response.failureCount > 0) {
          const invalidTokensByUser = new Map<string, string[]>();

          response.responses.forEach((resp, idx) => {
            if (
              !resp.success &&
              (resp.error?.code === "messaging/invalid-registration-token" ||
                resp.error?.code === "messaging/registration-token-not-registered")
            ) {
              const invalidToken = allTokens[idx];

              for (const [userId, tokens] of userTokenMap.entries()) {
                if (tokens.includes(invalidToken)) {
                  if (!invalidTokensByUser.has(userId)) {
                    invalidTokensByUser.set(userId, []);
                  }
                  invalidTokensByUser.get(userId)!.push(invalidToken);
                  break;
                }
              }
            }
          });

          for (const [userId, tokensToRemove] of invalidTokensByUser.entries()) {
            await admin
              .firestore()
              .collection("users")
              .doc(userId)
              .update({
                fcmTokens: admin.firestore.FieldValue.arrayRemove(...tokensToRemove),
              });
          }
      }

      await writeAnalyticsEvent("game_cancelled", { groupId });
      return null;
    } catch (error) {
      functions.logger.error("Error sending game cancelled notification", {
        gameId,
        error: error instanceof Error ? error.message : String(error),
      });
      return null;
    }
  });

/**
 * Send notification to all players in a game when a new chat message is created.
 * Skips the sender. Respects notification preferences and quiet hours.
 */
export const onChatMessageCreated = functions
  .region("europe-west6")
  .firestore.document("games/{gameId}/messages/{messageId}")
  .onCreate(async () => {
    // Notification removed (reduced noise) — game chat messages are too frequent
    // for push notifications; users check chat when they open the game.
    return null;
  });
