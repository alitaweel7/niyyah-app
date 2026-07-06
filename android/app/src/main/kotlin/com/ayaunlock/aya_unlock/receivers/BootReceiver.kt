package com.ayaunlock.aya_unlock.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.ayaunlock.aya_unlock.services.AppDetectionService

/**
 * Restarts the [AppDetectionService] after device boot if gating was active.
 */
class BootReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "BootReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return

        val prefs = context.getSharedPreferences("aya_unlock_gating", Context.MODE_PRIVATE)
        val gatedPackages = prefs.getStringSet("gated_packages", emptySet()) ?: emptySet()

        if (gatedPackages.isEmpty()) {
            Log.d(TAG, "No gated apps configured, skipping service restart")
            return
        }

        Log.d(TAG, "Restarting gating service for ${gatedPackages.size} apps")

        val serviceIntent = Intent(context, AppDetectionService::class.java).apply {
            action = "START"
            putStringArrayListExtra("packages", ArrayList(gatedPackages))
        }
        context.startForegroundService(serviceIntent)
    }
}
