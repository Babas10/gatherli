#!/usr/bin/env bash
# Checks that BLoC implementation and Repository layer coverage meets threshold.
# Parses coverage/lcov.info directly — no external tools required.
# Excludes *_event.dart and *_state.dart (Freezed-generated, no testable logic).
#
# Usage: ./tools/check_coverage.sh [threshold]
# Default threshold: 80

set -euo pipefail

THRESHOLD=${1:-80}
LCOV_FILE="coverage/lcov.info"

if [[ ! -f "$LCOV_FILE" ]]; then
  echo "❌ Coverage file not found: $LCOV_FILE"
  echo "   Run: flutter test --coverage test/unit/ test/widget/"
  exit 1
fi

python3 - << PYEOF
import sys

lcov = open("$LCOV_FILE").read()
threshold = $THRESHOLD

total = 0
covered = 0
current_file = ""
included_files = []

for line in lcov.splitlines():
    if line.startswith("SF:"):
        current_file = line[3:]
    elif line.startswith("DA:"):
        # Exclude event/state files (Freezed-generated, no testable logic)
        # Exclude generated files (*.freezed.dart, *.g.dart)
        is_bloc_impl = ("/bloc/" in current_file and not current_file.endswith(
            ("_event.dart", "_state.dart", ".freezed.dart", ".g.dart")))
        is_repo_impl = ("/repositories/" in current_file and not current_file.endswith(
            (".freezed.dart", ".g.dart")))
        if is_bloc_impl or is_repo_impl:
            _, count = line[3:].split(",", 1)
            total += 1
            if int(count) > 0:
                covered += 1
            if current_file not in included_files:
                included_files.append(current_file)

if total == 0:
    print("No BLoC/Repository coverage data found.")
    sys.exit(0)

pct = round(covered * 100 / total, 1)
print(f"Coverage (BLoC impls + Repositories, excl. event/state): {covered}/{total} lines = {pct}%")
print(f"Files checked: {len(included_files)}")

if pct < threshold:
    print(f"Coverage {pct}% is below threshold {threshold}%")
    sys.exit(1)
else:
    print(f"Coverage OK ({pct}% >= {threshold}%)")
PYEOF
