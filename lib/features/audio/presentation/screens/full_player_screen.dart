import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/screens/reading_screen.dart';
import '../../data/services/audio_player_service.dart';
import '../providers/audio_providers.dart';

/// Full-screen audio player with controls, seek bar, and surah info.
///
/// Uses `.select()` on audio state to avoid rebuilding the entire screen
/// on every position tick. Metadata rebuilds only on track change;
/// seek bar and controls are isolated ConsumerWidgets.
class FullPlayerScreen extends ConsumerWidget {
  const FullPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch metadata fields — no position/duration here
    final currentSurah = ref.watch(
      currentAudioStateProvider.select((s) => s.currentSurah),
    );
    final currentAyah = ref.watch(
      currentAudioStateProvider.select((s) => s.currentAyah),
    );
    final reciterName = ref.watch(
      currentAudioStateProvider.select((s) => s.reciterName),
    );
    final service = ref.read(audioPlayerServiceProvider);

    final surah = currentSurah != null
        ? SurahInfo.all.firstWhere(
            (s) => s.number == currentSurah,
            orElse: () => SurahInfo.all.first,
          )
        : null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          tooltip: 'Minimize player',
          onPressed: () => Navigator.pop(context),
        ),
        title: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Spacer(flex: 2),
            // Surah artwork / icon — tap to open reading screen
            GestureDetector(
              onTap: surah != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReadingScreen(
                            surah: surah,
                            initialAyah: currentAyah ?? 1,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withAlpha(179),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withAlpha(77),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (surah != null) ...[
                      Text(
                        surah.nameArabic,
                        style: TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: 36,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentAyah != null
                            ? '${AppLocalizations.of(context).playAyah} $currentAyah'
                            : '${AppLocalizations.of(context).surah} ${surah.number}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withAlpha(179),
                        ),
                      ),
                    ] else
                      Icon(Icons.music_note,
                          size: 64,
                          color: Theme.of(context).colorScheme.onPrimary,
                          semanticLabel: 'No track loaded'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Surah name + reciter
            if (surah != null) ...[
              Text(
                surah.nameTransliteration,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                currentAyah != null
                    ? '${surah.nameEnglish} • ${AppLocalizations.of(context).playAyah} $currentAyah'
                    : surah.nameEnglish,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
            ],
            if (reciterName != null) ...[
              const SizedBox(height: 8),
              Text(
                reciterName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
            const SizedBox(height: 32),
            // Seek bar (isolated — watches position/duration only)
            _SeekBar(service: service),
            const SizedBox(height: 24),
            // Playback controls (isolated — watches play state only)
            _PlaybackControls(service: service),
            const SizedBox(height: 16),
            // Repeat + continuous controls (isolated)
            _SecondaryControls(service: service),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _SeekBar extends ConsumerWidget {
  final AudioPlayerService service;

  const _SeekBar({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(
      currentAudioStateProvider.select((s) => s.position),
    );
    final duration = ref.watch(
      currentAudioStateProvider.select((s) => s.duration),
    );

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: Semantics(
            label: 'Seek audio position',
            child: Slider(
              value: duration.inMilliseconds > 0
                  ? (position.inMilliseconds / duration.inMilliseconds)
                      .clamp(0.0, 1.0)
                  : 0.0,
              onChanged: (value) {
                final newPosition = Duration(
                  milliseconds: (value * duration.inMilliseconds).round(),
                );
                service.seekTo(newPosition);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _formatDuration(duration),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class _PlaybackControls extends ConsumerWidget {
  final AudioPlayerService service;

  const _PlaybackControls({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(
      currentAudioStateProvider.select((s) => s.isPlaying),
    );
    final isLoading = ref.watch(
      currentAudioStateProvider.select((s) => s.isLoading),
    );
    final isBuffering = ref.watch(
      currentAudioStateProvider.select((s) => s.isBuffering),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous ayah/surah
        IconButton(
          icon: const Icon(Icons.skip_previous_rounded),
          iconSize: 36,
          tooltip: AppLocalizations.of(context).previous,
          onPressed: () => service.skipPrevious(),
        ),
        const SizedBox(width: 16),
        // Play/Pause
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isLoading || isBuffering
                  ? Icons.hourglass_top_rounded
                  : isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            iconSize: 40,
            tooltip: isPlaying ? AppLocalizations.of(context).pause : AppLocalizations.of(context).play,
            onPressed: () => service.togglePlayPause(),
          ),
        ),
        const SizedBox(width: 16),
        // Next ayah/surah
        IconButton(
          icon: const Icon(Icons.skip_next_rounded),
          iconSize: 36,
          tooltip: AppLocalizations.of(context).nextTrack,
          onPressed: () => service.skipNext(),
        ),
      ],
    );
  }
}

class _SecondaryControls extends ConsumerWidget {
  final AudioPlayerService service;

  const _SecondaryControls({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continuousMode = ref.watch(
      currentAudioStateProvider.select((s) => s.continuousMode),
    );
    final repeatMode = ref.watch(
      currentAudioStateProvider.select((s) => s.repeatMode),
    );

    final l10n = AppLocalizations.of(context);
    final (icon, label, isActive) = _modeInfo(continuousMode, repeatMode, l10n);

    return IconButton(
      icon: Icon(
        icon,
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withAlpha(153),
      ),
      onPressed: () {
        service.cyclePlaybackMode();
        // Show brief snackbar with new mode name
        final state = service.state;
        final (_, newLabel, _) = _modeInfo(state.continuousMode, state.repeatMode, l10n);
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: Text(newLabel),
            duration: const Duration(milliseconds: 1200),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).size.height - 150,
            ),
          ));
      },
      tooltip: label,
    );
  }

  (IconData, String, bool) _modeInfo(bool continuous, AudioRepeatMode repeat, AppLocalizations l10n) {
    if (repeat == AudioRepeatMode.ayah) {
      return (Icons.repeat_one_on_rounded, l10n.repeatAyah, true);
    }
    if (repeat == AudioRepeatMode.surah) {
      return (Icons.repeat_on_rounded, l10n.repeatSurah, true);
    }
    if (continuous) {
      return (Icons.playlist_play_rounded, l10n.continuous, true);
    }
    return (Icons.looks_one_rounded, l10n.playOnce, false);
  }
}
