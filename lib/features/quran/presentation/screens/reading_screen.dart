import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../audio/presentation/providers/audio_providers.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../data/models/surah_info.dart';
import '../providers/quran_providers.dart';
import '../widgets/tajweed_text_widget.dart';
import 'tafsir_screen.dart';

/// Reading modes for the Quran reader.
enum ReadingMode { translation, mushaf, split }

/// Main Quran reading screen with 3 modes:
/// - Translation: vertical scroll, ayah-by-ayah with Arabic + translation
/// - Mushaf: page-by-page, Arabic only, horizontal PageView
/// - Split: Arabic top / translation bottom
class ReadingScreen extends ConsumerStatefulWidget {
  final SurahInfo surah;
  final int initialAyah;

  const ReadingScreen({
    super.key,
    required this.surah,
    this.initialAyah = 1,
  });

  @override
  ConsumerState<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen> {
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');
  /// Matches trailing ayah-end sign (۝) + Arabic-Indic digits (both ranges) at end of plain text.
  static final RegExp _ayahEndMarkerRegex = RegExp(r'[\s\u06DD]*[\u0660-\u0669\u06F0-\u06F9]+[\s\u200F\u200E]*$');
  /// Same but for tajweed HTML where digits may be wrapped in <span>...</span>.
  static final RegExp _htmlAyahEndRegex = RegExp(
    r'\s*(?:<span[^>]*>\s*)?[\u06DD]?\s*[\u0660-\u0669\u06F0-\u06F9]+\s*(?:</span>)?\s*$',
  );
  ReadingMode _mode = ReadingMode.translation;
  double _fontSize = 28.0;
  bool _showTranslation = true;

  /// Plain text fallback: if textUthmani is empty, strip HTML from tajweed.
  String _plainText(Ayah ayah) {
    if (ayah.textUthmani.isNotEmpty) return ayah.textUthmani;
    return ayah.textUthmaniTajweed?.replaceAll(_htmlTagRegex, '') ?? '';
  }

  /// Plain text with trailing ayah number stripped (for card-based modes).
  String _plainTextNoNumber(Ayah ayah) {
    return _plainText(ayah).replaceAll(_ayahEndMarkerRegex, '').trimRight();
  }

  /// Tajweed HTML with trailing ayah number stripped (for card-based modes).
  String _tajweedHtmlNoNumber(String html) {
    return html.replaceAll(_htmlAyahEndRegex, '').trimRight();
  }

  @override
  void initState() {
    super.initState();
    // Record reading activity for gamification
    Future.microtask(() {
      ref.read(gamificationServiceProvider).recordActivity(ActivityType.readQuran);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ayahsAsync = ref.watch(surahAyahsProvider(widget.surah.number));
    final selectedTranslation = ref.watch(defaultTranslationProvider);
    final translationAsync = ref.watch(surahTranslationProvider(
      (surahNumber: widget.surah.number, edition: selectedTranslation.edition),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.surah.nameTransliteration,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              widget.surah.nameArabic,
              style: const TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Consumer(builder: (context, ref, _) {
            final showTajweed = ref.watch(tajweedProvider);
            final continuous = ref.watch(
              currentAudioStateProvider.select((s) => s.continuousMode),
            );
            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Options',
              onSelected: (value) {
                switch (value) {
                  case 'mode_translation':
                    setState(() => _mode = ReadingMode.translation);
                  case 'mode_mushaf':
                    setState(() => _mode = ReadingMode.mushaf);
                  case 'mode_split':
                    setState(() => _mode = ReadingMode.split);
                  case 'font_22':
                    setState(() => _fontSize = 22);
                  case 'font_28':
                    setState(() => _fontSize = 28);
                  case 'font_34':
                    setState(() => _fontSize = 34);
                  case 'font_40':
                    setState(() => _fontSize = 40);
                  case 'tajweed':
                    ref.read(tajweedProvider.notifier).toggle();
                  case 'translation':
                    _showTranslationPicker();
                  case 'continuous':
                    ref.read(audioPlayerServiceProvider).toggleContinuousMode();
                }
              },
              itemBuilder: (_) => [
                // ── Reading Mode ──
                const PopupMenuItem(enabled: false, height: 32, child: Text('Reading Mode', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                _checkItem('mode_translation', 'Translation', Icons.translate, _mode == ReadingMode.translation),
                _checkItem('mode_mushaf', 'Mushaf', Icons.menu_book_outlined, _mode == ReadingMode.mushaf),
                _checkItem('mode_split', 'Split View', Icons.vertical_split_outlined, _mode == ReadingMode.split),
                const PopupMenuDivider(),
                // ── Font Size ──
                const PopupMenuItem(enabled: false, height: 32, child: Text('Font Size', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                _checkItem('font_22', 'Small', Icons.text_fields, _fontSize == 22),
                _checkItem('font_28', 'Medium', Icons.text_fields, _fontSize == 28),
                _checkItem('font_34', 'Large', Icons.text_fields, _fontSize == 34),
                _checkItem('font_40', 'Extra Large', Icons.text_fields, _fontSize == 40),
                const PopupMenuDivider(),
                // ── Toggles ──
                _checkItem('tajweed', 'Tajweed Colors', Icons.color_lens_outlined, showTajweed),
                _checkItem('continuous', 'Continuous Playback', Icons.playlist_play_rounded, continuous),
                const PopupMenuDivider(),
                // ── Actions ──
                const PopupMenuItem(value: 'translation', child: Row(children: [Icon(Icons.language, size: 20), SizedBox(width: 12), Text('Change Translation')])),
              ],
            );
          }),
        ],
      ),
      body: ayahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildErrorView(error),
        data: (ayahs) {
          if (ayahs.isEmpty) {
            return const Center(child: Text('No ayahs found'));
          }

          final translations = translationAsync.valueOrNull ?? [];

          switch (_mode) {
            case ReadingMode.translation:
              return _buildTranslationMode(ayahs, translations);
            case ReadingMode.mushaf:
              return _buildMushafMode(ayahs);
            case ReadingMode.split:
              return _buildSplitMode(ayahs, translations);
          }
        },
      ),
    );
  }

  PopupMenuItem<String> _checkItem(String value, String label, IconData icon, bool checked) {
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

  void _showTranslationPicker() {
    final current = ref.read(defaultTranslationProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.8,
        minChildSize: 0.3,
        expand: false,
        builder: (sheetContext, scrollController) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Translation',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${current.name} (${current.language})',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: translationOptions
                      .map((option) => RadioListTile<String>(
                            value: option.edition,
                            groupValue: current.edition,
                            title: Text(option.name),
                            subtitle: Text(option.language),
                            onChanged: (_) {
                              ref
                                  .read(defaultTranslationProvider.notifier)
                                  .setTranslation(option);
                              Navigator.pop(sheetContext);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 64,
                color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Could not load surah',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                ref.invalidate(surahAyahsProvider(widget.surah.number));
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Translation Mode ───

  Widget _buildTranslationMode(
      List<Ayah> ayahs, List<AyahTranslation> translations) {
    // Pre-build lookup map: O(1) per ayah instead of O(N)
    final translationMap = <int, AyahTranslation>{};
    for (final t in translations) {
      translationMap[t.ayahNumber] = t;
    }

    return ListView.builder(
      cacheExtent: 800,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: ayahs.length + 1, // +1 for bismillah header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildSurahHeader();
        }
        final ayah = ayahs[index - 1];
        final translation = translationMap[ayah.ayahNumber];

        return _buildTranslationAyahCard(ayah, translation);
      },
    );
  }

  Widget _buildSurahHeader() {
    // Don't show bismillah for Surah At-Tawbah (9)
    if (widget.surah.number == 9) {
      return _buildSurahInfoHeader();
    }

    return Column(
      children: [
        _buildSurahInfoHeader(),
        // Bismillah
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withAlpha(51),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: _fontSize,
                height: 2.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurahInfoHeader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withAlpha(204),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Builder(builder: (context) {
        final onPrimary = Theme.of(context).colorScheme.onPrimary;
        return Column(
          children: [
            Text(
              widget.surah.nameArabic,
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 32,
                color: onPrimary,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 4),
            Text(
              widget.surah.nameTransliteration,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: onPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${widget.surah.nameEnglish} • ${widget.surah.ayahCount} Ayahs',
              style: TextStyle(
                fontSize: 14,
                color: onPrimary.withAlpha(204),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: onPrimary.withAlpha(51),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.surah.isMeccan ? 'Meccan' : 'Medinan',
                style: TextStyle(
                  fontSize: 12,
                  color: onPrimary.withAlpha(230),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTranslationAyahCard(Ayah ayah, AyahTranslation? translation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ayah number + actions row
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  formatAyahNumber(ayah.ayahNumber, ref.watch(numeralStyleProvider)),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const Spacer(),
              // Action buttons
              _playPauseButton(ayah.ayahNumber),
              _ayahActionButton(Icons.menu_book_rounded, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TafsirScreen(
                      surah: widget.surah,
                      ayahNumber: ayah.ayahNumber,
                    ),
                  ),
                );
              }, 'Tafsir'),
            ],
          ),
          const SizedBox(height: 12),
          // Arabic text (tajweed or plain based on preference)
          if (ref.watch(tajweedProvider) && ayah.textUthmaniTajweed != null) ...[
            TajweedTextWidget(
              textUthmaniTajweed: _tajweedHtmlNoNumber(ayah.textUthmaniTajweed!),
              fontSize: _fontSize,
            ),
          ] else ...[
            Text(
              _plainTextNoNumber(ayah),
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: _fontSize,
                height: 2.0,
                locale: const Locale('ar'),
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          ],
          // Translation
          if (_showTranslation && translation != null) ...[
            const SizedBox(height: 12),
            Divider(
              color: Theme.of(context).colorScheme.outline.withAlpha(51),
            ),
            const SizedBox(height: 8),
            Text(
              translation.translationText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(179),
                  ),
              textAlign: TextAlign.left,
            ),
          ],
        ],
      ),
    );
  }

  Widget _ayahActionButton(
      IconData icon, VoidCallback onPressed, String tooltip) {
    return IconButton(
      icon: Icon(icon, size: 20),
      onPressed: onPressed,
      tooltip: tooltip,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
    );
  }

  /// Play/pause button isolated with Consumer + select to avoid rebuilding
  /// every ayah card on each position tick.
  Widget _playPauseButton(int ayahNumber) {
    return Consumer(builder: (context, ref, _) {
      final isPlaying = ref.watch(
        currentAudioStateProvider.select((s) => s.isPlaying),
      );
      final isLoading = ref.watch(
        currentAudioStateProvider.select((s) => s.isLoading),
      );
      final isBuffering = ref.watch(
        currentAudioStateProvider.select((s) => s.isBuffering),
      );
      final playingSurah = ref.watch(
        currentAudioStateProvider.select((s) => s.currentSurah),
      );
      final playingAyah = ref.watch(
        currentAudioStateProvider.select((s) => s.currentAyah),
      );

      final isThisAyahPlaying = isPlaying &&
          playingSurah == widget.surah.number &&
          playingAyah == ayahNumber;
      final isThisAyahLoading = (isLoading || isBuffering) &&
          playingSurah == widget.surah.number &&
          playingAyah == ayahNumber;

      return IconButton(
        icon: Icon(
          isThisAyahLoading
              ? Icons.hourglass_top_rounded
              : isThisAyahPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
          size: 20,
        ),
        onPressed: () {
          final service = ref.read(audioPlayerServiceProvider);
          if (isThisAyahPlaying) {
            service.pause();
          } else if (isThisAyahLoading) {
            // Already loading, do nothing
          } else {
            final reciter = ref.read(defaultReciterProvider);
            service.playAyah(
              surahNumber: widget.surah.number,
              ayahNumber: ayahNumber,
              reciterFolder: reciter.id,
              reciterName: reciter.name,
              totalAyahs: widget.surah.ayahCount,
            );
          }
        },
        tooltip: isThisAyahPlaying ? 'Pause' : 'Play ayah',
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        color: isThisAyahPlaying
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withAlpha(153),
      );
    });
  }

  // ─── Mushaf Mode ───

  Widget _buildMushafMode(List<Ayah> ayahs) {
    // Group ayahs by page number
    final pages = <int, List<Ayah>>{};
    for (final ayah in ayahs) {
      pages.putIfAbsent(ayah.pageNumber, () => []).add(ayah);
    }
    final pageNumbers = pages.keys.toList()..sort();

    if (pageNumbers.isEmpty) {
      return _buildTranslationMode(ayahs, []);
    }

    return PageView.builder(
      reverse: true, // RTL page turning
      itemCount: pageNumbers.length,
      itemBuilder: (context, index) {
        final pageNum = pageNumbers[index];
        final pageAyahs = pages[pageNum]!;
        return _buildMushafPage(pageNum, pageAyahs);
      },
    );
  }

  Widget _buildMushafPage(int pageNumber, List<Ayah> ayahs) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Page number header
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Juz ${ayahs.first.juzNumber}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(128),
                      ),
                ),
                Text(
                  'Page $pageNumber',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(128),
                      ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Ayah text - continuous flow
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text.rich(
                  TextSpan(
                    children: ayahs.map((ayah) {
                      return TextSpan(
                        text: '${_plainTextNoNumber(ayah)} \u06DD${formatAyahNumber(ayah.ayahNumber, NumeralStyle.arabic)} ',
                        style: TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: _fontSize,
                          height: 2.2,
                          locale: const Locale('ar'),
                        ),
                      );
                    }).toList(),
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Split Mode ───

  Widget _buildSplitMode(
      List<Ayah> ayahs, List<AyahTranslation> translations) {
    // Pre-build lookup map: O(1) per ayah instead of O(N)
    final translationMap = <int, AyahTranslation>{};
    for (final t in translations) {
      translationMap[t.ayahNumber] = t;
    }

    return Column(
      children: [
        // Toggle translation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Text('Show translation'),
              const Spacer(),
              Switch(
                value: _showTranslation,
                onChanged: (v) => setState(() => _showTranslation = v),
              ),
            ],
          ),
        ),
        // Split view
        Expanded(
          child: ListView.builder(
            cacheExtent: 800,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              final translation = translationMap[ayah.ayahNumber];

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Translation (left)
                    if (_showTranslation)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withAlpha(128),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${formatAyahNumber(ayah.ayahNumber, ref.watch(numeralStyleProvider))}.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                translation?.translationText ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Arabic (right)
                    Expanded(
                      flex: _showTranslation ? 1 : 2,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withAlpha(51),
                          borderRadius: _showTranslation
                              ? const BorderRadius.horizontal(
                                  right: Radius.circular(12))
                              : BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                _playPauseButton(ayah.ayahNumber),
                              ],
                            ),
                            (ref.watch(tajweedProvider) && ayah.textUthmaniTajweed != null)
                                ? TajweedTextWidget(
                                    textUthmaniTajweed: _tajweedHtmlNoNumber(ayah.textUthmaniTajweed!),
                                    fontSize: _fontSize * 0.85,
                                  )
                                : Text(
                                    _plainTextNoNumber(ayah),
                                    style: TextStyle(
                                      fontFamily: 'AmiriQuran',
                                      fontSize: _fontSize * 0.85,
                                      height: 1.8,
                                    ),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
