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

**Critical rule:** NEVER use Material 3 generated surface colors (`surfaceContainerLow`, `surfaceVariant`, `surfaceContainer`, `primaryContainer`, `colorScheme.surface`, `colorScheme.primary`) — they produce wrong bluish/cream tints.

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
| Next Game / Next Training cards | White cards | White cards | ✅ |
| Pickup Game FAB | Dark teal `#004E64` | — | ✅ |

---

### 3. Stats / My Stats Page
**File:** `lib/features/profile/presentation/pages/stats_page.dart`
**Status:** ⚠️ Minor deviations

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` light grey | `#F4F6F8` | ✅ |
| AppBar | White, "My Stats" teal | White | ✅ |
| ELO progress stat chips | White chips with teal icon | White | ✅ |
| Monthly Progress Chart card | White card | White | ✅ |
| Time filter pills (30d / 90d / 1y / ∞) | **Sand/cream outlined pills** | AppColors chip styling | ⚠️ |

**Fix needed:** Time filter pills use a sand/cream tint on unselected state. Should use `AppColors.scaffoldBackground` with `AppColors.divider` border; `AppColors.primary` for selected.

---

### 4. Groups List (My Groups)
**File:** `lib/features/groups/presentation/pages/group_list_page.dart`
**Status:** ✅ Conforming (minor FAB shadow tint)

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "My Groups" teal | White | ✅ |
| Group cards | White, elevation 0 | White cards | ✅ |
| "Create Group" FAB | Gold + cream shadow | Solid gold | ⚠️ |

---

### 5. Group Details Page
**File:** `lib/features/groups/presentation/pages/group_details_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, group name teal | White | ✅ |
| Group header info | No container — scaffold shows through | Correct | ✅ |
| Members/Activities TabBar | Teal underline indicator | Teal | ✅ |
| Member list tiles | No background — scaffold shows through | Correct | ✅ |
| Create Game / Create Training buttons | White cards | White | ✅ |

---

### 6. Game Details Page (future game — Join/Waitlist)
**File:** `lib/features/games/presentation/pages/game_details_page.dart`
**Status:** ⚠️ Minor — wrong M3 color components

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| Game info header card | White card | White | ✅ |
| Player number circles (confirmed) | Gold tinted | AppColors.primary | ✅ |
| Player number circles (waitlist section) | **Cream/surface tinted** | Neutral grey | ⚠️ |
| "I'm In" / "Join Waitlist" button | **Washed-out gold/cream** | Solid `AppColors.primary` | ⚠️ |

**Root cause (line 535):** `CircleAvatar` uses `Theme.of(context).colorScheme.surface.withValues(alpha: 0.5)` — M3 surface = cream. Fix: use `Colors.grey.shade100` or `AppColors.scaffoldBackground`.

**Root cause (line 870):** Button uses `Theme.of(context).colorScheme.primary` — M3 primary, not `AppColors.primary`. Fix: replace with `AppColors.primary`.

---

### 7. Game Details Page (past game / with results)
**File:** `lib/features/games/presentation/pages/game_details_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| Game Results card | White card | White | ✅ |
| Confirmed Players card | White card | White | ✅ |

---

### 8. Score / Game Results Page
**File:** `lib/features/games/presentation/pages/game_history_screen.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Game Results" | White | ✅ |
| ELO changes card | White card | White | ✅ |
| Individual games list | White cards | White | ✅ |

---

### 9. Game Creation Page
**File:** `lib/features/games/presentation/pages/game_creation_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| Date picker | `showAppStyledDatePicker` ✅ | White bg, teal selection | ✅ |
| Submit button | Gold filled | Gold | ✅ |

---

### 10. Pickup Game Creation Page
**File:** `lib/features/games/presentation/pages/pickup_game_creation_page.dart`
**Status:** ⚠️ Minor — raw date picker

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| **Date & Time picker** | **Raw `showDatePicker` (line 97)** — cream calendar | `showAppStyledDatePicker` | ⚠️ |

