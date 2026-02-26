package com.qurani.qurani

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.support.v4.media.MediaMetadataCompat
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.media.app.NotificationCompat.MediaStyle
import io.flutter.plugin.common.MethodChannel

/**
 * Custom media notification service using MediaSessionCompat directly.
 * Avoids MediaBrowserServiceCompat which crashes on OEM skins (ColorOS, OxygenOS, MIUI).
 * All operations wrapped in try-catch for graceful degradation.
 */
class MediaNotificationService(private val context: Context) {

    companion object {
        private const val TAG = "MediaNotification"
        private const val CHANNEL_ID = "qurani_audio"
        private const val NOTIFICATION_ID = 1001
        private const val ACTION_PLAY = "com.qurani.qurani.ACTION_PLAY"
        private const val ACTION_PAUSE = "com.qurani.qurani.ACTION_PAUSE"
        private const val ACTION_NEXT = "com.qurani.qurani.ACTION_NEXT"
        private const val ACTION_PREV = "com.qurani.qurani.ACTION_PREV"
        private const val ACTION_STOP = "com.qurani.qurani.ACTION_STOP"
    }

    private var mediaSession: MediaSessionCompat? = null
    private var notificationManager: NotificationManager? = null
    private var flutterChannel: MethodChannel? = null
    private var isAvailable = false

    private var currentTitle = ""
    private var currentArtist = ""
    private var currentIsPlaying = false

    fun init(channel: MethodChannel) {
        flutterChannel = channel
        try {
            notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            createNotificationChannel()
            createMediaSession()
            isAvailable = true
            Log.d(TAG, "Media notification service initialized successfully")
        } catch (e: Exception) {
            isAvailable = false
            Log.w(TAG, "Media notification not available on this device: ${e.message}")
        }
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannel(
            CHANNEL_ID,
            "Audio Playback",
            NotificationManager.IMPORTANCE_LOW
        ).apply {
            description = "Quran audio playback controls"
            setShowBadge(false)
        }
        notificationManager?.createNotificationChannel(channel)
    }

    private fun createMediaSession() {
        mediaSession = MediaSessionCompat(context, "QuraniFplayer").apply {
            setCallback(object : MediaSessionCompat.Callback() {
                override fun onPlay() {
                    flutterChannel?.invokeMethod("onPlay", null)
                }

                override fun onPause() {
                    flutterChannel?.invokeMethod("onPause", null)
                }

                override fun onSkipToNext() {
                    flutterChannel?.invokeMethod("onSkipNext", null)
                }

                override fun onSkipToPrevious() {
                    flutterChannel?.invokeMethod("onSkipPrevious", null)
                }

                override fun onStop() {
                    flutterChannel?.invokeMethod("onStop", null)
                }
            })
            isActive = true
        }
    }

    /** Called from MainActivity when a notification action broadcast is received. */
    fun handleAction(action: String) {
        val callback = mediaSession?.controller?.transportControls ?: return
        when (action) {
            ACTION_PLAY -> callback.play()
            ACTION_PAUSE -> callback.pause()
            ACTION_NEXT -> callback.skipToNext()
            ACTION_PREV -> callback.skipToPrevious()
            ACTION_STOP -> callback.stop()
        }
    }

    fun updateTrack(title: String, artist: String) {
        if (!isAvailable) return
        try {
            currentTitle = title
            currentArtist = artist
            mediaSession?.setMetadata(
                MediaMetadataCompat.Builder()
                    .putString(MediaMetadataCompat.METADATA_KEY_TITLE, title)
                    .putString(MediaMetadataCompat.METADATA_KEY_ARTIST, artist)
                    .putString(MediaMetadataCompat.METADATA_KEY_ALBUM, "Qurani")
                    .build()
            )
            showNotification()
        } catch (e: Exception) {
            Log.w(TAG, "Failed to update track: ${e.message}")
        }
    }

    fun updatePlaybackState(isPlaying: Boolean, positionMs: Long, durationMs: Long) {
        if (!isAvailable) return
        try {
            currentIsPlaying = isPlaying
            val state = if (isPlaying) PlaybackStateCompat.STATE_PLAYING else PlaybackStateCompat.STATE_PAUSED
            val actions = PlaybackStateCompat.ACTION_PLAY or
                    PlaybackStateCompat.ACTION_PAUSE or
                    PlaybackStateCompat.ACTION_PLAY_PAUSE or
                    PlaybackStateCompat.ACTION_SKIP_TO_NEXT or
                    PlaybackStateCompat.ACTION_SKIP_TO_PREVIOUS or
                    PlaybackStateCompat.ACTION_STOP

            mediaSession?.setPlaybackState(
                PlaybackStateCompat.Builder()
                    .setState(state, positionMs, if (isPlaying) 1.0f else 0f)
                    .setActions(actions)
                    .build()
            )
            showNotification()
        } catch (e: Exception) {
            Log.w(TAG, "Failed to update playback state: ${e.message}")
        }
    }

    private fun showNotification() {
        if (!isAvailable || currentTitle.isEmpty()) return
        try {
            val sessionToken = mediaSession?.sessionToken ?: return

            val contentIntent = PendingIntent.getActivity(
                context, 0,
                Intent(context, MainActivity::class.java),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            val builder = NotificationCompat.Builder(context, CHANNEL_ID)
                .setContentTitle(currentTitle)
                .setContentText(currentArtist)
                .setSmallIcon(R.drawable.ic_notification)
                .setContentIntent(contentIntent)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setOngoing(currentIsPlaying)
                .setDeleteIntent(actionPendingIntent(ACTION_STOP, 4))
                .setStyle(
                    MediaStyle()
                        .setMediaSession(sessionToken)
                        .setShowActionsInCompactView(0, 1, 2)
                )
                .addAction(
                    android.R.drawable.ic_media_previous, "Previous",
                    actionPendingIntent(ACTION_PREV, 1)
                )

            if (currentIsPlaying) {
                builder.addAction(
                    android.R.drawable.ic_media_pause, "Pause",
                    actionPendingIntent(ACTION_PAUSE, 2)
                )
            } else {
                builder.addAction(
                    android.R.drawable.ic_media_play, "Play",
                    actionPendingIntent(ACTION_PLAY, 2)
                )
            }

            builder.addAction(
                android.R.drawable.ic_media_next, "Next",
                actionPendingIntent(ACTION_NEXT, 3)
            )

            notificationManager?.notify(NOTIFICATION_ID, builder.build())
        } catch (e: Exception) {
            Log.w(TAG, "Failed to show notification: ${e.message}")
        }
    }

    private fun actionPendingIntent(action: String, requestCode: Int): PendingIntent {
        val intent = Intent(context, MediaActionReceiver::class.java).apply {
            this.action = action
        }
        return PendingIntent.getBroadcast(
            context, requestCode, intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    fun dismiss() {
        try {
            notificationManager?.cancel(NOTIFICATION_ID)
        } catch (e: Exception) {
            Log.w(TAG, "Failed to dismiss notification: ${e.message}")
        }
    }

    fun release() {
        try {
            dismiss()
            mediaSession?.isActive = false
            mediaSession?.release()
            mediaSession = null
            isAvailable = false
        } catch (e: Exception) {
            Log.w(TAG, "Failed to release media session: ${e.message}")
        }
    }
}
