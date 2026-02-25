import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../providers/quran_providers.dart';
import '../../data/models/surah_info.dart';

/// Tafsir screen showing interpretation of a specific ayah.
/// Supports 6 curated Arabic tafsirs via Quran.com API with
/// Al Quran Cloud fallback. Caches results in local DB.
class TafsirScreen extends ConsumerStatefulWidget {
  final SurahInfo surah;
  final int ayahNumber;

  const TafsirScreen({
    super.key,
    required this.surah,
    required this.ayahNumber,
  });

  @override
  ConsumerState<TafsirScreen> createState() => _TafsirScreenState();
}

class _TafsirScreenState extends ConsumerState<TafsirScreen> {
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');

  String? _tafsirText;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTafsir();
  }

  Future<void> _fetchTafsir() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final tafsir = ref.read(defaultTafsirProvider);
    final db = ref.read(databaseProvider);

    // Check cache first
    final cached = await db.getCachedTafsir(
      widget.surah.number,
      widget.ayahNumber,
      tafsir.resourceId,
    );
    if (cached != null) {
      setState(() {
        _tafsirText = cached.tafsirText;
        _loading = false;
      });
      return;
    }

    final apiClient = ref.read(apiClientProvider);
    final verseKey = '${widget.surah.number}:${widget.ayahNumber}';

    // Try Quran.com API (primary)
    try {
      final response = await apiClient.quranComDio.get(
        '/tafsirs/${tafsir.resourceId}/by_ayah/$verseKey',
      );

      final data = response.data['tafsir'];
      if (data != null) {
        String text = (data['text'] ?? '') as String;
        text = text.replaceAll(_htmlTagRegex, '').trim();
        if (text.isNotEmpty) {
          _cacheAndShow(text, tafsir.resourceId, db);
          return;
        }
      }
    } catch (_) {
      // Fallback below
    }

    // Fallback to Al Quran Cloud (only if edition available)
    if (tafsir.fallbackEdition.isNotEmpty) {
      try {
        final response = await apiClient.alQuranCloudDio.get(
          '/ayah/$verseKey/${tafsir.fallbackEdition}',
        );
        final data = response.data['data'];
        if (data != null) {
          final text = (data['text'] ?? '') as String;
          if (text.isNotEmpty) {
            _cacheAndShow(text, tafsir.resourceId, db);
            return;
          }
        }
      } catch (_) {
        // Error below
      }
    }

    setState(() {
      _error = 'Could not load tafsir. Please check your connection.';
      _loading = false;
    });
  }

  void _cacheAndShow(String text, int resourceId, AppDatabase db) {
    setState(() {
      _tafsirText = text;
      _loading = false;
    });
    // Cache in background
    db.cacheTafsir(CachedTafsirsCompanion(
      surahId: drift.Value(widget.surah.number),
      ayahNumber: drift.Value(widget.ayahNumber),
      resourceId: drift.Value(resourceId),
      tafsirText: drift.Value(text),
      cachedAt: drift.Value(DateTime.now()),
    ));
  }

  void _onTafsirChanged(TafsirOption option) {
    ref.read(defaultTafsirProvider.notifier).setTafsir(option);
    _fetchTafsir();
  }

  @override
  Widget build(BuildContext context) {
    final currentTafsir = ref.watch(defaultTafsirProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.surah.nameTransliteration} ${widget.ayahNumber}',
        ),
        actions: [
          PopupMenuButton<TafsirOption>(
            icon: const Icon(Icons.swap_horiz),
            tooltip: 'Change Tafsir',
            onSelected: _onTafsirChanged,
            itemBuilder: (_) => tafsirOptions
                .map((t) => PopupMenuItem<TafsirOption>(
                      value: t,
                      child: Row(
                        children: [
                          if (t.slug == currentTafsir.slug)
                            Icon(Icons.check,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary)
                          else
                            const SizedBox(width: 18),
                          const SizedBox(width: 8),
                          Text(t.name),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _buildTafsir(currentTafsir),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _fetchTafsir,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTafsir(TafsirOption tafsir) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Surah/Ayah header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withAlpha(77),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Tafsir - ${tafsir.name}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.surah.nameArabic} - Ayah ${widget.ayahNumber}',
                style: const TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Tafsir text
        Text(
          _tafsirText ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
              ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
