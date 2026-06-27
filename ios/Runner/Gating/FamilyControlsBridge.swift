import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

/// Debug-only logging — compiled out of release builds.
private func gateLog(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
}

/// Bridges Flutter method channel calls to iOS FamilyControls/ManagedSettings APIs.
///
/// Key behaviors:
/// - Authorization: requests Screen Time permission via AuthorizationCenter
/// - Shielding: adds/removes shields on selected apps via ManagedSettingsStore
/// - Persistence: stores selected app tokens in UserDefaults for recovery
///
/// IMPORTANT: The FamilyControls Distribution Entitlement must be approved by Apple.
@available(iOS 16.0, *)
class FamilyControlsBridge: NSObject {

    static let shared = FamilyControlsBridge()

    private let store = ManagedSettingsStore()
    private let center = DeviceActivityCenter()
    private let tokenStorageKey = "shielded_app_tokens"

    /// App Group container shared with the Shield and DeviceActivityMonitor
    /// extensions. Tokens must live here (not in `.standard`) so the monitor
    /// extension can read them and re-apply shields when an unlock expires.
    private let appGroupId = "group.com.ayaunlock.shared"
    private var sharedDefaults: UserDefaults? { UserDefaults(suiteName: appGroupId) }

    /// Currently shielded app tokens (opaque — we cannot see the actual app identifiers)
    private var shieldedApps = Set<ApplicationToken>()

    override init() {
        super.init()
        // Restore previously saved tokens on launch
        restoreShieldsFromStorage()
    }

    /// Check if FamilyControls authorization has been granted
    var hasAuthorization: Bool {
        return AuthorizationCenter.shared.authorizationStatus == .approved
    }

