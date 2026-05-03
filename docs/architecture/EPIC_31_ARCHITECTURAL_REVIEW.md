# Epic 31 — Architectural Review & Improvements

**Date:** 2026-05-02
**Scope:** Full codebase review — games, groups, community, training, invitations, chat, user model
**Conclusion:** 8 concrete architectural improvements spanning data model, coupling, and maintainability.

---

## 1. Executive Summary

The current architecture was built feature-by-feature, which produced solid individual components but left several structural tensions. The most critical is the **hard coupling of every activity (games, training sessions) to a group**, which has already forced two workarounds: the Epic 28 guest invitation system and the parallel championship hierarchy in Epic 30. Left unaddressed, this coupling will continue to require increasingly complex workarounds for every new activity type.

A second tier of issues concerns **fat Firestore documents**: the `UserModel` stores unbounded arrays (`gameIds`, `groupIds`, `friendIds`) that grow indefinitely with user activity and create dual-write complexity. The `GroupModel` similarly stores `gameIds` as an unbounded array.

The remaining issues are maintainability concerns: duplicated converter code, two parallel invitation systems, and two parallel chat systems.

Since there is no real production game data yet, migration risk is low for game-related changes. User and group documents exist in production and require more careful migration.

---

## 2. Issues Found

### P0 — Critical (blockers for growth)

#### Issue A: Games and Training Sessions are hard-coupled to groups

**Current state:**
- `GameModel.groupId: required String` — every game must belong to a group
- `TrainingSessionModel.groupId: required String` — same constraint
- `GameVisibility` enum has `group | public | private` but all games still require a group

**Impact so far:**
- Championship matches (Epic 30) could not reuse game infrastructure → built parallel hierarchy
- Guest invitations (Epic 28) required a complex workaround: separate `gameInvitations` collection and 5 new Cloud Functions just to allow non-group members to play
- Pickup games (two friends want to play without a group) are architecturally impossible
- `getGroupGamesForUser` depends on `user.groupIds` being accurate — if that cache is stale, the query returns wrong results

**Root cause:** The original design assumed all activities happen within groups. This was correct for the initial MVP but is now a constraint.

---

#### Issue B: `UserModel` stores unbounded arrays that grow indefinitely

**Current state:**
```dart
@Default([]) List<String> groupIds,     // grows with every group joined
@Default([]) List<String> gameIds,      // grows with every game played — UNBOUNDED
@Default([]) List<String> recentGameIds, // another game ID list
@Default([]) List<String> friendIds,    // grows with every friend added
```

**Impact:**
- Firestore document size limit is 1MB. A user with 10,000 games has ~360KB in `gameIds` alone (UUID strings × 10,000). Combined with all other fields (ELO records, stats, nested objects), this is a real risk.
- Every game join/leave requires TWO writes: update `games/{id}.playerIds` AND update `users/{uid}.gameIds` — dual write, eventual consistency risk.
- Every friend add/remove requires TWO writes: update `friendships/{id}` AND update `users/{uid}.friendIds`.
- Every group join/leave requires TWO writes: update `groups/{id}.memberIds` AND update `users/{uid}.groupIds`.
- `getGroupGamesForUser` query uses `user.groupIds` as input — if that cache is diverged from actual group membership, the query silently returns wrong results.

---

#### Issue C: `GroupModel.gameIds` is an unbounded array and creates dual writes

**Current state:**
```dart
@Default([]) List<String> gameIds,  // all games ever created in this group
```

A group playing weekly for 3 years accumulates 150+ game IDs. The array grows forever.

Creating a game currently requires:
1. Write `games/{gameId}` document
2. Write `groups/{groupId}.gameIds` array (via `GroupRepository.addGame`)

These are two separate writes — not atomic. If step 2 fails, the group doc doesn't know about the game.

**However:** every game already stores `groupId` on the game document itself. So querying games by group is already possible via `games.where('groupId', isEqualTo: groupId)` — the `gameIds` array is redundant.

---

### P1 — Major (significant tech debt)

#### Issue D: Two parallel invitation systems

**Current state:**
- `invitations/{id}` + `InvitationModel` → group invitations only
- `gameInvitations/{id}` + `GameInvitationModel` → game-specific cross-group invitations (added Epic 28)

Both models represent the same concept: "user A is inviting user B to join activity X". They have separate repositories, separate Cloud Functions (`inviteToGroup` vs `inviteGuestToGame`), and separate UI flows.

**Impact:** Every new activity type (championship, pickup game) will need yet another invitation sub-system unless unified.

---

#### Issue E: Two parallel chat systems

**Current state:**
- `games/{id}/messages/{id}` subcollection → accessed via `GameRepository.getMessages()` and `sendMessage()`, using `ChatMessageModel`
- `championships/{id}/matches/{id}/messages/{id}` subcollection → new from Epic 30, using `ChampionshipMessageModel`

Both models store the same fields (`senderId`, `senderDisplayName`, `text`, `sentAt`). The championship model adds `teamId`. They use different security rules, different repository access patterns, and different Flutter models.

---

#### Issue F: `TimestampConverter` duplicated across 5 files

The same converter class is independently defined in:
- `user_model.dart` (as `TimestampConverter`, nullable)
- `game_model.dart` (as `TimestampConverter`, nullable; `fromFirestore` also does manual conversion for some fields)
- `group_model.dart` (as `TimestampConverter` class AND standalone helper functions)
- `invitation_model.dart` (as `TimestampConverter`, non-nullable)
- `championship_model.dart` (as `ChampionshipTimestampConverter` + `ChampionshipNullableTimestampConverter`)

