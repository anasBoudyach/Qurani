import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_orchestrator.dart';

/// Repository for Quran text data with offline-first caching.
///
/// Flow: Check local DB -> If empty, fetch from API -> Cache in DB -> Return.
class QuranRepository {
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');

  final AppDatabase _db;
  final ApiOrchestrator _api;

  QuranRepository({required AppDatabase db, required ApiOrchestrator api})
      : _db = db,
        _api = api;

  /// Get ayahs for a surah, fetching from API if not cached locally.
  Future<List<Ayah>> getAyahsForSurah(int surahNumber) async {
    // Try local DB first
    final local = await _db.getAyahsForSurah(surahNumber);
    if (local.isNotEmpty) return local;

    // Fetch from API and cache
    await _fetchAndCacheSurah(surahNumber);
    return _db.getAyahsForSurah(surahNumber);
  }

  /// Get ayahs for a specific page.
  Future<List<Ayah>> getAyahsForPage(int pageNumber) async {
    final local = await _db.getAyahsForPage(pageNumber);
    if (local.isNotEmpty) return local;

    // Pages require fetching multiple surahs - fetch by page from API
    await _fetchAndCachePage(pageNumber);
    return _db.getAyahsForPage(pageNumber);
  }

  /// Get ayahs for a juz.
  Future<List<Ayah>> getAyahsForJuz(int juzNumber) async {
    final local = await _db.getAyahsForJuz(juzNumber);
    if (local.isNotEmpty) return local;

    await _fetchAndCacheJuz(juzNumber);
    return _db.getAyahsForJuz(juzNumber);
  }

  /// Get translation for a surah using Al Quran Cloud edition string.
  Future<List<AyahTranslation>> getTranslation({
    required int surahNumber,
    String edition = 'en.sahih',
  }) async {
    // Use edition hashCode as a stable resourceId for local cache key
    final resourceId = edition.hashCode.abs();

    // Check local cache
    final local = await (_db.select(_db.ayahTranslations)
          ..where((t) =>
              t.surahId.equals(surahNumber) &
              t.resourceId.equals(resourceId)))
        .get();
    if (local.isNotEmpty) return local;

    // Fetch from API and cache
    await _fetchAndCacheTranslation(surahNumber, edition, resourceId);
    return (_db.select(_db.ayahTranslations)
          ..where((t) =>
              t.surahId.equals(surahNumber) &
              t.resourceId.equals(resourceId)))
        .get();
  }

  Future<void> _fetchAndCacheSurah(int surahNumber) async {
    try {
      final response = await _api.fetchQuranText(surahNumber: surahNumber);
      final data = response.data;

      // Handle both Quran.com and Al Quran Cloud response formats
      List<dynamic> ayahList;
      if (data is Map && data.containsKey('verses')) {
        // Quran.com format
        ayahList = data['verses'] as List;
        await _cacheQuranComAyahs(surahNumber, ayahList);
      } else if (data is Map && data.containsKey('data')) {
        // Al Quran Cloud format
        final surahData = data['data'];
        ayahList = surahData['ayahs'] as List;
        await _cacheAlQuranCloudAyahs(surahNumber, ayahList);
      }
    } catch (e) {
      // If all APIs fail, throw so UI can show error
      rethrow;
    }
  }

  Future<void> _cacheQuranComAyahs(
      int surahNumber, List<dynamic> ayahs) async {
    for (final ayah in ayahs) {
      final verseKey = (ayah['verse_key'] as String).split(':');
      await _db.into(_db.ayahs).insertOnConflictUpdate(AyahsCompanion(
        surahId: Value(surahNumber),
        ayahNumber: Value(int.parse(verseKey[1])),
        textUthmani: Value(ayah['text_uthmani'] ?? ''),
        textUthmaniTajweed: Value(ayah['text_uthmani_tajweed']),
        juzNumber: Value(ayah['juz_number'] ?? 1),
        hizbQuarter: Value(ayah['hizb_number'] ?? 1),
        pageNumber: Value(ayah['page_number'] ?? 1),
      ));
    }
  }

