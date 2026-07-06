# FABLE.md — the operating method for AI work on this project

This file preserves the working method of Claude Fable 5, the model that audited this codebase,
restructured its docs, designed the five-layer re-lock, and shipped the v1.1.0/v1.1.1 releases.
**Any model working in this repo (Opus, Sonnet, or others) follows this method.**

Division of labor between the two instruction files:
- `CLAUDE.md` = the **facts** (architecture, commands, keys, gotchas, release checklist).
- `FABLE.md` = the **method** (how to think, analyze, build, verify, and ship).
- Precedence: the owner's words > CLAUDE.md facts > this method > your defaults.

---

## 1 · Triage the request before touching anything

Classify what you were actually asked:
- **A question** ("why does X happen?", "is this okay?") → investigate and report findings.
  Do NOT apply fixes; the deliverable is your assessment.
- **A change** ("fix", "build", "update") → plan, get decisions on genuine forks, execute
  end-to-end, verify, and report the outcome.
- **Ambiguous or huge** → ask 2-4 sharp questions ONLY for decisions that are genuinely the
  owner's (scope, money, public exposure, product behavior). Never ask about things you can
  read from the code, and never ask permission to do what was already requested.

Decisions the owner already made (don't re-litigate): repo stays public with strategy in
gitignored `private/`; freemium Niyyah Plus (StoreKit 2, no RevenueCat); reading Quran is never
paywalled; no ads; no tracking; iOS-first.

## 2 · Orient before acting

First minutes of any substantive session, in order:
1. Read `CLAUDE.md`, then skim the memory index if present.
2. `git status` + `git log --oneline -10` + current branch. Know what state you're standing on.
3. Read the specific files you'll touch — the WHOLE enclosing function/class, not just the
   lines you plan to edit. Editing code you haven't read is how regressions ship.

For broad work, fan out parallel read-only exploration (by layer: Dart core / iOS native /
docs+meta), each with a focused brief, then synthesize centrally. Never let a sub-report's
claim become a headline without re-verifying it yourself at the primary source (grep the file,
read the line). Example that justifies the rule: the "monitor extension requires iOS 26.5"
finding was hand-verified in `project.pbxproj` before being reported — it was real, and it was
the most important bug in the codebase.

## 3 · How to think through architecture

These are the patterns that produced the current design. Apply them to any new problem here:

- **One source of truth.** When state is consulted by multiple layers or processes, define ONE
  canonical record and make everything else derive from it (re-lock: `unlock_until` in the App
  Group; everything funnels into one idempotent `enforceLockState()`).
- **Layered defense for unreliable platforms.** Apple's Screen Time APIs drop callbacks, have
  undocumented minimums (~15-min schedules), and extensions can silently fail to load. Never
  trust one mechanism for a promise the product makes. Layer independent mechanisms so every
  failure mode is covered by at least two, and make all of them idempotent so redundancy is
  free.
- **Idempotent enforcement, single-direction safety.** Enforcement re-asserts the safe state
  and NEVER performs the unsafe transition (re-lock code never removes shields; only an
  explicit grant does). Design every "healer" so running it twice, or at the wrong moment,
  cannot make things worse.
- **Fail closed, degrade honestly.** When a mechanism can't run, the failure must land on the
  safe side (a missed unlock beats a missed re-lock). When persistence can regress, fall back
  (App Group → standard defaults) rather than silently losing state.
- **Cross-process paranoia.** For every shared key ask: who writes, who reads, who deletes,
  and on which thread/process? Check-then-act across processes is a race. The rule that came
  out of a real near-miss here: *expiry paths never delete `unlock_until`* — expired values
  are inert, deletes belong only to explicit main-thread user actions. Preserve that rule and
  reason the same way about any new shared state.
- **Platform constraints first.** Before designing UX or logic, write down what the platform
  actually allows (ShieldAction cannot launch apps → notification indirection; Simulator has
  no Screen Time → device-only QA; new Xcode targets default to the newest deployment target →
  check it every time). Design within the constraints instead of discovering them in review.
- **Right altitude.** Fix causes, not symptoms. A special case layered on shared
  infrastructure is a smell — generalize the mechanism instead. But respect scope: a trust
  patch is not the moment for pbxproj surgery; defer deep refactors to the backlog WITH the
  reason recorded.

## 4 · Code analysis method

When auditing or reviewing (your own diff included):
1. Read every hunk line-by-line, then the enclosing function. For each line ask: what input,
   state, timing, or platform makes this wrong?
2. For every DELETED line, name the invariant it enforced and find where the new code
   re-establishes it. Removed behavior is the top source of regressions (the empty-picker
   un-gate path was exactly this).
3. Trace cross-file and cross-language: Dart ↔ method channel ↔ Swift ↔ extension. Verify both
   sides of every contract (argument names, types, who clears which key).
4. Hunt the classics: falsy-zero (`UserDefaults.double` returns 0 when absent — use
   `object(forKey:) as? Double`), floor-vs-ceil truncation, local-time string comparison,
   midnight/DST boundaries, force unwraps, swallowed catches, dead event channels.
5. Rank by severity against the product promise. For Niyyah the promise is "the gate returns" —
   anything touching re-lock outranks everything else.
6. Verify skeptically, fix decisively: for each candidate finding, try to refute it from the
   code before accepting it; once confirmed, fix it now or backlog it with a reason — never
   silently drop it.

## 5 · Code building method

- Match the surrounding code's idiom, naming, and comment density. New platform bridges copy
  the existing pattern (`AppGateService` interface + impl + stub trio; a small Swift bridge
  class + method channel).
- Comments state constraints the code can't show (WHY a rule exists, cross-process contracts),
  never narration of what the next line does.
- Every user-facing string is bilingual EN + AR via `lib/l10n/app_strings.dart`; native-side
  strings follow the synced `locale_code` and pick ONE language (see
  `scheduleExpiryNotification`) — never concatenate both.
- No new network calls, SDKs, or trackers without an explicit owner decision — the brand
  promise is "everything stays on your device".
- Prefer a full-file rewrite when a design changes shape (the bridge), surgical edits when it
  doesn't (the channel). Don't leave both old and new mechanisms alive: delete dead paths and
  leave a one-line NOTE saying who owns the behavior now.
- Dates: day arithmetic uses UTC-constructed dates (`streak_logic.dart` is canonical — reuse
  it, don't write a fourth `YYYY-MM-DD` formatter). Times that cross process boundaries are
  epoch seconds, not local ISO strings.

## 6 · Review protocol (mandatory before merging critical-path work)

After implementing, review your own diff as an adversary before merging:
1. Run multiple INDEPENDENT finder angles over the diff — minimum: line-by-line scan,
   removed-behavior audit, cross-file/cross-process trace; add reuse/simplification/efficiency/
   altitude/conventions angles for large changes (parallel subagents if available, sequential
   passes if not).
2. Every finding gets verified against the code (refute or confirm), then FIXED, DEFERRED with
   a written reason, or DOCUMENTED as an accepted edge. No silent drops.
3. Expect the review to find real bugs — this process caught a shield-orphaning path, a
   cross-process race, and a stranded OS range AFTER the "finished" implementation had passed
   all tests. Tests passing is not the bar; surviving adversarial review is.

## 7 · Verification discipline

The green bar for this repo, all four, every time:
1. `flutter analyze` → **zero issues** (the repo is at zero; keep it there).
2. `flutter test` → all pass; new logic gets new tests (pure functions preferred — extract
   logic out of widgets so it's testable).
3. `flutter build ios --release --no-codesign` → compiles all four targets (this is the ONLY
   automated check the Swift gets — never skip it).
4. **Inspect the built artifacts**, don't trust the config: read the `.appex` Info.plists for
   version/build/MinimumOSVersion after any pbxproj change. Config files lie; binaries don't.

What automation cannot cover: FamilyControls/Screen Time behavior is device-only. Ship nothing
gating-related without the owner running the device checklist (see `private/BACKLOG-*.md`
pattern: numbered steps, each tied to a specific layer/regression).

## 8 · Ship ritual

Follow `.claude/skills/niyyah-release/SKILL.md` exactly. The short form:
- Branch `vX.Y.Z-release` off `main`; bump `pubspec.yaml` AND the three extension targets'
  versions; verify every target's deployment floor (16.0).
- Commit messages explain WHY and list verification evidence. PR bodies state what device QA
  remains and who owns it.
- Merge when the owner says merge; tag `vX.Y.Z` only after Apple approval, pointing at the
  release commit.
- Git safety: repo is PUBLIC — nothing from `private/`, no strategy, no unpatched-weakness
  detail in commits. Never `git add site/` (separate repo). Review the staged diff before
  every push.

## 9 · Record and report

- **Order matters**: do the work, THEN write memory/docs recording what actually happened —
  never record intent as fact.
- After any phase that changes reality (release shipped, bug found, decision made): update the
  relevant memory file AND the repo docs (`CLAUDE.md` for new facts like App Group keys or
  channel methods; `private/` docs for findings/plans). Doc drift is a bug.
- Report outcome-first: what happened, what was found, what's left, in complete sentences with
  `file:line` references. State accepted edges and unfixable things plainly (e.g. "1.1.0 users
  updating mid-unlock re-lock early once — 1.1.0 never persisted that timestamp; errs toward
  locking"). Never claim verification that didn't run.

## 10 · Invariants that must never regress

Check these before merging ANY change to the gating path:
1. Re-lock enforcement is idempotent and never removes shields.
2. Expiry paths never delete `unlock_until`; only explicit main-thread user paths do.
3. The full `FamilyActivitySelection` (apps + categories + web domains) survives every
   persist/restore round-trip.
4. An empty picker selection stops gating entirely (it is the only user-reachable un-gate path).
5. Every target's deployment floor stays at 16.0; extension versions track the app.
6. Threshold math rounds UP; schedules use full date components (midnight-safe) with the
   ≥15-minute backstop padding.
7. Reading Quran stays free; a lapsed purchase never breaks an existing gate (fail-open rule
   applies to entitlements, fail-closed to re-locking).
8. `flutter analyze` stays at zero.

Keep this file honest: when the owner or a future session changes an invariant or the method
itself, update FABLE.md in the same commit.
