package com.ayaunlock.aya_unlock.services

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat

/**
 * Foreground service that polls UsageStatsManager to detect when a gated app
 * is brought to the foreground. When detected, it notifies the Flutter layer
 * via [GateMethodChannel] to show the Quran gate screen.
 */
class AppDetectionService : Service() {

    companion object {
        private const val TAG = "AppDetectionService"
        private const val CHANNEL_ID = "aya_unlock_gating"
        private const val NOTIFICATION_ID = 1001
        private const val POLL_INTERVAL_MS = 2000L

        // Keys for SharedPreferences
        private const val PREFS_NAME = "aya_unlock_gating"
        private const val KEY_GATED_PACKAGES = "gated_packages"
        private const val KEY_UNLOCKED_PACKAGES = "unlocked_packages"
        private const val KEY_IS_ACTIVE = "is_active"

        var onGatedAppDetected: ((String) -> Unit)? = null
    }

    private val handler = Handler(Looper.getMainLooper())
    private var isPolling = false
    private var gatedPackages = setOf<String>()
    private var unlockedPackages = mutableMapOf<String, Long>() // packageName -> expiryTimestamp
    private var lastDetectedPackage: String? = null

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        loadState()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            "START" -> {
                val packages = intent.getStringArrayListExtra("packages") ?: arrayListOf()
                gatedPackages = packages.toSet()
                saveState()
                startForeground(NOTIFICATION_ID, createNotification())
                startPolling()
                Log.d(TAG, "Gating started for ${gatedPackages.size} apps")
            }
            "STOP" -> {
                stopPolling()
                stopForeground(STOP_FOREGROUND_REMOVE)
                stopSelf()
                Log.d(TAG, "Gating stopped")
            }
            "UNLOCK" -> {
                val pkg = intent.getStringExtra("package") ?: return START_STICKY
                val durationSec = intent.getIntExtra("durationSeconds", 600)
                val expiresAt = System.currentTimeMillis() + (durationSec * 1000L)
                unlockedPackages[pkg] = expiresAt
                saveState()
                Log.d(TAG, "Unlocked $pkg for ${durationSec}s")
            }
            "REVOKE" -> {
                val pkg = intent.getStringExtra("package") ?: return START_STICKY
                unlockedPackages.remove(pkg)
                saveState()
                Log.d(TAG, "Revoked unlock for $pkg")
            }
            else -> {
                // Service restarted by system — reload state and resume
                loadState()
                if (gatedPackages.isNotEmpty()) {
                    startForeground(NOTIFICATION_ID, createNotification())
                    startPolling()
                }
            }
        }
        return START_STICKY
    }

    private fun startPolling() {
        if (isPolling) return
        isPolling = true
        handler.post(pollRunnable)
    }

    private fun stopPolling() {
        isPolling = false
        handler.removeCallbacks(pollRunnable)
    }

    private val pollRunnable = object : Runnable {
        override fun run() {
            if (!isPolling) return
            checkForegroundApp()
            handler.postDelayed(this, POLL_INTERVAL_MS)
        }
    }

    private fun checkForegroundApp() {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as? UsageStatsManager
            ?: return

        val now = System.currentTimeMillis()
        val stats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            now - 10_000, // last 10 seconds
            now
        )

        if (stats.isNullOrEmpty()) return

        // Find the most recently used app
        val currentApp = stats.maxByOrNull { it.lastTimeUsed }?.packageName ?: return

        // Skip our own app
        if (currentApp == packageName) {
            lastDetectedPackage = null
            return
        }

        // Check if this is a gated app
        if (currentApp !in gatedPackages) {
            lastDetectedPackage = null
            return
        }

        // Check if it's currently unlocked
        cleanExpiredUnlocks()
        if (currentApp in unlockedPackages) {
            return
        }

        // Avoid triggering multiple times for the same app
        if (currentApp == lastDetectedPackage) return
        lastDetectedPackage = currentApp

        Log.d(TAG, "Gated app detected: $currentApp")
        onGatedAppDetected?.invoke(currentApp)
    }

    private fun cleanExpiredUnlocks() {
        val now = System.currentTimeMillis()
        unlockedPackages.entries.removeAll { it.value < now }
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannel(
            CHANNEL_ID,
            "Niyyah Gating",
            NotificationManager.IMPORTANCE_LOW
        ).apply {
            description = "Monitors app usage for Quran gate"
            setShowBadge(false)
        }
        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(channel)
    }

    private fun createNotification(): Notification {
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Niyyah")
            .setContentText("Gating ${gatedPackages.size} apps — set your niyyah before you scroll")
            .setSmallIcon(android.R.drawable.ic_menu_compass)
            .setOngoing(true)
            .setSilent(true)
            .build()
    }

    private fun saveState() {
        getSharedPreferences(PREFS_NAME, MODE_PRIVATE).edit().apply {
            putStringSet(KEY_GATED_PACKAGES, gatedPackages)
            putBoolean(KEY_IS_ACTIVE, isPolling)
            // Store unlocked packages as "pkg:timestamp" strings
            val unlockStrings = unlockedPackages.map { "${it.key}:${it.value}" }.toSet()
            putStringSet(KEY_UNLOCKED_PACKAGES, unlockStrings)
            apply()
        }
    }

    private fun loadState() {
        val prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
        gatedPackages = prefs.getStringSet(KEY_GATED_PACKAGES, emptySet()) ?: emptySet()
        val unlockStrings = prefs.getStringSet(KEY_UNLOCKED_PACKAGES, emptySet()) ?: emptySet()
        unlockedPackages = unlockStrings.mapNotNull { s ->
            val parts = s.split(":")
            if (parts.size == 2) parts[0] to parts[1].toLongOrNull()
            else null
        }.filter { it.second != null }
            .associate { it.first to it.second!! }
            .toMutableMap()
    }

    override fun onDestroy() {
        stopPolling()
        super.onDestroy()
    }
}
