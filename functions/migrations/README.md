# Data Migration Runbook

When a Cloud Function or Flutter model change alters how data is stored in
Firestore (renames a field, splits a document, adds a required field),
existing documents keep the old shape until a migration is run. This folder
is the standard place to write, test, and track those one-time migrations.

## Folder structure

```
functions/migrations/
  README.md          ← this file
  template.ts         ← copy-paste starting point for new migrations
  tsconfig.json        ← typechecks this folder in isolation (see below)
  MIGRATION_LOG.md     ← append-only log of migrations run in prod
  done/                ← completed migration scripts, archived after execution
```

## 1. Write the migration

1. Copy `template.ts` to a new file named `<date>-<short-description>.ts`
   (e.g. `2026-09-01-add-championship-tiebreaker-field.ts`). Don't put it in
   `done/` yet — that's only for scripts that have already run in prod.
2. Fill in the header comment: what changes, before/after shapes, whether
   it's safe to re-run, and the story/issue it belongs to.
3. Write an **idempotency check** — the migration must be safe to run more
   than once (e.g. after a partial failure) without corrupting data. Skip
   documents that already have the new shape.
4. Batch writes in groups of ≤500 (Firestore's batch limit) — see the
   template for the pattern.
5. Typecheck it:
   ```bash
   cd functions
   npm run migrate:check
   ```
   This only typechecks files directly in `migrations/` (via
   `migrations/tsconfig.json`), not `done/` — archived scripts are historical
   records and aren't maintained to keep compiling.

## 2. Test locally against the emulator

Never run an untested migration against prod. Test it against the Firestore
emulator first:

```bash
# Terminal 1 — start the emulator with some representative data
firebase emulators:start --only auth,firestore --project gatherli-dev

# Terminal 2 — point the script at the emulator and run it
cd functions
FIRESTORE_EMULATOR_HOST=localhost:8080 npx ts-node migrations/<your-file>.ts
```

Verify the result in the Emulator UI (http://localhost:4000/firestore) before
going anywhere near prod.

## 3. Run against `gatherli-prod`

**Do not run standalone scripts directly against prod with a personal service
account key.** This repo's established pattern (see `done/2026-08-22-remove-user-array-fields-cf.ts`
and `done/2026-08-22-remove-group-game-ids.ts`) is to temporarily deploy the
migration as an **admin-only callable Cloud Function** instead:

1. Wrap the same logic from your tested script in a callable function, gated
   the same way as those two examples:
   ```typescript
   export const migrateXyz = functions
     .region("europe-west6")
     .runWith({ timeoutSeconds: 540, memory: "512MB" })
     .https.onCall(async (data, context) => {
       if (!context.auth) {
         throw new functions.https.HttpsError("unauthenticated", "...");
       }
       const adminDoc = await admin.firestore()
         .collection("appAdmins").doc(context.auth.uid).get();
       if (!adminDoc.exists) {
         throw new functions.https.HttpsError("permission-denied", "Only app admins can run this migration.");
       }
       // ... migration logic, with logging and a return summary ...
     });
   ```
2. Export it from `functions/src/index.ts`, deploy it alone:
   ```bash
   firebase deploy --only functions:migrateXyz --project gatherli-prod
   ```
3. Invoke it once as an app admin (Firebase Console → Functions → test the
   callable, or trigger it from an authenticated admin client). Confirm the
   returned summary counts look right.
4. **Immediately remove the function** from `index.ts` and redeploy, so it
   can't be triggered again by accident.

This keeps prod credentials out of developer machines and reuses the same
`context.auth` + `appAdmins` security model as the rest of the app (see
CLAUDE.md §11.3–§11.4).

**When to run:** always **after** the new function version is deployed, and
**after** the old app version is retired from the App Store if the migration
deletes fields the old app still reads (see CLAUDE.md §11.11).

## 4. Log and archive

After a successful prod run:

1. Append a row to `MIGRATION_LOG.md` (never edit past rows — this file is
   append-only):
   ```markdown
   | 2026-09-01 | done/2026-09-01-add-championship-tiebreaker-field.ts | <description> | <N docs> | <author> |
   ```
2. Move the script into `done/`.
3. If you deployed a temporary callable function for step 3, confirm it was
   removed from `index.ts` and redeployed out.

## Rollback

There is no automated rollback tooling — migrations are one-way by design
(deleted fields are gone). Before running a destructive migration:

- Confirm the old app version reading the old shape has already been retired,
  or keep the old fields until it has (see CLAUDE.md §11.11 on function
  versioning — the same "don't break clients still on the old build" rule
  applies to data shapes).
- For non-destructive migrations (adding a field, copying data to a new
  location without deleting the old one), rollback is simply not reading the
  new field — no action needed.
- If a destructive migration must be undone, restore from a Firestore
  scheduled backup ([console.cloud.google.com](https://console.cloud.google.com)
  → Firestore → Backups) rather than attempting to reconstruct deleted data.
