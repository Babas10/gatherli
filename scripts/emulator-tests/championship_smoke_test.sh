#!/usr/bin/env bash
# =============================================================================
# Championship Feature Smoke Tests — Gatherli Android Emulator
# =============================================================================
# Requires:
#   - Android emulator running (gatherli-dev flavor)
#   - App built and running via: flutter run --flavor dev -t lib/main_dev.dart -d emulator-5554
#   - Test data loaded via setupChampionshipTestEnvironment.ts
#
# Usage:
#   ./championship_smoke_test.sh            # run full suite
#   ./championship_smoke_test.sh login      # run single test
#   ./championship_smoke_test.sh schedule   # run schedule flow only
#
# Test users (password: test1010):
#   test1@mysta.com  — admin + Men's captain (Les Titans)
#   test21@mysta.com — Women's captain (Les Perles, 5W-0L leader)
#   test27@mysta.com — Women's captain (Soleil Levant)
#
# Emulator: emulator-5554 (1080x2400 px, 420dpi)
# =============================================================================

set -euo pipefail

DEVICE="emulator-5554"
ADB="adb -s $DEVICE"
PASS=0
FAIL=0

# ── Colours ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}PASS${NC} $1"; PASS=$((PASS+1)); }
fail() { echo -e "${RED}FAIL${NC} $1"; FAIL=$((FAIL+1)); }
info() { echo -e "${YELLOW}INFO${NC} $1"; }

# ── Core helpers ──────────────────────────────────────────────────────────────

screenshot() {
  local path="${1:-/tmp/emulator_test_$(date +%s).png}"
  $ADB exec-out screencap -p > "$path"
  echo "$path"
}

tap() {
  # tap X Y [delay_ms]
  $ADB shell input tap "$1" "$2"
  sleep "${3:-0.5}"
}

type_text() {
  $ADB shell input text "$1"
  sleep 0.3
}

key() {
  $ADB shell input keyevent "$1"
  sleep 0.3
}

swipe_up() {
  # scroll up (reveal content below)
  $ADB shell input swipe 540 1800 540 800 500
  sleep 0.8
}

swipe_down() {
  # scroll down (reveal content above)
  $ADB shell input swipe 540 800 540 1800 500
  sleep 0.8
}

back() {
  $ADB shell input keyevent KEYCODE_BACK
  sleep 0.8
}

dump_ui() {
  $ADB shell uiautomator dump /sdcard/ui.xml 2>/dev/null
  $ADB pull /sdcard/ui.xml /tmp/ui_dump.xml 2>/dev/null
}

# Find element bounds by content-desc substring. Prints "cx cy" (center).
find_element() {
  local search="$1"
  dump_ui
  python3 -c "
import re, sys
txt = open('/tmp/ui_dump.xml').read()
items = re.findall(r'content-desc=\"([^\"]+)\"[^>]*bounds=\"(\[[0-9,\]\[]+)\"', txt)
for desc, bounds in items:
    if '${search}'.lower() in desc.lower():
        coords = re.findall(r'[0-9]+', bounds)
        cx = (int(coords[0]) + int(coords[2])) // 2
        cy = (int(coords[1]) + int(coords[3])) // 2
        print(f'{cx} {cy}')
        sys.exit(0)
sys.exit(1)
" 2>/dev/null
}

tap_element() {
  local search="$1"
  local delay="${2:-1}"
  local coords
  coords=$(find_element "$search") || { fail "Element not found: $search"; return 1; }
  read -r cx cy <<< "$coords"
  tap "$cx" "$cy" "$delay"
}

wait_for_element() {
  local search="$1"
  local timeout="${2:-10}"
  local elapsed=0
  while [ $elapsed -lt $timeout ]; do
    if find_element "$search" &>/dev/null; then return 0; fi
    sleep 1; elapsed=$((elapsed+1))
  done
  fail "Timeout waiting for: $search"
  return 1
}

