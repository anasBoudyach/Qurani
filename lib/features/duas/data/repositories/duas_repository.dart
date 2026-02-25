import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../services/duas_api_service.dart';

/// Offline-first repository for du'as data.
/// Reuses the CachedAzkar table (same HisnMuslim API source).
class DuasRepository {
  final AppDatabase _db;
  final DuasApiService _api;

  DuasRepository({required AppDatabase db, required DuasApiService api})
      : _db = db,
        _api = api;

  /// Get du'as for a category. Fetches from API on first access, caches locally.
  Future<List<CachedAzkarData>> getDuasForCategory(
      int categoryId, String categoryTitle,
      {bool offlineOnly = false}) async {
    final local = await _db.getAzkarForCategory(categoryId);
    if (local.isNotEmpty || offlineOnly) return local;

    final items = await _api.fetchDuasForCategory(categoryId);
    for (final item in items) {
      await _db
          .into(_db.cachedAzkar)
          .insertOnConflictUpdate(CachedAzkarCompanion(
            categoryId: Value(categoryId),
            categoryTitle: Value(categoryTitle),
            itemId: Value(item.itemId),
            arabicText: Value(item.arabicText),
            repeatCount: Value(item.repeatCount),
          ));
    }

    return _db.getAzkarForCategory(categoryId);
  }
}
