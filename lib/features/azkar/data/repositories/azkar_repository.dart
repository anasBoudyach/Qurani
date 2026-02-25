import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../services/azkar_api_service.dart';

/// Offline-first repository for azkar data.
/// Flow: Check local DB → If empty, fetch from API → Cache in DB → Return.
class AzkarRepository {
  final AppDatabase _db;
  final AzkarApiService _api;

  AzkarRepository({required AppDatabase db, required AzkarApiService api})
      : _db = db,
        _api = api;

  /// Get azkar for a category. Fetches from API on first access, caches locally.
  Future<List<CachedAzkarData>> getAzkarForCategory(
      int categoryId, String categoryTitle,
      {bool offlineOnly = false}) async {
    final local = await _db.getAzkarForCategory(categoryId);
    if (local.isNotEmpty || offlineOnly) return local;

    // Fetch from API and cache
    final items = await _api.fetchAzkarForCategory(categoryId);
    for (final item in items) {
      await _db
          .into(_db.cachedAzkar)
          .insertOnConflictUpdate(CachedAzkarCompanion(
            categoryId: Value(categoryId),
            categoryTitle: Value(categoryTitle),
            itemId: Value(item.itemId),
            arabicText: Value(item.arabicText),
            repeatCount: Value(item.repeatCount),
            audioUrl: Value(item.audioUrl),
          ));
    }

    return _db.getAzkarForCategory(categoryId);
  }
}