  Future<void> _cacheAlQuranCloudAyahs(
      int surahNumber, List<dynamic> ayahs) async {
    for (final ayah in ayahs) {
      await _db.into(_db.ayahs).insertOnConflictUpdate(AyahsCompanion(
        surahId: Value(surahNumber),
        ayahNumber: Value(ayah['numberInSurah'] as int),
        textUthmani: Value(ayah['text'] ?? ''),
        textUthmaniTajweed: Value(ayah['text']),
        juzNumber: Value(ayah['juz'] as int? ?? 1),
        hizbQuarter: Value(ayah['hizbQuarter'] as int? ?? 1),
        pageNumber: Value(ayah['page'] as int? ?? 1),
      ));
    }
  }

  Future<void> _fetchAndCachePage(int pageNumber) async {
    try {
      final response = await _api.client.quranComDio.get(
        '/quran/verses/uthmani_tajweed',
        queryParameters: {'page_number': pageNumber},
      );
      final verses = response.data['verses'] as List;
      for (final ayah in verses) {
        final verseKey = (ayah['verse_key'] as String).split(':');
        await _db.into(_db.ayahs).insertOnConflictUpdate(AyahsCompanion(
          surahId: Value(int.parse(verseKey[0])),
          ayahNumber: Value(int.parse(verseKey[1])),
          textUthmani: Value(ayah['text_uthmani'] ?? ''),
          textUthmaniTajweed: Value(ayah['text_uthmani_tajweed']),
          juzNumber: Value(ayah['juz_number'] ?? 1),
          hizbQuarter: Value(ayah['hizb_number'] ?? 1),
          pageNumber: Value(pageNumber),
        ));
      }
    } catch (_) {
      // Silently fail for page-level fetch
    }
  }

  Future<void> _fetchAndCacheJuz(int juzNumber) async {
    try {
      final response = await _api.client.alQuranCloudDio.get(
        '/juz/$juzNumber/quran-tajweed',
      );
      final data = response.data['data'];
      final ayahs = data['ayahs'] as List;
      for (final ayah in ayahs) {
        final surahNum = (ayah['surah'] as Map)['number'] as int;
        await _db.into(_db.ayahs).insertOnConflictUpdate(AyahsCompanion(
          surahId: Value(surahNum),
          ayahNumber: Value(ayah['numberInSurah'] as int),
          textUthmani: Value(ayah['text'] ?? ''),
          textUthmaniTajweed: Value(ayah['text']),
          juzNumber: Value(juzNumber),
          hizbQuarter: Value(ayah['hizbQuarter'] as int? ?? 1),
          pageNumber: Value(ayah['page'] as int? ?? 1),
        ));
      }
    } catch (_) {
      // Silently fail
    }
  }

  Future<void> _fetchAndCacheTranslation(
      int surahNumber, String edition, int resourceId) async {
    try {
      // Fetch directly from Al Quran Cloud using edition string
      final response = await _api.client.alQuranCloudDio.get(
        '/surah/$surahNumber/$edition',
      );
      final data = response.data;

      if (data is Map && data.containsKey('data')) {
        final surahData = data['data'];
        final editionInfo = surahData['edition'] as Map<String, dynamic>?;
        final langCode = (editionInfo?['language'] as String?) ??
            edition.split('.').first;
        final translatorName = (editionInfo?['englishName'] as String?) ??
            edition;
        final ayahs = surahData['ayahs'] as List;
        for (final a in ayahs) {
          final rawText = (a['text'] ?? '') as String;
          final cleanText = rawText.replaceAll(_htmlTagRegex, '');
          await _db
              .into(_db.ayahTranslations)
              .insertOnConflictUpdate(AyahTranslationsCompanion(
                surahId: Value(surahNumber),
                ayahNumber: Value(a['numberInSurah'] as int),
                translationText: Value(cleanText),
                languageCode: Value(langCode),
                translatorName: Value(translatorName),
                resourceId: Value(resourceId),
              ));
        }
      }
    } catch (_) {
      // Translation fetch failed - reading will work without it
    }
  }
}
