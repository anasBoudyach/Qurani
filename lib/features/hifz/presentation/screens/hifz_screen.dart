import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../audio/presentation/providers/audio_providers.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../../quran/presentation/widgets/tajweed_text_widget.dart';
import '../../../../core/l10n/app_localizations.dart';

/// Hifz (Memorization) mode screen.
/// Progressively hides ayahs to test recall. User taps to reveal.
/// Supports three difficulty levels:
/// - Easy: first word visible, rest hidden
/// - Medium: fully hidden, tap to reveal
/// - Hard: fully hidden, must type first word to reveal
class HifzScreen extends ConsumerStatefulWidget {
  final SurahInfo surah;
  final int startAyah;
  final int endAyah;

  const HifzScreen({
    super.key,
    required this.surah,
    this.startAyah = 1,
    this.endAyah = 0, // 0 = end of surah
  });

  @override
  ConsumerState<HifzScreen> createState() => _HifzScreenState();
}

class _HifzScreenState extends ConsumerState<HifzScreen> {
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');
  static final RegExp _ayahEndMarkerRegex = RegExp(r'[\s\u06DD]*[\u0660-\u0669\u06F0-\u06F9]+[\s\u200F\u200E]*$');
  static final RegExp _htmlAyahEndRegex = RegExp(
    r'\s*(?:<span[^>]*>\s*)?[\u06DD]?\s*[\u0660-\u0669\u06F0-\u06F9]+\s*(?:</span>)?\s*$',
  );

  /// Get plain Arabic text, falling back to stripped tajweed HTML.
  String _plainText(Ayah ayah) {
    final raw = ayah.textUthmani.isNotEmpty
        ? ayah.textUthmani
        : (ayah.textUthmaniTajweed?.replaceAll(_htmlTagRegex, '') ?? '');
    return raw.replaceAll(_ayahEndMarkerRegex, '').trimRight();
  }

  /// Tajweed HTML with trailing ayah number stripped.
  String _tajweedHtmlNoNumber(String html) {
    return html.replaceAll(_htmlAyahEndRegex, '').trimRight();
  }

  HifzDifficulty _difficulty = HifzDifficulty.easy;
  final Set<int> _revealedAyahs = {};      // revealed but not yet rated
  final Set<int> _correctAyahs = {};       // rated correct
  final Set<int> _wrongAyahs = {};         // rated wrong
  bool _showAll = false;

  bool _isRevealed(int ayahNumber) =>
      _showAll || _revealedAyahs.contains(ayahNumber) ||
      _correctAyahs.contains(ayahNumber) || _wrongAyahs.contains(ayahNumber);