assert_visible() {
  local search="$1"
  dump_ui
  if python3 -c "
import re; txt = open('/tmp/ui_dump.xml').read()
items = re.findall(r'content-desc=\"([^\"]+)\"', txt)
found = any('${search}'.lower() in d.lower() for d in items)
exit(0 if found else 1)
" 2>/dev/null; then
    pass "Visible: $search"
  else
    fail "Not visible: $search"
  fi
}

# ── Known coordinates (1080x2400 device) ─────────────────────────────────────
# Login form (when on login screen)
LOGIN_EMAIL_X=540;    LOGIN_EMAIL_Y=886
LOGIN_PASS_X=540;     LOGIN_PASS_Y=1075
LOGIN_BTN_X=540;      LOGIN_BTN_Y=1284

# Bottom navigation tabs
NAV_HOME_X=108;       NAV_HOME_Y=2261
NAV_STATS_X=324;      NAV_STATS_Y=2261
NAV_GROUPS_X=540;     NAV_GROUPS_Y=2261
NAV_COMMUNITY_X=756;  NAV_COMMUNITY_Y=2261
NAV_CHAMP_X=972;      NAV_CHAMP_Y=2261

# App bar buttons
APPBAR_SIGNOUT_X=1027; APPBAR_SIGNOUT_Y=196

# ── Auth helpers ──────────────────────────────────────────────────────────────

login() {
  local email="$1"
  local pass="${2:-test1010}"
  info "Logging in as $email"
  tap $LOGIN_EMAIL_X $LOGIN_EMAIL_Y
  sleep 0.3
  key KEYCODE_CTRL_A; key KEYCODE_DEL
  type_text "$email"
  tap $LOGIN_PASS_X $LOGIN_PASS_Y
  sleep 0.3
  key KEYCODE_CTRL_A; key KEYCODE_DEL
  type_text "$pass"
  key 111  # dismiss keyboard
  sleep 0.3
  tap $LOGIN_BTN_X $LOGIN_BTN_Y
  sleep 4
  wait_for_element "Home" 10
}

signout() {
  info "Signing out"
  tap $NAV_HOME_X $NAV_HOME_Y; sleep 1
  tap $APPBAR_SIGNOUT_X $APPBAR_SIGNOUT_Y; sleep 1.5
  tap_element "Sign Out" 2  # confirm dialog
  sleep 2
}

# ── Navigation helpers ────────────────────────────────────────────────────────

nav_championships() {
  tap $NAV_CHAMP_X $NAV_CHAMP_Y; sleep 2
}

open_championship() {
  local name="$1"
  tap_element "$name" 3
}

tap_tab() {
  # Tab name: Standings | Matches | My Matches | Admin
  tap_element "${1}	Tab" 2
}

# ── Test suites ───────────────────────────────────────────────────────────────

test_login_flow() {
  info "=== TEST: Login flow ==="
  login "test21@mysta.com"
  assert_visible "Performance Overview"
  assert_visible "Home	Tab 1 of 5"
  signout
  pass "Login/logout flow complete"
}

test_championship_list() {
  info "=== TEST: Championship list ==="
  login "test21@mysta.com"
  nav_championships

  assert_visible "Active	Tab 1 of 2"
  assert_visible "Completed	Tab 2 of 2"
  assert_visible "Women's Beach Volleyball Open 2026"
  assert_visible "Men's Beach Volleyball Open 2026"
  assert_visible "Round 5/9"          # Women's active
  assert_visible "Registration Open"  # Men's still open
  assert_visible "Create Championship" # FAB visible to all

  # Switch to Completed tab (should be empty initially)
  tap_element "Completed	Tab 2" 2
  assert_visible "Completed"

  signout
}

test_championship_detail_standings() {
  info "=== TEST: Championship detail — standings + tiebreaker ==="
  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"

  # My Team section visible (test21 is registered)
  assert_visible "Les Perles"
  assert_visible "Leave team"

  # Standings tab should be default
  assert_visible "Standings	Tab 1 of 3"
  assert_visible "My Matches	Tab 3 of 3"

  # Standings table
  assert_visible "#"         # header
  assert_visible "Pts"

  # Tiebreaker info icon
  tap_element "How standings work" 1
  assert_visible "How standings work"
  assert_visible "Head-to-head"
  tap_element "OK" 1

  signout
}

