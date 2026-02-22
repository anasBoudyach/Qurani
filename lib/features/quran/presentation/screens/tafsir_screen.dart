import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/quran_providers.dart';
import '../../data/models/surah_info.dart';

/// Tafsir screen showing interpretation of a specific ayah.
/// Uses Quran.com API with Al Quran Cloud fallback.
/// Uses the shared ApiClient singleton (no raw Dio).
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
  String _tafsirName = 'Ibn Kathir';
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

    final apiClient = ref.read(apiClientProvider);

    try {
      // Try Quran.com API first (tafsir resource ID 169 = Ibn Kathir)
      final response = await apiClient.quranComDio.get(
        '/quran/tafsirs/169',
        queryParameters: {
          'verse_key': '${widget.surah.number}:${widget.ayahNumber}',
        },
      );

      final tafsirs = response.data['tafsirs'] as List?;
      if (tafsirs != null && tafsirs.isNotEmpty) {
        String text = tafsirs.first['text'] ?? '';
        text = text.replaceAll(_htmlTagRegex, '');
        setState(() {
          _tafsirText = text;
          _loading = false;
        });
        return;
      }
    } catch (_) {
      // Fallback below
    }

    // Fallback to Al Quran Cloud (Ibn Kathir Arabic tafsir)
    try {
      final response = await apiClient.alQuranCloudDio.get(
        '/ayah/${widget.surah.number}:${widget.ayahNumber}/ar.muyassar',
      );
      final data = response.data['data'];
      setState(() {
        _tafsirText = data['text'] ?? 'No tafsir available';
        _tafsirName = 'Tafsir Al-Muyassar';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Could not load tafsir. Please check your connection.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.surah.nameTransliteration} ${widget.ayahNumber}',
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _buildTafsir(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 48,
                color: Theme.of(context).colorScheme.error),
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

  Widget _buildTafsir() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Surah/Ayah header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withAlpha(77),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Tafsir - $_tafsirName',
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
        ),
      ],
    );
  }
}