  @override
  Widget build(BuildContext context) {
    final ayahsAsync = ref.watch(surahAyahsProvider(widget.surah.number));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context).hifz}: ${widget.surah.nameTransliteration}',
                style: const TextStyle(fontSize: 16)),
            Text(
              widget.surah.nameArabic,
              style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 14),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        actions: [
          Consumer(builder: (context, ref, _) {
            final showTajweed = ref.watch(tajweedProvider);
            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              tooltip: AppLocalizations.of(context).options,
              onSelected: (value) {
                switch (value) {
                  case 'easy':
                    setState(() { _difficulty = HifzDifficulty.easy; _revealedAyahs.clear(); _showAll = false; });
                  case 'medium':
                    setState(() { _difficulty = HifzDifficulty.medium; _revealedAyahs.clear(); _showAll = false; });
                  case 'tajweed':
                    ref.read(tajweedProvider.notifier).toggle();
                  case 'show_all':
                    setState(() { _showAll = !_showAll; if (!_showAll) _revealedAyahs.clear(); });
                  case 'reset':
                    setState(() { _revealedAyahs.clear(); _correctAyahs.clear(); _wrongAyahs.clear(); _showAll = false; });
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(enabled: false, height: 32, child: Text(AppLocalizations.of(context).difficulty, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                _hifzCheckItem('easy', AppLocalizations.of(context).easyHint, Icons.sentiment_satisfied_rounded, _difficulty == HifzDifficulty.easy),
                _hifzCheckItem('medium', AppLocalizations.of(context).mediumHidden, Icons.sentiment_neutral_rounded, _difficulty == HifzDifficulty.medium),
                const PopupMenuDivider(),
                _hifzCheckItem('tajweed', AppLocalizations.of(context).tajweedColors, Icons.color_lens_outlined, showTajweed),
                _hifzCheckItem('show_all', _showAll ? AppLocalizations.of(context).hideAllAyahs : AppLocalizations.of(context).showAllAyahs, _showAll ? Icons.visibility_off_rounded : Icons.visibility_rounded, _showAll),
                const PopupMenuDivider(),
                PopupMenuItem(value: 'reset', child: Row(children: [const Icon(Icons.refresh_rounded, size: 20), const SizedBox(width: 12), Text(AppLocalizations.of(context).resetProgress)])),
              ],
            );
          }),
        ],
      ),
      body: ayahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${AppLocalizations.of(context).errorLoading}: $e')),
        data: (ayahs) {
          final endAyah = widget.endAyah > 0
              ? widget.endAyah
              : widget.surah.ayahCount;
          final filtered = ayahs
              .where((a) =>
                  a.ayahNumber >= widget.startAyah &&
                  a.ayahNumber <= endAyah)
              .toList();

          if (filtered.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context).noAyahsFound));
          }

          return Column(
            children: [
              // Progress bar
              _buildProgressBar(filtered),
              // Ayah list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final ayah = filtered[index];
                    return _buildHifzCard(ayah, _isRevealed(ayah.ayahNumber));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  PopupMenuItem<String> _hifzCheckItem(String value, String label, IconData icon, bool checked) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          if (checked)
            Icon(Icons.check, size: 18, color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }

  String _difficultyLabel() {
    final l10n = AppLocalizations.of(context);
    return switch (_difficulty) {
      HifzDifficulty.easy => l10n.easyHint,
      HifzDifficulty.medium => l10n.mediumHidden,
    };
  }

  Widget _buildProgressBar(List<Ayah> ayahs) {
    final total = ayahs.length;
    final revealedCount = _showAll
        ? total
        : (_revealedAyahs.length + _correctAyahs.length + _wrongAyahs.length);
    final progress = total > 0 ? revealedCount / total : 0.0;
    final correctCount = _correctAyahs.length;
    final wrongCount = _wrongAyahs.length;
    final rated = correctCount + wrongCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(77),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                _difficultyLabel(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              if (rated > 0) ...[
                Icon(Icons.check_circle, size: 14, color: Colors.green),
                const SizedBox(width: 2),
                Text(
                  '$correctCount',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.cancel, size: 14, color: Colors.red),
                const SizedBox(width: 2),
                Text(
                  '$wrongCount',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                '$revealedCount / $total',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withAlpha(51),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHifzCard(Ayah ayah, bool isRevealed) {
    final isCorrect = _correctAyahs.contains(ayah.ayahNumber);
    final isWrong = _wrongAyahs.contains(ayah.ayahNumber);
    final rated = isCorrect || isWrong;

    // Border color: green if correct, red if wrong, default otherwise
    Color borderColor;
    if (isCorrect) {
      borderColor = Colors.green.withAlpha(150);
    } else if (isWrong) {
      borderColor = Colors.red.withAlpha(150);
    } else if (isRevealed) {
      borderColor = Theme.of(context).colorScheme.outline.withAlpha(51);
    } else {
      borderColor = Theme.of(context).colorScheme.primary.withAlpha(77);
    }

    return GestureDetector(
      onTap: isRevealed ? null : () => _revealAyah(ayah),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCorrect
              ? Colors.green.withAlpha(15)
              : isWrong
                  ? Colors.red.withAlpha(15)
                  : isRevealed
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withAlpha(51),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: rated ? 1.5 : 1.0),
        ),
        child: Column(
          children: [
            // Ayah number badge + actions
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? Colors.green.withAlpha(40)
                        : isWrong
                            ? Colors.red.withAlpha(40)
                            : Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    formatAyahNumber(ayah.ayahNumber, ref.watch(numeralStyleProvider)),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isCorrect
                          ? Colors.green
                          : isWrong
                              ? Colors.red
                              : Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const Spacer(),
                if (!isRevealed)
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary.withAlpha(128),
                  ),
                if (isRevealed) ...[
                  _PlayAyahButton(
                    surahNumber: widget.surah.number,
                    ayahNumber: ayah.ayahNumber,
                    totalAyahs: widget.surah.ayahCount,
                  ),
                  if (!rated) ...[
                    // Self-assessment buttons (only before rating)
                    const SizedBox(width: 8),
                    _RatingButton(
                      icon: Icons.check_circle_rounded,
                      color: Colors.green,
                      tooltip: AppLocalizations.of(context).iKnewIt,
                      onTap: () => _rateAyah(ayah.ayahNumber, true),
                    ),
                    const SizedBox(width: 4),
                    _RatingButton(
                      icon: Icons.cancel_rounded,
                      color: Colors.red,
                      tooltip: AppLocalizations.of(context).iDidntKnow,
                      onTap: () => _rateAyah(ayah.ayahNumber, false),
                    ),
                  ],
                  if (rated) ...[
                    const SizedBox(width: 8),
                    Icon(
                      isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                      size: 20,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ],
                ],
              ],
            ),
            const SizedBox(height: 12),
            // Ayah content
            if (isRevealed)
              (ref.watch(tajweedProvider) && ayah.textUthmaniTajweed != null)
                  ? TajweedTextWidget(
                      textUthmaniTajweed: _tajweedHtmlNoNumber(ayah.textUthmaniTajweed!),
                      fontSize: 26,
                    )
                  : Text(
                      _plainText(ayah),
                      style: const TextStyle(
                        fontFamily: 'AmiriQuran',
                        fontSize: 26,
                        height: 2.0,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    )
            else
              _buildHiddenContent(ayah),
          ],
        ),
      ),
    );
  }

  Widget _buildHiddenContent(Ayah ayah) {
    switch (_difficulty) {
      case HifzDifficulty.easy:
        // Show first word, hide rest
        final words = _plainText(ayah).split(' ');
        final firstWord = words.isNotEmpty ? words.first : '';
        final hiddenCount = max(0, words.length - 1);
        return Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: firstWord,
                    style: TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 26,
                      height: 2.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${'⬜ ' * hiddenCount}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(77),
                    ),
                  ),
                ],
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).tapToReveal,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withAlpha(153),
                  ),
            ),
          ],
        );

      case HifzDifficulty.medium:
        // Fully hidden
        final wordCount = _plainText(ayah).split(' ').length;
        return Column(
          children: [
            Text(
              '⬜ ' * wordCount,
              style: TextStyle(
                fontSize: 20,
                color:
                    Theme.of(context).colorScheme.onSurface.withAlpha(77),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${AppLocalizations.of(context).tapToReveal} ($wordCount ${AppLocalizations.of(context).ayahs})',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withAlpha(153),
                  ),
            ),
          ],
        );

    }
  }

  void _revealAyah(Ayah ayah) {
    setState(() {
      _revealedAyahs.add(ayah.ayahNumber);
    });
  }

  void _rateAyah(int ayahNumber, bool correct) {
    setState(() {
      _revealedAyahs.remove(ayahNumber);
      if (correct) {
        _correctAyahs.add(ayahNumber);
        _wrongAyahs.remove(ayahNumber);
      } else {
        _wrongAyahs.add(ayahNumber);
        _correctAyahs.remove(ayahNumber);
      }
    });
  }

}

