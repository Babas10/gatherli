# UI Styling Audit — Gatherli App
*Conducted via live emulator screenshots — Aug 13, 2026*

## Design Standard (from CLAUDE.md §9b)

| Token | Value | Usage |
|---|---|---|
| Scaffold background | `#F4F6F8` (`AppColors.scaffoldBackground`) | Every page scaffold — never override |
| AppBar background | `#FFFFFF` white | All app bars |
| Bottom nav background | `#FFFFFF` white | — |
| Cards | `#FFFFFF` white, elevation 0, radius 16 | Global cardTheme |
| Primary (gold) | `#EACE6A` (`AppColors.primary`) | Buttons, selected states, FABs |
| Secondary (teal) | `#004E64` (`AppColors.secondary`) | Tab indicators, headings, links |
| Text muted | `#64748B` (`AppColors.textMuted`) | Subtitles, hints |
| Danger | `#EF476F` (`AppColors.danger`) | Errors, destructive actions |
| Dividers | `#E2E8F0` (`AppColors.divider`) | — |

**Critical rule:** NEVER use Material 3 generated surface colors (`surfaceContainerLow`, `surfaceVariant`, `surfaceContainer`, etc.) — they produce wrong bluish/cream tints.

---

## Page-by-Page Audit

### STATUS LEGEND
- ✅ Correct — follows standard
- ⚠️ Minor deviation — small fix needed
- ❌ Non-conforming — wrong background, colors, or components

---

### 1. Login Page
**File:** `lib/features/auth/presentation/pages/login_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` light grey | `#F4F6F8` | ✅ |
| AppBar | White, "Login" title teal | White | ✅ |
| Email/Password fields | White card, teal icons | White card | ✅ |
| Login button | Gold filled | Gold | ✅ |
| "Sign Up" link | Pink/teal accent | — | ✅ |
| "Forgot Password?" | Gold | Gold | ✅ |

---

### 2. Home Page (Dashboard)
**File:** `lib/app/play_with_me_app.dart` → `_HomeTab`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` light grey | `#F4F6F8` | ✅ |
| AppBar | White, "Gatherli" logo | White | ✅ |
| ELO / Win Rate cards | White, elevation 0 | White cards | ✅ |
| Section headers ("NEXT GAME") | Light grey background (scaffold shows through) | No container | ✅ |
| Empty state dashed cards | Light grey dashed border, muted icon | — | ✅ |
| Pickup Game FAB | Dark teal `#004E64` | — | ✅ |

---

### 3. Stats / My Stats Page
**File:** `lib/features/profile/presentation/pages/stats_page.dart`
**Status:** ⚠️ Minor deviations

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` light grey | `#F4F6F8` | ✅ |
| AppBar | White, "My Stats" teal | White | ✅ |
| "No Performance Data" card | White card | White | ✅ |
| ELO progress stat chips (Global Rank, Percentile…) | White chips with teal icon | White card | ✅ |
| Time filter pills (30d / 90d / 1y / ∞) | **Sand/cream outlined pills**, selected uses gold | Should use `AppColors` chip styling | ⚠️ |
| Monthly Progress Chart card | White card | White | ✅ |

**Fix needed:** The 30d/90d/1y time filter pills appear to use a sand/cream tint on the unselected state. Should use `AppColors.scaffoldBackground` as background with `AppColors.divider` border, and `AppColors.primary` for the selected state.

---

### 4. Groups List (My Groups)
**File:** `lib/features/groups/presentation/pages/group_list_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "My Groups" teal | White | ✅ |
| Empty state illustration | Muted gold icon | — | ✅ |
| "Create Group" FAB | Gold + cream background | Gold | ⚠️ |

**Note:** "Create Group" FAB has a cream/warm background behind it (likely FAB elevation shadow tinting). Should be solid gold background on dark teal icon, or solid gold as per other FABs.

---

### 5. Community (My Community / Friends)
**File:** `lib/features/friends/presentation/pages/my_community_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "My Community" teal | White | ✅ |
| Friends / Requests TabBar | Gold underline indicator, teal text | Gold indicator | ✅ |
| Empty state icon | Teal people icon | — | ✅ |
| "Add Friend" FAB | Gold + cream background | Gold | ⚠️ |

---

