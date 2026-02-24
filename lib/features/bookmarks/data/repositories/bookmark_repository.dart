import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

/// Repository for reading progress and ayah bookmarks.
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

  // ─── Ayah Bookmarks ───

  Future<List<AyahBookmark>> getBookmarks() => _db.getAllBookmarks();

  Future<bool> isBookmarked(int surahId, int ayahNumber) async {
    final result = await _db.getBookmark(surahId, ayahNumber);
    return result != null;
  }

  Future<void> addBookmark({
    required int surahId,
    required int ayahNumber,
  }) {
    return _db.addBookmark(AyahBookmarksCompanion(
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      createdAt: Value(DateTime.now()),
    )).then((_) {});
  }

  Future<void> removeBookmark({
    required int surahId,
    required int ayahNumber,
  }) async {
    await _db.removeBookmark(surahId, ayahNumber);
  }

  Future<void> toggleBookmark({
    required int surahId,
    required int ayahNumber,
  }) async {
    final exists = await isBookmarked(surahId, ayahNumber);
    if (exists) {
      await removeBookmark(surahId: surahId, ayahNumber: ayahNumber);
    } else {
      await addBookmark(surahId: surahId, ayahNumber: ayahNumber);
    }
  }
}
