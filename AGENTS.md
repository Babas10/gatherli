# AGENTS.md — Gatherli

> Agent instruction file for agentic / autonomous work.
> For project identity, stack, architecture, and coding standards see `CLAUDE.md`.

---

## Spec-Driven Development

### When a spec is required

| Change type | Spec needed? |
|---|---|
| Bug fix, typo, localization string addition | No |
| Config tweak, dependency version bump | No |
| New screen, new BLoC, new repository | Yes |
| New Cloud Function | Yes |
| New Epic or Story spanning multiple files | Yes |
| Architectural change (layer boundaries, DI setup, auth flow) | Yes |
| New data model with Firestore schema implications | Yes |

### Before implementing anything that needs a spec

1. Read `.specify/memory/context.md` — current focus and active work
2. Read `.specify/memory/decisions.md` (last 30 lines) — recent decisions and rationale
3. Check `.specify/specs/` — does a spec already cover this area?
4. If not, create `.specify/specs/<short-name>/spec.md` **before** writing any code

### Spec format (minimal)

```markdown
# <Title>

## Goal
One paragraph — what problem does this solve and why now.

## Scope
What changes and what is explicitly out of scope.

## Architecture Notes
Layer breakdown: which BLoC, Repository, Cloud Function, and Firestore collection are involved.

## Tasks
- [ ] Task 1
- [ ] Task 2

## Decisions
<!-- Append dated decisions here as they are made during implementation -->
```

### Task tracking discipline

- Mark tasks `[x]` immediately after completing — never batch-update at the end
- When a discovery changes the plan, amend the spec **before** implementing the fix
- At session end, verify the task list matches the git log — no silent completions
- NEVER claim work is done while tasks still show `[ ]`

---

## Session Start — Context Loading

At the start of every session:

1. Read `.specify/memory/context.md` — what was being worked on, active spec, next step
2. Read `.specify/memory/decisions.md` (last 30 lines) — recent decisions and rationale
3. If continuing a spec, open its task list and cross-check against the git log before writing any code

---

## Session End — Memory Write-back

Before ending any session:

1. Update `.specify/memory/context.md` with current state, active spec name, and next concrete step
2. Append new decisions to `.specify/memory/decisions.md` with date and one-line rationale
3. Append any recurring fix patterns discovered to `.specify/memory/patterns.md`

Memory is only useful if kept current. Stale context misleads the next session more than no context at all.

---

## Phased Feature Development

Use this process for any Story that requires a spec. Phases must be followed in order.

### Phase 1: Discovery

**Goal**: Understand what needs to be built before touching any file.

1. Create a todo list covering all phases
2. If the Story or feature is unclear, ask the user:
   - What problem does this solve?
   - What screens/flows are involved?
   - Any constraints (performance, offline, platform-specific)?
3. Summarize understanding and confirm with the user before proceeding

### Phase 2: Codebase Exploration

**Goal**: Understand existing patterns at both high and low levels before designing.

1. Launch 2–3 `code-explorer` subagents in parallel, each targeting a different aspect:
   - "Trace the implementation of a similar existing feature (e.g. game creation, group invitation) end-to-end"
   - "Map the BLoC → Repository → Firestore layer for [feature area]"
   - "Identify existing UI patterns, widget conventions, and theme usage relevant to [feature]"
2. Read all key files identified by the subagents before continuing
3. Present a summary of findings: patterns, layer boundaries, reuse opportunities

### Phase 3: Clarifying Questions

**Goal**: Resolve every ambiguity before writing a single line of code.

**CRITICAL — DO NOT SKIP THIS PHASE.**

1. Review codebase findings and the original Story requirements
2. Identify underspecified aspects: edge cases, error states, localization needs, offline behavior, Firestore schema implications, Cloud Function requirements, security rule changes
3. Present all questions to the user in a numbered list
4. **Wait for answers before proceeding to architecture design**

If the user says "whatever you think is best", provide a concrete recommendation and get explicit confirmation.

### Phase 4: Architecture Design

**Goal**: Produce a decisive, complete implementation blueprint.

1. Launch 2–3 `code-architect` subagents in parallel with different focuses:
   - Minimal change: smallest delta, maximum reuse of existing BLoCs and repositories
   - Clean architecture: new abstractions where needed, testability-first
   - Pragmatic balance: speed + quality, aligned with existing patterns
2. Review all approaches and form a recommendation
3. Present to the user: trade-off comparison, **your recommendation with reasoning**
4. **Ask the user which approach to proceed with**

### Phase 5: Implementation

**Goal**: Build the feature following the approved architecture.

**DO NOT START WITHOUT EXPLICIT USER APPROVAL.**

1. Follow the approved architecture strictly
2. Read every relevant file before editing it — never edit blind
3. Implement in this order: model → repository → BLoC → UI → Cloud Function (if any) → tests → localization
4. Mark spec tasks `[x]` as each is completed
5. Run `flutter analyze` after each logical chunk — never accumulate analyzer errors
6. Never leave a TODO or placeholder in committed code

### Phase 6: Quality Review

