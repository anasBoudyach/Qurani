import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/reciter.dart';
import '../providers/audio_providers.dart';
import 'reciter_detail_screen.dart';

class ReciterListScreen extends ConsumerStatefulWidget {
  const ReciterListScreen({super.key});

  @override
  ConsumerState<ReciterListScreen> createState() => _ReciterListScreenState();
}

class _ReciterListScreenState extends ConsumerState<ReciterListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recitersAsync = ref.watch(defaultRecitersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reciters')),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search reciters...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          // Reciter list
          Expanded(
            child: recitersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _buildErrorView(context, ref, error),
              data: (reciters) {
                final filtered = _filterReciters(reciters);
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      _searchQuery.isNotEmpty
                          ? 'No reciters found for "$_searchQuery"'
                          : 'No reciters available',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return _buildReciterList(filtered);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<ReciterModel> _filterReciters(List<ReciterModel> reciters) {
    if (_searchQuery.isEmpty) return reciters;
    final query = _searchQuery.toLowerCase();
    return reciters
        .where((r) => r.name.toLowerCase().contains(query))
        .toList();
  }

  Widget _buildReciterList(List<ReciterModel> reciters) {
    // Group by first letter
    final grouped = <String, List<ReciterModel>>{};
    for (final reciter in reciters) {
      final letter = reciter.letter ?? reciter.name[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []).add(reciter);
    }
    final letters = grouped.keys.toList()..sort();

    return ListView.builder(
      itemCount: letters.length,
      itemBuilder: (context, index) {
        final letter = letters[index];
        final group = grouped[letter]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Letter header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                letter,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            // Reciters in this group
            ...group.map((reciter) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _reciterColor(reciter.name),
                    child: const Icon(
                      Icons.mic_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(reciter.name),
                  subtitle: Text(
                    reciter.mpieces.isNotEmpty
                        ? '${reciter.mpieces.first.surahTotal} surahs'
                        : 'Reciter',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ReciterDetailScreen(reciter: reciter),
                      ),
                    );
                  },
                )),
          ],
        );
      },
    );
  }

  /// Generate a unique but consistent color from a reciter's name.
  Color _reciterColor(String name) {
    final hash = name.codeUnits.fold<int>(0, (sum, c) => sum * 31 + c);
    const colors = [
      Color(0xFF1B5E20), // Green
      Color(0xFF0D47A1), // Blue
      Color(0xFF4A148C), // Purple
      Color(0xFFBF360C), // Deep Orange
      Color(0xFF006064), // Teal
      Color(0xFF311B92), // Deep Purple
      Color(0xFF1A237E), // Indigo
      Color(0xFF004D40), // Dark Teal
      Color(0xFF33691E), // Light Green
      Color(0xFF880E4F), // Pink
      Color(0xFF3E2723), // Brown
      Color(0xFF827717), // Lime
    ];
    return colors[hash.abs() % colors.length];
  }

  Widget _buildErrorView(
      BuildContext context, WidgetRef ref, Object error) {
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
              'Could not load reciters',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your internet connection.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => ref.invalidate(defaultRecitersProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
