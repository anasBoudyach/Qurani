import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../services/hadith_api_service.dart';

/// Offline-first repository for hadith data.
/// Flow: Check local DB → If empty, fetch from API → Cache in DB → Return.
class HadithRepository {
  final AppDatabase _db;
  final HadithApiService _api;

  HadithRepository({required AppDatabase db, required HadithApiService api})
      : _db = db,
        _api = api;

  /// Get sections for a collection. Fetches from API on first access.
  Future<List<CachedHadithSection>> getSections(String collectionKey,
      {bool offlineOnly = false}) async {
    final local = await _db.getHadithSections(collectionKey);
    if (local.isNotEmpty || offlineOnly) return local;

    // Fetch from API and cache
    final sections = await _api.fetchSections(collectionKey);
    for (final s in sections) {
      await _db
          .into(_db.cachedHadithSections)
          .insertOnConflictUpdate(CachedHadithSectionsCompanion(
            collectionKey: Value(collectionKey),
            sectionNumber: Value(s.sectionNumber),
            name: Value(s.name),
            hadithStartNumber: Value(s.hadithStartNumber),
            hadithEndNumber: Value(s.hadithEndNumber),
          ));
    }

    return _db.getHadithSections(collectionKey);
  }

  /// Get hadiths for a section. Fetches from API on first access.
  Future<List<CachedHadith>> getHadithsForSection(
      String collectionKey, int sectionNumber,
      {bool offlineOnly = false}) async {
    final local = await _db.getHadithsForSection(collectionKey, sectionNumber);
    if (local.isNotEmpty || offlineOnly) return local;

    // Fetch from API and cache
    final hadiths =
        await _api.fetchHadithsForSection(collectionKey, sectionNumber);
    for (final h in hadiths) {
      await _db
          .into(_db.cachedHadiths)
          .insertOnConflictUpdate(CachedHadithsCompanion(
            collectionKey: Value(collectionKey),
            sectionNumber: Value(sectionNumber),
            hadithNumber: Value(h.hadithNumber),
            textArabic: Value(h.textArabic),
            textEnglish: Value(h.textEnglish),
          ));
    }

    return _db.getHadithsForSection(collectionKey, sectionNumber);
  }
}
