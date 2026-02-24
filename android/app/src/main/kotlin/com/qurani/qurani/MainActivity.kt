package com.qurani.qurani

import android.content.Intent
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceActivity() {
    private val CHANNEL = "com.qurani.qurani/widget"
    private var pendingRoute: String? = null
    private var channel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Capture initial intent route from widget tap
        pendingRoute = intent?.getStringExtra("navigate_to")

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel!!.setMethodCallHandler { call, result ->
            if (call.method == "getNavigateRoute") {
                val route = pendingRoute
                pendingRoute = null
                result.success(route)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val route = intent.getStringExtra("navigate_to")
        if (route != null) {
            pendingRoute = route
            // Push route to Flutter immediately when app is already running
            channel?.invokeMethod("navigateTo", route)
        }
    }
}
