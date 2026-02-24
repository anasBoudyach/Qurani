import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/screens/reading_screen.dart';
import '../providers/bookmark_providers.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksAsync = ref.watch(bookmarksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: bookmarksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Error loading bookmarks: $error'),
        ),
        data: (bookmarks) {
          if (bookmarks.isEmpty) {
            return _buildEmptyState(context);
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarks[index];
              return _BookmarkTile(bookmark: bookmark);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark_outline_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(60),
            ),
            const SizedBox(height: 16),
            Text(
              'No bookmarks yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(140),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the bookmark icon on any ayah\nwhile reading to save it here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(100),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookmarkTile extends ConsumerWidget {
  final AyahBookmark bookmark;

  const _BookmarkTile({required this.bookmark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surah = SurahInfo.all.firstWhere(
      (s) => s.number == bookmark.surahId,
      orElse: () => SurahInfo.all.first,
    );

    final timeAgo = _formatTimeAgo(bookmark.createdAt);

    return Dismissible(
      key: ValueKey('${bookmark.surahId}_${bookmark.ayahNumber}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete_rounded,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      onDismissed: (_) {
        HapticFeedback.lightImpact();
        ref.read(bookmarkRepositoryProvider).removeBookmark(
              surahId: bookmark.surahId,
              ayahNumber: bookmark.ayahNumber,
            );
        ref.invalidate(bookmarksProvider);
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            '${bookmark.ayahNumber}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(
          surah.nameTransliteration,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Ayah ${bookmark.ayahNumber} of ${surah.ayahCount} - $timeAgo',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withAlpha(140),
              ),
        ),
        trailing: Text(
          surah.nameArabic,
          style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReadingScreen(
                surah: surah,
                initialAyah: bookmark.ayahNumber,
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}