### 6. Championships List
**File:** `lib/features/championships/presentation/pages/championship_list_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Championships" teal | White | ✅ |
| Active / Completed TabBar | Teal underline indicator | Teal | ✅ |
| Championship cards | White, elevation 0, radius 16 | White cards | ✅ |
| Status badges (Registration Open, Round N/9) | Correct accent colors | — | ✅ |
| "+" Create Championship FAB | Gold solid | Gold | ✅ |

---

### 7. Championship Detail — Standings Tab
**File:** `lib/features/championships/presentation/pages/championship_detail_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | Appears white | White | ✅ |
| Tab bar (Standings/Matches/Admin) | Gold underline | Gold | ✅ |
| Standings table | No card container — scaffold shows through | Correct (no card) | ✅ |
| Points values | Teal/gold accent colors | — | ✅ |
| Set ratio positive | Green | — | ✅ |
| Set ratio negative | Red/danger | — | ✅ |
| My Team section | Gold border, gold text | Gold accent | ✅ |

---

### 8. Match Detail Page
**File:** `lib/features/championships/presentation/pages/match_detail_page.dart`
**Status:** ❌ Non-conforming — cream scaffold

| Element | Observed | Standard | OK? |
|---|---|---|---|
| **Scaffold background** | **Cream/warm white** | `#F4F6F8` light grey | ❌ |
| **AppBar background** | **Cream/warm off-white** | `#FFFFFF` pure white | ❌ |
| Match header card | White card ✅ | White | ✅ |
| Match Chat card | White card ✅ | White | ✅ |
| Result card | White card ✅ | White | ✅ |
| "Propose Schedule" section | White card ✅ | White | ✅ |
| Bottom nav | White ✅ | White | ✅ |

**Root cause:** The page's `Scaffold` is not explicitly setting `backgroundColor: AppColors.scaffoldBackground`. Flutter's Material 3 is defaulting to `Theme.of(context).colorScheme.surface` which resolves to a warm cream/off-white surface color. Need to add `backgroundColor: AppColors.scaffoldBackground` to the Scaffold, and ensure the AppBar uses `backgroundColor: AppColors.appBarBackground`.

---

### 9. Profile Page
**File:** `lib/features/profile/presentation/pages/profile_page.dart` (or similar)
**Status:** ❌ Non-conforming — cream header section

| Element | Observed | Standard | OK? |
|---|---|---|---|
| **Profile header section** (avatar, name, email, Verified badge) | **Cream/warm gold-tinted background** — clearly visible warm cream | `#F4F6F8` scaffold or white card | ❌ |
| Scaffold below header | `#F4F6F8` (correct) | `#F4F6F8` | ✅ |
| "Account Information" card | White card ✅ | White | ✅ |
| Row labels (Email, Account Type…) | Teal small caps | — | ✅ |
| "Account Settings" button | Gold filled ✅ | Gold | ✅ |
| "Notification Settings" button | Outlined, teal icon ✅ | — | ✅ |
| AppBar | White ✅ | White | ✅ |

**Root cause:** The profile header section uses `Container` with a color that resolves to `Theme.of(context).colorScheme.primaryContainer` or similar Material 3 color — producing the cream/gold tint. Should use `Colors.white` (card-like) or `AppColors.scaffoldBackground` with no explicit background.

---

### 10. Notification Settings
**File:** `lib/features/notifications/presentation/pages/notification_settings_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Notifications" teal | White | ✅ |
| Category tiles (Social, Games…) | No background container — scaffold shows through | Correct | ✅ |
| Toggle switches | Gold when active | Gold | ✅ |
| Category icons | Teal | Teal | ✅ |
| Section headers | Teal bold text, no background container | No container | ✅ |

---

### 11. Create Championship
**File:** `lib/features/championships/presentation/pages/create_championship_page.dart`
**Status:** ⚠️ Minor — date/time pickers use default Material 3 style

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| Title field | Standard text field | — | ✅ |
| Gender option cards | White outlined, teal when selected | — | ✅ |
| Max teams segmented field (`_SegmentedField`) | Teal border + light teal bg when selected | Teal | ✅ |
| Date pickers | `showAppStyledDatePicker` used ✅ | White background, teal selection | ✅ |
| Submit button | Gold filled | Gold | ✅ |

---

### 12. Admin Panel (Championship Detail — Admin Tab)
**File:** `championship_detail_page.dart` → `_AdminTab`
**Status:** ⚠️ AlertDialogs have cream background

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Admin panel content area | `#F4F6F8` scaffold | `#F4F6F8` | ✅ |
| "Edit Details" button | Gold outlined | — | ✅ |
| **Edit Championship dialog** | **Cream/warm background** (Material 3 default AlertDialog) | White | ❌ |
| **Rename Team dialog** | **Cream/warm background** (same issue) | White | ❌ |
| **Start Championship dialog** | **Cream/warm background** | White | ❌ |
| **Leave Team confirm dialog** | **Cream/warm background** | White | ❌ |

