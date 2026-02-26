import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../../../quran/data/models/surah_info.dart';
import 'media_controls_service.dart';

/// Repeat mode for audio playback.
enum AudioRepeatMode {
  none,
  ayah,    // Repeat current ayah
  range,   // Repeat a range of ayahs
  surah,   // Repeat entire surah
}

/// State of the audio player.
class AudioPlayerState {
  final bool isPlaying;
  final bool isLoading;
  final bool isBuffering;
  final Duration position;
  final Duration duration;
  final int? currentSurah;
  final int? currentAyah;
  final int? currentReciterId;
  final String? reciterName;
  final String? reciterFolder;
  final int? totalAyahs;
  final String? serverUrl;
  final List<int>? surahList;
  final AudioRepeatMode repeatMode;
  final bool continuousMode;
  final String? error;

  const AudioPlayerState({
    this.isPlaying = false,
    this.isLoading = false,
    this.isBuffering = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.currentSurah,
    this.currentAyah,
    this.currentReciterId,
    this.reciterName,
    this.reciterFolder,
    this.totalAyahs,
    this.serverUrl,
    this.surahList,
    this.repeatMode = AudioRepeatMode.none,
    this.continuousMode = true,
    this.error,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    bool? isLoading,
    bool? isBuffering,
    Duration? position,
    Duration? duration,
    int? currentSurah,
    int? currentAyah,
    int? currentReciterId,
    String? reciterName,
    String? reciterFolder,
    int? totalAyahs,
    String? serverUrl,
    List<int>? surahList,
    AudioRepeatMode? repeatMode,
    bool? continuousMode,
    String? error,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isBuffering: isBuffering ?? this.isBuffering,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentSurah: currentSurah ?? this.currentSurah,
      currentAyah: currentAyah ?? this.currentAyah,
      currentReciterId: currentReciterId ?? this.currentReciterId,
      reciterName: reciterName ?? this.reciterName,
      reciterFolder: reciterFolder ?? this.reciterFolder,
      totalAyahs: totalAyahs ?? this.totalAyahs,
      serverUrl: serverUrl ?? this.serverUrl,
      surahList: surahList ?? this.surahList,
      repeatMode: repeatMode ?? this.repeatMode,
      continuousMode: continuousMode ?? this.continuousMode,
      error: error,
    );
  }

  bool get hasTrack => currentSurah != null;
  bool get isSurahLevel => serverUrl != null;
}