test_championship_matches_tab() {
  info "=== TEST: Matches tab — round navigation ==="
  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"
  tap_element "Matches	Tab 2" 2

  assert_visible "Round 5"   # current round
  assert_visible "Verified"  # all R5 matches should be verified

  # Navigate to Round 6 (arrow button — right arrow)
  dump_ui
  local arrow_x arrow_y
  # Right arrow is the second empty-desc button (navigation arrows)
  read -r arrow_x arrow_y <<< "$(python3 -c "
import re
txt = open('/tmp/ui_dump.xml').read()
btns = re.findall(r'class=\"android\.widget\.Button\"[^>]*content-desc=\"\"[^>]*bounds=\"(\[[0-9,\]\[]+)\"', txt)
if len(btns) >= 2:
    coords = re.findall(r'[0-9]+', btns[1])
    print((int(coords[0])+int(coords[2]))//2, (int(coords[1])+int(coords[3]))//2)
" 2>/dev/null)"
  if [ -n "$arrow_x" ]; then
    tap "$arrow_x" "$arrow_y" 1.5
    assert_visible "Round 6"
    assert_visible "Pending"
    pass "Round navigation works"
  else
    fail "Round navigation arrows not found"
  fi

  signout
}

test_my_matches_tab() {
  info "=== TEST: My Matches tab ==="
  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"

  # Tap My Matches
  tap_element "My Matches	Tab" 2
  sleep 2  # wait for allMatches stream

  assert_visible "R1"
  assert_visible "R6"
  assert_visible "Scheduled"

  swipe_up
  assert_visible "R7"
  assert_visible "R8"
  assert_visible "R9"
  assert_visible "Pending"

  pass "My Matches shows all 9 rounds"
  signout
}

test_match_detail() {
  info "=== TEST: Match detail — scheduled match ==="
  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"
  tap_element "Matches	Tab" 2

  # Navigate to Round 6
  dump_ui
  local arrow_x arrow_y
  read -r arrow_x arrow_y <<< "$(python3 -c "
import re
txt = open('/tmp/ui_dump.xml').read()
btns = re.findall(r'class=\"android\.widget\.Button\"[^>]*content-desc=\"\"[^>]*bounds=\"(\[[0-9,\]\[]+)\"', txt)
if len(btns) >= 2:
    coords = re.findall(r'[0-9]+', btns[1])
    print((int(coords[0])+int(coords[2]))//2, (int(coords[1])+int(coords[3]))//2)
" 2>/dev/null)"
  [ -n "$arrow_x" ] && tap "$arrow_x" "$arrow_y" 1.5

  # Open scheduled match (Les Perles vs Les Gazelles)
  tap_element "Perles" 3
  assert_visible "Match Detail"
  assert_visible "Scheduled"
  assert_visible "Match Chat"
  assert_visible "Propose Schedule"

  back
  signout
}

test_schedule_proposal_flow() {
  info "=== TEST: Schedule proposal + accept flow ==="
  info "Step 1: test21 (Les Perles) proposes schedule for R7"

  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"
  tap_element "My Matches	Tab" 2; sleep 2
  swipe_up; sleep 0.5

  # Open R7
  tap_element "Soleil Levant" 2.5
  assert_visible "Match Detail"
  assert_visible "Propose Schedule"

  # Pick a date
  tap_element "Date: —" 2
  sleep 2  # calendar opens
  dump_ui
  local day_x day_y
  read -r day_x day_y <<< "$(python3 -c "
import re
txt = open('/tmp/ui_dump.xml').read()
# Pick a future date (e.g. Aug 25)
for desc, bounds in re.findall(r'content-desc=\"([^\"]+)\"[^>]*bounds=\"(\[[0-9,\]\[]+)\"', txt):
    if 'august 25' in desc.lower() or 'aug 25' in desc.lower():
        coords = re.findall(r'[0-9]+', bounds)
        print((int(coords[0])+int(coords[2]))//2, (int(coords[1])+int(coords[3]))//2)
        break
" 2>/dev/null)"
  [ -n "$day_x" ] && tap "$day_x" "$day_y" 0.5
  tap_element "OK" 1

  # Pick a time
  tap_element "Time: —" 2
  sleep 2
  tap_element "PM" 0.5
  tap_element "OK" 1

  # Propose
  tap_element "Propose" 5
  assert_visible "Waiting for Confirmation"
  assert_visible "proposed"
  pass "Schedule proposal sent"

  signout

  info "Step 2: test27 (Soleil Levant) accepts"
  login "test27@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"
  tap_element "My Matches	Tab" 2; sleep 2
  swipe_up; sleep 0.5

  tap_element "Les Perles" 2.5
  assert_visible "Schedule Proposed"
  assert_visible "Accept"
  assert_visible "Reject"

  tap_element "Accept" 5
  assert_visible "confirmed the schedule"
  pass "Schedule acceptance confirmed"
  signout
}

test_team_rename() {
  info "=== TEST: Team rename (Men's championship, registration phase) ==="
  login "test1@mysta.com"
  nav_championships

  # Men's championship is in Registration Open
  open_championship "Men's Beach Volleyball Open 2026"

  # Pencil icon next to team name (captain only, registration only)
  assert_visible "Les Titan"  # team name (may be renamed)

  dump_ui
  local pencil_x pencil_y
  read -r pencil_x pencil_y <<< "$(python3 -c "
import re
txt = open('/tmp/ui_dump.xml').read()
# Small clickable button near the team name section (y < 600)
items = [(b, d) for d, b in re.findall(r'content-desc=\"([^\"]{0,20})\"[^>]*bounds=\"(\[[0-9,\]\[]+)\"', txt)]
for bounds, desc in items:
    coords = re.findall(r'[0-9]+', bounds)
    cx = (int(coords[0]) + int(coords[2])) // 2
    cy = (int(coords[1]) + int(coords[3])) // 2
    if cy < 700 and cx > 300 and cx < 500 and not desc:
        print(cx, cy)
        break
" 2>/dev/null)"

  if [ -n "$pencil_x" ]; then
    tap "$pencil_x" "$pencil_y" 1.5
    assert_visible "Rename Team"
    assert_visible "Team name"

    # Type new name
    tap_element "Team name" 0.5
    key KEYCODE_CTRL_A; key KEYCODE_DEL
    type_text "Les Titans 2026"
    tap_element "Save" 4

    assert_visible "Team renamed successfully"
    pass "Team rename works"
  else
    fail "Pencil icon not found — check if user is captain in registration phase"
  fi

  signout
}

test_create_championship() {
  info "=== TEST: Create Championship form ==="
  login "test1@mysta.com"
  nav_championships

  tap_element "Create Championship" 2
  assert_visible "Create Championship"
  assert_visible "Max teams"
  assert_visible "10"         # default max teams
  assert_visible "4"          # option
  assert_visible "6"          # option
  assert_visible "8"          # option

  # No "Players per team" selector — always 2 for beach volleyball
  dump_ui
  if python3 -c "
import re; txt = open('/tmp/ui_dump.xml').read()
exit(0 if 'players per team' in txt.lower() else 1)
" 2>/dev/null; then
    fail "Players per team selector should not be visible (always 2)"
  else
    pass "Players per team correctly removed"
  fi

  # Select 6 teams
  tap_element "6" 0.5
  assert_visible "6"  # still visible = selected

  back
  signout
}

test_admin_panel() {
  info "=== TEST: Admin panel ==="
  login "test1@mysta.com"
  nav_championships
  open_championship "Men's Beach Volleyball Open 2026"

  # Admin tab (test1 is the championship creator)
  tap_element "Admin	Tab" 3
  assert_visible "Edit Details"     # visible in registration phase
  assert_visible "No matches requiring admin attention"

  # Test Edit Details dialog
  tap_element "Edit Details" 2
  assert_visible "Edit Championship"
  assert_visible "Change deadline"
  assert_visible "Save"
  tap_element "Cancel" 1

  pass "Admin panel visible and Edit Details dialog opens"
  signout
}

test_tiebreaker_dialog() {
  info "=== TEST: Tiebreaker info dialog ==="
  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"

  # Info icon on standings
  tap_element "How standings work" 1.5
  assert_visible "How standings work"
  assert_visible "Win 2-0"
  assert_visible "Head-to-head"
  assert_visible "Set ratio"
  tap_element "OK" 1

  signout
}

test_bottom_nav_on_all_pages() {
  info "=== TEST: Bottom nav visible on championship pages ==="
  login "test21@mysta.com"
  nav_championships
  open_championship "Women's Beach Volleyball Open 2026"

  # Championship detail
  assert_visible "Championships	Tab 5 of 5"

  # Match detail
  tap_element "Matches	Tab" 2
  dump_ui
  local arrow_x arrow_y
  read -r arrow_x arrow_y <<< "$(python3 -c "
import re
txt = open('/tmp/ui_dump.xml').read()
btns = re.findall(r'class=\"android\.widget\.Button\"[^>]*content-desc=\"\"[^>]*bounds=\"(\[[0-9,\]\[]+)\"', txt)
if len(btns) >= 2:
    coords = re.findall(r'[0-9]+', btns[1])
    print((int(coords[0])+int(coords[2]))//2, (int(coords[1])+int(coords[3]))//2)
" 2>/dev/null)"
  [ -n "$arrow_x" ] && tap "$arrow_x" "$arrow_y" 1.5

  tap_element "Perles" 2.5  # open a match
  assert_visible "Match Detail"
  assert_visible "Championships	Tab 5 of 5"
  back

  pass "Bottom nav visible on championship detail and match detail"
  signout
}

# ── Main runner ───────────────────────────────────────────────────────────────

run_suite() {
  echo ""
  echo "=============================================="
  echo "  Championship Smoke Tests — $(date '+%Y-%m-%d %H:%M')"
  echo "=============================================="
  echo ""

  test_login_flow
  echo ""
  test_championship_list
  echo ""
  test_championship_detail_standings
  echo ""
  test_championship_matches_tab
  echo ""
  test_my_matches_tab
  echo ""
  test_match_detail
  echo ""
  test_schedule_proposal_flow
  echo ""
  test_team_rename
  echo ""
  test_create_championship
  echo ""
  test_admin_panel
  echo ""
  test_tiebreaker_dialog
  echo ""
  test_bottom_nav_on_all_pages

  echo ""
  echo "=============================================="
  echo -e "  Results: ${GREEN}${PASS} passed${NC}  ${RED}${FAIL} failed${NC}"
  echo "=============================================="
  echo ""
  [ $FAIL -eq 0 ] && exit 0 || exit 1
}

# Run specific test or full suite
case "${1:-all}" in
  login)        test_login_flow ;;
  list)         test_championship_list ;;
  standings)    test_championship_detail_standings ;;
  matches)      test_championship_matches_tab ;;
  my-matches)   test_my_matches_tab ;;
  match-detail) test_match_detail ;;
  schedule)     test_schedule_proposal_flow ;;
  rename)       test_team_rename ;;
  create)       test_create_championship ;;
  admin)        test_admin_panel ;;
  tiebreaker)   test_tiebreaker_dialog ;;
  nav)          test_bottom_nav_on_all_pages ;;
  all)          run_suite ;;
  *)
    echo "Usage: $0 [all|login|list|standings|matches|my-matches|match-detail|schedule|rename|create|admin|tiebreaker|nav]"
    exit 1
    ;;
esac
