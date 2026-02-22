import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

/// Repository for reading progress tracking.
class BookmarkRepository {
  final AppDatabase _db;

  BookmarkRepository({required AppDatabase db}) : _db = db;

  // ─── Reading Progress ───

  Future<ReadingProgressData?> getLastReadingPosition() =>
      _db.getLastReadingPosition();

  Future<void> saveReadingPosition({
    required int surahId,
    required int ayahNumber,
    required int pageNumber,
  }) {
    return _db.saveReadingPosition(ReadingProgressCompanion(
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      pageNumber: Value(pageNumber),
      lastReadAt: Value(DateTime.now()),
    ));
  }
}