**Goal**: Verify correctness, conventions, and coverage before declaring done.

1. Launch 3 `code-reviewer` subagents in parallel with different focuses:
   - Simplicity, DRY, and BLoC/Repository conventions
   - Bugs, null safety, error handling, and Firebase edge cases
   - Localization completeness, UI theme compliance, and test coverage
2. Consolidate findings and identify issues worth fixing now vs later
3. **Present findings to the user and ask what they want to do**
4. Address agreed issues before marking the Story complete

### Phase 7: Completion

**Goal**: Close the Story cleanly.

1. Mark all spec tasks `[x]`
2. Run the full test suite: `flutter test test/unit/ test/widget/`
3. Run `flutter analyze` — zero warnings required
4. Update `.specify/memory/` with session write-back
5. Summarize: what was built, key decisions, files modified, suggested follow-ups

---

## Autonomous Work Patterns

The agent CAN self-initiate these without asking:

### New BLoC + Repository pair
When a Story introduces a new feature area:
1. Check `lib/core/domain/exceptions/repository_exceptions.dart` — add the new exception class
2. Check `lib/core/utils/error_messages.dart` — add handling for the new exception
3. Register the repository in `get_it` DI setup
4. Create the BLoC, event, state, and repository files following existing naming conventions
5. Write unit tests alongside (not after) the implementation

### Localization update
When adding any user-visible string:
1. Add the key to all 5 ARB files: `app_en.arb`, `app_fr.arb`, `app_de.arb`, `app_es.arb`, `app_it.arb`
2. Run `flutter gen-l10n`
3. Use `AppLocalizations.of(context)!` in the widget — never a hardcoded string

### New Cloud Function
1. Create `functions/src/<functionName>.ts` following the naming convention `onVerbObject`
2. Validate auth (`context.auth`) and all inputs before any write
3. Use structured error codes from section 11.6 of CLAUDE.md
4. Export the function in `functions/src/index.ts`
5. Test locally with Firebase Emulator before committing
6. Deploy to dev only: `firebase deploy --only functions --project gatherli-dev`

### Firestore schema change
When a Story changes or adds a collection/document shape:
1. Update the affected model (Freezed class) and its `toJson`/`fromJson`
2. Check Firestore security rules — update `firestore.rules` if collection access changes
3. Update the repository to match the new schema
4. If the change is breaking for existing documents, document a migration note in the spec

### Adding a test file
Mirror the source file path exactly:
- `lib/features/foo/bloc/foo_bloc.dart` → `test/unit/features/foo/bloc/foo_bloc_test.dart`
- `lib/features/foo/presentation/foo_page.dart` → `test/widget/features/foo/presentation/foo_page_test.dart`
- Begin every test file with a one-line purpose comment

---

## Agent MUST Ask Before

- Creating a new spec from scratch
- Deleting or archiving any spec
- Changing layer boundaries (e.g. a Game feature importing FriendRepository)
- Modifying `firestore.rules` or Firebase security configuration
- Pushing to GitHub or opening any PR, issue, or comment
- Deploying Cloud Functions to `gatherli-prod`
- Deleting any Firestore collection or document in any environment
- Changing the DI wiring in `get_it` setup in a way that affects multiple features
- Any change to Firebase Auth configuration

---

## Available Subagents

Place custom subagents in `.claude/agents/`. The following are the recommended agents for this project:

| Agent | When to use | Focus |
|---|---|---|
| `code-explorer` | Phase 2 — before designing | Trace existing feature implementations, map BLoC/Repository layers |
| `code-architect` | Phase 4 — before implementing | Design the file structure, data flow, and integration points |
| `code-reviewer` | Phase 6 — before closing a Story | Check conventions, bugs, coverage, localization |
| `security-reviewer` | Any Story touching auth, Firestore rules, or Cloud Functions | Catch permission errors, data exposure, unauthenticated paths |
| `test-writer` | When BLoC or Repository coverage is below 90% | Generate unit/widget tests matching project conventions |

All subagents should operate read-only during exploration phases. Only `code-reviewer` and `test-writer` write files.

---

## Background Routines

| Routine | When | What it checks |
|---|---|---|
| Analyzer check | After every implementation chunk | `flutter analyze` — zero warnings |
| Test suite | Before closing any Story | `flutter test test/unit/ test/widget/` — all pass |
| Localization completeness | After any string addition | All 5 ARB files updated, `flutter gen-l10n` run |
| Security rules review | After any Firestore schema or collection change | Rules match new access patterns |
| Spec health | Session start | Incomplete specs with stale `[ ]` tasks |
| Memory write-back | Session end | `context.md`, `decisions.md`, `patterns.md` current |
| Task list sync | Session end | All completed tasks marked `[x]`, matches git log |

---

## Specs Index

Active specs live in `.specify/specs/`. Add a row here when creating a new spec.

| Spec | Scope | Status |
|---|---|---|
| *(none yet)* | | |

---

*Update this file when agent behaviour needs correcting. Append recurring fix patterns to `.specify/memory/patterns.md`.*
