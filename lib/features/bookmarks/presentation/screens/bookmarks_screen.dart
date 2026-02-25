import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/screens/reading_screen.dart';
import '../providers/bookmark_providers.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  List<AyahBookmark> _bookmarks = [];

  @override
  Widget build(BuildContext context) {
    final bookmarksAsync = ref.watch(bookmarksProvider);

    // Sync local list when provider data arrives
    bookmarksAsync.whenData((data) {
      if (!_listEquals(_bookmarks, data)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _bookmarks = List.from(data));
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).bookmarks),
      ),
      body: bookmarksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Error loading bookmarks: $error'),
        ),
        data: (_) {
          if (_bookmarks.isEmpty) {
            return _buildEmptyState(context);
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = _bookmarks[index];
              return _BookmarkTile(
                bookmark: bookmark,
                onDismissed: () {
                  setState(() => _bookmarks.removeAt(index));
                  ref.read(bookmarkRepositoryProvider).removeBookmark(
                        surahId: bookmark.surahId,
                        ayahNumber: bookmark.ayahNumber,
                      );
                  ref.invalidate(bookmarksProvider);
                },
              );
            },
          );
        },
      ),
    );
  }

  bool _listEquals(List<AyahBookmark> a, List<AyahBookmark> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].surahId != b[i].surahId ||
          a[i].ayahNumber != b[i].ayahNumber) {
        return false;
      }
    }
    return true;
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
              AppLocalizations.of(context).noBookmarksYet,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(140),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).bookmarkDesc,
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
  final VoidCallback onDismissed;

  const _BookmarkTile({required this.bookmark, required this.onDismissed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surah = SurahInfo.all.firstWhere(
      (s) => s.number == bookmark.surahId,
      orElse: () => SurahInfo.all.first,
    );

    final timeAgo = _formatTimeAgo(context, bookmark.createdAt);

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
        onDismissed();
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
          '${AppLocalizations.of(context).ayahXofY(bookmark.ayahNumber, surah.ayahCount)} - $timeAgo',
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
          // Switch to Quran tab, then push ReadingScreen there
          context.go(RouteNames.quran);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            quranNavigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (_) => ReadingScreen(
                  surah: surah,
                  initialAyah: bookmark.ayahNumber,
                ),
              ),
            );
          });
        },
      ),
    );
  }

  String _formatTimeAgo(BuildContext context, DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return AppLocalizations.of(context).justNow;
  }
}
