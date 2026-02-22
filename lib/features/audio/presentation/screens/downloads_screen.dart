import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../providers/audio_providers.dart';

/// Screen to manage downloaded audio files.
class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadsAsync = ref.watch(allDownloadsProvider);
    final totalSizeAsync = ref.watch(totalDownloadSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        actions: [
          if (downloadsAsync.valueOrNull?.isNotEmpty == true)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Delete all downloads',
              onPressed: () => _confirmDeleteAll(context, ref),
            ),
        ],
      ),
      body: downloadsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (downloads) {
          if (downloads.isEmpty) {
            return _buildEmpty(context);
          }

          // Group downloads by reciter
          final grouped = <int, List<DownloadedAudioData>>{};
          for (final d in downloads) {
            grouped.putIfAbsent(d.reciterId, () => []).add(d);
          }

          return Column(
            children: [
              // Storage summary
              totalSizeAsync.when(
                data: (bytes) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withAlpha(77),
                  child: Row(
                    children: [
                      Icon(Icons.storage,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Text(
                        '${downloads.length} files',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        _formatBytes(bytes),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              // Grouped list
              Expanded(
                child: ListView.builder(
                  itemCount: grouped.length,
                  itemBuilder: (context, index) {
                    final reciterId = grouped.keys.elementAt(index);
                    final reciterDownloads = grouped[reciterId]!;

                    return _ReciterDownloadGroup(
                      reciterId: reciterId,
                      downloads: reciterDownloads,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.download_done_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
          ),
          const SizedBox(height: 16),
          Text(
            'No downloads yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(153),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Download surahs from reciter pages\nfor offline listening',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(102),
                ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAll(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete All Downloads?'),
        content: const Text(
            'This will remove all downloaded audio files. You can re-download them anytime.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final service = ref.read(downloadServiceProvider);
              final downloads = ref.read(allDownloadsProvider).valueOrNull ?? [];
              for (final d in downloads) {
                await service.deleteDownload(d);
              }
              ref.invalidate(allDownloadsProvider);
              ref.invalidate(totalDownloadSizeProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All downloads deleted')),
                );
              }
            },
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

class _ReciterDownloadGroup extends ConsumerWidget {
  final int reciterId;
  final List<DownloadedAudioData> downloads;

  const _ReciterDownloadGroup({
    required this.reciterId,
    required this.downloads,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculate total size for this reciter
    final totalSize = downloads.fold<int>(0, (sum, d) => sum + d.fileSize);

    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.mic_rounded,
          size: 20,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text('Reciter #$reciterId'),
      subtitle: Text(
        '${downloads.length} surahs - ${DownloadsScreen._formatBytes(totalSize)}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: 'Delete all for this reciter',
        onPressed: () => _confirmDeleteReciter(context, ref),
      ),
      children: downloads.map((d) {
        final surah = SurahInfo.all.firstWhere(
          (s) => s.number == d.surahId,
          orElse: () => SurahInfo.all.first,
        );
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 72, right: 16),
          title: Text(surah.nameTransliteration),
          subtitle: Text(
            '${surah.nameArabic} - ${DownloadsScreen._formatBytes(d.fileSize)}',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Play locally
              IconButton(
                icon: const Icon(Icons.play_circle_outline),
                tooltip: 'Play offline',
                onPressed: () {
                  ref.read(audioPlayerServiceProvider).playLocal(
                    d.filePath,
                    surahNumber: d.surahId,
                    reciterName: 'Reciter #$reciterId',
                  );
                },
              ),
              // Delete single
              IconButton(
                icon: Icon(Icons.close,
                    size: 20,
                    color: Theme.of(context).colorScheme.error),
                tooltip: 'Delete',
                onPressed: () async {
                  final file = File(d.filePath);
                  if (await file.exists()) {
                    await file.delete();
                  }
                  final db = ref.read(databaseProvider);
                  await db.deleteDownload(d.id);
                  ref.invalidate(allDownloadsProvider);
                  ref.invalidate(totalDownloadSizeProvider);
                  ref.invalidate(reciterDownloadsProvider(reciterId));
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _confirmDeleteReciter(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Reciter Downloads?'),
        content: Text(
            'Delete all ${downloads.length} downloaded surahs for this reciter?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final service = ref.read(downloadServiceProvider);
              await service.deleteReciterDownloads(reciterId);
              ref.invalidate(allDownloadsProvider);
              ref.invalidate(totalDownloadSizeProvider);
              ref.invalidate(reciterDownloadsProvider(reciterId));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