enum HifzDifficulty {
  easy('Easy - First word hint'),
  medium('Medium - Fully hidden');

  final String label;
  const HifzDifficulty(this.label);
}

class _RatingButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _RatingButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, size: 26, color: color),
      ),
    );
  }
}

class _PlayAyahButton extends ConsumerWidget {
  final int surahNumber;
  final int ayahNumber;
  final int totalAyahs;

  const _PlayAyahButton({
    required this.surahNumber,
    required this.ayahNumber,
    required this.totalAyahs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(
      currentAudioStateProvider.select((s) => s.isPlaying),
    );
    final playingSurah = ref.watch(
      currentAudioStateProvider.select((s) => s.currentSurah),
    );
    final playingAyah = ref.watch(
      currentAudioStateProvider.select((s) => s.currentAyah),
    );

    final isThisPlaying =
        isPlaying && playingSurah == surahNumber && playingAyah == ayahNumber;

    return GestureDetector(
      onTap: () {
        final service = ref.read(audioPlayerServiceProvider);
        if (isThisPlaying) {
          service.pause();
        } else {
          final reciter = ref.read(defaultReciterProvider);
          service.playAyah(
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            reciterFolder: reciter.id,
            totalAyahs: totalAyahs,
          );
        }
      },
      child: Icon(
        isThisPlaying ? Icons.pause_circle_rounded : Icons.volume_up_rounded,
        size: 22,
        color: isThisPlaying
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withAlpha(140),
      ),
    );
  }
}
