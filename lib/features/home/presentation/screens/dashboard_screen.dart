import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../bookmarks/presentation/providers/bookmark_providers.dart';
import '../../../quran/data/models/surah_info.dart';
import '../../../quran/presentation/screens/reading_screen.dart';

/// A curated list of well-known ayahs for the Daily Ayah card.
/// Each entry: (arabic, translation, reference)
const _dailyAyahs = [
  (
    'إِنَّ مَعَ ٱلْعُسْرِ يُسْرًا',
    'Indeed, with hardship comes ease.',
    'Ash-Sharh (94:6)',
  ),
  (
    'وَمَن يَتَوَكَّلْ عَلَى ٱللَّهِ فَهُوَ حَسْبُهُۥ',
    'And whoever relies upon Allah - then He is sufficient for him.',
    'At-Talaq (65:3)',
  ),
  (
    'فَٱذْكُرُونِىٓ أَذْكُرْكُمْ',
    'So remember Me; I will remember you.',
    'Al-Baqarah (2:152)',
  ),
  (
    'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰٓ',
    'And your Lord is going to give you, and you will be satisfied.',
    'Ad-Duha (93:5)',
  ),
  (
    'رَبِّ ٱشْرَحْ لِى صَدْرِى',
    'My Lord, expand for me my breast.',
    'Ta-Ha (20:25)',
  ),
  (
    'وَقُل رَّبِّ زِدْنِى عِلْمًا',
    'And say, "My Lord, increase me in knowledge."',
    'Ta-Ha (20:114)',
  ),
  (
    'إِنَّ ٱللَّهَ مَعَ ٱلصَّـٰبِرِينَ',
    'Indeed, Allah is with the patient.',
    'Al-Baqarah (2:153)',
  ),
  (
    'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ',
    'And He is with you wherever you are.',
    'Al-Hadid (57:4)',
  ),
  (
    'لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
    'Allah does not burden a soul beyond that it can bear.',
    'Al-Baqarah (2:286)',
  ),
  (
    'أَلَا بِذِكْرِ ٱللَّهِ تَطْمَئِنُّ ٱلْقُلُوبُ',
    'Verily, in the remembrance of Allah do hearts find rest.',
    'Ar-Ra\'d (13:28)',
  ),
  (
    'وَنَحْنُ أَقْرَبُ إِلَيْهِ مِنْ حَبْلِ ٱلْوَرِيدِ',
    'And We are closer to him than his jugular vein.',
    'Qaf (50:16)',
  ),
  (
    'وَإِذَا سَأَلَكَ عِبَادِى عَنِّى فَإِنِّى قَرِيبٌ',
    'And when My servants ask you about Me - indeed I am near.',
    'Al-Baqarah (2:186)',
  ),
  (
    'قُلْ هُوَ ٱللَّهُ أَحَدٌ',
    'Say, "He is Allah, the One."',
    'Al-Ikhlas (112:1)',
  ),
  (
    'وَمَا تَوْفِيقِىٓ إِلَّا بِٱللَّهِ',
    'And my success is not but through Allah.',
    'Hud (11:88)',
  ),
];

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastPosition = ref.watch(lastReadingPositionProvider);

    // Pick daily ayah based on day of year (changes every day)
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    final dailyAyah = _dailyAyahs[dayOfYear % _dailyAyahs.length];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qurani'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bismillah header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
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
            child: Column(
              children: [
                Icon(Icons.auto_stories,
                    size: 48,
                    color: Theme.of(context).colorScheme.onPrimary),
                const SizedBox(height: 12),
                Text(
                  'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(
                  'In the name of Allah, the Most Gracious, the Most Merciful',
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        Theme.of(context).colorScheme.onPrimary.withAlpha(204),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Continue Reading card
          lastPosition.when(
            data: (position) {
              if (position == null) return const SizedBox.shrink();

              final surah = SurahInfo.all.firstWhere(
                (s) => s.number == position.surahId,
                orElse: () => SurahInfo.all.first,
              );

              return _ContinueReadingCard(
                surah: surah,
                ayahNumber: position.ayahNumber,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReadingScreen(
                        surah: surah,
                        initialAyah: position.ayahNumber,
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),

          // Quick actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _QuickActionCard(
                icon: Icons.menu_book_rounded,
                label: 'Read Quran',
                color: Theme.of(context).colorScheme.primary,
                onTap: () => context.go(RouteNames.quran),
              ),
              const SizedBox(width: 12),
              _QuickActionCard(
                icon: Icons.headphones_rounded,
                label: 'Listen',
                color: Theme.of(context).colorScheme.tertiary,
                onTap: () => context.go(RouteNames.listen),
              ),
              const SizedBox(width: 12),
              _QuickActionCard(
                icon: Icons.school_rounded,
                label: 'Tajweed',
                color: Theme.of(context).colorScheme.secondary,
                onTap: () => context.go(RouteNames.learn),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Daily Ayah
          Text(
            'Daily Ayah',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withAlpha(77),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  dailyAyah.$1,
                  style: const TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 28,
                    height: 2.0,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '"${dailyAyah.$2}"',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(179),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Surah ${dailyAyah.$3}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueReadingCard extends StatelessWidget {
  final SurahInfo surah;
  final int ayahNumber;
  final VoidCallback onTap;

  const _ContinueReadingCard({
    required this.surah,
    required this.ayahNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Continue Reading',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      surah.nameTransliteration,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Ayah $ayahNumber of ${surah.ayahCount}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(153),
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                surah.nameArabic,
                style: const TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: 22,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withAlpha(26),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withAlpha(51)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 28, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
