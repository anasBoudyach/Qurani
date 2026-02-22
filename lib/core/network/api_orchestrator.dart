import 'package:dio/dio.dart';
import 'api_client.dart';

/// Orchestrates API calls with fallback between multiple sources.
///
/// Flow: Local DB -> Quran.com -> Al Quran Cloud
class ApiOrchestrator {
  final ApiClient _apiClient;

  /// Expose the shared ApiClient for direct access when needed.
  ApiClient get client => _apiClient;

  ApiOrchestrator(this._apiClient);

  /// Fetch Quran text with tajweed from primary API, falling back to secondary.
  Future<Response> fetchQuranText({
    required int surahNumber,
    String? edition,
  }) async {
    // Try Quran.com first
    try {
      return await _apiClient.quranComDio.get(
        '/quran/verses/uthmani_tajweed',
        queryParameters: {
          'chapter_number': surahNumber,
        },
      );
    } on DioException {
      // Fallback to Al Quran Cloud
      final editionName = edition ?? 'quran-tajweed';
      return await _apiClient.alQuranCloudDio.get(
        '/surah/$surahNumber/$editionName',
      );
    }
  }

  /// Fetch translations with fallback.
  Future<Response> fetchTranslation({
    required int surahNumber,
    required int translationId,
  }) async {
    try {
      final response = await _apiClient.quranComDio.get(
        '/quran/translations/$translationId',
        queryParameters: {
          'chapter_number': surahNumber,
          'per_page': 300,
        },
      );
      // Verify response actually has translations
      final data = response.data;
      if (data is Map &&
          data.containsKey('translations') &&
          (data['translations'] as List).isNotEmpty) {
        return response;
      }
      throw Exception('Empty translations response');
    } catch (_) {
      // Fallback to Al Quran Cloud
      return await _apiClient.alQuranCloudDio.get(
        '/surah/$surahNumber/en.asad',
      );
    }
  }

  /// Fetch reciters list from MP3Quran (largest collection).
  Future<Response> fetchReciters({String language = 'eng'}) async {
    return await _apiClient.mp3QuranDio.get(
      '/reciters',
      queryParameters: {'language': language},
    );
  }

  /// Fetch tafsir from QuranHub (156+ editions).
  Future<Response> fetchTafsir({
    required int surahNumber,
    required int ayahNumber,
    String? tafsirEdition,
  }) async {
    try {
      return await _apiClient.quranHubDio.get(
        '/tafsirs/${tafsirEdition ?? 'ibn-kathir'}/ayah/$surahNumber:$ayahNumber',
      );
    } on DioException {
      // Fallback to Quran.com tafsir
      return await _apiClient.quranComDio.get(
        '/quran/tafsirs/${tafsirEdition ?? '169'}',
        queryParameters: {
          'chapter_number': surahNumber,
          'verse_number': ayahNumber,
        },
      );
    }
  }
}
