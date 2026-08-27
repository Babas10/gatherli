## Summary
<!-- What does this PR do? -->

## Breaking changes checklist
<!-- A "breaking change" is any Cloud Function modification that changes the API
     contract for clients still on the current App Store version. See
     CLAUDE.md §11.11 (Cloud Function Versioning & Production Safety):
     https://github.com/Babas10/gatherli/blob/main/CLAUDE.md#1111-cloud-function-versioning--production-safety -->
- [ ] No Cloud Functions were renamed or removed
- [ ] No existing function parameters were renamed or made required
- [ ] No response fields were removed or renamed
- [ ] No Firestore field names used by the current app were renamed/removed
- [ ] If any box above is unchecked → a versioned function (V2) has been created
      and the old function is kept until the old app version is retired
- [ ] If a function is being removed → its name has been added to
      `functions/deprecated-functions.json` (the CD pipeline blocks the
      deploy otherwise — see CLAUDE.md §11.11)

If any box above is unchecked, apply the `breaking-change` label to this PR.

## Data migrations
- [ ] No existing Firestore documents need to be updated
- [ ] If documents need updating → a migration script exists in functions/migrations/

## Deployment notes
<!-- Anything special CI needs to know before deploying? -->
