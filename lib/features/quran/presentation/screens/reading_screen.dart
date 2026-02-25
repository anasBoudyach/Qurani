import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../audio/presentation/providers/audio_providers.dart';
import '../../../bookmarks/presentation/providers/bookmark_providers.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../data/models/surah_info.dart';
import '../providers/quran_providers.dart';
import '../widgets/tajweed_text_widget.dart';
import '../../../../core/constants/tajweed_colors.dart';
import '../../../../core/utils/tajweed_parser.dart';
import 'tafsir_screen.dart';

/// Main Quran reading screen with 2 modes:
/// - Recitation: vertical scroll, ayah-by-ayah cards (translation optional via picker)
/// - Mushaf: page-by-page, Arabic only, horizontal PageView
class ReadingScreen extends ConsumerStatefulWidget {
  final SurahInfo surah;
  final int initialAyah;
  final int? initialPage;

  const ReadingScreen({
    super.key,
    required this.surah,
    this.initialAyah = 1,
    this.initialPage,
  });

  @override
  ConsumerState<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen>
    with WidgetsBindingObserver {
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');
  static final RegExp _ayahEndMarkerRegex =
      RegExp(r'[\s\u06DD]*[\u0660-\u0669\u06F0-\u06F9]+[\s\u200F\u200E]*$');
  static final RegExp _htmlAyahEndRegex = RegExp(
    r'\s*(?:<span[^>]*>\s*)?[\u06DD]?\s*[\u0660-\u0669\u06F0-\u06F9]+\s*(?:</span>)?\s*$',
  );

  late ReadingMode _mode;
  int _currentAyah = 1;
  int _currentPage = 0;
  Timer? _saveDebounce;

  // Controllers
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  PageController? _pageController;

  // Initial scroll tracking
  bool _initialScrollDone = false;

  // Audio auto-scroll state
  bool _userIsScrolling = false;
  Timer? _userScrollTimer;

  // Cached ayah data for synchronization
  List<Ayah>? _loadedAyahs;
  Map<int, List<Ayah>>? _pageMap;
  List<int>? _pageNumbers;

  String _plainText(Ayah ayah) {
    if (ayah.textUthmani.isNotEmpty) return ayah.textUthmani;
    return ayah.textUthmaniTajweed?.replaceAll(_htmlTagRegex, '') ?? '';
  }

  String _plainTextNoNumber(Ayah ayah) {
    return _plainText(ayah).replaceAll(_ayahEndMarkerRegex, '').trimRight();
  }

  String _tajweedHtmlNoNumber(String html) {
    return html.replaceAll(_htmlAyahEndRegex, '').trimRight();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize from saved preference
    _mode = ref.read(readingModeProvider);
    _currentAyah = widget.initialAyah;

    // Record reading activity for gamification
    Future.microtask(() {
      ref.read(gamificationServiceProvider)
          .recordActivity(ActivityType.readQuran);
    });

    // Save initial position after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveCurrentPosition();
    });

    // Listen for visible item changes (recitation mode position tracking)
    _itemPositionsListener.itemPositions.addListener(_onPositionsChanged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _saveDebounce?.cancel();
    _userScrollTimer?.cancel();
    _itemPositionsListener.itemPositions.removeListener(_onPositionsChanged);
    _pageController?.dispose();
    super.dispose();
  }

