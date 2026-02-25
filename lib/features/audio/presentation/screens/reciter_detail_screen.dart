import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../data/models/reciter.dart';
import '../providers/audio_providers.dart';

/// Shows available surahs for a specific reciter and allows playback + download.
class ReciterDetailScreen extends ConsumerStatefulWidget {
  final ReciterModel reciter;

  const ReciterDetailScreen({super.key, required this.reciter});

  @override
  ConsumerState<ReciterDetailScreen> createState() =>
      _ReciterDetailScreenState();
}

class _ReciterDetailScreenState extends ConsumerState<ReciterDetailScreen> {
  bool _offlineOnly = false;
  final Set<int> _downloading = {};
  final Map<int, double> _downloadProgress = {};

  ReciterModel get reciter => widget.reciter;

  @override
  Widget build(BuildContext context) {
    final moshaf = reciter.mpieces.isNotEmpty ? reciter.mpieces.first : null;
    final allSurahs = moshaf?.surahList ?? [];
    final downloadsAsync = ref.watch(reciterDownloadsProvider(reciter.id));
    final downloadedSurahIds = downloadsAsync.valueOrNull
            ?.map((d) => d.surahId)
            .toSet() ??
        <int>{};

    // Force offline filter when global offline mode is on
    final globalOffline = ref.watch(offlineModeProvider);
    final effectiveOffline = _offlineOnly || globalOffline;

    // Filter based on offline mode
    final displaySurahs =
        effectiveOffline
            ? allSurahs.where((s) => downloadedSurahIds.contains(s)).toList()
            : allSurahs;

    return Scaffold(
      appBar: AppBar(
        title: Text(reciter.name),
        actions: [
          // Offline toggle (hidden when global offline forces it)
          if (downloadedSurahIds.isNotEmpty && !globalOffline)
            IconButton(
              icon: Icon(
                _offlineOnly ? Icons.wifi_off : Icons.wifi,
                color: _offlineOnly
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              tooltip: _offlineOnly ? AppLocalizations.of(context).showAllSurahs : AppLocalizations.of(context).offlineMode,
              onPressed: () => setState(() => _offlineOnly = !_offlineOnly),
            ),
          // Download all (hidden in offline mode)
          if (moshaf != null && !effectiveOffline)
            IconButton(
              icon: const Icon(Icons.download_rounded),
              tooltip: AppLocalizations.of(context).downloadAll,
              onPressed: () => _downloadAll(moshaf, allSurahs, downloadedSurahIds),
            ),
        ],
      ),
      body: Column(
        children: [
          // Reciter header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withAlpha(179),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white.withAlpha(51),
                  child: const Icon(
                    Icons.mic_rounded,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  reciter.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (moshaf != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${moshaf.surahTotal} ${AppLocalizations.of(context).surahsAvailable}'
                    '${downloadedSurahIds.isNotEmpty ? ' · ${downloadedSurahIds.length} ${AppLocalizations.of(context).downloaded}' : ''}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                  if (moshaf.name.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      moshaf.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(153),
                      ),
                    ),
                  ],
                ],
                if (effectiveOffline) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          AppLocalizations.of(context).offlineMode,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Surah list
          Expanded(
            child: displaySurahs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download_outlined,
                            size: 48,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(77)),
                        const SizedBox(height: 12),
                        Text(
                          effectiveOffline
                              ? AppLocalizations.of(context).noDownloadsYet
                              : AppLocalizations.of(context).surahsAvailable,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(128),
                                  ),
                        ),
                        if (effectiveOffline && !globalOffline) ...[
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () =>
                                setState(() => _offlineOnly = false),
                            child: Text(AppLocalizations.of(context).showAllSurahs),
                          ),
                        ],
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: displaySurahs.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final surahNumber = displaySurahs[index];
                      final surah = SurahInfo.all.firstWhere(
                        (s) => s.number == surahNumber,
                        orElse: () => SurahInfo.all.first,
                      );
                      final isDownloaded =
                          downloadedSurahIds.contains(surahNumber);
                      final isDownloading = _downloading.contains(surahNumber);
                      final progress = _downloadProgress[surahNumber];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                          radius: 18,
                          child: Text(
                            '${surah.number}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(surah.nameTransliteration),
                        subtitle: Row(
                          children: [
                            Text(surah.nameArabic),
                            if (isDownloaded) ...[
                              const SizedBox(width: 8),
                              Icon(Icons.download_done,
                                  size: 14,
                                  color:
                                      Theme.of(context).colorScheme.primary),
                            ],
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Download / downloaded indicator
                            if (isDownloading)
                              SizedBox(
                                width: 36,
                                height: 36,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value: progress,
                                      strokeWidth: 2,
                                    ),
                                    Icon(Icons.close,
                                        size: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withAlpha(128)),
                                  ],
                                ),
                              )
                            else if (!isDownloaded && moshaf != null && !globalOffline)
                              IconButton(
                                icon: const Icon(Icons.download_outlined),
                                iconSize: 24,
                                tooltip: AppLocalizations.of(context).download,
                                onPressed: () => _downloadSurah(
                                    surah.number, moshaf),
                              ),
                            // Play button
                            IconButton(
                              icon: const Icon(
                                  Icons.play_circle_filled_rounded),
                              color: Theme.of(context).colorScheme.primary,
                              iconSize: 36,
                              onPressed: () =>
                                  _playSurah(surah, moshaf, isDownloaded),
                            ),
                          ],
                        ),
                        onTap: () =>
                            _playSurah(surah, moshaf, isDownloaded),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _playSurah(SurahInfo surah, ReciterMoshaf? moshaf, bool isDownloaded) {
    if (moshaf == null) return;

    // Block streaming in offline mode
    if (ref.read(offlineModeProvider) && !isDownloaded) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).offlineNotAvailable),
          behavior: SnackBarBehavior.floating,
        ));
      return;
    }

    final service = ref.read(audioPlayerServiceProvider);
    // Record listening activity for gamification
    ref.read(gamificationServiceProvider).recordActivity(ActivityType.listenQuran);

    if (isDownloaded) {
      // Play from local file
      ref.read(downloadServiceProvider).getLocalPath(reciter.id, surah.number).then((path) {
        if (path != null) {
          service.playLocal(
            path,
            surahNumber: surah.number,
            reciterName: reciter.name,
            serverUrl: moshaf.server,
            reciterId: reciter.id,
            surahList: moshaf.surahList,
          );
        } else {
          // File missing, fall back to streaming
          service.playSurah(
            surahNumber: surah.number,
            serverUrl: moshaf.server,
            reciterId: reciter.id,
            reciterName: reciter.name,
            surahList: moshaf.surahList,
          );
        }
      });
    } else {
      service.playSurah(
        surahNumber: surah.number,
        serverUrl: moshaf.server,
        reciterId: reciter.id,
        reciterName: reciter.name,
        surahList: moshaf.surahList,
      );
    }
  }

  Future<void> _downloadSurah(int surahNumber, ReciterMoshaf moshaf) async {
    setState(() => _downloading.add(surahNumber));
    _downloadProgress.remove(surahNumber);

    final service = ref.read(downloadServiceProvider);
    final success = await service.downloadSurahSync(
      reciterId: reciter.id,
      surahNumber: surahNumber,
      serverUrl: moshaf.server,
      onProgress: (progress) {
        if (mounted) {
          setState(() => _downloadProgress[surahNumber] = progress);
        }
      },
    );

    if (mounted) {
      setState(() {
        _downloading.remove(surahNumber);
        _downloadProgress.remove(surahNumber);
      });
      // Refresh download list
      ref.invalidate(reciterDownloadsProvider(reciter.id));
      ref.invalidate(allDownloadsProvider);
      ref.invalidate(totalDownloadSizeProvider);

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).downloadFailed)),
        );
      }
    }
  }

  Future<void> _downloadAll(
    ReciterMoshaf moshaf,
    List<int> allSurahs,
    Set<int> alreadyDownloaded,
  ) async {
    final toDownload =
        allSurahs.where((s) => !alreadyDownloaded.contains(s)).toList();
    if (toDownload.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All surahs already downloaded')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('${AppLocalizations.of(context).downloadAll}?'),
        content: Text(
            '${AppLocalizations.of(context).download} ${toDownload.length} ${AppLocalizations.of(context).surahsAvailable}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(AppLocalizations.of(context).download),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    for (final surahNum in toDownload) {
      if (!mounted) break;
      await _downloadSurah(surahNum, moshaf);
    }
  }
}
