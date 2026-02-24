import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/gradient_header.dart';
import '../../data/services/hadith_api_service.dart';
import 'hadith_collection_screen.dart';

class AhadithScreen extends StatefulWidget {
  const AhadithScreen({super.key});

  @override
  State<AhadithScreen> createState() => _AhadithScreenState();
}

class _AhadithScreenState extends State<AhadithScreen> {
  String _searchQuery = '';

  List<HadithCollectionInfo> get _filteredCollections {
    if (_searchQuery.isEmpty) return hadithCollections;
    final q = _searchQuery.toLowerCase();
    return hadithCollections
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.nameArabic.contains(_searchQuery) ||
            c.author.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final collections = _filteredCollections;

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            gradient: isDark
                ? AppColors.gradientRedDark
                : AppColors.gradientRed,
            height: 160,
            showMosque: true,
            padding: EdgeInsets.fromLTRB(
              24, MediaQuery.of(context).padding.top + 8, 24, 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Ahadith',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  'الأحاديث النبوية',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 20,
                    color: Colors.white.withAlpha(200),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '${hadithCollections.length} collections',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withAlpha(160),
                  ),
                ),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search collections...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accentAhadith.withAlpha(26),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.auto_stories_rounded,
                          color: AppColors.accentAhadith),
                    ),
                    title: Text(
                      collection.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          collection.nameArabic,
                          style: const TextStyle(
                              fontFamily: 'AmiriQuran', fontSize: 16),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${collection.author} • ${collection.hadithCount} hadiths',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(140),
                              ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              HadithCollectionScreen(collection: collection),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
