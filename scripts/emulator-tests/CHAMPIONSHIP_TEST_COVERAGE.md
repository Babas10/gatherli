# Championship Feature — Emulator Test Coverage

Generated from live emulator testing session (Aug 13, 2026).
Script: `./scripts/emulator-tests/championship_smoke_test.sh [test-name]`

Legend: ✅ Tested  |  ⚠️ Partial  |  ❌ Not tested

---

## 1. Championship List

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| View Active tab (default) | ✅ | test21 | `./championship_smoke_test.sh list` | Shows registration + active championships |
| View Completed tab | ✅ | test21 | `./championship_smoke_test.sh list` | Empty in current test env |
| See championship card (status badge, teams count, location) | ✅ | test21 | `./championship_smoke_test.sh list` | Round badge shown for active |
| Tap card to open detail | ✅ | test21 | `./championship_smoke_test.sh list` | — |
| Create Championship FAB visible to all users | ✅ | test1 | `./championship_smoke_test.sh create` | Was admin-only, now open to all |

---

## 2. Create Championship

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| Open Create Championship form | ✅ | test1 | `./championship_smoke_test.sh create` | Full-screen page, bottom nav visible |
| Enter title | ❌ | — | Manual | Text field, keyboard input |
| Pick gender category (Men/Women) | ⚠️ | test1 | `./championship_smoke_test.sh create` | Buttons visible, not tapped in script |
| Pick max teams (4/6/8/10) | ✅ | test1 | `./championship_smoke_test.sh create` | Segmented selector, tapped 6 |
| No team size selector (always 2) | ✅ | test1 | `./championship_smoke_test.sh create` | Removed — Story 30.27 fix |
| Pick registration deadline | ❌ | — | Manual | Date picker |
| Pick start/end date (optional) | ❌ | — | Manual | Date pickers |
| Enter country/region (optional) | ❌ | — | Manual | Text fields |
| Submit and create championship | ❌ | — | Manual | Full flow not automated |

---

## 3. Championship Detail — Header

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| See status badge (Registration Open / Round N/9 / Completed) | ✅ | test21 | `./championship_smoke_test.sh standings` | — |
| See team count, location | ✅ | test21 | `./championship_smoke_test.sh list` | — |
| My Team section visible (registered user) | ✅ | test21 | `./championship_smoke_test.sh standings` | Shows team name + partner |
| My Team section hidden (non-registered) | ✅ | test1 | `./championship_smoke_test.sh standings` | test1 not in Women's |
| Pencil (rename) icon visible (captain + registration) | ✅ | test1 | `./championship_smoke_test.sh rename` | Men's championship, registration phase |
| Pencil icon hidden (non-captain or active championship) | ✅ | test21 | `./championship_smoke_test.sh standings` | Women's is active — no pencil |
| Team rename dialog opens | ✅ | test1 | `./championship_smoke_test.sh rename` | Pre-filled with current name |
| Rename saves and updates in real time | ✅ | test1 | `./championship_smoke_test.sh rename` | Firestore stream reflects immediately |
| Leave team button visible (registration phase) | ✅ | test21 | `./championship_smoke_test.sh standings` | — |
| Leave team confirmation dialog | ❌ | — | Manual | Not tapped |
| Champion banner (completed championship) | ❌ | — | Manual | No completed championship in test env |
| Register Team button (open + not registered) | ❌ | — | Manual | Men's has one open slot |

---

