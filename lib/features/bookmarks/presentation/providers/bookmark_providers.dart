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