---

### 11. Training Session Creation Page
**File:** `lib/features/training/presentation/pages/training_session_creation_page.dart`
**Status:** ⚠️ Minor — raw date picker

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| **Start/End time pickers** | **Raw `showDatePicker` (line 66)** — cream calendar | `showAppStyledDatePicker` | ⚠️ |
| Min/Max participants sliders | Native look | — | ✅ |

---

### 12. Training Session Details Page
**File:** `lib/features/training/presentation/pages/training_session_details_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| Status badge (Completed) | White card | White | ✅ |
| Session info header | No container — scaffold shows through | Correct | ✅ |
| Participants / Exercises TabBar | Teal underline | Teal | ✅ |
| Participation stats card | White card | White | ✅ |

---

### 13. Community (My Community / Friends)
**File:** `lib/features/friends/presentation/pages/my_community_page.dart`
**Status:** ✅ Conforming (minor FAB shadow tint)

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "My Community" teal | White | ✅ |
| Friends / Requests TabBar | Gold underline indicator | Gold | ✅ |
| Friend list tiles | No card — scaffold shows through | Correct | ✅ |
| Requests badge | Teal pill on tab | — | ✅ |
| "Add Friend" FAB | Gold + cream shadow | Solid gold | ⚠️ |

---

### 14. Add Friend / Search Page
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Add Friend" | White | ✅ |
| Search field | Standard text field | — | ✅ |

---

### 15. Invite Member Page
**File:** `lib/features/groups/presentation/pages/invite_member_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Invite Members" | White | ✅ |
| Friends list | No container — scaffold shows through | Correct | ✅ |
| "Select All" / "Clear All" | Teal text buttons | Teal | ✅ |

---

### 16. Profile Page
**File:** `lib/features/profile/presentation/pages/profile_page.dart` + `profile_header.dart`
**Status:** ❌ Non-conforming — cream header section

| Element | Observed | Standard | OK? |
|---|---|---|---|
| **Profile header section** | **Cream/warm gold-tinted background** | `Colors.white` | ❌ |
| **Avatar CircleAvatar** | **M3 primary tint** | `AppColors.secondary` | ❌ |
| Scaffold below header | `#F4F6F8` (correct) | `#F4F6F8` | ✅ |
| "Account Information" card | White card | White | ✅ |
| "Account Settings" button | Gold filled | Gold | ✅ |
| AppBar | White | White | ✅ |

**Root cause confirmed (`profile_header.dart` line 19):**
```dart
color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3)  // WRONG
```
**Root cause (`profile_header.dart` line 30):**
```dart
backgroundColor: theme.colorScheme.primary  // WRONG
```
**Fix:**
```dart
color: Colors.white                      // line 19
backgroundColor: AppColors.secondary     // line 30
```

---

### 17. Account Settings Page
**File:** `lib/features/profile/presentation/pages/profile_edit_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Account Settings" | White | ✅ |
| Language / Country selectors | Standard form fields | — | ✅ |
| Save/Cancel buttons | Gold filled / outlined | Gold | ✅ |

---

### 18. Notification Settings
**File:** `lib/features/notifications/presentation/pages/notification_settings_page.dart`
**Status:** ⚠️ Minor — raw time pickers for Quiet Hours

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Notifications" teal | White | ✅ |
| Category tiles (Social, Games, Training, Championships) | No container — scaffold shows through | Correct | ✅ |
| Toggle switches | Gold when active | Gold | ✅ |
| **Quiet Hours time pickers** | **Raw `showTimePicker` (lines 194, 208)** | Styled time picker | ⚠️ |

---

### 19. Championships List
**File:** `lib/features/championships/presentation/pages/championship_list_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White, "Championships" teal | White | ✅ |
| Active / Completed TabBar | Teal underline | Teal | ✅ |
| Championship cards | White, elevation 0, radius 16 | White cards | ✅ |
| Status badges | Correct accent colors | — | ✅ |
| Create Championship FAB | Gold solid | Gold | ✅ |

