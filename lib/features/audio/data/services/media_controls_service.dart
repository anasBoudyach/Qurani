import 'package:flutter/services.dart';

import 'audio_player_service.dart';

/// Bridges audio playback state to native Android media notification controls.
///
/// Uses a platform channel to communicate with [MediaNotificationService] in Kotlin.
/// If the native side fails (OEM compatibility issues), audio keeps playing normally.
class MediaControlsService {
  static const _channel = MethodChannel('com.qurani.qurani/media');

  AudioPlayerService? _playerService;

  void attach(AudioPlayerService playerService) {
    _playerService = playerService;
    _channel.setMethodCallHandler(_handleNativeCommand);
  }

  /// Send track info to the native notification.
  Future<void> updateTrack(String title, String artist) async {
    try {
      await _channel.invokeMethod('updateTrack', {
        'title': title,
        'artist': artist,
      });
    } catch (_) {}
  }

  /// Send playback state to the native notification.
  Future<void> updatePlaybackState({
    required bool isPlaying,
    required Duration position,
    required Duration duration,
  }) async {
    try {
      await _channel.invokeMethod('updateState', {
        'isPlaying': isPlaying,
        'positionMs': position.inMilliseconds,
        'durationMs': duration.inMilliseconds,
      });
    } catch (_) {}
  }

  /// Dismiss the notification.
  Future<void> dismiss() async {
    try {
      await _channel.invokeMethod('dismiss');
    } catch (_) {}
  }

  /// Handle commands from notification buttons (play/pause/skip).
  Future<dynamic> _handleNativeCommand(MethodCall call) async {
    final player = _playerService;
    if (player == null) return;

    switch (call.method) {
      case 'onPlay':
        await player.play();
      case 'onPause':
        await player.pause();
      case 'onSkipNext':
        await player.skipNext();
      case 'onSkipPrevious':
        await player.skipPrevious();
      case 'onStop':
        await player.stop();
    }
  }
}
