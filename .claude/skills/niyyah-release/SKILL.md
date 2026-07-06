---
name: niyyah-release
description: Ship a Niyyah iOS release end-to-end — version bump (app + extension targets), on-device verification, Xcode archive/upload, App Store Connect submission with Family Controls notes, and the post-approval git ritual (merge + tag). Use for any "release", "ship", "submit to App Store", or version-bump task on this repo.
---

# Niyyah release process

Niyyah ships from this repo to the App Store as
[Niyyah - Set Your Intention](https://apps.apple.com/app/id6761061944)
(`com.alimustafa.ayaunlock`, team `W47NPWSG9U`). Flutter + 3 Screen Time extensions.
History and canonical facts: root `CLAUDE.md`.

## 1. Branch & version

- Work lands on a `vX.Y.Z-release` branch off `main`; open a PR but do NOT merge until Apple approves.
- Bump `pubspec.yaml` `version: X.Y.Z+N` (build N always increments, even for a resubmission).
- **Check the extension targets** in `ios/Runner.xcodeproj/project.pbxproj`: ShieldConfiguration /
  ShieldAction / DeviceActivityMonitor should have `MARKETING_VERSION = $(FLUTTER_BUILD_NAME)` and
  `CURRENT_PROJECT_VERSION = $(FLUTTER_BUILD_NUMBER)`. If any are hardcoded (they shipped as 1.0/1
  in v1.1.0), fix them. Also verify every target's `IPHONEOS_DEPLOYMENT_TARGET` is 16.6 — Xcode
  creates new targets at the newest SDK (that bug shipped once as 26.5 on the monitor extension).

## 2. Pre-flight (all must pass)

```bash
flutter analyze          # zero errors/warnings (info hints ok)
flutter test
flutter clean && flutter run --release -d <device-id>   # clean build on the physical iPhone
```

- Screen Time is dead in the Simulator — gating QA is device-only. Minimum manual pass: gate an
  app → shield shows ayah → Read to Unlock → notification → gate → complete reading → unlock →
  **verify re-lock** (background the app; wait out the window).
- Entitlement check: only base `com.apple.developer.family-controls` on Runner +
  DeviceActivityMonitorExtension. **Never** the `app-and-website-usage` variant — the team lacks
  its Distribution approval; it broke Distribute once (fixed in 997d8f8).

## 3. Archive & upload (GUI-only, owner's action)

Xcode → scheme Runner → destination "Any iOS Device (arm64)" → Product ▸ Archive →
Distribute App ▸ App Store Connect ▸ Upload. If Distribute fails on provisioning for an extension,
check the extension's App ID capabilities on the developer portal (Family Controls Distribution) —
and remember a stale cached archive can mask an entitlement fix: archive again after any
entitlement change.

## 4. App Store Connect submission

- Attach the new build; write What's New **EN + AR** (native Arabic, no excessive em dashes —
  see `.claude/skills/niyyah-marketing/SKILL.md` copy rules). Keep a copy in
  `marketing/release_notes_<version>.md` and update `store/app_store_description.md` if the
  listing text changed.
- App Review note (reuse from `marketing/release_notes_1.1.0.md`): explain the Family Controls
  usage — user-initiated self-restriction, `.individual` authorization, no child accounts.
- Screenshots: `marketing/screenshots/` (6.5" = 1284×2778 dir, iPad = 2048×2732). App preview
  video (886×1920) is in `marketing/remotion/out/` — optional but use it.
- Review turnaround has been ~1-3 days; Family Controls apps can get extra scrutiny.

## 5. After approval (the git ritual — don't skip)

```bash
gh pr merge <PR#> --merge
git checkout main && git pull
git tag -a vX.Y.Z <release-tip-sha> -m "App Store build X.Y.Z+N, approved <date>"
git push origin vX.Y.Z
```

Then: update the memory file for the release, post launch content via the `niyyah-marketing`
skill, and file follow-ups into `private/BACKLOG-*.md`.

## If review rejects

Fix on the same release branch, bump build number only (`+N`), re-archive, resubmit with a reply
in Resolution Center. Do not merge the PR until a build is approved and live.
