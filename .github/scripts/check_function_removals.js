#!/usr/bin/env node
/**
 * Fails the deploy if a currently-live Cloud Function would be removed by
 * this deploy, unless it's documented in functions/deprecated-functions.json.
 *
 * See CLAUDE.md §11.11 (Cloud Function Versioning & Production Safety) and
 * Story 0.3.5 — this is the enforcement mechanism behind the advisory-only
 * breaking-change PR label check.
 *
 * Usage: node check_function_removals.js <deployed-names-file>
 * <deployed-names-file> — output of `gcloud functions list --format="value(name)"`,
 * one function per line (short name or full resource path, either is accepted).
 */
const fs = require("fs");
const path = require("path");

const deployedFile = process.argv[2];
if (!deployedFile) {
  console.error("Usage: check_function_removals.js <deployed-names-file>");
  process.exit(1);
}

const deployedRaw = fs.readFileSync(deployedFile, "utf8").trim();
const deployed = deployedRaw
  ? deployedRaw
    .split("\n")
    .map((line) => line.trim().split("/").pop())
    .filter(Boolean)
  : [];

if (deployed.length === 0) {
  console.log("ℹ️  No functions currently deployed — nothing to check (first deploy).");
  process.exit(0);
}

const intended = Object.keys(require(path.resolve("functions/lib/index.js")));
const intendedSet = new Set(intended);

// Firebase Extension instances (e.g. "Export Collections to BigQuery") create
// functions prefixed "ext-" that are installed and managed independently of
// this repo (via the Firebase Console/CLI extension mechanism, not
// functions/src). `firebase deploy --only functions` never touches them, so
// they must never be treated as "removed" by this repo's deploy.
const isExtensionFunction = (name) => name.startsWith("ext-");

const removed = deployed.filter(
  (name) => !intendedSet.has(name) && !isExtensionFunction(name)
);

if (removed.length === 0) {
  console.log("✅ No function removals detected.");
  process.exit(0);
}

console.log("⚠️  The following currently-live functions are NOT in this deploy:");
removed.forEach((name) => console.log(`   - ${name}`));

const allowlistPath = path.resolve("functions/deprecated-functions.json");
const allowlist = JSON.parse(fs.readFileSync(allowlistPath, "utf8"));
const allowedNames = new Set(allowlist.map((entry) => entry.name));

const undocumented = removed.filter((name) => !allowedNames.has(name));

if (undocumented.length > 0) {
  console.error("");
  console.error(
    `❌ ERROR: The following function(s) would be removed but are not documented in functions/deprecated-functions.json:`
  );
  undocumented.forEach((name) => console.error(`   - ${name}`));
  console.error("");
  console.error(
    "   If this removal is intentional (old app version retired — CLAUDE.md §11.11),"
  );
  console.error(
    "   add an entry to functions/deprecated-functions.json and re-run. Otherwise, restore the function."
  );
  process.exit(1);
}

console.log(
  "✅ All removed functions are documented in functions/deprecated-functions.json — proceeding."
);
