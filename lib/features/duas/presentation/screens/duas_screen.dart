import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/gradient_header.dart';
import '../providers/duas_providers.dart';
import 'dua_list_screen.dart';

class DuasScreen extends StatefulWidget {
  const DuasScreen({super.key});

  @override
  State<DuasScreen> createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> {
  String _searchQuery = '';

  List<DuaCategoryInfo> get _filteredCategories {
    if (_searchQuery.isEmpty) return duaCategoryList;
    final q = _searchQuery.toLowerCase();
    return duaCategoryList
        .where((c) =>
            c.title.toLowerCase().contains(q) ||
            c.titleArabic.contains(_searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categories = _filteredCategories;

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            gradient: isDark
                ? AppColors.gradientWarmDark
                : AppColors.gradientWarm,
            height: 160,
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
                      "Du'as",
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
                  'الأدعية المأثورة',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 20,
                    color: Colors.white.withAlpha(200),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '${duaCategoryList.length} categories',
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
                hintText: 'Search categories...',
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
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accentDua.withAlpha(26),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(category.icon, color: AppColors.accentDua),
                    ),
                    title: Text(
                      category.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      category.titleArabic,
                      style: const TextStyle(
                          fontFamily: 'AmiriQuran', fontSize: 16),
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DuaListScreen(
                            categoryId: category.categoryId,
                            categoryTitle: category.titleArabic,
                            displayTitle: category.title,
                          ),
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