  // ─── Lifecycle ───

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveCurrentPosition();
    }
  }

  // ─── Position Saving ───

  Future<void> _saveCurrentPosition() async {
    if (_currentAyah <= 0) return;
    final repo = ref.read(bookmarkRepositoryProvider);
    await repo.saveReadingPosition(
      surahId: widget.surah.number,
      ayahNumber: _currentAyah,
      pageNumber: _currentPage,
    );
    ref.read(readingModeProvider.notifier).setMode(_mode);
    ref.invalidate(lastReadingPositionProvider);
  }

  void _debouncedSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 500), () {
      _saveCurrentPosition();
    });
  }

  // ─── Scroll Tracking (Recitation Mode) ───

  void _onPositionsChanged() {
    if (_loadedAyahs == null || _loadedAyahs!.isEmpty) return;

    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    // Find the first visible ayah item (index > 0, since index 0 = header)
    final ayahPositions = positions.where((p) => p.index > 0).toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    if (ayahPositions.isEmpty) return;

    final firstVisible = ayahPositions.first;
    final ayahIndex = (firstVisible.index - 1).clamp(0, _loadedAyahs!.length - 1);
    final newAyah = _loadedAyahs![ayahIndex].ayahNumber;

    if (newAyah != _currentAyah) {
      _currentAyah = newAyah;
      _currentPage = _loadedAyahs![ayahIndex].pageNumber;
      _debouncedSave();
    }
  }

  // ─── Mode Switching (Synchronized) ───

  void _switchToMode(ReadingMode newMode) {
    if (newMode == _mode) return;

    setState(() {
      if (newMode == ReadingMode.mushaf && _loadedAyahs != null) {
        // Recitation → Mushaf: find page for current ayah
        _buildPageMap(_loadedAyahs!);
        final pageIndex = _findPageIndexForAyah(_currentAyah);
        _pageController?.dispose();
        _pageController = PageController(initialPage: pageIndex);
      }
      _mode = newMode;
    });

    // When switching to recitation, ScrollablePositionedList rebuilds
    // with initialScrollIndex: _currentAyah, so no manual scroll needed.

    ref.read(readingModeProvider.notifier).setMode(newMode);
  }

  void _buildPageMap(List<Ayah> ayahs) {
    _pageMap = <int, List<Ayah>>{};
    for (final ayah in ayahs) {
      _pageMap!.putIfAbsent(ayah.pageNumber, () => []).add(ayah);
    }
    _pageNumbers = _pageMap!.keys.toList()..sort();
  }

  int _findPageIndexForAyah(int ayahNumber) {
    if (_pageNumbers == null || _pageMap == null) return 0;
    for (int i = 0; i < _pageNumbers!.length; i++) {
      final pageAyahs = _pageMap![_pageNumbers![i]]!;
      if (pageAyahs.any((a) => a.ayahNumber == ayahNumber)) {
        return i;
      }
    }
    return 0;
  }

  void _scrollToAyah(int ayahNumber, {bool animate = true}) {
    if (!_itemScrollController.isAttached) return;
    // index 0 = header, so ayahNumber maps directly to item index
    if (animate) {
      _itemScrollController.scrollTo(
        index: ayahNumber,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _itemScrollController.jumpTo(index: ayahNumber);
    }
  }

  // ─── Audio Auto-Scroll ───

  void _handleAudioAyahChange(int? previousAyah, int? newAyah) {
    if (newAyah == null) return;
    final audioState = ref.read(currentAudioStateProvider);
    if (audioState.currentSurah != widget.surah.number) return;
    if (!audioState.isPlaying) return;

    _currentAyah = newAyah;
    if (_loadedAyahs != null) {
      final ayah = _loadedAyahs!.firstWhere(
        (a) => a.ayahNumber == newAyah,
        orElse: () => _loadedAyahs!.first,
      );
      _currentPage = ayah.pageNumber;
    }

    if (_mode == ReadingMode.recitation && !_userIsScrolling) {
      _scrollToAyah(newAyah);
    } else if (_mode == ReadingMode.mushaf) {
      // Auto-flip page if the ayah is on a different page
      final pageIndex = _findPageIndexForAyah(newAyah);
      if (_pageController != null && _pageController!.hasClients) {
        final currentPageIndex = _pageController!.page?.round() ?? 0;
        if (pageIndex != currentPageIndex) {
          _pageController!.animateToPage(
            pageIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }

    _debouncedSave();
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    final ayahsAsync = ref.watch(surahAyahsProvider(widget.surah.number));
    final selectedTranslation = ref.watch(defaultTranslationProvider);
    final showTranslation = selectedTranslation.edition != 'none';
    final translationAsync = showTranslation
        ? ref.watch(surahTranslationProvider(
            (
              surahNumber: widget.surah.number,
              edition: selectedTranslation.edition
            ),
          ))
        : null;

    // Listen for audio ayah changes (auto-scroll)
    ref.listen<int?>(
      currentAudioStateProvider.select((s) => s.currentAyah),
      _handleAudioAyahChange,
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _saveCurrentPosition();
      },
      child: Scaffold(
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
            if (_mode == ReadingMode.mushaf)
              _mushafPlayButton(),
            Consumer(builder: (context, ref, _) {
              final showTajweed = ref.watch(tajweedProvider);
              final continuous = ref.watch(
                currentAudioStateProvider.select((s) => s.continuousMode),
              );
              return PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                tooltip: AppLocalizations.of(context).options,
                onSelected: (value) {
                  switch (value) {
                    case 'mode_recitation':
                      _switchToMode(ReadingMode.recitation);
                    case 'mode_mushaf':
                      _switchToMode(ReadingMode.mushaf);
                    case 'tajweed':
                      ref.read(tajweedProvider.notifier).toggle();
                    case 'translation':
                      _showTranslationPicker();
                    case 'continuous':
                      ref
                          .read(audioPlayerServiceProvider)
                          .toggleContinuousMode();
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                      enabled: false,
                      height: 32,
                      child: Text(AppLocalizations.of(context).readingMode,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600))),
                  _checkItem('mode_recitation', AppLocalizations.of(context).recitation,
                      Icons.auto_stories, _mode == ReadingMode.recitation),
                  _checkItem('mode_mushaf', AppLocalizations.of(context).mushaf,
                      Icons.menu_book_outlined, _mode == ReadingMode.mushaf),
                  const PopupMenuDivider(),
                  _checkItem('tajweed', AppLocalizations.of(context).tajweedColors,
                      Icons.color_lens_outlined, showTajweed),
                  _checkItem('continuous', AppLocalizations.of(context).continuousPlayback,
                      Icons.playlist_play_rounded, continuous),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                      value: 'translation',
                      child: Row(children: [
                        const Icon(Icons.language, size: 20),
                        const SizedBox(width: 12),
                        Text(AppLocalizations.of(context).changeTranslation)
                      ])),
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
              return Center(child: Text(AppLocalizations.of(context).noAyahsFound));
            }

            // Cache ayahs for synchronization and scroll tracking
            _loadedAyahs = ayahs;
            _buildPageMap(ayahs);

            // Resolve initialPage → first ayah on that page
            if (widget.initialPage != null &&
                _currentAyah <= 1 &&
                _pageMap!.containsKey(widget.initialPage)) {
              _currentAyah = _pageMap![widget.initialPage]!.first.ayahNumber;
            }

            // Ensure initial scroll position after list is built
            if (_currentAyah > 1 && !_initialScrollDone) {
              _initialScrollDone = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToAyah(_currentAyah, animate: false);
              });
            }

            // Initialize page controller for mushaf if needed
            if (_mode == ReadingMode.mushaf && _pageController == null) {
              final pageIndex = _findPageIndexForAyah(_currentAyah);
              _pageController = PageController(initialPage: pageIndex);
            }

            final translations = translationAsync?.valueOrNull ?? [];

            switch (_mode) {
              case ReadingMode.recitation:
                return _buildRecitationMode(ayahs, translations);
              case ReadingMode.mushaf:
                return _buildMushafMode(ayahs);
            }
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> _checkItem(
      String value, String label, IconData icon, bool checked) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          if (checked)
            Icon(Icons.check,
                size: 18, color: Theme.of(context).colorScheme.primary),
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
                AppLocalizations.of(context).translation,
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

  void _showReciterPicker() {
    final current = ref.read(defaultReciterProvider);
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
                AppLocalizations.of(context).reciter,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                current.name,
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
                  children: reciterOptions
                      .map((option) => RadioListTile<String>(
                            value: option.id,
                            groupValue: current.id,
                            title: Text(option.name),
                            secondary: Icon(
                              Icons.mic_rounded,
                              color: option.id == current.id
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(100),
                              size: 20,
                            ),
                            onChanged: (_) {
                              ref
                                  .read(defaultReciterProvider.notifier)
                                  .setReciter(option);
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
            Icon(Icons.cloud_off,
                size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).couldNotLoad,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).checkConnection,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                ref.invalidate(surahAyahsProvider(widget.surah.number));
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Recitation Mode ───

  Widget _buildRecitationMode(
      List<Ayah> ayahs, List<AyahTranslation> translations) {
    final translationMap = <int, AyahTranslation>{};
    for (final t in translations) {
      translationMap[t.ayahNumber] = t;
    }

    return Listener(
      onPointerDown: (_) {
        _userIsScrolling = true;
        _userScrollTimer?.cancel();
      },
      onPointerUp: (_) {
        // Re-enable auto-scroll after user stops touching for 3 seconds
        _userScrollTimer?.cancel();
        _userScrollTimer = Timer(const Duration(seconds: 3), () {
          _userIsScrolling = false;
        });
      },
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemPositionsListener: _itemPositionsListener,
        initialScrollIndex: _currentAyah > 1 ? _currentAyah : 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ayahs.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildSurahHeader();
          }
          final ayah = ayahs[index - 1];
          final translation = translationMap[ayah.ayahNumber];
          return _buildTranslationAyahCard(ayah, translation);
        },
      ),
    );
  }

  Widget _buildSurahHeader() {
    if (widget.surah.number == 9) {
      return _buildSurahInfoHeader();
    }

    return Column(
      children: [
        _buildSurahInfoHeader(),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withAlpha(51),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: ref.watch(fontSizeProvider),
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
              '${widget.surah.nameEnglish} • ${widget.surah.ayahCount} ${AppLocalizations.of(context).ayahNumbers}',
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
                widget.surah.isMeccan ? AppLocalizations.of(context).meccan : AppLocalizations.of(context).medinan,
                style: TextStyle(
                  fontSize: 12,
                  color: onPrimary.withAlpha(230),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Reciter selector chip
            Consumer(builder: (context, ref, _) {
              final reciter = ref.watch(defaultReciterProvider);
              return GestureDetector(
                onTap: _showReciterPicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: onPrimary.withAlpha(36),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: onPrimary.withAlpha(60),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.mic_rounded,
                          size: 14, color: onPrimary.withAlpha(220)),
                      const SizedBox(width: 6),
                      Text(
                        reciter.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: onPrimary.withAlpha(220),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.expand_more_rounded,
                          size: 16, color: onPrimary.withAlpha(180)),
                    ],
                  ),
                ),
              );
            }),
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
                  formatAyahNumber(
                      ayah.ayahNumber, ref.watch(numeralStyleProvider)),
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const Spacer(),
              _playPauseButton(ayah.ayahNumber),
              _bookmarkButton(ayah.ayahNumber),
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
              }, AppLocalizations.of(context).tafsir),
            ],
          ),
          const SizedBox(height: 12),
          if (ref.watch(tajweedProvider) &&
              ayah.textUthmaniTajweed != null) ...[
            TajweedTextWidget(
              textUthmaniTajweed:
                  _tajweedHtmlNoNumber(ayah.textUthmaniTajweed!),
              fontSize: ref.watch(fontSizeProvider),
            ),
          ] else ...[
            Text(
              _plainTextNoNumber(ayah),
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: ref.watch(fontSizeProvider),
                height: 2.0,
                locale: const Locale('ar'),
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          ],
          if (ref.watch(defaultTranslationProvider).edition != 'none' &&
              translation != null) ...[
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

  Widget _bookmarkButton(int ayahNumber) {
    return Consumer(builder: (context, ref, _) {
      final isBookmarked = ref.watch(isAyahBookmarkedProvider(
        (surahId: widget.surah.number, ayahNumber: ayahNumber),
      ));

      return IconButton(
        icon: Icon(
          isBookmarked.valueOrNull == true
              ? Icons.bookmark_rounded
              : Icons.bookmark_outline_rounded,
          size: 20,
        ),
        onPressed: () async {
          HapticFeedback.lightImpact();
          final repo = ref.read(bookmarkRepositoryProvider);
          await repo.toggleBookmark(
            surahId: widget.surah.number,
            ayahNumber: ayahNumber,
          );
          ref.invalidate(isAyahBookmarkedProvider(
            (surahId: widget.surah.number, ayahNumber: ayahNumber),
          ));
          ref.invalidate(bookmarksProvider);
        },
        tooltip: isBookmarked.valueOrNull == true
            ? AppLocalizations.of(context).removeBookmark
            : AppLocalizations.of(context).bookmarkAyah,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        color: isBookmarked.valueOrNull == true
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withAlpha(153),
      );
    });
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
          if (ref.read(offlineModeProvider) && !isThisAyahPlaying && !isThisAyahLoading) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context).offlineNotAvailable),
                behavior: SnackBarBehavior.floating,
              ));
            return;
          }
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
        tooltip: isThisAyahPlaying ? AppLocalizations.of(context).pause : AppLocalizations.of(context).playAyah,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        color: isThisAyahPlaying
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withAlpha(153),
      );
    });
  }

  Widget _mushafPlayButton() {
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

      final isThisSurahPlaying =
          isPlaying && playingSurah == widget.surah.number;
      final isThisSurahLoading = (isLoading || isBuffering) &&
          playingSurah == widget.surah.number;

      return IconButton(
        icon: Icon(
          isThisSurahLoading
              ? Icons.hourglass_top_rounded
              : isThisSurahPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
        ),
        onPressed: () {
          if (ref.read(offlineModeProvider) && !isThisSurahPlaying && !isThisSurahLoading) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context).offlineNotAvailable),
                behavior: SnackBarBehavior.floating,
              ));
            return;
          }
          final service = ref.read(audioPlayerServiceProvider);
          if (isThisSurahPlaying) {
            service.pause();
          } else if (isThisSurahLoading) {
            // Already loading
          } else if (playingSurah == widget.surah.number && !isPlaying) {
            service.play();
          } else {
            final reciter = ref.read(defaultReciterProvider);
            final currentPageAyahs = _pageMap?[_currentPage];
            final firstAyah = currentPageAyahs?.first.ayahNumber ?? 1;
            service.playAyah(
              surahNumber: widget.surah.number,
              ayahNumber: firstAyah,
              reciterFolder: reciter.id,
              reciterName: reciter.name,
              totalAyahs: widget.surah.ayahCount,
            );
          }
        },
        tooltip: isThisSurahPlaying
            ? AppLocalizations.of(context).pause
            : AppLocalizations.of(context).play,
      );
    });
  }

  // ─── Mushaf Mode ───

  Widget _buildMushafMode(List<Ayah> ayahs) {
    if (_pageNumbers == null || _pageNumbers!.isEmpty) {
      return _buildRecitationMode(ayahs, []);
    }

    return PageView.builder(
      controller: _pageController,
      reverse: true, // RTL page turning
      itemCount: _pageNumbers!.length,
      onPageChanged: (index) {
        final pageNum = _pageNumbers![index];
        final pageAyahs = _pageMap![pageNum]!;
        _currentPage = pageNum;
        _currentAyah = pageAyahs.first.ayahNumber;
        _debouncedSave();
      },
      itemBuilder: (context, index) {
        final pageNum = _pageNumbers![index];
        final pageAyahs = _pageMap![pageNum]!;
        return _buildMushafPage(pageNum, pageAyahs);
      },
    );
  }

  Widget _buildMushafPage(int pageNumber, List<Ayah> ayahs) {
    final showTajweed = ref.watch(tajweedProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = Theme.of(context).colorScheme.onSurface;
    final fontSize = ref.watch(fontSizeProvider);
    final audioState = ref.watch(currentAudioStateProvider);
    final playingAyah = audioState.isPlaying &&
            audioState.currentSurah == widget.surah.number
        ? audioState.currentAyah
        : null;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context).juz} ${ayahs.first.juzNumber}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(128),
                      ),
                ),
                Text(
                  '${AppLocalizations.of(context).page} $pageNumber',
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text.rich(
                  TextSpan(
                    children: ayahs.map((ayah) {
                      return _buildMushafAyahSpan(
                        ayah,
                        showTajweed: showTajweed,
                        isDark: isDark,
                        defaultColor: defaultColor,
                        fontSize: fontSize,
                        isPlayingAyah: playingAyah == ayah.ayahNumber,
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

  TextSpan _buildMushafAyahSpan(
    Ayah ayah, {
    required bool showTajweed,
    required bool isDark,
    required Color defaultColor,
    required double fontSize,
    required bool isPlayingAyah,
  }) {
    final baseStyle = TextStyle(
      fontFamily: 'AmiriQuran',
      fontSize: fontSize,
      height: 2.2,
      locale: const Locale('ar'),
      backgroundColor: isPlayingAyah
          ? Theme.of(context).colorScheme.primary.withAlpha(30)
          : null,
    );

    final numberSuffix =
        ' \u06DD${formatAyahNumber(ayah.ayahNumber, NumeralStyle.arabic)} ';

    if (showTajweed && ayah.textUthmaniTajweed != null) {
      final html = _tajweedHtmlNoNumber(ayah.textUthmaniTajweed!);
      final tokens = TajweedParser.parse(html);

      final children = tokens.map((token) {
        Color? tokenColor;
        if (token.hasTajweedRule) {
          // Reverse-lookup: category -> CSS class -> color
          for (final entry in TajweedColors.cssClassToCategory.entries) {
            if (entry.value == token.rule) {
              final baseColor = TajweedColors.cssClassToColor[entry.key];
              if (baseColor != null) {
                tokenColor =
                    isDark ? TajweedColors.forDarkMode(baseColor) : baseColor;
              }
              break;
            }
          }
        }
        return TextSpan(
          text: token.text,
          style: baseStyle.copyWith(color: tokenColor ?? defaultColor),
        );
      }).toList();

      // Append ayah number marker
      children.add(TextSpan(
        text: numberSuffix,
        style: baseStyle.copyWith(color: defaultColor),
      ));

      return TextSpan(children: children);
    } else {
      return TextSpan(
        text: '${_plainTextNoNumber(ayah)}$numberSuffix',
        style: baseStyle.copyWith(color: defaultColor),
      );
    }
  }
}
