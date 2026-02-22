import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../../core/database/app_database.dart';

/// Tracks progress of a single download.
class DownloadProgress {
  final int reciterId;
  final int surahNumber;
  final double progress; // 0.0 - 1.0
  final bool isComplete;
  final String? error;

  const DownloadProgress({
    required this.reciterId,
    required this.surahNumber,
    this.progress = 0.0,
    this.isComplete = false,
    this.error,
  });
}

/// Service for downloading surah audio files from MP3Quran CDN.
class DownloadService {
  final Dio _dio = Dio();
  final AppDatabase _db;

  // Active download cancel tokens
  final Map<String, CancelToken> _cancelTokens = {};

  DownloadService({required AppDatabase db}) : _db = db;

  /// Get the download directory for audio files.
  Future<Directory> get _downloadDir async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(appDir.path, 'audio_downloads'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// Build file path for a downloaded surah.
  Future<String> _filePath(int reciterId, int surahNumber) async {
    final dir = await _downloadDir;
    final paddedSurah = surahNumber.toString().padLeft(3, '0');
    return p.join(dir.path, 'reciter_$reciterId', '$paddedSurah.mp3');
  }

  /// Key for tracking active downloads.
  String _key(int reciterId, int surahNumber) => '$reciterId:$surahNumber';

  /// Download a single surah for a reciter.
  Stream<DownloadProgress> downloadSurah({
    required int reciterId,
    required int surahNumber,
    required String serverUrl,
  }) async* {
    final key = _key(reciterId, surahNumber);

    // Check if already downloaded
    final existing = await _db.getDownload(reciterId, surahNumber);
    if (existing != null && await File(existing.filePath).exists()) {
      yield DownloadProgress(
        reciterId: reciterId,
        surahNumber: surahNumber,
        progress: 1.0,
        isComplete: true,
      );
      return;
    }

    final filePath = await _filePath(reciterId, surahNumber);
    final file = File(filePath);

    // Ensure parent directory exists
    await file.parent.create(recursive: true);

    final paddedSurah = surahNumber.toString().padLeft(3, '0');
    final url = '$serverUrl$paddedSurah.mp3';

    final cancelToken = CancelToken();
    _cancelTokens[key] = cancelToken;

    try {
      yield DownloadProgress(
        reciterId: reciterId,
        surahNumber: surahNumber,
        progress: 0.0,
      );

      await _dio.download(
        url,
        filePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          // Progress is handled via the stream below
        },
      );

      // Get file size
      final fileSize = await file.length();

      // Save to database
      await _db.insertDownload(DownloadedAudioCompanion(
        reciterId: Value(reciterId),
        surahId: Value(surahNumber),
        filePath: Value(filePath),
        fileSize: Value(fileSize),
        downloadedAt: Value(DateTime.now()),
      ));

      _cancelTokens.remove(key);

      yield DownloadProgress(
        reciterId: reciterId,
        surahNumber: surahNumber,
        progress: 1.0,
        isComplete: true,
      );
    } on DioException catch (e) {
      _cancelTokens.remove(key);
      // Clean up partial file
      if (await file.exists()) {
        await file.delete();
      }
      if (e.type == DioExceptionType.cancel) {
        yield DownloadProgress(
          reciterId: reciterId,
          surahNumber: surahNumber,
          error: 'Cancelled',
        );
      } else {
        yield DownloadProgress(
          reciterId: reciterId,
          surahNumber: surahNumber,
          error: e.message ?? 'Download failed',
        );
      }
    } catch (e) {
      _cancelTokens.remove(key);
      if (await file.exists()) {
        await file.delete();
      }
      yield DownloadProgress(
        reciterId: reciterId,
        surahNumber: surahNumber,
        error: e.toString(),
      );
    }
  }

  /// Download a surah with progress callback (simpler API for batch downloads).
  Future<bool> downloadSurahSync({
    required int reciterId,
    required int surahNumber,
    required String serverUrl,
    void Function(double progress)? onProgress,
  }) async {
    final key = _key(reciterId, surahNumber);

    // Check if already downloaded
    final existing = await _db.getDownload(reciterId, surahNumber);
    if (existing != null && await File(existing.filePath).exists()) {
      onProgress?.call(1.0);
      return true;
    }

    final filePath = await _filePath(reciterId, surahNumber);
    final file = File(filePath);
    await file.parent.create(recursive: true);

    final paddedSurah = surahNumber.toString().padLeft(3, '0');
    final url = '$serverUrl$paddedSurah.mp3';

    final cancelToken = CancelToken();
    _cancelTokens[key] = cancelToken;

    try {
      await _dio.download(
        url,
        filePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            onProgress?.call(received / total);
          }
        },
      );

      final fileSize = await file.length();
      await _db.insertDownload(DownloadedAudioCompanion(
        reciterId: Value(reciterId),
        surahId: Value(surahNumber),
        filePath: Value(filePath),
        fileSize: Value(fileSize),
        downloadedAt: Value(DateTime.now()),
      ));

      _cancelTokens.remove(key);
      return true;
    } catch (e) {
      _cancelTokens.remove(key);
      if (await file.exists()) {
        await file.delete();
      }
      return false;
    }
  }

  /// Cancel a specific download.
  void cancelDownload(int reciterId, int surahNumber) {
    final key = _key(reciterId, surahNumber);
    _cancelTokens[key]?.cancel();
    _cancelTokens.remove(key);
  }

  /// Cancel all active downloads.
  void cancelAll() {
    for (final token in _cancelTokens.values) {
      token.cancel();
    }
    _cancelTokens.clear();
  }

  /// Delete a downloaded surah file and DB record.
  Future<void> deleteDownload(DownloadedAudioData download) async {
    final file = File(download.filePath);
    if (await file.exists()) {
      await file.delete();
    }
    await _db.deleteDownload(download.id);

    // Clean up empty reciter directory
    final dir = file.parent;
    if (await dir.exists()) {
      final remaining = await dir.list().length;
      if (remaining == 0) {
        await dir.delete();
      }
    }
  }

  /// Delete all downloads for a reciter.
  Future<void> deleteReciterDownloads(int reciterId) async {
    final downloads = await _db.getDownloadsForReciter(reciterId);
    for (final d in downloads) {
      final file = File(d.filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await _db.deleteDownloadsForReciter(reciterId);

    // Clean up reciter directory
    final dir = await _downloadDir;
    final reciterDir = Directory(p.join(dir.path, 'reciter_$reciterId'));
    if (await reciterDir.exists()) {
      await reciterDir.delete(recursive: true);
    }
  }

  /// Get the local file path if a surah is downloaded, null otherwise.
  Future<String?> getLocalPath(int reciterId, int surahNumber) async {
    final download = await _db.getDownload(reciterId, surahNumber);
    if (download == null) return null;
    final file = File(download.filePath);
    if (await file.exists()) return download.filePath;
    // File missing, clean up stale record
    await _db.deleteDownload(download.id);
    return null;
  }

  /// Check if there are any active downloads.
  bool get hasActiveDownloads => _cancelTokens.isNotEmpty;
}
