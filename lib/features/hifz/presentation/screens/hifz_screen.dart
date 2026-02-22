import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/providers/quran_providers.dart';

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
  static final RegExp _diacriticsRegex = RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7\u06E8\u06EA-\u06ED]');

  HifzDifficulty _difficulty = HifzDifficulty.easy;
  final Set<int> _revealedAyahs = {};
  bool _showAll = false;
  int _correctCount = 0;
  int _totalAttempts = 0;

  @override
  Widget build(BuildContext context) {
    final ayahsAsync = ref.watch(surahAyahsProvider(widget.surah.number));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hifz: ${widget.surah.nameTransliteration}',
                style: const TextStyle(fontSize: 16)),
            Text(
              widget.surah.nameArabic,
              style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 14),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        actions: [
          // Difficulty selector
          PopupMenuButton<HifzDifficulty>(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Difficulty',
            onSelected: (d) => setState(() {
              _difficulty = d;
              _revealedAyahs.clear();
              _showAll = false;
            }),
            itemBuilder: (_) => HifzDifficulty.values
                .map((d) => PopupMenuItem(
                      value: d,
                      child: Row(
                        children: [
                          Text(d.label),
                          if (_difficulty == d) ...[
                            const Spacer(),
                            Icon(Icons.check,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary),
                          ],
                        ],
                      ),
                    ))
                .toList(),
          ),
          // Show/hide all toggle
          IconButton(
            icon: Icon(_showAll
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
            tooltip: _showAll ? 'Hide all' : 'Show all',
            onPressed: () => setState(() {
              _showAll = !_showAll;
              if (!_showAll) _revealedAyahs.clear();
            }),
          ),
          // Reset
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset',
            onPressed: () => setState(() {
              _revealedAyahs.clear();
              _showAll = false;
              _correctCount = 0;
              _totalAttempts = 0;
            }),
          ),
        ],
      ),
      body: ayahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
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
            return const Center(child: Text('No ayahs found'));
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
                    final isRevealed =
                        _showAll || _revealedAyahs.contains(ayah.ayahNumber);
                    return _buildHifzCard(ayah, isRevealed);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressBar(List<Ayah> ayahs) {
    final total = ayahs.length;
    final revealed = _showAll ? total : _revealedAyahs.length;
    final progress = total > 0 ? revealed / total : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(77),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                _difficulty.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                '$revealed / $total ayahs revealed',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
              if (_totalAttempts > 0) ...[
                const SizedBox(width: 12),
                Text(
                  '$_correctCount/$_totalAttempts correct',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
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
    return GestureDetector(
      onTap: isRevealed ? null : () => _revealAyah(ayah),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRevealed
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withAlpha(51),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isRevealed
                ? Theme.of(context).colorScheme.outline.withAlpha(51)
                : Theme.of(context).colorScheme.primary.withAlpha(77),
          ),
        ),
        child: Column(
          children: [
            // Ayah number badge
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${ayah.ayahNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                if (isRevealed)
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: Colors.green.withAlpha(179),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // Ayah content
            if (isRevealed)
              Text(
                ayah.textUthmani,
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
        final words = ayah.textUthmani.split(' ');
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
              'Tap to reveal',
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
        final wordCount = ayah.textUthmani.split(' ').length;
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
              'Tap to reveal ($wordCount words)',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withAlpha(153),
                  ),
            ),
          ],
        );

      case HifzDifficulty.hard:
        // Must type first word to reveal
        final words = ayah.textUthmani.split(' ');
        final wordCount = words.length;
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
              'Tap and type the first word to reveal',
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
    if (_difficulty == HifzDifficulty.hard) {
      // Show dialog to type first word
      _showTypeChallenge(ayah);
    } else {
      setState(() {
        _revealedAyahs.add(ayah.ayahNumber);
        _totalAttempts++;
        _correctCount++;
      });
    }
  }

  void _showTypeChallenge(Ayah ayah) {
    final controller = TextEditingController();
    final firstWord = ayah.textUthmani.split(' ').first;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Type the first word'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ayah ${ayah.ayahNumber}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 22),
              decoration: InputDecoration(
                hintText: 'اكتب الكلمة الأولى',
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              autofocus: true,
              onSubmitted: (_) {
                _checkAnswer(controller.text.trim(), firstWord, ayah);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _checkAnswer(controller.text.trim(), firstWord, ayah);
              Navigator.pop(ctx);
            },
            child: const Text('Check'),
          ),
        ],
      ),
    );
  }

  void _checkAnswer(String typed, String correct, Ayah ayah) {
    setState(() => _totalAttempts++);
    // Normalize: remove diacritics for comparison
    final normalizedTyped = _removeDiacritics(typed);
    final normalizedCorrect = _removeDiacritics(correct);

    if (normalizedTyped == normalizedCorrect) {
      setState(() {
        _revealedAyahs.add(ayah.ayahNumber);
        _correctCount++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correct! Ma sha Allah!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Try again. The word was: $correct'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Remove Arabic diacritics (tashkeel) for flexible comparison.
  String _removeDiacritics(String text) {
    return text.replaceAll(_diacriticsRegex, '');
  }
}

enum HifzDifficulty {
  easy('Easy - First word hint'),
  medium('Medium - Fully hidden'),
  hard('Hard - Type to reveal');

  final String label;
  const HifzDifficulty(this.label);
}
