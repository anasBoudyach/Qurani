import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/repositories/bookmark_repository.dart';

/// Reading progress repository provider.
final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
  return BookmarkRepository(db: ref.watch(databaseProvider));
});

/// Last reading position.
final lastReadingPositionProvider =
    FutureProvider<ReadingProgressData?>((ref) async {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.getLastReadingPosition();
});

/// All ayah bookmarks (sorted by createdAt desc).
final bookmarksProvider = FutureProvider<List<AyahBookmark>>((ref) async {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.getBookmarks();
});

/// Check if a specific ayah is bookmarked.
final isAyahBookmarkedProvider =
    FutureProvider.family<bool, ({int surahId, int ayahNumber})>(
        (ref, params) async {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.isBookmarked(params.surahId, params.ayahNumber);
});
