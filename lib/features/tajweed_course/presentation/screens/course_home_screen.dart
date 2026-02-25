import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../data/models/tajweed_lesson.dart';
import '../../data/tajweed_curriculum.dart';
import '../providers/course_providers.dart';
import 'level_overview_screen.dart';

class CourseHomeScreen extends ConsumerWidget {
  const CourseHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(userStreakProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tajweedCourse),
        actions: [
          // Streak indicator
          streakAsync.when(
            data: (streak) => streak != null && streak.currentStreak > 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department,
                            color: Colors.orange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${streak.currentStreak}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.secondary.withAlpha(179),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(Icons.school_rounded,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSecondary),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context).learnTajweed,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '24 free lessons across 3 levels',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withAlpha(204),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Level cards
          _LevelCard(
            level: TajweedLevel.beginner,
            title: AppLocalizations.of(context).beginner,
            subtitle: 'Foundations of tajweed',
            icon: Icons.looks_one_rounded,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          _LevelCard(
            level: TajweedLevel.intermediate,
            title: AppLocalizations.of(context).intermediate,
            subtitle: 'Noon & meem rules',
            icon: Icons.looks_two_rounded,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _LevelCard(
            level: TajweedLevel.advanced,
            title: AppLocalizations.of(context).advanced,
            subtitle: 'Madd, stopping & mastery',
            icon: Icons.looks_3_rounded,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends ConsumerWidget {
  final TajweedLevel level;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _LevelCard({
    required this.level,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionAsync = ref.watch(levelCompletionProvider(level));

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LevelOverviewScreen(level: level),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Level icon with progress ring
              SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    completionAsync.when(
                      data: (completed) => CircularProgressIndicator(
                        value: completed / TajweedCurriculum.lessonsPerLevel,
                        strokeWidth: 4,
                        backgroundColor: color.withAlpha(51),
                        valueColor: AlwaysStoppedAnimation(color),
                      ),
                      loading: () => CircularProgressIndicator(
                        strokeWidth: 4,
                        backgroundColor: color.withAlpha(51),
                        value: 0,
                      ),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    Icon(icon, size: 28, color: color),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Level info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(153),
                          ),
                    ),
                    const SizedBox(height: 4),
                    completionAsync.when(
                      data: (completed) => Text(
                        '$completed/${TajweedCurriculum.lessonsPerLevel} ${AppLocalizations.of(context).lessonsCompleted}',
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(102),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
