# Migration Log

| Date | Script | Description | Documents affected | Author |
|------|--------|-------------|-------------------|--------|
| 2026-08-22 | done/2026-08-22-remove-group-game-ids.ts | Remove `gameIds` unbounded array from all `groups` documents | 15 groups (2 with actual data: Zurich Volleyball Club ×6, Zurich Beach Crew ×13) | Babas10 |
| 2026-08-22 | done/2026-08-22-remove-user-array-fields.ts | Remove friendIds/gameIds/recentGameIds/groupIds arrays from user documents + fix friendCount drift | 43 users patched, 111 array field deletions, 20 friendCount corrections | Babas10 |
| 2026-08-23 | (inline) | Move teammateStats map to users/{uid}/stats/{partnerUid} subcollection | 15 users, 42 partner docs created, root field deleted | Babas10 |
