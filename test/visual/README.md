# Visual Regression Harness (Epic 36)

Local-only screenshot regression testing against a real iOS Simulator. Catches
the class of bug where a feature silently stops working even though unit
tests still pass and the code still compiles — see the harness's motivating
incident in [Epic 36](https://github.com/Babas10/gatherli/issues/921).

Not CI-integrated by design (no simulator access in GitHub Actions runners).
Run it locally before opening/updating a PR that touches a covered feature
area, and paste the report summary into the PR description — see the
checklist item in `CLAUDE.md` §5.

## Prerequisites

- A booted iOS Simulator (`open -a Simulator`, or `xcrun simctl boot <udid>`)
- Firebase emulator running: `firebase emulators:start --only auth,firestore --project gatherli-dev`

## Running

```bash
# Run everything
dart run test/visual/tooling/run_visual_tests.dart

# Run only flows tagged `auth` (see tags in test/visual/manifest.json)
dart run test/visual/tooling/run_visual_tests.dart --tags auth

# Run flows matching any of several tags
dart run test/visual/tooling/run_visual_tests.dart --tags auth,championship

# Target a specific simulator instead of the first booted one
dart run test/visual/tooling/run_visual_tests.dart --device <udid>

# Loosen/tighten the pixel-diff tolerance (default 0.5% of pixels)
dart run test/visual/tooling/run_visual_tests.dart --tolerance 1.0
```

Each run prints a one-line-per-checkpoint summary and writes a full markdown
report to `test/visual/reports/<timestamp>/report.md` (gitignored — local
artifact only, never committed, never posted anywhere automatically).

The process exits non-zero if any checkpoint fails or errors — safe to wire
into a local pre-push hook if you want, but nothing in this repo does that
automatically today.

## Interpreting a report

Each checkpoint ends up in one of five states:

| Status | Meaning |
|---|---|
| ✅ `pass` | Captured screenshot is within tolerance of the golden. Nothing to do. |
| ❌ `fail` | Diverges beyond tolerance. Report includes a diff-highlight image (mismatched pixels in red) plus paths to the golden, the captured screenshot, and the diff — open the diff image first, it usually tells you immediately whether this is a real regression or an intentional change. |
| 🆕 `new` | No golden exists yet for this checkpoint (new flow, or new checkpoint added to an existing flow). Review the captured screenshot, then run with `--update-goldens` to accept it. |
| 🔄 `updated` | You ran with `--update-goldens` — the golden was overwritten. |
| ⚠️ `error` | The screenshot capture itself failed (e.g. `simctl` error) — not a visual diff, something broke in the harness or the device connection. |

**A failing report doesn't always mean a regression.** If you intentionally
changed a covered screen, review the diff image to confirm the change is the
one you meant, then run with `--update-goldens` to accept the new baseline.
Never regenerate goldens without looking at the diff first — that defeats the
entire point of the harness.

## Updating goldens deliberately

```bash
dart run test/visual/tooling/run_visual_tests.dart --tags <relevant-tag> --update-goldens
```

This overwrites the committed PNGs under `test/visual/goldens/`. Treat the
resulting `git diff` like any other change — review the new images (or at
least the diff report from the run right before you did this) before
committing. Don't run `--update-goldens` reflexively just to make a red run
go green.

## Known determinism gotchas (read before writing a new flow)

- **iOS's one-time notification permission dialog** is a native system alert,
  invisible to the Flutter widget tree and *not* controllable via
  `xcrun simctl privacy` (`notifications` isn't in its supported service
  list — confirmed empirically, don't waste time on it). It only appears the
  first time an app requests notification permission on a given simulator;
  dismiss it manually once (tap Allow or Don't Allow) and iOS remembers the
  decision for that app install on all future automated runs.
- **Never use timestamp- or random-based test data** (emails, display names,
  IDs) in a flow if that data is visible on screen — it'll make every
  screenshot differ from the golden every single run. Use fixed values
  instead, and make the flow idempotent by wiping relevant Firebase Emulator
  state at the start (see `_resetAuthEmulator()` in
  `integration_test/visual/auth_login_and_navigation_test.dart` for the
  pattern — deletes all emulator Auth accounts via its REST endpoint before
  creating a fixed test user).
- **Always `tester.ensureVisible()` before tapping anything that might be
  below the fold** (e.g. a submit button at the bottom of a long scrollable
  form). `tester.tap()` on an off-screen widget only prints a warning, it
  doesn't fail the test — so a missed tap can silently mean the checkpoint
  captures the wrong screen entirely while the test still reports "passed".
  This actually happened while building the `auth_signup` flow; see its git
  history for the fix.
- **Trust the screenshot, not the green checkmark.** "All tests passed" only
  means no Dart exception was thrown — it says nothing about whether the
  flow actually reached the screen you think it did. Open newly-established
  or newly-changed goldens and look at them before committing.
- The status bar is frozen automatically by the orchestrator
  (`xcrun simctl status_bar ... override`) — you don't need to do anything
  for that, but don't rely on real device chrome (real clock, battery, etc.)
  being visible in a way that would break this.

## Writing a new flow

1. Add a file under `integration_test/visual/` (must be under this exact
   top-level directory — Flutter's on-device test discovery requires it,
   `test/visual/flows/` does **not** work, see Story 36.1's PR for why).
2. Follow the Firebase Emulator bootstrap pattern at the top of
   `integration_test/visual/smoke_app_launch_test.dart` (handles the
   iOS-auto-initializes-Firebase-natively `duplicate-app` gotcha) or
   `auth_login_and_navigation_test.dart` (adds the Auth emulator reset).
3. Drive the real app via `tester.pumpWidget(const PlayWithMeApp())` +
   `initializeDependencies()`, then interact with it exactly like a normal
   `flutter_test` widget test (`tester.tap()`, `tester.enterText()`, etc.) —
   the only harness-specific addition is calling
   `await visualCheckpoint('some-name')` (from
   `test/visual/tooling/checkpoint.dart`) after `pumpAndSettle()` at each
   point you want a screenshot.
4. Register the flow in `test/visual/manifest.json` with one or more tags.
5. Run it with `--update-goldens` to establish the initial baseline, inspect
   the resulting screenshots, then run again *without* `--update-goldens` at
   least once to confirm it's deterministic (0% diff) before committing.

## How it works

- Flows call `visualCheckpoint('name')` (from
  `test/visual/tooling/checkpoint.dart`) after `pumpAndSettle()`. This hands
  control to the host orchestrator (`test/visual/tooling/run_visual_tests.dart`)
  via a file-based handshake at `/tmp/gatherli_visual_test/` — the flow
  writes a ready-marker and blocks; the orchestrator polls for it, captures
  a real `xcrun simctl io screenshot`, writes a done-marker, and the flow
  resumes.
- This only works on the iOS **Simulator**, which is a plain macOS process
  sharing the host filesystem — not true of a real device or the Android
  emulator (a true separate VM), which is why this is iOS-Simulator-only for
  now (see Epic 36 non-goals).
- Screenshots are diffed against `test/visual/goldens/<flow>/<checkpoint>.png`
  with a tolerance threshold (default 0.5% of differing pixels), not exact
  byte match, using the `image` package
  (`test/visual/tooling/image_diff.dart`) — real screenshots have a small
  amount of run-to-run anti-aliasing/font-rendering noise even on an
  otherwise static screen.