/// Service managing Quran audio playback.
///
/// Supports streaming from multiple sources:
/// - MP3Quran (surah-level, 260+ reciters)
/// - EveryAyah (verse-level, per-reciter CDN)
/// - Local downloads (offline)
class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();
  final _stateController = StreamController<AudioPlayerState>.broadcast();
  final MediaControlsService _mediaControls = MediaControlsService();

  AudioPlayerState _state = const AudioPlayerState();

  AudioPlayerState get state => _state;
  Stream<AudioPlayerState> get stateStream => _stateController.stream;
  AudioPlayer get player => _player;

  AudioPlayerService() {
    _mediaControls.attach(this);
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    // Playing state
    _player.playingStream.listen((playing) {
      _updateState(_state.copyWith(isPlaying: playing));
    });

    // Position
    _player.positionStream.listen((position) {
      _updateState(_state.copyWith(position: position));
    });

    // Duration
    _player.durationStream.listen((duration) {
      if (duration != null) {
        _updateState(_state.copyWith(duration: duration));
      }
    });

    // Processing state (loading/buffering)
    _player.processingStateStream.listen((processingState) {
      _updateState(_state.copyWith(
        isLoading: processingState == ProcessingState.loading,
        isBuffering: processingState == ProcessingState.buffering,
      ));

      // Handle completion
      if (processingState == ProcessingState.completed) {
        _handleCompletion();
      }
    });

    // Player errors
    _player.playbackEventStream.listen(
      (_) {},
      onError: (Object e, StackTrace st) {
        _updateState(_state.copyWith(
          error: e.toString(),
          isPlaying: false,
          isLoading: false,
        ));
      },
    );
  }

  DateTime _lastMediaSync = DateTime(0);

  void _updateState(AudioPlayerState newState) {
    final playStateChanged = _state.isPlaying != newState.isPlaying;
    _state = newState;
    _stateController.add(_state);
    // Throttle notification updates to avoid spamming the platform channel.
    // Always sync immediately on play/pause changes.
    final now = DateTime.now();
    if (playStateChanged || now.difference(_lastMediaSync).inSeconds >= 1) {
      _lastMediaSync = now;
      _syncMediaControls();
    }
  }

  void _syncMediaControls() {
    if (_state.hasTrack) {
      _mediaControls.updatePlaybackState(
        isPlaying: _state.isPlaying,
        position: _state.position,
        duration: _state.duration,
      );
    }
  }

  String _surahName(int surahNumber) {
    return SurahInfo.all
        .firstWhere((s) => s.number == surahNumber,
            orElse: () => SurahInfo.all.first)
        .nameTransliteration;
  }

  /// Play a surah from MP3Quran CDN.
  Future<void> playSurah({
    required int surahNumber,
    required String serverUrl,
    required int reciterId,
    String? reciterName,
    List<int>? surahList,
  }) async {
    try {
      _updateState(_state.copyWith(
        isLoading: true,
        currentSurah: surahNumber,
        currentAyah: 1,
        currentReciterId: reciterId,
        reciterName: reciterName,
        serverUrl: serverUrl,
        surahList: surahList ?? _state.surahList,
        error: null,
      ));

      // MP3Quran URL format: {serverUrl}/{surahNumber padded to 3 digits}.mp3
      final paddedSurah = surahNumber.toString().padLeft(3, '0');
      final url = '$serverUrl$paddedSurah.mp3';

      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      _mediaControls.updateTrack(
        _surahName(surahNumber),
        reciterName ?? 'Qurani',
      );
      await _player.play();
    } catch (e) {
      _updateState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
        isPlaying: false,
      ));
    }
  }

  /// Play a specific ayah from EveryAyah CDN.
  Future<void> playAyah({
    required int surahNumber,
    required int ayahNumber,
    String reciterFolder = 'Alafasy_128kbps',
    String? reciterName,
    int? totalAyahs,
  }) async {
    try {
      _updateState(_state.copyWith(
        isLoading: true,
        currentSurah: surahNumber,
        currentAyah: ayahNumber,
        reciterName: reciterName ?? 'Mishary Alafasy',
        reciterFolder: reciterFolder,
        totalAyahs: totalAyahs,
        error: null,
      ));

      // EveryAyah URL format: {base}/{reciterFolder}/{surah3}{ayah3}.mp3
      final paddedSurah = surahNumber.toString().padLeft(3, '0');
      final paddedAyah = ayahNumber.toString().padLeft(3, '0');
      final url =
          'https://everyayah.com/data/$reciterFolder/$paddedSurah$paddedAyah.mp3';

      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      _mediaControls.updateTrack(
        '${_surahName(surahNumber)} - Ayah $ayahNumber',
        reciterName ?? 'Mishary Alafasy',
      );
      await _player.play();
    } catch (e) {
      _updateState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
        isPlaying: false,
      ));
    }
  }

  /// Play from a local file path (downloaded audio).
  Future<void> playLocal(String filePath, {
    int? surahNumber,
    int? ayahNumber,
    String? reciterName,
    String? serverUrl,
    int? reciterId,
    List<int>? surahList,
  }) async {
    try {
      _updateState(_state.copyWith(
        isLoading: true,
        currentSurah: surahNumber,
        currentAyah: ayahNumber,
        currentReciterId: reciterId,
        reciterName: reciterName,
        serverUrl: serverUrl ?? _state.serverUrl,
        surahList: surahList ?? _state.surahList,
        error: null,
      ));

      await _player.setAudioSource(AudioSource.file(filePath));
      final title = surahNumber != null ? _surahName(surahNumber) : 'Qurani';
      _mediaControls.updateTrack(title, reciterName ?? 'Qurani');
      await _player.play();
    } catch (e) {
      _updateState(_state.copyWith(
        error: e.toString(),
        isLoading: false,
        isPlaying: false,
      ));
    }
  }

  // ─── Playback Controls ───

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();

  Future<void> togglePlayPause() async {
    if (_state.isPlaying) {
      await pause();
    } else {
      // If completed, seek to start before playing
      if (_player.processingState == ProcessingState.completed) {
        await _player.seek(Duration.zero);
      }
      await play();
    }
  }

  Future<void> stop() async {
    await _player.stop();
    _mediaControls.dismiss();
    _updateState(const AudioPlayerState());
  }

  Future<void> seekTo(Duration position) => _player.seek(position);

  Future<void> seekRelative(Duration offset) {
    final newPosition = _state.position + offset;
    final clamped = newPosition < Duration.zero
        ? Duration.zero
        : (newPosition > _state.duration ? _state.duration : newPosition);
    return seekTo(clamped);
  }

  // ─── Continuous Mode ───

  void toggleContinuousMode() {
    _updateState(_state.copyWith(continuousMode: !_state.continuousMode));
  }

  // ─── Repeat Mode ───

  void setRepeatMode(AudioRepeatMode mode) {
    _updateState(_state.copyWith(repeatMode: mode));

    switch (mode) {
      case AudioRepeatMode.none:
      case AudioRepeatMode.range:
      case AudioRepeatMode.surah:
        // surah repeat is handled in _handleCompletion, not by just_audio
        _player.setLoopMode(LoopMode.off);
      case AudioRepeatMode.ayah:
        _player.setLoopMode(LoopMode.one);
    }
  }

  /// Cycle through all playback modes in one button:
  /// Single → Continuous → Repeat Surah → Repeat Ayah → Single
  void cyclePlaybackMode() {
    if (_state.repeatMode == AudioRepeatMode.ayah) {
      // Repeat ayah → Single (stop after current)
      setRepeatMode(AudioRepeatMode.none);
      _updateState(_state.copyWith(continuousMode: false));
    } else if (_state.repeatMode == AudioRepeatMode.surah) {
      // Repeat surah → Repeat ayah
      setRepeatMode(AudioRepeatMode.ayah);
      _updateState(_state.copyWith(continuousMode: false));
    } else if (_state.continuousMode) {
      // Continuous → Repeat surah
      setRepeatMode(AudioRepeatMode.surah);
      _updateState(_state.copyWith(continuousMode: false));
    } else {
      // Single → Continuous
      setRepeatMode(AudioRepeatMode.none);
      _updateState(_state.copyWith(continuousMode: true));
    }
  }

  // ─── Skip Navigation ───

  /// Skip to next track (next surah or next ayah depending on mode).
  Future<void> skipNext() async {
    if (_state.isSurahLevel) {
      _skipToNextSurah();
    } else if (_state.reciterFolder != null &&
        _state.currentSurah != null &&
        _state.currentAyah != null) {
      final nextAyah = _state.currentAyah! + 1;
      final maxAyahs = _state.totalAyahs ?? 999;
      if (nextAyah <= maxAyahs) {
        await playAyah(
          surahNumber: _state.currentSurah!,
          ayahNumber: nextAyah,
          reciterFolder: _state.reciterFolder!,
          reciterName: _state.reciterName,
          totalAyahs: _state.totalAyahs,
        );
      }
    }
  }

  /// Skip to previous track. If > 3s in, restart current instead.
  Future<void> skipPrevious() async {
    if (_state.position > const Duration(seconds: 3)) {
      await seekTo(Duration.zero);
      return;
    }

    if (_state.isSurahLevel) {
      _skipToPreviousSurah();
    } else if (_state.reciterFolder != null &&
        _state.currentSurah != null &&
        _state.currentAyah != null) {
      final prevAyah = _state.currentAyah! - 1;
      if (prevAyah >= 1) {
        await playAyah(
          surahNumber: _state.currentSurah!,
          ayahNumber: prevAyah,
          reciterFolder: _state.reciterFolder!,
          reciterName: _state.reciterName,
          totalAyahs: _state.totalAyahs,
        );
      } else {
        await seekTo(Duration.zero);
      }
    }
  }

  void _skipToNextSurah() {
    final surahList = _state.surahList;
    final currentSurah = _state.currentSurah;
    final serverUrl = _state.serverUrl;
    if (surahList == null || currentSurah == null || serverUrl == null) return;

    final idx = surahList.indexOf(currentSurah);
    if (idx < 0 || idx >= surahList.length - 1) return;

    playSurah(
      surahNumber: surahList[idx + 1],
      serverUrl: serverUrl,
      reciterId: _state.currentReciterId ?? 0,
      reciterName: _state.reciterName,
      surahList: surahList,
    );
  }

  void _skipToPreviousSurah() {
    final surahList = _state.surahList;
    final currentSurah = _state.currentSurah;
    final serverUrl = _state.serverUrl;
    if (surahList == null || currentSurah == null || serverUrl == null) return;

    final idx = surahList.indexOf(currentSurah);
    if (idx <= 0) {
      seekTo(Duration.zero);
      return;
    }

    playSurah(
      surahNumber: surahList[idx - 1],
      serverUrl: serverUrl,
      reciterId: _state.currentReciterId ?? 0,
      reciterName: _state.reciterName,
      surahList: surahList,
    );
  }

  // ─── Completion Handling ───

  void _handleCompletion() {
    // Ayah repeat: just_audio LoopMode.one handles it, nothing to do
    if (_state.repeatMode == AudioRepeatMode.ayah) {
      return;
    }

    // Surah repeat
    if (_state.repeatMode == AudioRepeatMode.surah) {
      if (_state.isSurahLevel) {
        // Surah-level: replay same surah file from start
        _player.seek(Duration.zero);
        _player.play();
      } else if (_state.currentSurah != null &&
          _state.currentAyah != null &&
          _state.reciterFolder != null) {
        // Ayah-level: advance to next ayah, wrap to ayah 1 at end
        final nextAyah = _state.currentAyah! + 1;
        final maxAyahs = _state.totalAyahs ?? 999;
        final targetAyah = nextAyah <= maxAyahs ? nextAyah : 1;
        playAyah(
          surahNumber: _state.currentSurah!,
          ayahNumber: targetAyah,
          reciterFolder: _state.reciterFolder!,
          reciterName: _state.reciterName,
          totalAyahs: _state.totalAyahs,
        );
      }
      return;
    }

    // No repeat + no continuous → stop
    if (!_state.continuousMode) {
      _updateState(_state.copyWith(isPlaying: false));
      return;
    }

    // Continuous mode: advance to next track
    // Ayah-level: advance to next ayah
    if (!_state.isSurahLevel &&
        _state.currentSurah != null &&
        _state.currentAyah != null &&
        _state.reciterFolder != null) {
      final nextAyah = _state.currentAyah! + 1;
      final maxAyahs = _state.totalAyahs ?? 999;
      if (nextAyah <= maxAyahs) {
        playAyah(
          surahNumber: _state.currentSurah!,
          ayahNumber: nextAyah,
          reciterFolder: _state.reciterFolder!,
          reciterName: _state.reciterName,
          totalAyahs: _state.totalAyahs,
        );
        return;
      }
    }

    // Surah-level: advance to next surah
    if (_state.isSurahLevel) {
      final surahList = _state.surahList;
      final currentSurah = _state.currentSurah;
      if (surahList != null && currentSurah != null) {
        final idx = surahList.indexOf(currentSurah);
        if (idx >= 0 && idx < surahList.length - 1) {
          _skipToNextSurah();
          return;
        }
      }
    }

    _updateState(_state.copyWith(isPlaying: false));
  }

  // ─── Cleanup ───

  Future<void> dispose() async {
    await _player.dispose();
    await _stateController.close();
  }
}