---

### 20. Championship Detail — Standings/Matches Tabs
**File:** `lib/features/championships/presentation/pages/championship_detail_page.dart`
**Status:** ✅ Conforming (content) — AlertDialogs ❌

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| Tab bar | Teal underline | Teal | ✅ |
| Standings table | No card — scaffold shows through | Correct | ✅ |
| Match cards | White, elevation 0 | White | ✅ |
| Champion banner (completed) | Trophy icon + name | — | ✅ |
| My Team section | Gold border, gold text | Gold | ✅ |
| **Tiebreaker dialog** | **Cream background** | White | ❌ |
| **All admin dialogs** | **Cream background** | White | ❌ |

---

### 21. Match Detail Page
**File:** `lib/features/championships/presentation/pages/match_detail_page.dart`
**Status:** ❌ Non-conforming — cream scaffold + raw pickers

| Element | Observed | Standard | OK? |
|---|---|---|---|
| **Scaffold background** | **Cream/warm white** | `#F4F6F8` | ❌ |
| **AppBar background** | **Cream/warm off-white** | `#FFFFFF` | ❌ |
| Match header card | White card | White | ✅ |
| Match Chat card | White card | White | ✅ |
| **Date picker (Propose Schedule)** | **Raw `showDatePicker` (line 415)** | `showAppStyledDatePicker` | ❌ |
| **Time picker (Propose Schedule)** | **Raw `showTimePicker` (line 425)** | `showAppStyledTimePicker` | ❌ |
| Bottom nav | White | White | ✅ |

**Root cause:** Scaffold missing `backgroundColor: AppColors.scaffoldBackground`. Flutter Material 3 defaults to `colorScheme.surface` (cream).

---

### 22. Create Championship Page
**File:** `lib/features/championships/presentation/pages/create_championship_page.dart`
**Status:** ✅ Conforming

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Scaffold background | `#F4F6F8` | `#F4F6F8` | ✅ |
| AppBar | White | White | ✅ |
| Gender option cards | White outlined, teal selected | — | ✅ |
| Max teams segmented field | Teal border + teal bg selected | Teal | ✅ |
| Date pickers | `showAppStyledDatePicker` ✅ | White bg, teal selection | ✅ |
| Submit button | Gold filled | Gold | ✅ |

---

### 23. Admin Panel (Championship Detail — Admin Tab)
**File:** `championship_detail_page.dart` → `_AdminTab`
**Status:** ❌ All AlertDialogs have cream background

| Element | Observed | Standard | OK? |
|---|---|---|---|
| Admin panel content area | `#F4F6F8` scaffold | `#F4F6F8` | ✅ |
| "Edit Details" button | Outlined | — | ✅ |
| **Edit Championship dialog** | **Cream background** | White | ❌ |
| **Rename Team dialog** | **Cream background** | White | ❌ |
| **Start Championship dialog** | **Cream background** | White | ❌ |
| **Leave Team confirm dialog** | **Cream background** | White | ❌ |

---

## Summary of All Issues

### Critical (❌ visually obvious)

| # | Page | Issue | File |
|---|---|---|---|
| 1 | **Match Detail** | Cream scaffold + AppBar | `match_detail_page.dart` — missing `backgroundColor` |
| 2 | **Profile Header** | Cream/gold-tinted container | `profile_header.dart` line 19 — `primaryContainer` |
| 3 | **All AlertDialogs** | Cream background in every `showDialog` | 25 dialogs across 15 files |

### Non-critical (⚠️ inconsistent)

