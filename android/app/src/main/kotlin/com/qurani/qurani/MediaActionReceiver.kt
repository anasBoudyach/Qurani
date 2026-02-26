package com.qurani.qurani

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

/**
 * Receives notification button taps and forwards them to MediaNotificationService.
 */
class MediaActionReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "MediaActionReceiver"
        var mediaService: MediaNotificationService? = null
    }

    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action ?: return
        try {
            mediaService?.handleAction(action)
        } catch (e: Exception) {
            Log.w(TAG, "Failed to handle media action: ${e.message}")
        }
    }
}
