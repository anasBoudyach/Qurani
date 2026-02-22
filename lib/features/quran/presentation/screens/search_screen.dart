import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/models/surah_info.dart';
import '../providers/quran_providers.dart';
import 'reading_screen.dart';

/// Search result combining surah info with ayah data.
class SearchResult {
  final SurahInfo surah;
  final Ayah ayah;

  const SearchResult({required this.surah, required this.ayah});
}

/// Provider for search results.
final searchResultsProvider =
    FutureProvider.family<List<SearchResult>, String>((ref, query) async {
  if (query.trim().isEmpty) return [];

  final db = ref.watch(databaseProvider);
  // Search in ayahs table for text matching (uthmani text only, non-nullable)
  final pattern = '%$query%';
  final results = await (db.select(db.ayahs)
        ..where((a) => a.textUthmani.like(pattern))
        ..limit(50))
      .get();

  return results.map((ayah) {
    final surah = SurahInfo.all.firstWhere(
      (s) => s.number == ayah.surahId,
      orElse: () => SurahInfo.all.first,
    );
    return SearchResult(surah: surah, ayah: ayah);
  }).toList();
});

/// Quran search screen with text search across cached ayahs.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search Quran...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() => _query = value.trim());
          },
          textInputAction: TextInputAction.search,
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _query.isEmpty ? _buildSuggestions() : _buildResults(),
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.search_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
          ),
          const SizedBox(height: 16),
          Text(
            'Search the Quran',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search by Arabic text, surah name, or ayah content.\n'
            'Note: Only cached/downloaded surahs are searchable offline.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(128),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 24),
          // Quick surah search
          Text(
            'Quick Find by Surah Name',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _quickChip('Al-Fatihah'),
              _quickChip('Al-Baqarah'),
              _quickChip('Ya-Sin'),
              _quickChip('Ar-Rahman'),
              _quickChip('Al-Mulk'),
              _quickChip('Al-Kahf'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickChip(String name) {
    return ActionChip(
      label: Text(name),
      onPressed: () {
        final surah = SurahInfo.all.firstWhere(
          (s) => s.nameTransliteration == name,
          orElse: () => SurahInfo.all.first,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReadingScreen(surah: surah),
          ),
        );
      },
    );
  }

  Widget _buildResults() {
    final resultsAsync = ref.watch(searchResultsProvider(_query));

    return resultsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (results) {
        if (results.isEmpty) {
          return _buildNoResults();
        }

        return ListView.separated(
          itemCount: results.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  '${result.surah.number}',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                '${result.surah.nameTransliteration} : ${result.ayah.ayahNumber}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                result.ayah.textUthmani,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: 16,
                  height: 1.8,
                ),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReadingScreen(
                      surah: result.surah,
                      initialAyah: result.ayah.ayahNumber,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildNoResults() {
    // Also search by surah name
    final surahResults = SurahInfo.all.where((s) {
      final q = _query.toLowerCase();
      return s.nameEnglish.toLowerCase().contains(q) ||
          s.nameTransliteration.toLowerCase().contains(q) ||
          s.nameArabic.contains(_query);
    }).toList();

    if (surahResults.isNotEmpty) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Surahs matching "$_query"',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          ...surahResults.map((surah) => ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text('${surah.number}'),
                ),
                title: Text(surah.nameTransliteration),
                subtitle: Text('${surah.nameArabic} • ${surah.nameEnglish}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReadingScreen(surah: surah),
                    ),
                  );
                },
              )),
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
          ),
          const SizedBox(height: 16),
          Text(
            'No results for "$_query"',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term or browse surahs',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(128),
                ),
          ),
        ],
      ),
    );
  }
}
