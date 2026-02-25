import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../data/services/audio_player_service.dart';
import '../providers/audio_providers.dart';
import '../screens/full_player_screen.dart';

/// Persistent mini audio player shown at the bottom of the app.
/// Tap surah/reciter area to expand to full player.
///
/// Layout: [surah + reciter] ... [mode chip] [prev] [play] [next] [close]
class MiniPlayerWidget extends ConsumerWidget {
  const MiniPlayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTrack = ref.watch(
      currentAudioStateProvider.select((s) => s.hasTrack),
    );

    if (!hasTrack) return const SizedBox.shrink();

    final currentSurah = ref.watch(
      currentAudioStateProvider.select((s) => s.currentSurah),
    );
    final reciterName = ref.watch(
      currentAudioStateProvider.select((s) => s.reciterName),
    );

    final surahName = currentSurah != null
        ? SurahInfo.all
            .firstWhere(
              (s) => s.number == currentSurah,
              orElse: () => SurahInfo.all.first,
            )
            .nameTransliteration
        : 'Unknown';

    return Semantics(
      label: 'Mini player: $surahName. Tap to open full player',
      button: true,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Thin progress line at top
            Consumer(builder: (context, ref, _) {
              final position = ref.watch(
                currentAudioStateProvider.select((s) => s.position),
              );
              final duration = ref.watch(
                currentAudioStateProvider.select((s) => s.duration),
              );
              final progress = duration.inMilliseconds > 0
                  ? (position.inMilliseconds / duration.inMilliseconds)
                      .clamp(0.0, 1.0)
                  : 0.0;
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 2,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  // Surah info — tap to open full player
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FullPlayerScreen()),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surahName,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (reciterName != null)
                            Text(
                              reciterName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(153),
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ),
                  // Playback mode chip
                  _ModeChip(),
                  const SizedBox(width: 4),
                  // Previous
                  Consumer(builder: (context, ref, _) {
                    final service = ref.read(audioPlayerServiceProvider);
                    return IconButton(
                      icon: const Icon(Icons.skip_previous_rounded, size: 22),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 36, minHeight: 36),
                      tooltip: AppLocalizations.of(context).previous,
                      onPressed: () => service.skipPrevious(),
                    );
                  }),
                  // Play/Pause
                  Consumer(builder: (context, ref, _) {
                    final isPlaying = ref.watch(
                      currentAudioStateProvider.select((s) => s.isPlaying),
                    );
                    final isLoading = ref.watch(
                      currentAudioStateProvider.select((s) => s.isLoading),
                    );
                    final isBuffering = ref.watch(
                      currentAudioStateProvider.select((s) => s.isBuffering),
                    );
                    return IconButton(
                      icon: Icon(
                        isLoading || isBuffering
                            ? Icons.hourglass_top_rounded
                            : isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                        size: 26,
                      ),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 40, minHeight: 40),
                      tooltip: isPlaying ? AppLocalizations.of(context).pause : AppLocalizations.of(context).play,
                      onPressed: () {
                        ref.read(audioPlayerServiceProvider).togglePlayPause();
                      },
                    );
                  }),
                  // Next
                  Consumer(builder: (context, ref, _) {
                    final service = ref.read(audioPlayerServiceProvider);
                    return IconButton(
                      icon: const Icon(Icons.skip_next_rounded, size: 22),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 36, minHeight: 36),
                      tooltip: AppLocalizations.of(context).nextTrack,
                      onPressed: () => service.skipNext(),
                    );
                  }),
                  // Close
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                    tooltip: AppLocalizations.of(context).stopPlayback,
                    onPressed: () {
                      ref.read(audioPlayerServiceProvider).stop();
                    },
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeChip extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continuous = ref.watch(
      currentAudioStateProvider.select((s) => s.continuousMode),
    );
    final repeat = ref.watch(
      currentAudioStateProvider.select((s) => s.repeatMode),
    );
    final l10n = AppLocalizations.of(context);

    final (IconData icon, String label, bool active) = switch (repeat) {
      AudioRepeatMode.ayah => (Icons.repeat_one_rounded, l10n.repeatAyah, true),
      AudioRepeatMode.surah => (Icons.repeat_rounded, l10n.repeatSurah, true),
      _ when continuous =>
        (Icons.playlist_play_rounded, l10n.continuous, true),
      _ => (Icons.looks_one_rounded, l10n.playOnce, false),
    };

    final accent = Theme.of(context).colorScheme.primary;
    final muted = Theme.of(context).colorScheme.onSurface.withAlpha(120);

    return GestureDetector(
      onTap: () {
        final service = ref.read(audioPlayerServiceProvider);
        service.cyclePlaybackMode();
        final state = service.state;
        final newLabel = switch (state.repeatMode) {
          AudioRepeatMode.ayah => l10n.repeatAyah,
          AudioRepeatMode.surah => l10n.repeatSurah,
          _ when state.continuousMode => l10n.continuous,
          _ => l10n.playOnce,
        };
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: Text(newLabel),
            duration: const Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
          ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: active ? accent.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? accent.withAlpha(80) : muted.withAlpha(60),
          ),
        ),
        child: Icon(icon, size: 14, color: active ? accent : muted),
      ),
    );
  }
}
