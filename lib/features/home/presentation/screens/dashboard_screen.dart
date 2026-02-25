import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/hijri_utils.dart';
import '../../../../core/utils/page_transitions.dart';
import '../../../islamic_events/data/models/islamic_event.dart';
import '../../../islamic_events/presentation/providers/islamic_events_providers.dart';
import '../../../../shared/widgets/animated_counter.dart';
import '../../../../shared/widgets/gradient_header.dart';
import '../../../../shared/widgets/feature_tile.dart';
import '../../../../shared/widgets/staggered_grid.dart';
import '../../../azkar/presentation/screens/azkar_screen.dart';
import '../../../bookmarks/presentation/providers/bookmark_providers.dart';
import '../../../prayer_times/presentation/screens/prayer_times_screen.dart';
import '../../../prayer_times/presentation/screens/qibla_screen.dart';
import '../../../prayer_times/presentation/screens/hijri_screen.dart';
import '../../../hifz/presentation/screens/hifz_setup_screen.dart';
import '../../../reading_plans/presentation/screens/khatmah_screen.dart';
import '../../../duas/presentation/screens/duas_screen.dart';
import '../../../ahkam/presentation/screens/ahkam_screen.dart';
import '../../../ahadith/presentation/screens/ahadith_screen.dart';
import '../../../tajweed_course/presentation/screens/course_home_screen.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../../gamification/data/models/achievement_def.dart';
import '../../../gamification/presentation/screens/achievements_screen.dart';
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

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset.clamp(0, 200);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'السلام عليكم';
    if (hour < 12) return 'صباح الخير';
    if (hour < 17) return 'مساء الخير';
    return 'مساء النور';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lastPosition = ref.watch(lastReadingPositionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Pick daily ayah based on day of year
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    final dailyAyah = _dailyAyahs[dayOfYear % _dailyAyahs.length];

    return Scaffold(
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          // ── Gradient Header with parallax ──
          GradientHeader(
            gradient: AppColors.getDailyHeaderGradient(isDark),
            height: 200,
            showMosque: true,
            scrollOffset: _scrollOffset,
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.of(context).padding.top + 12,
              24,
              16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gregorianToHijri(DateTime.now()).formatCompact(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      _greeting(),
                      style: TextStyle(
                        fontFamily: 'AmiriQuran',
                        fontSize: 18,
                        color: Colors.white.withAlpha(200),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Text(
                    dailyAyah.$1,
                    style: TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 20,
                      color: Colors.white.withAlpha(240),
                      height: 1.8,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    '"${dailyAyah.$2}"',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withAlpha(180),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 2),
                Center(
                  child: Text(
                    dailyAyah.$3,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withAlpha(140),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Streak & Daily Goals Card ──
                const _StreakGoalsCard(),
                const SizedBox(height: 16),

                // ── Upcoming Islamic Event ──
                _UpcomingEventCard(
                  event: ref.watch(nextMajorEventProvider),
                  todayEvent: ref.watch(todayEventProvider),
                ),

                // ── Continue Reading ──
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
                        // Switch to Quran tab, then push ReadingScreen there
                        context.go(RouteNames.quran);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          quranNavigatorKey.currentState?.push(
                            MaterialPageRoute(
                              builder: (_) => ReadingScreen(
                                surah: surah,
                                initialAyah: position.ayahNumber,
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 12),

                // ── 4x3 Feature Grid with staggered animation ──
                StaggeredAnimationGrid(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  children: [
                    FeatureTile(
                      icon: Icons.menu_book_rounded,
                      label: l10n.quran,
                      color: AppColors.accentQuran,
                      compact: true,
                      onTap: () => context.go(RouteNames.quran),
                    ),
                    FeatureTile(
                      icon: Icons.headphones_rounded,
                      label: l10n.listen,
                      color: AppColors.accentListen,
                      compact: true,
                      onTap: () => context.go(RouteNames.listen),
                    ),
                    FeatureTile(
                      icon: Icons.school_rounded,
                      label: l10n.tajweed,
                      color: AppColors.accentTajweed,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const CourseHomeScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.auto_awesome_rounded,
                      label: l10n.azkar,
                      color: AppColors.accentAzkar,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const AzkarScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.access_time_rounded,
                      label: l10n.prayer,
                      color: AppColors.accentPrayer,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const PrayerTimesScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.volunteer_activism_rounded,
                      label: l10n.duas,
                      color: AppColors.accentDua,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const DuasScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.gavel_rounded,
                      label: l10n.ahkam,
                      color: AppColors.accentAhkam,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const AhkamScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.auto_stories_rounded,
                      label: l10n.ahadith,
                      color: AppColors.accentAhadith,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const AhadithScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.psychology_rounded,
                      label: l10n.hifz,
                      color: AppColors.accentHifz,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const HifzSetupScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.track_changes_rounded,
                      label: l10n.khatmah,
                      color: AppColors.accentKhatmah,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const KhatmahScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.explore_rounded,
                      label: l10n.qibla,
                      color: AppColors.accentQibla,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const QiblaScreen()),
                      ),
                    ),
                    FeatureTile(
                      icon: Icons.calendar_month_rounded,
                      label: l10n.hijri,
                      color: AppColors.accentHijri,
                      compact: true,
                      onTap: () => Navigator.push(
                        context,
                        SlideUpRoute(page: const HijriScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Achievements Preview ──
                const _AchievementsPreview(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Streak & Daily Goals Card ──

class _StreakGoalsCard extends ConsumerWidget {
  const _StreakGoalsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(dailyStreakProvider);
    final goalsAsync = ref.watch(dailyGoalsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentStreak = streakAsync.whenOrNull(data: (s) => s?.currentStreak) ?? 0;
    final goals = goalsAsync.whenOrNull(data: (g) => g) ?? DailyGoal.defaults;
    final completedCount = goals.where((g) => g.isCompleted).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF3E2E00), const Color(0xFF1A1200)]
              : [const Color(0xFFFFF8E1), const Color(0xFFFFECB3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.amber).withAlpha(30),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: streak + progress ring
          Row(
            children: [
              // Fire icon + streak count
              Icon(
                Icons.local_fire_department_rounded,
                color: currentStreak > 0
                    ? Colors.orange
                    : Theme.of(context).colorScheme.onSurface.withAlpha(80),
                size: 32,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedCounter(
                    value: currentStreak,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: currentStreak > 0
                              ? Colors.orange.shade800
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    AppLocalizations.of(context).dayStreak,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(150),
                        ),
                  ),
                ],
              ),
              const Spacer(),
              // Circular progress ring
              SizedBox(
                width: 48,
                height: 48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: goals.isEmpty
                          ? 0
                          : completedCount / goals.length,
                      strokeWidth: 4,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(30),
                      valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    ),
                    Text(
                      '$completedCount/${goals.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Daily goal chips
          Row(
            children: goals.map((goal) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: _GoalChip(goal: goal),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  final DailyGoal goal;
  const _GoalChip({required this.goal});

  String _localizedTitle(AppLocalizations l10n) {
    switch (goal.type) {
      case DailyGoalType.readQuran:
        return l10n.readGoal;
      case DailyGoalType.listenQuran:
        return l10n.listen;
      case DailyGoalType.morningAzkar:
      case DailyGoalType.eveningAzkar:
        return l10n.azkar;
      case DailyGoalType.makeDua:
        return l10n.duaGoal;
      case DailyGoalType.tajweedLesson:
        return l10n.tajweed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final completed = goal.isCompleted;
    final title = _localizedTitle(AppLocalizations.of(context));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withAlpha(25)
            : Theme.of(context).colorScheme.surface.withAlpha(180),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: completed
              ? Colors.green.withAlpha(120)
              : Theme.of(context).colorScheme.outline.withAlpha(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            completed ? Icons.check_circle_rounded : goal.icon,
            size: 18,
            color: completed
                ? Colors.green
                : Theme.of(context).colorScheme.onSurface.withAlpha(140),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: completed ? FontWeight.bold : FontWeight.w500,
                  color: completed
                      ? Colors.green
                      : Theme.of(context).colorScheme.onSurface.withAlpha(140),
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Achievements Preview ──

class _AchievementsPreview extends ConsumerWidget {
  const _AchievementsPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(unlockedAchievementsProvider);

    return achievementsAsync.when(
      data: (unlocked) {
        if (unlocked.isEmpty) return const SizedBox.shrink();

        // Show up to 4 most recent
        final recent = unlocked.length > 4
            ? unlocked.sublist(unlocked.length - 4)
            : unlocked;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, SlideUpRoute(page: const AchievementsScreen())),
                  child: Text(
                    AppLocalizations.of(context).achievements,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, SlideUpRoute(page: const AchievementsScreen())),
                  child: Text(
                    '${unlocked.length} ${AppLocalizations.of(context).earned}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: recent.map((achievement) {
                final def = AchievementDef.getById(achievement.achievementId);
                if (def == null) return const SizedBox.shrink();
                return Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, SlideUpRoute(page: const AchievementsScreen())),
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: def.color.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(def.icon, color: def.color, size: 22),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          def.title,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 9,
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

// ── Upcoming Islamic Event Card ──

class _UpcomingEventCard extends StatelessWidget {
  final IslamicEvent? event;
  final IslamicEvent? todayEvent;

  const _UpcomingEventCard({this.event, this.todayEvent});

  @override
  Widget build(BuildContext context) {
    final displayEvent = todayEvent ?? event;
    if (displayEvent == null) return const SizedBox.shrink();
    if (todayEvent == null && (displayEvent.daysUntil ?? 999) > 60) {
      return const SizedBox.shrink();
    }

    final isToday = displayEvent.daysUntil == 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final daysText = isToday
        ? '${l10n.today}!'
        : '${displayEvent.daysUntil} ${l10n.days}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HijriScreen()),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? AppColors.gradientGoldDark
                  : AppColors.gradientGold,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayEvent.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      displayEvent.nameArabic,
                      style: TextStyle(
                        fontFamily: 'AmiriQuran',
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isToday
                      ? Colors.white.withAlpha(50)
                      : Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  daysText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Continue Reading Card ──

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
    final progress = ayahNumber / surah.ayahCount;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
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
                      color:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).continueReading,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          surah.nameTransliteration,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          AppLocalizations.of(context).ayahXofY(ayahNumber, surah.ayahCount),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
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
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 4,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(100),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
