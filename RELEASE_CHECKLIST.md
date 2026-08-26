# Release Checklist

This checklist covers every step of shipping a Gatherli release, from tagging a
beta through App Store submission and post-release cleanup. It complements
[`docs/epic-20/RELEASE_WORKFLOW.md`](./docs/epic-20/RELEASE_WORKFLOW.md), which
documents the tag-based CD pipeline mechanics in detail.

Copy this checklist into the release tracking issue/PR description and tick
items off as you go.

---

## 1. Pre-release (automated by CI — verify green before proceeding)

Triggered by pushing a `v*-beta` tag (see `RELEASE_WORKFLOW.md`):

- [ ] `validate-version-tag.yml` passed (tag is incremental)
- [ ] All tests passed (`cd-beta.yml` → `test` job)
- [ ] Cloud Functions + Firestore indexes/rules deployed to `gatherli-prod`
      (`cd-beta.yml` → `deploy_functions` job, including the post-deploy smoke test)
- [ ] Android build uploaded to Google Play Internal Testing
- [ ] iOS build uploaded to TestFlight
- [ ] GitHub Release + `CHANGELOG.md` entry generated for the tag
      (`validate-version-tag.yml` → `generate_changelog` job)

## 2. TestFlight / Internal Testing gate (manual)

- [ ] Internal testers (team) sign off on core flows: login, games, championships
- [ ] No new crash reports in Crashlytics for this build
- [ ] Firestore indexes fully built (Firebase Console → no "Building" status)
- [ ] If issues are found, fix on `main` and tag the next beta (`v1.0.0-beta2`, etc.) — repeat this section

## 3. App Store / Play Store submission (manual)

> Note: we currently ship real users via the beta track (TestFlight + Play
> Internal) since the automated production-promotion tag (`v1.0.0`, no
> `-beta` suffix) is not yet part of the regular release cadence. Once a
> `v*` production tag is cut, complete this section.

- [ ] Submit to App Store Review from App Store Connect
- [ ] Set phased rollout (7-day)
- [ ] Update App Store / Play Store description or screenshots if UI changed
- [ ] Promote Android build from Internal Testing to Production track

## 4. Post-release cleanup (manual, next sprint)

- [ ] Identify any deprecated function versions (`vN-1`, see CLAUDE.md §11.11) with
      zero traffic → delete
- [ ] Run any pending data migrations from [`functions/migrations/`](./functions/migrations/)
      (see `functions/migrations/MIGRATION_LOG.md` for the log of what's already run)
- [ ] Remove old Firestore indexes that only the retired app version needed
- [ ] Update this checklist if the process changed
