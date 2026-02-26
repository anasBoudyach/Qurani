package com.qurani.qurani

import android.content.Intent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val WIDGET_CHANNEL = "com.qurani.qurani/widget"
    private val MEDIA_CHANNEL = "com.qurani.qurani/media"
    private var pendingRoute: String? = null
    private var widgetChannel: MethodChannel? = null
    private var mediaChannel: MethodChannel? = null
    private var mediaService: MediaNotificationService? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Capture initial intent route from widget tap
        pendingRoute = intent?.getStringExtra("navigate_to")

        // Widget navigation channel
        widgetChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WIDGET_CHANNEL)
        widgetChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "getNavigateRoute") {
                val route = pendingRoute
                pendingRoute = null
                result.success(route)
            } else {
                result.notImplemented()
            }
        }

        // Media notification channel
        mediaChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MEDIA_CHANNEL)
        try {
            mediaService = MediaNotificationService(this)
            mediaService!!.init(mediaChannel!!)
            MediaActionReceiver.mediaService = mediaService
        } catch (e: Exception) {
            Log.w("MainActivity", "Failed to init media notification: ${e.message}")
        }

        mediaChannel!!.setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "updateTrack" -> {
                        val title = call.argument<String>("title") ?: ""
                        val artist = call.argument<String>("artist") ?: ""
                        mediaService?.updateTrack(title, artist)
                        result.success(null)
                    }
                    "updateState" -> {
                        val isPlaying = call.argument<Boolean>("isPlaying") ?: false
                        val positionMs = call.argument<Number>("positionMs")?.toLong() ?: 0L
                        val durationMs = call.argument<Number>("durationMs")?.toLong() ?: 0L
                        mediaService?.updatePlaybackState(isPlaying, positionMs, durationMs)
                        result.success(null)
                    }
                    "dismiss" -> {
                        mediaService?.dismiss()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            } catch (e: Exception) {
                Log.w("MainActivity", "Media channel error: ${e.message}")
                result.success(null)
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val route = intent.getStringExtra("navigate_to")
        if (route != null) {
            pendingRoute = route
            widgetChannel?.invokeMethod("navigateTo", route)
        }
    }

    override fun onDestroy() {
        mediaService?.release()
        MediaActionReceiver.mediaService = null
        super.onDestroy()
    }
}