Additionally, `game_model.dart`'s `fromFirestore()` manually converts Timestamps to ISO strings before calling `fromJson`, while `championship_model.dart` uses proper `@JsonConverter` annotations — two inconsistent patterns.

---

### P2 — Moderate (maintainability)

#### Issue G: `GameRepository` interface is too wide (40+ methods, mixed concerns)

The single `GameRepository` handles:
- Game CRUD and lifecycle (create, update, start, end, cancel)
- Player management (join, leave, waitlist)
- Score and result recording
- Pagination of game history
- Location-based queries
- **Chat messages** (`getMessages`, `sendMessage`)
- Statistics (`getCompletedGames`, `getGameStats`)

The chat concern in particular belongs in a separate `ChatRepository` or `MessageRepository`.

---

#### Issue H: `UserModel` is a God Object (50+ fields)

The `UserModel` mixes:
- Auth identity (uid, email, isEmailVerified)
- Profile (displayName, firstName, lastName, bio, photo, location, gender)
- Account management (accountStatus, gracePeriodExpiresAt, deletionScheduledAt)
- Preferences (notificationsEnabled, emailNotifications, pushNotifications)
- Privacy settings (privacyLevel, showEmail, showPhoneNumber)
- Stats (gamesPlayed, gamesWon, currentStreak)
- ELO (eloRating, eloPeak, eloGamesPlayed)
- Embedded nested objects (NemesisRecord, BestWinRecord, PointStats, RoleBasedStats)
- Social graph cache (friendIds, friendCount)
- Membership caches (groupIds, gameIds)

This makes every user read expensive (large document), every user update touch the same document, and increases the document size limit risk. The nested stats objects (`NemesisRecord`, `BestWinRecord`) require special `toFirestore()` serialization hacks.

---

## 3. Proposed Target Architecture

### 3.1 Decouple activities from groups via `ActivityContext`

Instead of `required String groupId`, activities get an optional context:

```dart
// New concept: what is this game/training "for"?
enum ActivityContextType { group, pickup, championship }

// Applied to GameModel:
ActivityContextType? contextType,   // null = standalone
String? contextId,                  // groupId, or championshipId, etc.

// Keep groupId as nullable for backward compat:
String? groupId,  // == contextId when contextType == group
```

This makes group-scoped games work exactly as today, while unlocking pickup games and championship matches that reuse the game infrastructure.

### 3.2 Remove redundant arrays from UserModel

Remove: `groupIds`, `gameIds`, `recentGameIds`, `friendIds` from `UserModel`.

Replace with queries:
- "Groups for user": `groups.where('memberIds', arrayContains: uid)` — already a valid Firestore query
- "Games for user": `games.where('playerIds', arrayContains: uid)` — already queried this way in `GameRepository.getMyGames()`
- "Friends for user": query `friendships` collection

Keep: `friendCount` as a display cache (small integer, not a list).

**Migration:** Drop the array fields from existing user documents via a one-time Cloud Function. The underlying truth data (group.memberIds, game.playerIds) remains intact.

### 3.3 Remove `gameIds` from GroupModel

Remove: `GroupModel.gameIds`.

Replace: query `games.where('groupId', isEqualTo: groupId)` — already supported and already the way `GameRepository.getGamesForGroup()` works.

Remove: `GroupRepository.addGame()` and `removeGame()` — eliminate the dual write.

**Migration:** Since there are no real production games, all `gameIds` arrays are empty — safe to drop the field.

### 3.4 Centralize TimestampConverter

Create `lib/core/data/converters/timestamp_converter.dart` with:
- `TimestampConverter` (non-nullable: `JsonConverter<DateTime, Object>`)
- `NullableTimestampConverter` (nullable: `JsonConverter<DateTime?, Object?>`)

Import from all models. Remove all per-file definitions.

Also standardize `fromFirestore()` to use `@JsonConverter` annotations instead of manual conversion.

### 3.5 Unify invitation model

Single `InvitationModel` with:
```dart
enum InvitationType { group, game, championship }

InvitationType type,
String? groupId,
String? gameId,
String? championshipId,
```

Single `invitations` collection. Single set of Cloud Functions.

### 3.6 Unify chat/message model

Single `ChatMessageModel` with optional `teamId` field.

Standardize on subcollection pattern: `{entity}/{id}/messages/{msgId}`.

Single `MessageRepository` used by games and championships alike.

---

## 4. Migration Plan

| Change | Production Risk | Approach |
|--------|----------------|----------|
| Central TimestampConverter | None (code only) | Refactor in one PR |
| Remove GroupModel.gameIds | Low (no real games) | Drop field from schema + cloud function to clean existing docs |
| Decouple games from groups | Low (no real games) | Make `groupId` nullable in schema + model |
| Remove UserModel arrays | Medium (real users exist) | Cloud Function migration: drop arrays, queries take over |
| Unify invitations | Low (parallel deploy) | Ship new model alongside old, migrate data, delete old |
| Unify chat | Low (no real game chats) | Standardize model + repository |

---

## 5. What is NOT proposed

- Replacing Firestore with a different database
- Changing the BLoC architecture
- Moving to subcollections for group members (maxMembers=20 keeps memberIds bounded)
- Changing the Cloud Functions runtime
- Changing the ELO calculation logic

These are out of scope or unnecessary given the current scale.
