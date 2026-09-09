# Story 37.1 — Design-System Consistency Audit Findings

Part of [Epic 37](https://github.com/Babas10/gatherli/issues/946). This is a research-only
deliverable — no `lib/` code changes accompany this document. It is the checklist Stories
37.2–37.6 execute against.

Audited: 2026-09-07. Scope: `lib/features/**/presentation/` and `lib/core/presentation/widgets/`.

## Headline finding

The design system documented in `CLAUDE.md` section 9b is real and partially adopted, but
adoption is inconsistent enough that in three of the four categories audited, the "shared"
widget is the exception rather than the rule:

| Category | Shared widget | Compliant call sites found | Hand-rolled call sites found |
|---|---|---|---|
| Empty states | `EmptyState` (`core/presentation/widgets/empty_state.dart`) | **0** | 28 |
| Status/role badges | `StatusBadge` (`core/presentation/widgets/status_badge.dart`) | 4 | 30+ |
| Detail-page headers | *(none exists)* | 0 | 3 (fully independent) |
| Raw styling (`Colors.*`, `Color(0x...)`, inline `TextStyle`, `colorScheme.*`) | `AppColors`/`AppTextStyles` | — | ~640 across ~65 files |

The `EmptyState` widget in particular is **entirely dead code** — zero imports, zero
instantiations anywhere in `lib/`. Every empty state in the app (28 found) is an independent
hand-rolled implementation.

Two genuine **functional bugs** (not just style drift) were also found: a badge whose
background and foreground are the identical solid color, making its label invisible. See
"Bugs found" below — these should be prioritized ahead of general consistency work.

---

## 1. Empty states (28 call sites, 2 competing "shared" widgets, 0 use the documented one)

### The documented widget

`lib/core/presentation/widgets/empty_state.dart` — `EmptyState(icon, title, message?, action?)`.
Icon color is hard-coded to `AppColors.textMuted @ 0.4`, no way to override. **Never
instantiated anywhere in the codebase.**

### A second, more successful de-facto standard (stats only)

`EmptyStatsPlaceholder` / `InsufficientDataPlaceholder` in
`lib/features/profile/presentation/widgets/empty_states/insufficient_data_placeholder.dart` —
genuinely reused by 3+ call sites in the stats feature, but a completely different
API/visual language from `core`'s `EmptyState`, and still gets bypassed by a hand-rolled
duplicate in the same file's sibling (`monthly_improvement_chart.dart`).

### All hand-rolled instances found

| # | Location | Icon | Icon color | Layout | Notes |
|---|---|---|---|---|---|
| 1 | `groups/presentation/widgets/empty_group_list.dart:13-54` (used from `group_list_page.dart`) | `Icons.groups_outlined`, 96 | `colorScheme.primary @0.3` | Center→Column, 3 text lines, no action | |
| 2 | `groups/presentation/pages/group_details_page.dart:877-906` (Activities tab) | `Icons.sports_volleyball`, 48 | `colorScheme.onSurfaceVariant` | Padding→Center→Column | Same l10n keys as #18 but different icon size |
| 3 | `groups/presentation/widgets/friend_selector_widget.dart:187-214` | `Icons.people_outline`, 48 | `AppColors.secondary` | **Tinted `Card`** (`AppColors.primary @0.2` bg) | Hard-coded English strings, not localized |
| 4 | `friends/presentation/widgets/friends_list.dart:25-55` | `Icons.people_outline`, 64 | `colorScheme.secondary` | Center→Column | |
| 5 | `friends/presentation/pages/add_friend_page.dart:272-301` | `Icons.person_search`, 64 | `colorScheme.onSurfaceVariant` | Center→Column | Reused for 4 different bloc states incl. error |
| 6 | `games/presentation/widgets/invitee_picker.dart:81-92,118-129` | none | — | Center→Text only | |
| 7 | `championships/presentation/widgets/partner_picker_list.dart:23-32` | none | — | Padding→Text only | |
| 8 | `profile/.../performance_overview_card.dart:26-35` via `EmptyStatsPlaceholder` | `Icons.show_chart`, 64 | `colorScheme.primary @0.5` | `Card`→Padding→Column + bordered "locked" pill sub-component | The most-reused "shared" pattern in practice |
| 9 | `profile/.../monthly_improvement_chart.dart:39-47,60-65` via `InsufficientDataPlaceholder` | `Icons.timeline`, 48 | `onSurfaceVariant @0.5` | Bordered `Container`, radius 16 | Different radius/border than #8 |
| 10 | `profile/.../monthly_improvement_chart.dart:77-128` `_buildEmptyPeriodPlaceholder` | `Icons.calendar_today_outlined`, 48 | `onSurfaceVariant @0.5` | Same bordered-Container pattern, **hand-duplicated instead of reusing #9 in the same file** | |
| 11 | `profile/presentation/widgets/rivals_card.dart:160-167` via `EmptyStatsPlaceholder` | `Icons.emoji_events_outlined` | — | Correctly reuses #8's component | |
| 12 | `profile/presentation/widgets/partners_card.dart:152-188` | `Icons.people_outline`, 32 | `AppColors.textMuted @0.35` | **Horizontal Row**, not Column | |
| 13 | `profile/presentation/widgets/best_elo_highlight_card.dart:38-65` | `Icons.emoji_events_outlined`, 18 (smallest found) | `onSurfaceVariant @0.5` | `Card`+Row, single line | |
| 14 | `profile/presentation/pages/full_elo_history_page.dart:153-168` | `Icons.timeline`, 64 | `onSurface @0.3` | Center→Column | Hard-coded strings, not localized |
| 15 | `profile/presentation/pages/head_to_head_page.dart:320-327` | none | — | Plain inline `Text` | Hard-coded string, not localized |
| 16 | `profile/presentation/pages/partner_detail_page.dart:345-353` | none | — | Center→Text only | |
| 17 | `games/presentation/pages/games_list_page.dart:187-219` | `Icons.sports_volleyball`, 64 | `colorScheme.onSurfaceVariant` | Center→Column **+ real CTA button** | One of only 2 empty states with an action |
| 18 | `games/presentation/pages/game_history_screen.dart:287-313` | `Icons.history`, 64 | `colorScheme.onSurfaceVariant` | Center→Column | |
| 19 | `games/presentation/pages/my_games_page.dart:224-245` | `Icons.sports_volleyball_outlined`, 64 | `AppColors.textMuted` (full opacity) | Center→Column, single line | |
| 20 | `games/presentation/pages/pending_game_invitations_page.dart:149-164` | `Icons.mail_outline`, 64 | `AppColors.textMuted` (full opacity) | Center→Column, single line | |
| 21 | `games/presentation/widgets/invite_guest_players_sheet.dart:133-144` | none | — | Center→Padding→Text | |
| 22 | `games/presentation/widgets/game_chat_section.dart:168-179` | none | — | Center→Text | Near-duplicate of #23 |
| 23 | `championships/presentation/widgets/match_chat_section.dart:197-208` | none | — | Center→Text | Near-duplicate of #22 |
| 24 | `invitations/presentation/pages/pending_invitations_page.dart:142-169` | `Icons.mail_outline`, 64 | `colorScheme.onSurfaceVariant` | Center→Column | Hard-coded strings, not localized |
| 25 | `championships/presentation/pages/championship_list_page.dart:133-160` | none | — | Center→Padding→Text | Plainest pattern in the app |
| 26 | `championships/presentation/pages/championship_detail_page.dart` (5 sibling instances: Teams tab L820, Standings L844, Matches-by-round L1109, Admin L1413, My Matches L2142) | none | — | Center→Padding→Text | Internally consistent with each other and #25 |
| 27 | `training/presentation/widgets/exercise_list_widget.dart:188-214` | `Icons.fitness_center`, 64 | **raw `Colors.grey[400]`** | Expanded→Center→Column | Raw Colors violation |
| 28 | `training/presentation/widgets/feedback_display_widget.dart:108-146` | `Icons.feedback_outlined`, 80 (largest found) | **raw `Colors.grey[400]`** | Center→Column **+ real CTA button** | Raw Colors violation; other action-having empty state |

### Cross-cutting empty-state issues

- At least **6 different icon sizes** in use: 96, 80, 64 (majority), 48, 32, 18.
- Icon color sourced 4 different ways: `AppColors.textMuted` (varying alpha), `colorScheme.onSurfaceVariant` (varying alpha), `colorScheme.primary`/`secondary`, raw `Colors.grey[400]`.
- Layout shape varies: plain Center+Text (7 instances), Center+Column icon+title+subtitle (majority), bordered/tinted Container card (3), plain Card (2), tinted colored Card (1), horizontal Row (2).
- Hard-coded (non-localized) English strings in 6 call sites, despite the app otherwise using `l10n.*` consistently.
- Duplicated l10n keys (`noActivitiesYet`/`createFirstActivity`) rendered with different icon sizes in two different files (#2 vs #17).
- Only 2 of 28 empty states include an actual CTA action button.

---

## 2. Status/role badges (30+ call sites, 4 use `StatusBadge`)

### The documented widget

`lib/core/presentation/widgets/status_badge.dart` — `StatusBadge({label, color})`: fill
`color @0.12`, border `color @0.4`, radius `AppSpacing.badgeRadius`. Named constructors:
`.success`, `.warning`, `.danger`, `.info`, `.primary`, `.muted`.

### Compliant

1. Championship status pill (`_StatusBadge`, duplicated verbatim in both
   `championship_detail_page.dart:756-787` and `championship_list_page.dart:292-322` instead
   of being one shared private widget).
2. Friend request "Pending" — `sent_request_tile.dart:47` (`StatusBadge.muted`).
3. "Joined" badge via `JoinedBadge` wrapper (games/training list tiles).
4. "Mix" gender badge via `MixGameBadge` wrapper (one-off purple `Color(0xFF9B59B6)` — itself
   a raw-hex violation inside a "shared" widget).

### Hand-rolled — training

5. Training detail status pill (Scheduled/Completed/Cancelled) —
   `training_session_details_page.dart:435-486`. Own `Container`/`BoxDecoration`, full-opacity
   border (vs. `StatusBadge`'s 0.4 alpha), radius 16 (vs. `AppSpacing.badgeRadius`).
6. Training "Organizer" — icon+text, not a pill; icon color `AppColors.secondary` but the
   separate subtitle text is `AppColors.warning` — two different colors for the same concept
   within the same widget.
7. Training "You" pill — solid opaque `AppColors.primary` fill, no border, no alpha.
8. Training card list "Full" indicator — separate hand-rolled red pill.

### Hand-rolled — championship match status (4 duplicated, mutually-inconsistent implementations)

9. `match_detail_page.dart:382-406` — `pending→textMuted`, `scheduled→info`,
   `played→warning`, `disputed→Colors.deepOrange` **(raw)**, `adminDecided→Colors.purple`
   **(raw)**, `verified→success`.
10. `championship_detail_page.dart:1165-1187` (`_MatchCard`) — **conflicts with #9**:
    `scheduled→secondary` (not info), `played→info` (not warning). Radius 6 (vs #9's 8).
11. `championship_detail_page.dart:1790-1858` (`_AdminMatchCard`) — third variant, radius 6.
12. `championship_detail_page.dart:2109-2133` (`_MyMatchesTab`) — matches #9's color mapping
    but fill alpha 0.10 instead of 0.12, radius 8.

Net effect: **the same match status renders in different colors depending on which tab you're
looking at it from**, and none of the 4 delegate to `StatusBadge`.

### Hand-rolled — group membership

13-15. `member_list_item_with_friendship.dart` — "Friend" (plain icon+text, no pill),
"Request Sent"/"Wants to be friends"/"Not in Community" (plain icon+text), "(You)" (plain
text, no badge at all — contrast with training's solid gold "You" pill for the same concept).
16-17. "Admin" role — implemented as a `Chip` **twice**, in two different widget files
(`member_list_item_with_friendship.dart` using `AppColors.avatarBackground`, and
`member_list_item.dart` using `AppColors.primary.withValues(alpha: 0.25)`) — visually similar
but different color expressions.
18. "isCreator" — plain star icon, no text/pill.
20-21. Group/friend search result "Member"/"Invited"/"Friends"/"Request Pending" chips use
`Theme.of(context).colorScheme.surfaceContainerHighest`/`secondaryContainer` — Material theme
tokens, not `AppColors`, in both `user_search_result_tile.dart` and `search_result_tile.dart`.

### Hand-rolled — games

22. My Games tile status (`my_game_tile.dart:130-179`) — "Completed" uses **raw
    `Colors.grey`/`Colors.grey.shade600`**, not `AppColors.textMuted` — this is the
    grey/muted "Completed" pill from the original screenshot review, confirmed to be a raw-color
    violation, not just an inconsistent-but-themed choice.
23-31. Nine further hand-rolled badges across `game_list_item.dart`,
    `training_session_list_item.dart`, and `game_details_page.dart` for "Open", "Cancelled"
    (raw `Colors.grey`), "Verification", type badges (`colorScheme.secondaryContainer`),
    "Waitlist", "Full", "Organizer" (a *pill* here, vs. plain icon+text for the same concept
    in training — finding #6), and a "Confirmed Players" count chip.

### Hand-rolled — profile

33. Email verification badge (`verification_badge.dart`) — uses
    `colorScheme.primaryContainer`/`errorContainer`, no `AppColors`/`StatusBadge` reference
    at all.

### Bugs found (not just inconsistency — actual invisible-text defects)

- **`member_list_item_with_friendship.dart:204-209`** — the "Pending" `Chip` sets
  `backgroundColor: AppColors.warning` **and** `labelStyle: TextStyle(color: AppColors.warning)`
  — background and text are the identical solid color, so the label is invisible.
- **`game_result_badge.dart:57-83`** — `GameResultBadge`'s `Container` sets
  `decoration.color: AppColors.success`, `border: Border.all(color: AppColors.success)`, and
  the icon/text are also `AppColors.success` — background and foreground are the same solid
  color, so the trophy icon and score text are invisible against their own background.

These should be fixed immediately regardless of the broader consistency work, since they're
functional defects a user can hit today, not a style judgment call.

---

## 3. Detail-page headers (3 independent implementations, 0 shared widget)

| | Games (`game_details_page.dart`, `_GameInfoCard` ~L284-365) | Training (`training_session_details_page.dart`, `_buildSessionHeader` ~L245-415) | Championships (`championship_detail_page.dart`, `_ChampionshipHeader` ~L337-472) |
|---|---|---|---|
| Wrapper | `Card` (cream `AppColors.cardBackground`) | `Container(color: Colors.white)` — **hardcoded raw color**, flat, no card/border/elevation | `Card`, explicit margin |
| Page background | grey `scaffoldBackground`, card floats inset | grey `scaffoldBackground`, but header is full-bleed and visually merges with the AppBar | grey `scaffoldBackground`, card floats inset |
| Status badge | none in header (only a gender/mix badge) | hand-rolled reimplementation (see badge finding #5), not `StatusBadge` | shared `StatusBadge` via local adapter |
| Copy Link placement | outside the card, on the grey background | **not present in the header at all** — a FAB handles join/leave instead | inside the card |
| AppBar widget | (uses the shared app bar) | (uses the shared app bar) | plain `AppBar(title: Text(title))` — **not** wrapped in the same `PlayWithMeAppBar` the other two use |

No `DetailHeader`/`EntityHeader` shared widget exists anywhere in `lib/core/presentation/widgets/`
— each page is a fully bespoke, independently-styled implementation of conceptually the same
"title + status + key facts + primary action" block. The Copy Link *button style* is shared via
a `copyLinkToClipboard`/`ActivityLinkUrlBuilder` utility function, but the widget/layout around
it is copy-pasted per page, not shared.

---

## 4. Raw styling violations (~640 across ~65 files)

Full per-file/line detail is in the agent transcript this document was compiled from; summary:

| Category | Approx. count | Approx. files |
|---|---|---|
| Raw `Colors.*` (e.g. `Colors.white`, `Colors.grey.shade600`) | ~200 | ~65 |
| Raw `Color(0x...)` hex literals | 11 | 7 |
| Inline fresh `TextStyle(fontSize: ..., ...)` construction | ~190 | ~55 |
| Forbidden `colorScheme.*` (`.primary`, `.secondary`, `.surface*`, `.error`, `.onSurface*`, etc.) | ~240 | ~50 |

Worst offenders by density: `email_verification_page.dart`, `game_details_page.dart`,
`performance_overview_card.dart`, `training_session_details_page.dart`,
`game_result_view_page.dart`.

Notable specific findings:
- `lib/core/theme/play_with_me_app_bar.dart` — a **theme-support file** itself contains raw
  `Colors.white`/`Colors.transparent`, despite living in `core/theme/`.
- `lib/core/presentation/widgets/mix_game_badge.dart:7` — the shared `MixGameBadge` widget
  hardcodes `const _kMixColor = Color(0xFF9B59B6)` rather than an `AppColors` constant.
- Championship champion-banner styling (`championship_detail_page.dart:502-529,924,954`) uses
  5 raw hex literals for gold/bronze gradient colors that should be named `AppColors` constants.
- `lib/core/widgets/environment_indicator.dart` is dev-only and lower priority, but still
  technically in scope.

Given the volume, Story 37.6's original plan to "fix any pre-existing violations the new test
surfaces" is not realistic as a single pass — see recommendation below.

---

## Recommendation for Stories 37.2–37.6 given these findings

The original story scope assumed the screenshot-review findings (4 concrete issues) were
close to the full picture. The audit shows the real surface area is much larger. Suggested
re-scoping:

- **37.2** (destructive button) — scope unchanged, still a small, well-defined fix. Confirmed:
  no other destructive buttons were found to share the same violation.
- **37.3** (empty states) — 28 call sites is a real multi-PR effort, not one PR. Recommend
  splitting by feature vertical (groups+community, stats, games+championships+training) across
  3 follow-up PRs under the same story.
- **37.4** (status badges) — recommend prioritizing the **2 invisible-text bugs** as an
  immediate hotfix ahead of the broader consolidation, then tackling the 4-way-duplicated
  championship match-status logic (the most visible inconsistency, and the one that actually
  changes what color a user sees) before the lower-stakes group-membership/profile badges.
- **37.5** (detail-page headers) — scope unchanged, 3 pages, well-defined.
- **37.6** (architecture test) — **recommend a baseline/grandfathering approach**: introduce
  the lint test now with the ~640 current violations captured in an explicit allowlist/baseline
  file (so it passes immediately), require all *new* code to be clean, and pay down the
  baseline incrementally via 37.3–37.5 and future opportunistic cleanup — rather than trying to
  fix ~640 violations in one story.
