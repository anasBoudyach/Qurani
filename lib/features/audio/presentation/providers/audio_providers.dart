import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/models/reciter.dart';
import '../../data/repositories/audio_repository.dart';
import '../../data/services/audio_player_service.dart';
import '../../data/services/download_service.dart';

/// Singleton audio player service.
final audioPlayerServiceProvider = Provider<AudioPlayerService>((ref) {
  final service = AudioPlayerService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Bridges the audio service stream to Riverpod state.
/// Sets state directly — rebuild efficiency is handled by `.select()`
/// at the widget level, so no post-frame deferral is needed.
class _AudioStateNotifier extends StateNotifier<AudioPlayerState> {
  late final StreamSubscription<AudioPlayerState> _subscription;

  _AudioStateNotifier(AudioPlayerService service) : super(service.state) {
    _subscription = service.stateStream.listen((newState) {
      if (mounted) state = newState;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Current audio player state (synchronous, lifecycle-safe).
final currentAudioStateProvider =
    StateNotifierProvider<_AudioStateNotifier, AudioPlayerState>((ref) {
  final service = ref.watch(audioPlayerServiceProvider);
  return _AudioStateNotifier(service);
});

/// Audio repository provider.
final audioRepositoryProvider = Provider<AudioRepository>((ref) {
  return AudioRepository(apiClient: ref.watch(apiClientProvider));
});

/// All reciters from MP3Quran API.
final recitersProvider =
    FutureProvider.family<List<ReciterModel>, String>((ref, language) async {
  final repo = ref.watch(audioRepositoryProvider);
  return repo.getReciters(language: language);
});

/// Default reciters list (English).
final defaultRecitersProvider =
    FutureProvider<List<ReciterModel>>((ref) async {
  final repo = ref.watch(audioRepositoryProvider);
  return repo.getReciters();
});

/// Download service provider.
final downloadServiceProvider = Provider<DownloadService>((ref) {
  final db = ref.watch(databaseProvider);
  return DownloadService(db: db);
});

/// All downloaded audio files.
final allDownloadsProvider =
    FutureProvider<List<DownloadedAudioData>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllDownloads();
});

/// Downloads for a specific reciter.
final reciterDownloadsProvider =
    FutureProvider.family<List<DownloadedAudioData>, int>(
        (ref, reciterId) async {
  final db = ref.watch(databaseProvider);
  return db.getDownloadsForReciter(reciterId);
});

/// Check if a specific surah is downloaded for a reciter.
final isDownloadedProvider =
    FutureProvider.family<bool, ({int reciterId, int surahId})>(
        (ref, params) async {
  final db = ref.watch(databaseProvider);
  return db.isAudioDownloaded(params.reciterId, params.surahId);
});

/// Total download size in bytes.
final totalDownloadSizeProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getTotalDownloadSize();
});
