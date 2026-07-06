package com.ayaunlock.aya_unlock.services

import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Process
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Handles method channel calls from Flutter for app gating.
 * Bridges Flutter requests to [AppDetectionService].
 */
class GateMethodChannel(
    private val context: Context,
    flutterEngine: FlutterEngine
) : MethodChannel.MethodCallHandler {

    private val methodChannel = MethodChannel(
        flutterEngine.dartExecutor.binaryMessenger,
        "com.ayaunlock/gate"
    )

    private val eventChannel = EventChannel(
        flutterEngine.dartExecutor.binaryMessenger,
        "com.ayaunlock/gate_events"
    )

    private var eventSink: EventChannel.EventSink? = null

    init {
        methodChannel.setMethodCallHandler(this)

        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                AppDetectionService.onGatedAppDetected = { packageName ->
                    events?.success(packageName)
                }
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
                AppDetectionService.onGatedAppDetected = null
            }
        })
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hasPermissions" -> {
                result.success(hasUsageStatsPermission() && hasOverlayPermission())
            }

            "requestPermissions" -> {
                // We can only open the settings screens — user must grant manually
                if (!hasUsageStatsPermission()) {
                    val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS).apply {
                        flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    }
                    context.startActivity(intent)
                } else if (!hasOverlayPermission()) {
                    val intent = Intent(
                        Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        android.net.Uri.parse("package:${context.packageName}")
                    ).apply {
                        flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    }
                    context.startActivity(intent)
                }
                result.success(hasUsageStatsPermission() && hasOverlayPermission())
            }

            "startGating" -> {
                val packageNames = call.argument<List<String>>("packageNames") ?: emptyList()
                val intent = Intent(context, AppDetectionService::class.java).apply {
                    action = "START"
                    putStringArrayListExtra("packages", ArrayList(packageNames))
                }
                context.startForegroundService(intent)
                result.success(null)
            }

            "stopGating" -> {
                val intent = Intent(context, AppDetectionService::class.java).apply {
                    action = "STOP"
                }
                context.startService(intent)
                result.success(null)
            }

            "grantTemporaryUnlock" -> {
                val packageName = call.argument<String>("packageName") ?: ""
                val durationSeconds = call.argument<Int>("durationSeconds") ?: 600
                val intent = Intent(context, AppDetectionService::class.java).apply {
                    action = "UNLOCK"
                    putExtra("package", packageName)
                    putExtra("durationSeconds", durationSeconds)
                }
                context.startService(intent)
                result.success(null)
            }

            "revokeUnlock" -> {
                val packageName = call.argument<String>("packageName") ?: ""
                val intent = Intent(context, AppDetectionService::class.java).apply {
                    action = "REVOKE"
                    putExtra("package", packageName)
                }
                context.startService(intent)
                result.success(null)
            }

            "isRunning" -> {
                // Check if service is running via shared prefs
                val prefs = context.getSharedPreferences("aya_unlock_gating", Context.MODE_PRIVATE)
                result.success(prefs.getBoolean("is_active", false))
            }

            else -> result.notImplemented()
        }
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.unsafeCheckOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            Process.myUid(),
            context.packageName
        )
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun hasOverlayPermission(): Boolean {
        return Settings.canDrawOverlays(context)
    }

    fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }
}
