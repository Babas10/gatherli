# Emulator Smoke Tests

Shell scripts that drive the Android emulator via ADB to smoke-test features
without needing a human to tap through the app.

## Prerequisites

1. Android emulator running: `flutter emulators --launch gatherli-dev`
2. App running: `flutter run --flavor dev -t lib/main_dev.dart -d emulator-5554`
3. Test data loaded: run `setupChampionshipTestEnvironment.ts` once against gatherli-dev
4. Cloud Functions deployed: `firebase deploy --only functions --project gatherli-dev`

## Scripts

| Script | Coverage |
|---|---|
| `championship_smoke_test.sh` | Full championship feature suite |

## Running

```bash
# Full suite (~5-8 minutes)
./scripts/emulator-tests/championship_smoke_test.sh

# Single test
./scripts/emulator-tests/championship_smoke_test.sh schedule
./scripts/emulator-tests/championship_smoke_test.sh standings
./scripts/emulator-tests/championship_smoke_test.sh create
```

## Available test names

`login` `list` `standings` `matches` `my-matches` `match-detail`
`schedule` `rename` `create` `admin` `tiebreaker` `nav`

## How it works

- Uses `adb uiautomator dump` to inspect the UI tree
- Finds elements by `content-desc` substring (locale-independent)
- Uses `adb shell input tap X Y` for interactions
- `assert_visible` checks the UI dump for expected text
- Results shown as PASS/FAIL with a summary at the end

## Test users (password: test1010)

| User | Role |
|---|---|
| test1@mysta.com | Platform admin + Men's captain (Les Titans) |
| test21@mysta.com | Women's captain (Les Perles, 5W-0L) |
| test27@mysta.com | Women's captain (Soleil Levant) |
