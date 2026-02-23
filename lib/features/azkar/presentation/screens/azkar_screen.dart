import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/celebration_overlay.dart';
import '../../../../shared/widgets/gradient_header.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';

/// Azkar categories and their content.
class _AzkarCategory {
  final String title;
  final String titleArabic;
  final IconData icon;
  final Color color;
  final List<_Dhikr> items;

  const _AzkarCategory({
    required this.title,
    required this.titleArabic,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class _Dhikr {
  final String arabic;
  final String translation;
  final int count;

  const _Dhikr({
    required this.arabic,
    required this.translation,
    required this.count,
  });
}

final _categories = [
  _AzkarCategory(
    title: 'Morning Azkar',
    titleArabic: 'أذكار الصباح',
    icon: Icons.wb_sunny_rounded,
    color: Colors.amber,
    items: [
      _Dhikr(arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ', translation: 'We have reached the morning and sovereignty belongs to Allah.', count: 1),
      _Dhikr(arabic: 'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ', translation: 'O Allah, by You we enter the morning, by You we enter the evening, by You we live, by You we die, and to You is the resurrection.', count: 1),
      _Dhikr(arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', translation: 'Glory is to Allah and praise is to Him.', count: 100),
      _Dhikr(arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ', translation: 'None has the right to be worshipped but Allah alone, with no partner.', count: 10),
    ],
  ),
  _AzkarCategory(
    title: 'Evening Azkar',
    titleArabic: 'أذكار المساء',
    icon: Icons.nightlight_round,
    color: Colors.indigo,
    items: [
      _Dhikr(arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ', translation: 'We have reached the evening and sovereignty belongs to Allah.', count: 1),
      _Dhikr(arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ', translation: 'O Allah, by You we enter the evening, by You we enter the morning, by You we live, by You we die, and to You is the final return.', count: 1),
      _Dhikr(arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ', translation: 'I seek refuge in the perfect words of Allah from the evil of what He has created.', count: 3),
    ],
  ),
  _AzkarCategory(
    title: 'After Salah',
    titleArabic: 'أذكار بعد الصلاة',
    icon: Icons.mosque_rounded,
    color: Colors.teal,
    items: [
      _Dhikr(arabic: 'أَسْتَغْفِرُ اللَّهَ', translation: 'I seek forgiveness from Allah.', count: 3),
      _Dhikr(arabic: 'سُبْحَانَ اللَّهِ', translation: 'Glory be to Allah.', count: 33),
      _Dhikr(arabic: 'الْحَمْدُ لِلَّهِ', translation: 'Praise be to Allah.', count: 33),
      _Dhikr(arabic: 'اللَّهُ أَكْبَرُ', translation: 'Allah is the Greatest.', count: 33),
      _Dhikr(arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ', translation: 'None has the right to be worshipped but Allah alone, with no partner. His is the dominion and His is the praise, and He is Able to do all things.', count: 1),
    ],
  ),
  _AzkarCategory(
    title: 'Before Sleep',
    titleArabic: 'أذكار النوم',
    icon: Icons.bedtime_rounded,
    color: Colors.deepPurple,
    items: [
      _Dhikr(arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا', translation: 'In Your name, O Allah, I die and I live.', count: 1),
      _Dhikr(arabic: 'سُبْحَانَ اللَّهِ', translation: 'Glory be to Allah.', count: 33),
      _Dhikr(arabic: 'الْحَمْدُ لِلَّهِ', translation: 'Praise be to Allah.', count: 33),
      _Dhikr(arabic: 'اللَّهُ أَكْبَرُ', translation: 'Allah is the Greatest.', count: 34),
    ],
  ),
];

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            gradient: isDark ? AppColors.gradientGoldDark : AppColors.gradientGold,
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
                      'Azkar',
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
                  'أذكار المسلم',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 20,
                    color: Colors.white.withAlpha(200),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '${_categories.length} categories',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withAlpha(160),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: category.color.withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(category.icon, color: category.color),
                  ),
                  title: Text(
                    category.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    category.titleArabic,
                    style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 16),
                    textDirection: TextDirection.rtl,
                  ),
                  trailing: Text(
                    '${category.items.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: category.color,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            _AzkarListScreen(category: category),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AzkarListScreen extends ConsumerStatefulWidget {
  final _AzkarCategory category;
  const _AzkarListScreen({required this.category});

  @override
  ConsumerState<_AzkarListScreen> createState() => _AzkarListScreenState();
}

class _AzkarListScreenState extends ConsumerState<_AzkarListScreen> {
  late List<int> _counters;

  @override
  void initState() {
    super.initState();
    _counters = List.filled(widget.category.items.length, 0);
  }

  void _increment(int index) {
    final target = widget.category.items[index].count;
    if (_counters[index] < target) {
      setState(() => _counters[index]++);
      HapticFeedback.lightImpact();
    }
    if (_counters[index] >= target) {
      HapticFeedback.heavyImpact();
      // Check if ALL azkar in category are complete
      final allComplete = List.generate(
        widget.category.items.length,
        (i) => _counters[i] >= widget.category.items[i].count,
      ).every((c) => c);
      if (allComplete) {
        CelebrationOverlay.show(context, color: widget.category.color);
        // Record azkar activity based on category
        final title = widget.category.title.toLowerCase();
        if (title.contains('morning')) {
          ref.read(gamificationServiceProvider).recordActivity(ActivityType.morningAzkar);
        } else if (title.contains('evening')) {
          ref.read(gamificationServiceProvider).recordActivity(ActivityType.eveningAzkar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.category.items.length,
        itemBuilder: (context, index) {
          final dhikr = widget.category.items[index];
          final count = _counters[index];
          final complete = count >= dhikr.count;

          return GestureDetector(
            onTap: () => _increment(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: complete
                    ? Colors.green.withAlpha(20)
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: complete
                      ? Colors.green.withAlpha(102)
                      : Theme.of(context).colorScheme.outline.withAlpha(51),
                ),
              ),
              child: Column(
                children: [
                  // Arabic text
                  Text(
                    dhikr.arabic,
                    style: const TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 22,
                      height: 2.0,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Translation
                  Text(
                    dhikr.translation,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(153),
                          height: 1.4,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (complete)
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 20),
                      if (complete) const SizedBox(width: 8),
                      Text(
                        '$count / ${dhikr.count}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: complete
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  if (!complete) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Tap to count',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(102),
                          ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
