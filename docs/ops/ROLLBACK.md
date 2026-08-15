# Gatherli — Rollback Runbook

Procedure for rolling back a bad release in < 30 minutes.

---

## When to roll back

Roll back immediately if any of these occur within 30 minutes of a release:
- Error rate > 5% on any core journey (game creation, championship registration, friend requests)
- App crash rate > 1%
- Cloud Function error rate > 2%
- Multiple user reports of total feature failure

---

## App rollback (< 5 minutes)

### Via Firebase App Distribution (dev/staging)
```bash
# Re-promote the previous build in App Distribution console
# Or deploy the previous APK:
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-dev-debug.apk \
  --app YOUR_APP_ID \
  --release-notes "Rollback to previous version"
```

### Via Google Play (production)
1. Play Console → App → Release → Rollout to production
2. Select the previous release → Promote
3. Takes 1-2 hours to propagate

---

## Cloud Function rollback (< 2 minutes)

```bash
# List recent deployments
firebase functions:list

# Rollback a specific function to previous version via re-deploy
git checkout HEAD~1 -- functions/src/myFunction.ts
cd functions && npm run build
firebase deploy --only functions:myFunction --project gatherli-prod
```

---

## Firestore data rollback

If a bad Cloud Function corrupted data:
1. Identify affected documents via Cloud Logging queries
2. Use Firebase Admin SDK script to restore from backup:
```typescript
// Restore from daily export in Cloud Storage
// gs://gatherli-prod-backups/YYYY-MM-DD/
```

---

## Post-rollback checklist

- [ ] Verify core journeys working via smoke test
- [ ] Notify users if impact was widespread (in-app message or email)
- [ ] File incident report with timeline
- [ ] Post-mortem scheduled within 48 hours
- [ ] Root cause documented before next release
