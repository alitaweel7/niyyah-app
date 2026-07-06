# Niyyah — Phase 1 critical fixes (build & finish-up guide)

> **HISTORICAL — completed and shipped in v1.1.0 (App Store, July 2026).**
> All steps below were done: the DeviceActivityMonitorExtension is a registered target and the
> App-Group token fix is live. Kept for reference only. The "Part B" open question (15-minute
> DeviceActivitySchedule minimum vs shorter unlocks) was NOT fully resolved in 1.1.0 — the
> follow-up re-lock hardening design lives in `private/BACKLOG-1.1.1.md`.

This documents the Phase 1 critical fixes made to the codebase and the **two steps that
require you** (full Xcode + a GUI target add), plus how to verify the core fix on your iPhone.

## What was changed in code (already done)

| Area | Files | Status |
|------|-------|--------|
| **P0** Share shield tokens via App Group so the monitor extension can re-shield | `ios/Runner/Gating/FamilyControlsBridge.swift` (tokens now saved to `UserDefaults(suiteName: "group.com.ayaunlock.shared")` with migration), `ios/DeviceActivityMonitorExtension/DeviceActivityMonitorExtension.swift` (`reapplyAllShields()` implemented) | ✅ code done, ⏳ needs build |
| **P1** Replaced 8 silent `catch {}` with `debugPrint` logging | `lib/app.dart`, `lib/features/gate/screens/gate_picker_screen.dart`, `lib/features/gate/screens/gate_screen.dart`, `lib/features/app_selection/screens/app_selection_screen.dart`, `lib/features/settings/screens/notification_settings_screen.dart` | ✅ verified (`flutter analyze` clean) |
| **P3** Defensive `HH:mm` parsing | `lib/services/prayer_times_service.dart`, `lib/features/gate/screens/gate_picker_screen.dart` | ✅ verified |
| **P2** `print()` → `#if DEBUG`-gated `gateLog()` in iOS code | `FamilyControlsBridge.swift`, `GateMethodChannel.swift`, `AppDelegate.swift`, `ShieldActionExtension.swift` | ✅ code done, ⏳ needs build |

`flutter analyze` passes (only pre-existing, unrelated info/warning lints remain).

## Toolchain status on this Mac

- ✅ Flutter 3.44.4 (stable) installed at `~/flutter` (added to `~/.zshrc` PATH)
- ✅ CocoaPods 1.16.2 (Homebrew)
- ❌ **Xcode — you must install the full Xcode** (App Store, ~10–15 GB). Command Line Tools alone can't build iOS.

After installing Xcode:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
cd ~/Projects/ayaunlock/ios && pod install
flutter doctor          # Xcode should now show ✓
```

---

## STEP 1 (you, in Xcode): register the DeviceActivityMonitor extension target

This is the wiring that makes the unlock actually expire. Without a real monitor-extension
**target**, iOS has nothing to call when an unlock window ends, so apps stay unlocked until
Niyyah is reopened. (Confirmed: only `ShieldActionExtension` and `ShieldConfigurationExtension`
are registered targets today.)

1. **Avoid a name clash:** delete the placeholder folder `ios/DeviceActivityMonitorExtension/`
   (it's dead code — not in any target). The final implementation is in step 3 below.
   ```bash
   rm -rf ~/Projects/ayaunlock/ios/DeviceActivityMonitorExtension
   ```
2. Open the **workspace** (not the project): `open ~/Projects/ayaunlock/ios/Runner.xcworkspace`
3. **File ▸ New ▸ Target… ▸ iOS ▸ "Device Activity Monitor Extension" ▸ Next.**
4. Product Name: **`DeviceActivityMonitorExtension`**; Team: your Apple Developer team;
   Language: Swift; **Embed in Application: Runner**. Click **Finish**.
   When asked "Activate scheme?", click **Cancel** (keep the Runner scheme).
5. Set the new target's **iOS Deployment Target to 16.0** (Build Settings).

## STEP 2 (you, in Xcode): add the target's capabilities

Select the **DeviceActivityMonitorExtension** target ▸ **Signing & Capabilities**:
- Set **Team** to the same team as Runner.
- **+ Capability ▸ App Groups** → add/check **`group.com.ayaunlock.shared`**.
- **+ Capability ▸ Family Controls.**

(These match `Runner.entitlements`, which already has both.)

## STEP 3 (you, in Xcode): paste the implementation

Open the Swift file Xcode generated for the new target and **replace its entire contents**
with this (keep the class name Xcode generated — usually `DeviceActivityMonitorExtension`):

```swift
import DeviceActivity
import ManagedSettings
import FamilyControls
import Foundation

class DeviceActivityMonitorExtension: DeviceActivityMonitor {

    private let store = ManagedSettingsStore()

    override func intervalDidStart(for activity: DeviceActivityName) {
        // Shield already applied — nothing to do.
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        // An unlock window expired → re-apply shields.
        reapplyAllShields()
    }

    private func reapplyAllShields() {
        // Suite + key MUST match FamilyControlsBridge.swift.
        guard let defaults = UserDefaults(suiteName: "group.com.ayaunlock.shared"),
              let data = defaults.data(forKey: "shielded_app_tokens"),
              let tokens = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data),
              !tokens.isEmpty else {
            return
        }
        store.shield.applications = tokens
    }
}
```

> The main app already writes `shielded_app_tokens` into the `group.com.ayaunlock.shared`
> App Group (FamilyControlsBridge change), so this extension can read and re-apply them.

---

## STEP 4: build & verify on your iPhone

> Screen Time / FamilyControls does **not** work in the Simulator — use a real device.

```bash
cd ~/Projects/ayaunlock
flutter run --release      # release so shields behave like production
```
(or Run from Xcode with the Runner scheme and your device selected.)

### Core re-lock test (the whole point of P0)
1. In Niyyah, add a gated app (e.g. Instagram) and grant Screen Time permission.
2. Open the gated app → complete a gate → receive the unlock.
3. Switch to the gated app, then **leave Niyyah in the background** (don't reopen it).
4. Wait until the unlock window passes.
5. ✅ **Expected:** the gated app becomes shielded again *without* reopening Niyyah.
   ❌ Before this fix it stayed unlocked until Niyyah was reopened.

### ⚠️ Part B — the sub-15-minute caveat (test this explicitly)
Apple's `DeviceActivitySchedule` has a **~15-minute minimum interval**. The default unlock is
10 minutes, so the OS may not fire `intervalDidEnd` for short windows. Test **two** cases:
- **Unlock window ≥ 15 min** → should re-lock reliably via the monitor extension.
- **Unlock window < 15 min** (e.g. the 10-min default) → if it does **not** re-lock in the
  background, we pick one of:
  - enforce a **15-minute minimum unlock** in settings (`unlockDurationSeconds`), or
  - switch to a **`DeviceActivityEvent` usage threshold** that re-shields in
    `eventDidReachThreshold`.

Report which cases re-lock and we'll finalize Part B accordingly.

### Other checks
- Confirm `gateLog` output no longer appears in a **release** build's console (it's `#if DEBUG`).
- Confirm previously-silent failures now log in debug (P1).
```