    /// Request FamilyControls authorization from the user
    func requestAuthorization() async -> Bool {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            return AuthorizationCenter.shared.authorizationStatus == .approved
        } catch {
            gateLog("FamilyControlsBridge: Authorization failed: \(error)")
            return false
        }
    }

    /// Apply shields to the currently selected apps.
    func applyShields(tokens: Set<ApplicationToken>) {
        shieldedApps = tokens
        store.shield.applications = tokens.isEmpty ? nil : tokens
        store.shield.applicationCategories = nil
        saveTokensToStorage()
        gateLog("FamilyControlsBridge: Applied shields to \(tokens.count) apps")
    }

    /// Apply shields from the FamilyActivitySelection (contains both apps and categories)
    func applySelectionShields(selection: FamilyActivitySelection) {
        let appTokens = selection.applicationTokens
        let categoryTokens = selection.categoryTokens

        shieldedApps = appTokens

        store.shield.applications = appTokens.isEmpty ? nil : appTokens
        store.shield.applicationCategories = categoryTokens.isEmpty
            ? nil
            : ShieldSettings.ActivityCategoryPolicy<Application>.specific(categoryTokens)

        saveTokensToStorage()
        gateLog("FamilyControlsBridge: Applied shields — \(appTokens.count) apps, \(categoryTokens.count) categories")
    }

    /// Remove all shields (temporary unlock for all)
    func removeAllShields() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        gateLog("FamilyControlsBridge: All shields temporarily removed")
    }

    /// Re-apply shields from stored tokens (after unlock expires or app restart)
    func reapplyShields() {
        if !shieldedApps.isEmpty {
            store.shield.applications = shieldedApps
            gateLog("FamilyControlsBridge: Re-applied shields for \(shieldedApps.count) apps")
        }
    }

    /// Clear all shields and stored data (stop gating entirely)
    func clearAllShieldsAndData() {
        shieldedApps.removeAll()
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        center.stopMonitoring()
        clearTokenStorage()
        gateLog("FamilyControlsBridge: All shields and data cleared")
    }

    /// Schedule re-shielding after a duration using DeviceActivityCenter
    func scheduleReshield(after seconds: Int, name: String) {
        let calendar = Calendar.current
        let now = Date()
        let endDate = now.addingTimeInterval(TimeInterval(seconds))

        let startComponents = calendar.dateComponents(
            [.hour, .minute, .second],
            from: now
        )
        let endComponents = calendar.dateComponents(
            [.hour, .minute, .second],
            from: endDate
        )

        let schedule = DeviceActivitySchedule(
            intervalStart: startComponents,
            intervalEnd: endComponents,
            repeats: false
        )

        let activityName = DeviceActivityName(name)

        // Stop any existing monitoring first
        center.stopMonitoring([activityName])

        do {
            try center.startMonitoring(activityName, during: schedule)
            gateLog("FamilyControlsBridge: Scheduled re-shield '\(name)' in \(seconds)s (from \(startComponents.hour!):\(startComponents.minute!) to \(endComponents.hour!):\(endComponents.minute!))")
        } catch {
            gateLog("FamilyControlsBridge: Failed to schedule via DeviceActivity: \(error)")
            // Fallback: use a background task to re-apply shields
            scheduleBackgroundReshield(after: seconds)
        }
    }

    /// Fallback re-shield using a background-safe approach
    private func scheduleBackgroundReshield(after seconds: Int) {
        // Store the re-shield time so it can be checked on app launch
        let reshieldTime = Date().addingTimeInterval(TimeInterval(seconds))
        UserDefaults.standard.set(reshieldTime.timeIntervalSince1970, forKey: "reshield_at")

        // Also try DispatchQueue (works while app is in foreground)
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(seconds)) { [weak self] in
            self?.reapplyShields()
            UserDefaults.standard.removeObject(forKey: "reshield_at")
        }
        gateLog("FamilyControlsBridge: Fallback re-shield scheduled in \(seconds)s")
    }

    /// Check if a pending re-shield time has passed (call on app launch/resume)
    func checkPendingReshield() {
        guard let reshieldAt = UserDefaults.standard.object(forKey: "reshield_at") as? Double else {
            return
        }
        if Date().timeIntervalSince1970 >= reshieldAt {
            reapplyShields()
            UserDefaults.standard.removeObject(forKey: "reshield_at")
            gateLog("FamilyControlsBridge: Applied pending re-shield")
        }
    }

    /// Stop all monitoring schedules
    func stopAllMonitoring() {
        center.stopMonitoring()
        gateLog("FamilyControlsBridge: Stopped all monitoring")
    }

    // MARK: - Token Persistence

    private func saveTokensToStorage() {
        do {
            let data = try JSONEncoder().encode(shieldedApps)
            // Persist into the App Group so the DeviceActivityMonitor extension
            // can read the tokens and re-apply shields when an unlock expires.
            (sharedDefaults ?? UserDefaults.standard).set(data, forKey: tokenStorageKey)
        } catch {
            gateLog("FamilyControlsBridge: Failed to save tokens: \(error)")
        }
    }

    private func restoreShieldsFromStorage() {
        // Prefer the App Group container; fall back to standard defaults so tokens
        // saved by older builds are migrated forward on first launch.
        let storedData = sharedDefaults?.data(forKey: tokenStorageKey)
            ?? UserDefaults.standard.data(forKey: tokenStorageKey)
        guard let data = storedData,
              let tokens = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data),
              !tokens.isEmpty else {
            return
        }
        shieldedApps = tokens
        // Migrate legacy tokens into the App Group container if they were only
        // present in standard defaults.
        if sharedDefaults?.data(forKey: tokenStorageKey) == nil {
            saveTokensToStorage()
        }
        // Re-apply shields if we have authorization
        if hasAuthorization {
            store.shield.applications = tokens
            gateLog("FamilyControlsBridge: Restored shields for \(tokens.count) apps from storage")
        }
    }

    private func clearTokenStorage() {
        sharedDefaults?.removeObject(forKey: tokenStorageKey)
        UserDefaults.standard.removeObject(forKey: tokenStorageKey)
    }
}
