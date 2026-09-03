# Visual Regression Harness (Epic 36)

Local-only screenshot regression testing against a real iOS Simulator. Full
usage docs land in Story 36.3 — this is a quick-start stub.

## Prerequisites

- A booted iOS Simulator (`open -a Simulator`)
- Firebase emulator running: `firebase emulators:start --only auth,firestore --project gatherli-dev`

## Run

```bash
# Run everything
dart run test/visual/tooling/run_visual_tests.dart

# Run only flows tagged `smoke` (see test/visual/manifest.json)
dart run test/visual/tooling/run_visual_tests.dart --tags smoke

# Accept freshly captured screenshots as the new baseline (deliberate only —
# review the diff before doing this)
dart run test/visual/tooling/run_visual_tests.dart --tags smoke --update-goldens
```

A markdown report (pass/fail table + diff images for failures) is written to
`test/visual/reports/<timestamp>/report.md` (gitignored, local only).

## How it works

- Each flow is an `integration_test/visual/*.dart` file (must live under the
  top-level `integration_test/` directory — Flutter's on-device test
  discovery requires it).
- Flows call `visualCheckpoint('name')` (from `test/visual/tooling/checkpoint.dart`)
  after `pumpAndSettle()`. This hands control to the host orchestrator via a
  file-based handshake at `/tmp/gatherli_visual_test/`, which captures a real
  `xcrun simctl io screenshot` and hands control back.
- This only works on the iOS **Simulator**, which is a plain macOS process
  sharing the host filesystem — not a real device or the Android emulator
  (a true separate VM). Android support is a future non-goal (see Epic 36).
- Screenshots are diffed against `test/visual/goldens/<flow>/<checkpoint>.png`
  with a tolerance threshold (default 0.5% of pixels), not exact match.