| # | Page | Issue | File / Location |
|---|---|---|---|
| 4 | **Game Details** | Waitlist CircleAvatar uses `colorScheme.surface` | `game_details_page.dart` line 535 |
| 5 | **Game Details** | Join/Waitlist button uses `colorScheme.primary` | `game_details_page.dart` line 870 |
| 6 | **Match Detail** | Raw `showDatePicker` + `showTimePicker` | `match_detail_page.dart` lines 415, 425 |
| 7 | **Pickup Game Creation** | Raw `showDatePicker` | `pickup_game_creation_page.dart` line 97 |
| 8 | **Training Creation** | Raw `showDatePicker` | `training_session_creation_page.dart` line 66 |
| 9 | **Notification Settings** | Raw `showTimePicker` for quiet hours | `notification_settings_page.dart` lines 194, 208 |
| 10 | **Stats** | Time filter pills use sand/cream outlined style | `stats_page.dart` |
| 11 | **Groups + Community FABs** | Cream shadow tint on FABs | `group_list_page.dart`, `my_community_page.dart` |

---

## Root Causes

**1. Missing `backgroundColor` on Scaffold**
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

**3. Profile header uses `primaryContainer`**
```dart
// WRONG (profile_header.dart line 19)
color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3)

// CORRECT
color: Colors.white
```

**4. Profile CircleAvatar uses `colorScheme.primary`**
```dart
// WRONG (profile_header.dart line 30)
backgroundColor: theme.colorScheme.primary

// CORRECT
backgroundColor: AppColors.secondary
```

**5. Raw date/time pickers (show cream calendar)**
```dart
// WRONG
showDatePicker(context: context, ...)
showTimePicker(context: context, ...)

// CORRECT for dates (helper already exists in date_picker_helper.dart)
showAppStyledDatePicker(context: context, ...)

// CORRECT for times (need to create showAppStyledTimePicker helper)
showAppStyledTimePicker(context: context, ...)
```

**6. Button/widget using `colorScheme` instead of `AppColors`**
```dart
// WRONG (game_details_page.dart line 870)
backgroundColor: Theme.of(context).colorScheme.primary

// CORRECT
backgroundColor: AppColors.primary
```

---

## Files With AlertDialog — All 15 files need fix

| File | AlertDialog count |
|---|---|
| `championship_detail_page.dart` | 6 |
| `training_session_details_page.dart` | ~2 |
| `exercise_form_dialog.dart` | ~1 |
| `exercise_list_widget.dart` | ~1 |
| `notification_settings_page.dart` | ~1 |
| `profile_edit_page.dart` | ~1 |
| `profile_page.dart` | ~1 |
| `avatar_upload_widget.dart` | ~1 |
| `championship_registration_page.dart` | ~1 |
| `friends_list.dart` | ~1 |
| `game_history_screen.dart` | ~1 |
| `member_action_dialogs.dart` | ~2 |
| `restricted_action_guard.dart` | ~1 |
| `play_with_me_app_bar.dart` | ~1 |
| `password_reset_page.dart` | ~1 |

---

## Fix Priority

| Priority | Fix | Effort |
|---|---|---|
| P0 | Fix all `AlertDialog` — add `backgroundColor: Colors.white, surfaceTintColor: Colors.transparent` | Small — grep + replace across 15 files |
| P0 | Fix Match Detail scaffold — add `backgroundColor: AppColors.scaffoldBackground` | Trivial |
| P0 | Fix Profile header — `primaryContainer` → `Colors.white` | Trivial |
| P0 | Fix Profile CircleAvatar — `colorScheme.primary` → `AppColors.secondary` | Trivial |
| P1 | Create `showAppStyledTimePicker` helper in `date_picker_helper.dart` | Small |
| P1 | Replace raw pickers in Match Detail (lines 415, 425) | Small |
| P1 | Replace raw pickers in Training Creation (line 66) | Small |
| P1 | Replace raw pickers in Pickup Game Creation (line 97) | Small |
| P1 | Replace raw pickers in Notification Settings (lines 194, 208) | Small |
| P2 | Fix Game Details Join/Waitlist button — `colorScheme.primary` → `AppColors.primary` | Trivial |
| P2 | Fix Game Details waitlist CircleAvatar — `colorScheme.surface` → neutral | Trivial |
| P2 | Fix Stats time filter pills styling | Small |
| P2 | Fix FAB cream shadow tint on Groups/Community | Small |