**Root cause:** All `showDialog` / `AlertDialog` calls use Flutter Material 3 defaults which produce a warm cream surface. Need to wrap all `AlertDialog` with explicit `backgroundColor: Colors.white` and `surfaceTintColor: Colors.transparent`.

---

## Pages Not Yet Captured (needs follow-up audit)

| Page | File | Expected issues |
|---|---|---|
| Group Details | `group_details_page.dart` | Likely OK based on code review |
| Invite Member | `invite_member_page.dart` | Unknown |
| Game Creation | `game_creation_page.dart` | `showAppStyledDatePicker` used ✅ |
| Training Session Creation | `training_session_creation_page.dart` | May use raw date picker ⚠️ |
| Game Details | `game_details_page.dart` | Unknown |
| Score Entry | `score_entry_page.dart` | Unknown |
| My Games | `my_games_page.dart` | Unknown |
| Championship Registration | `championship_registration_page.dart` | Unknown |
| Pickup Game Creation | `pickup_game_creation_page.dart` | Unknown |
| Profile Edit | `profile_edit_page.dart` | Likely has cream header too |
| Add Friend / Search | Various | Unknown |
| Training Session Details | `training_session_details_page.dart` | Unknown |

---

## Summary of Issues

### Critical (❌ visually obvious)

| # | Page | Issue | File |
|---|---|---|---|
| 1 | **Match Detail** | Cream scaffold + cream AppBar instead of `#F4F6F8` + white | `match_detail_page.dart` |
| 2 | **Profile** | Cream header section (avatar + info area) | `profile_page.dart` |
| 3 | **All AlertDialogs** | Cream/warm background on every `showDialog` | All files using `AlertDialog` |

### Non-critical (⚠️ inconsistent)

| # | Page | Issue | Fix |
|---|---|---|---|
| 4 | **Stats** | Time filter pills (30d/90d/1y) use sand/cream outlined style | Use `AppColors` chip styling |
| 5 | **Groups + Community FABs** | Cream background behind FAB (shadow tint) | Verify FAB `backgroundColor` |
| 6 | **Time Picker** | Raw `showTimePicker` uses Material 3 cream background | Create `showAppStyledTimePicker` helper |
| 7 | **Any raw `showDatePicker`** | Any page NOT using `showAppStyledDatePicker` shows cream calendar | Audit all pages for date picker usage |

---

## Root Causes

**1. Missing `backgroundColor` on Scaffolds**
```dart
// WRONG — Material 3 defaults to cream surface
Scaffold(body: ...)

// CORRECT
Scaffold(
  backgroundColor: AppColors.scaffoldBackground,
  body: ...
)
```

**2. AlertDialog uses Material 3 surface**
```dart
// WRONG
AlertDialog(title: ..., content: ...)

// CORRECT
AlertDialog(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.transparent,
  title: ..., content: ...
)
```

**3. Profile header uses a Material 3 container color**
```dart
// WRONG — likely uses colorScheme.primaryContainer
Container(color: Theme.of(context).colorScheme.primaryContainer, ...)

// CORRECT — use white or no explicit color (let scaffold show)
Container(color: Colors.white, ...)
// or just use a Card widget
```

**4. Time Picker not styled**
```dart
// WRONG — raw picker shows cream
showTimePicker(context: context, initialTime: ...)

// CORRECT — create a showAppStyledTimePicker helper in date_picker_helper.dart
// mirroring showAppStyledDatePicker with white background + teal accents
```

---

## Fix Priority

| Priority | Fix | Pages affected | Effort |
|---|---|---|---|
| P0 | Fix all `AlertDialog` `backgroundColor` | All dialogs across app | Small — find+replace |
| P0 | Fix Match Detail scaffold + AppBar | `match_detail_page.dart` | Trivial |
| P0 | Fix Profile header container color | `profile_page.dart` | Small |
| P1 | Create `showAppStyledTimePicker` helper | Any page with time input | Medium |
| P1 | Audit all pages for raw `showDatePicker` / `showTimePicker` | Multiple files | Medium |
| P2 | Fix Stats time filter pills styling | `stats_page.dart` | Small |
| P2 | Fix FAB cream shadow tint on Groups/Community | `group_list_page.dart`, `my_community_page.dart` | Small |
