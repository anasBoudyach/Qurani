import 'package:flutter/material.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../data/models/surah_info.dart';
import '../widgets/surah_list_tile.dart';
import 'reading_screen.dart';
import 'search_screen.dart';

class QuranBrowseScreen extends StatefulWidget {
  const QuranBrowseScreen({super.key});

  @override
  State<QuranBrowseScreen> createState() => _QuranBrowseScreenState();
}

class _QuranBrowseScreenState extends State<QuranBrowseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<SurahInfo> get _filteredSurahs {
    if (_searchQuery.isEmpty) return SurahInfo.all;
    final query = _searchQuery.toLowerCase();
    return SurahInfo.all.where((s) {
      return s.nameEnglish.toLowerCase().contains(query) ||
          s.nameTransliteration.toLowerCase().contains(query) ||
          s.nameArabic.contains(query) ||
          s.number.toString() == query;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).quran),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: AppLocalizations.of(context).searchTheQuran,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.of(context).surah),
            Tab(text: AppLocalizations.of(context).juz),
            Tab(text: AppLocalizations.of(context).page),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).searchSurah,
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
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSurahList(),
                _buildJuzList(),
                _buildPageGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahList() {
    final surahs = _filteredSurahs;
    return ListView.separated(
      itemCount: surahs.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return SurahListTile(
          surah: surahs[index],
          onTap: () => _openSurah(surahs[index]),
        );
      },
    );
  }

  // Juz -> (surahNumber, ayahNumber) start mapping
  static const _juzStartData = <int, List<int>>{
    1: [1, 1], 2: [2, 142], 3: [2, 253], 4: [3, 93], 5: [4, 24],
    6: [4, 148], 7: [5, 83], 8: [6, 111], 9: [7, 88], 10: [8, 41],
    11: [9, 93], 12: [11, 6], 13: [12, 53], 14: [15, 1], 15: [17, 1],
    16: [18, 75], 17: [21, 1], 18: [23, 1], 19: [25, 21], 20: [27, 56],
    21: [29, 46], 22: [33, 31], 23: [36, 28], 24: [39, 32], 25: [41, 47],
    26: [46, 1], 27: [51, 31], 28: [58, 1], 29: [67, 1], 30: [78, 1],
  };

  Widget _buildJuzList() {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        final juzNumber = index + 1;
        final startData = _juzStartData[juzNumber]!;
        final startSurah = SurahInfo.all[startData[0] - 1];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text('$juzNumber'),
          ),
          title: Text('${AppLocalizations.of(context).juz} $juzNumber'),
          subtitle: Text('${startSurah.nameTransliteration} ${startData[1]}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReadingScreen(
                  surah: startSurah,
                  initialAyah: startData[1],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPageGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 604,
      itemBuilder: (context, index) {
        final pageNumber = index + 1;
        return InkWell(
          onTap: () {
            // Find the surah that contains this page
            final surah = _surahForPage(pageNumber);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReadingScreen(
                      surah: surah, initialPage: pageNumber),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withAlpha(77),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$pageNumber',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      },
    );
  }

  // Standard Quran page -> starting surah mapping (Madani mushaf)
  // Each surah's starting page number
  static const _surahStartPages = [
    1, 2, 50, 77, 106, 128, 151, 177, 187, 208, 221, 235, 249, 255, 262,
    267, 282, 293, 305, 312, 322, 332, 342, 350, 359, 367, 377, 385, 396,
    404, 411, 415, 418, 428, 434, 440, 446, 453, 458, 467, 477, 483, 489,
    496, 499, 502, 507, 511, 515, 518, 520, 523, 526, 528, 531, 534, 537,
    542, 545, 549, 551, 553, 554, 556, 558, 560, 562, 564, 566, 568, 570,
    572, 574, 575, 577, 578, 580, 582, 583, 585, 586, 587, 587, 589, 590,
    591, 591, 592, 593, 594, 595, 595, 596, 596, 597, 597, 598, 598, 599,
    599, 600, 600, 601, 601, 601, 602, 602, 602, 603, 603, 603, 604, 604, 604,
  ];

  SurahInfo _surahForPage(int page) {
    for (int i = _surahStartPages.length - 1; i >= 0; i--) {
      if (_surahStartPages[i] <= page) {
        return SurahInfo.all[i];
      }
    }
    return SurahInfo.all.first;
  }

  void _openSurah(SurahInfo surah) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReadingScreen(surah: surah),
      ),
    );
  }
}
