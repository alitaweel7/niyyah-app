# CLAUDE.md — Niyyah (project `aya_unlock`)

Niyyah is a live iOS app: a privacy-first, fully-offline Quran-gated blocker for social apps.
Opening a gated app shows a Screen Time shield; the user reads Quran/Duas in Niyyah for a timed
"gate" (default 5 min), which grants a temporary unlock window (default 10 min), then the shield
returns. Also: prayer times + tracker, Qibla compass, reading progress/streaks, full EN/AR + RTL.

- **App Store**: [Niyyah - Set Your Intention](https://apps.apple.com/app/id6761061944) — bundle `com.alimustafa.ayaunlock`, seller "Ali Mustafa".
- **No backend, no accounts, no analytics.** All data local (Drift/SQLite). Don't add network calls casually — the brand promise is "everything stays on your device".
- **iOS-only in practice.** `android/` compiles but is unshipped/untested; don't spend effort there without an explicit decision.
- Version lives in `pubspec.yaml` (`version: X.Y.Z+N`). The three extension targets have their own `MARKETING_VERSION`/`CURRENT_PROJECT_VERSION` in `project.pbxproj` — keep them in sync when bumping (they drift silently).

## Architecture

**Flutter** (`lib/`): Riverpod (DI in `lib/core/di/providers.dart`) + go_router (`lib/core/router/`) + Drift schema **v7** (`lib/data/datasources/local/app_database.dart`; tables incl. UserPreferences, BlockedApps, GateSessions, UnlockSessions, ReadAyahs idempotent per-ayah, ReadingEvents append-only timeline, PrayerLogs). Bundled Quran DB at `assets/quran/quran.db` (Basmala is merged into ayah 1 in the DB — stripped at display time via `lib/core/quran/basmala.dart`; don't "fix" the DB without forcing a re-copy, the loader only copies when absent). Services: `PrayerTimesService` (adhan_dart, on-device), `LocationService`, `NotificationService` (local only), `UnlockManager`, `AppGateService` (platform interface). L10n: lightweight `context.tr()` map in `lib/l10n/app_strings.dart` (~260 keys, en+ar) — every user-facing string needs both.

**iOS native** (`ios/`): Screen Time / FamilyControls gating.
- `Runner/Gating/GateMethodChannel.swift` — method channel **`com.ayaunlock/gate`**: hasPermissions, requestPermissions, showAppPicker, startGating, grantTemporaryUnlock, revokeUnlock, checkGateRequested, getGateNavigationInfo, syncPrefsToAppGroup, syncShieldAyahs. (Event channel `com.ayaunlock/gate_events` exists but is unused.)
- `Runner/Gating/FamilyControlsBridge.swift` — ManagedSettingsStore shields, token persistence, re-shield scheduling (DeviceActivity).
- Extensions: `ShieldConfigurationExtension` (renders the shield: rotating ayah + "Read to Unlock"), `ShieldActionExtension` (button tap → time-sensitive notification → app opens the gate; ShieldAction *cannot* launch apps directly — the notification indirection is an iOS platform limit), `DeviceActivityMonitorExtension` (`intervalDidEnd` → re-apply shields).
- **App Group `group.com.ayaunlock.shared`** is the only Dart↔extension bridge. Keys: `shielded_app_tokens`, `gate_duration_seconds`, `unlock_duration_seconds`, `preferred_content_type`, `shield_ayahs`, `gate_requested_at`, `last_blocked_app_name`.
- Entitlements: base `family-controls` on Runner + DeviceActivityMonitorExtension only. **Never add `family-controls.app-and-website-usage`** — the team is not approved for its Distribution variant; it blocked a release once (fixed in 997d8f8).

## Build / run / test

- Toolchain: Flutter stable at `~/flutter`, CocoaPods via Homebrew, full Xcode required.
- **Screen Time does not work in the Simulator.** All gating work needs the physical iPhone (unlocked, USB).
- Run on device: `flutter run --release -d <device-id>`. Incremental builds sometimes skip framework re-signing — when a device install misbehaves, do `flutter clean` first.
- `flutter analyze` must stay clean (info-level hints acceptable); `flutter test` runs the repo tests (Drift in-memory).
- App Store archive is GUI-only: Xcode → Any iOS Device → Product ▸ Archive → Distribute. Full release checklist: `.claude/skills/niyyah-release/SKILL.md`.

## Repo map

| Path | What it is |
|---|---|
| `lib/`, `ios/`, `test/`, `assets/` | The app (see Architecture) |
| `docs/` | **Live GitHub Pages site** (`alitaweel7.github.io/niyyah-app`) — index.html + privacy.html. Anything committed here is published. |
| `site/` | **Nested checkout of the separate website repo** `alitaweel7/niyyah` (also live on Pages, has the email-signup form). Own `.git` — never `git add site/`; commit/push website changes from inside it, and mirror privacy-policy edits to `docs/` too. |
| `privacy_policy.md` | Markdown source of truth for the policy. Publish chain: edit here → update `docs/privacy.html` AND `site/privacy.html`. |
| `store/` | App Store listing reference copy (description, keywords). Update alongside real ASC changes. |
| `marketing/` | Screenshots pipeline, Remotion video/social kit, release notes. Canonical doc: `marketing/README.md`; skill: `.claude/skills/niyyah-marketing/SKILL.md`. |
| `tools/` | One-off Python data pipelines (load duas/hadith/translations into SQLite, icon/art generation). |
| `private/` | **Gitignored** internal docs (audit, roadmap, backlog). Repo is public — never commit strategy or security notes outside `private/`. |

## Git gotchas

- Repo `alitaweel7/niyyah-app` is **PUBLIC**. Review diffs before push; nothing from `private/`, no store credentials, no strategy.
- `marketing/remotion/node_modules/` stays ignored (has its own `.gitignore`).
- `site/` is a separate repo (see above); `ios/build/` and `private/` are gitignored here.
- Releases: work on a `vX.Y.Z-release` branch, PR to `main`, merge + tag `vX.Y.Z` only after Apple approval.

## Copy & content rules

- All user-facing and marketing copy is bilingual EN + AR; Arabic written natively (warm MSA), not translated-sounding. No excessive em dashes (owner preference). Voice: calm, intentional, never preachy.
- Quote Quran with verified text only (source: bundled Tanzil-derived DB); signature ayah «إِنَّ مَعَ الْعُسْرِ يُسْرًا» (Ash-Sharh 94:6).
- Reading Quran is never paywalled — the core gate experience stays free in any monetization work.