## 4. Championship Detail — Standings Tab

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| View standings table (# / Team / P / Pts / W / L / SR) | ✅ | test21 | `./championship_smoke_test.sh standings` | Women's Round 5 data |
| Tiebreaker info icon visible | ✅ | test21 | `./championship_smoke_test.sh tiebreaker` | Top-right corner |
| Tiebreaker dialog content (points + tiebreaker rules) | ✅ | test21 | `./championship_smoke_test.sh tiebreaker` | — |
| Winner row gold highlight (completed championship) | ❌ | — | Manual | Requires completed championship |
| W column breakdown "5 (3+2)" format | ⚠️ | test21 | `./championship_smoke_test.sh standings` | Visible but not asserted |

---

## 5. Championship Detail — Matches Tab

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| View matches for current round | ✅ | test21 | `./championship_smoke_test.sh matches` | Defaults to currentRound |
| Navigate to next round (→ arrow) | ✅ | test21 | `./championship_smoke_test.sh matches` | Round 5 → Round 6 |
| Navigate to previous round (← arrow) | ❌ | — | Manual | Not scripted |
| Verified match card (scores + green badge) | ✅ | test21 | `./championship_smoke_test.sh matches` | R5 all verified |
| Scheduled match card (date + blue badge) | ✅ | test21 | `./championship_smoke_test.sh matches` | R6 Les Perles vs Les Gazelles |
| Pending match card (grey badge) | ✅ | test21 | `./championship_smoke_test.sh matches` | R6 other matches |
| My match highlighted (gold border) | ⚠️ | test21 | `./championship_smoke_test.sh matches` | Visible but not asserted |
| Tap match card → opens Match Detail | ✅ | test21 | `./championship_smoke_test.sh match-detail` | — |

---

## 6. Championship Detail — My Matches Tab

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| Tab visible only for registered users | ✅ | test21 | `./championship_smoke_test.sh my-matches` | Not shown to spectators |
| All 9 rounds shown | ✅ | test21 | `./championship_smoke_test.sh my-matches` | R1–R5 Verified, R6 Scheduled, R7–R9 Pending |
| Verified match shows score | ✅ | test21 | `./championship_smoke_test.sh my-matches` | e.g. 21–15 21–12 |
| Scheduled match shows date | ✅ | test21 | `./championship_smoke_test.sh my-matches` | 21 Aug · 01:31 |
| Pending match shows opponent | ✅ | test21 | `./championship_smoke_test.sh my-matches` | vs Soleil Levant |
| Tap row → opens Match Detail | ✅ | test21 | `./championship_smoke_test.sh my-matches` | — |
| Empty state when championship not started | ❌ | — | Manual | Use a fresh pre-start championship |

---

## 7. Match Detail

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| Header: team names, status badge, scheduled date, deadline | ✅ | test21 | `./championship_smoke_test.sh match-detail` | — |
| Waiting for Confirmation banner (proposer view) | ✅ | test21 | `./championship_smoke_test.sh schedule` | Shows spinner + proposed date |
| Schedule Proposed card (opponent view) with Accept/Reject | ✅ | test27 | `./championship_smoke_test.sh schedule` | After test21 proposes |
| Propose Schedule form (date + time + location) | ✅ | test21 | `./championship_smoke_test.sh schedule` | — |
| Schedule proposal sent (CF call) | ✅ | test21 | `./championship_smoke_test.sh schedule` | — |
| Accept schedule (opponent) | ✅ | test27 | `./championship_smoke_test.sh schedule` | System message in chat |
| Reject schedule (opponent) | ❌ | — | Manual | Not scripted — tap Reject button |
| Match Chat visible | ✅ | test21 | `./championship_smoke_test.sh match-detail` | — |
| Match Chat shows system messages | ✅ | test21/27 | `./championship_smoke_test.sh schedule` | "Les Perles proposed…", "confirmed…" |
| Send a chat message | ❌ | — | Manual | Tap chat field, type, send |
| Only team members see chat input | ✅ | test1 | `./championship_smoke_test.sh match-detail` | test1 sees "Only team members can…" |
| Submit Result form visible (team member) | ✅ | test27 | Manual | Seen on screen, not submitted via script |
| Submit Result (actual CF call) | ❌ | — | Manual (#823) | Stepper UX being rebuilt — Story #823 |
| Awaiting verification state | ❌ | — | Manual | Submitter sees hourglass |
| Verification widget (opposing team) | ❌ | — | Manual | Accept or Dispute buttons |
| Verify result → standings update | ❌ | — | Manual | Standings should update in real time |
| Dispute result → admin notified | ❌ | — | Manual | — |
| Disputed state explanation card | ❌ | — | Manual | Only visible when status = disputed |
| Admin decided state display | ❌ | — | Manual | Admin sets result manually |
| Verified state (final scores shown) | ❌ | — | Manual | — |
| Bottom nav visible | ✅ | test21 | `./championship_smoke_test.sh nav` | Championships tab highlighted |

---

## 8. Admin Panel

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| Admin tab visible only to championship creator | ✅ | test1 | `./championship_smoke_test.sh admin` | test27 sees 3 tabs, test1 sees 4 |
| Edit Details button (registration / registration_closed) | ✅ | test1 | `./championship_smoke_test.sh admin` | — |
| Edit Details dialog opens with current title | ✅ | test1 | `./championship_smoke_test.sh admin` | — |
| Edit title and save (CF call) | ❌ | — | Manual | Type new title, tap Save |
| Change deadline in edit dialog | ❌ | — | Manual | Date picker in dialog |
| Start Championship button (registration_closed only) | ❌ | — | Manual | Needs 10th team + registration closed |
| Start Championship with date picker | ❌ | — | Manual | CF generates all 45 matches |
| Round auto-advances after round completes | ❌ | — | Manual | Verify via Firestore after all R1 matches verified |
| Mark as Complete button (active phase) | ❌ | — | Manual | Needs active championship |
| Mark as Complete → champion determined | ❌ | — | Manual | — |
| Admin match decision list (disputed/overdue) | ❌ | — | Manual | Only appears when matches need attention |
| Admin decision: Set Result | ❌ | — | Manual | Set scores manually |
| Admin decision: Award Walkover | ❌ | — | Manual | Pick winner |
| Admin decision: Cancel match | ❌ | — | Manual | — |

---

## 9. Notifications (hard to test via ADB)

| Action | Status | User | Notes |
|---|---|---|---|
| Championship started → all teams notified | ❌ | — | CF deployed, not triggered in test |
| Schedule proposed → opposing team notified | ⚠️ | test21→test27 | CF fires (logs confirm), push not visible on emulator |
| Schedule confirmed → proposing team notified | ❌ | — | CF removed per Story refinement |
| Result submitted → opposing team notified | ❌ | — | — |
| Result verified → submitting team notified | ❌ | — | — |
| Match disputed → admin notified | ❌ | — | — |
| 48h deadline warning → both teams notified | ❌ | — | Scheduled CF runs daily |
| Championship complete → all teams notified | ❌ | — | — |
| Tap notification → deep-links to Match Detail | ❌ | — | Story 30.22 implemented, not tested on emulator |
| Tap notification → deep-links to Championship Detail | ❌ | — | — |

---

## 10. Cross-cutting

| Action | Status | User | Script command | Notes |
|---|---|---|---|---|
| Bottom nav on Championship List | ✅ | test21 | `./championship_smoke_test.sh nav` | Built into HomePage, always visible |
| Bottom nav on Championship Detail | ✅ | test21 | `./championship_smoke_test.sh nav` | Fixed (was missing) |
| Bottom nav on Match Detail | ✅ | test21 | `./championship_smoke_test.sh nav` | Fixed (was missing) |
| Bottom nav on Create Championship | ✅ | test1 | `./championship_smoke_test.sh create` | Fixed (was missing) |
| Bottom nav on Championship Registration | ⚠️ | — | Manual | Fixed (was missing), not verified on device |
| Championship list loads after auth (no PERMISSION_DENIED) | ✅ | test21 | `./championship_smoke_test.sh list` | Fixed — was loading before auth |
| My Matches loads correctly (allMatches stream fix) | ✅ | test21 | `./championship_smoke_test.sh my-matches` | Fixed — _onUserUpdated was resetting allMatches |

---

## Quick Reference: Test Setup

```bash
# 1. Start emulator
flutter emulators --launch gatherli-dev

# 2. Start app
flutter run --flavor dev -t lib/main_dev.dart -d emulator-5554

# 3. Deploy functions (if changed)
firebase deploy --only functions --project gatherli-dev

# 4. Run full suite
./scripts/emulator-tests/championship_smoke_test.sh

# 5. Run specific test
./scripts/emulator-tests/championship_smoke_test.sh schedule
```

## Manual Test Sequences (not yet automated)

### Submit + Verify Result (pending Story #823 score entry UX)
```
Login test21 → Championships → Women's → My Matches → R7 → Submit Result
Enter set scores (once Story #823 replaces inline form with full-screen page)
Login test27 → Championships → Women's → My Matches → R7 → Verify / Dispute
```

### Start Championship (Men's needs 10th team first)
```
Login any user → Championships → Men's → Register with a partner
Login test1 → Championships → Men's → Admin → Start Championship → pick date
Verify 45 matches generated in Firestore
Verify currentRound = 1 in championship document
```

### Admin Match Decision (need a disputed or overdue match)
```
Submit a result as one team (R7)
Dispute it as the opposing team
Login test1 → Championships → Women's → Admin → see the disputed match
Apply admin decision (Set Result / Award Walkover / Cancel)
Verify standings updated
```

### Champion Display (need to complete a championship)
```
Login test1 → Championships → Women's → Admin → Mark as Complete
Verify champion banner on championship detail header
Verify championship moves to Completed tab on list
Verify completion notifications sent (check test27's device)
```
