package com.ayaunlock.aya_unlock

import com.ayaunlock.aya_unlock.services.GateMethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    private var gateMethodChannel: GateMethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        gateMethodChannel = GateMethodChannel(this, flutterEngine)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        gateMethodChannel?.dispose()
        gateMethodChannel = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
