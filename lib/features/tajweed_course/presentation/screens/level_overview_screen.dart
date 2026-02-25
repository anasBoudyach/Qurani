import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../data/models/tajweed_lesson.dart';
import '../providers/course_providers.dart';
import 'lesson_screen.dart';

/// Shows all lessons for a specific tajweed level.
class LevelOverviewScreen extends ConsumerWidget {
  final TajweedLevel level;

  const LevelOverviewScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(levelLessonsProvider(level));
    final allProgressAsync = ref.watch(allLessonProgressProvider);

    final levelName = switch (level) {
      TajweedLevel.beginner => AppLocalizations.of(context).beginner,
      TajweedLevel.intermediate => AppLocalizations.of(context).intermediate,
      TajweedLevel.advanced => AppLocalizations.of(context).advanced,
    };

    final levelColor = switch (level) {
      TajweedLevel.beginner => Colors.green,
      TajweedLevel.intermediate => Colors.orange,
      TajweedLevel.advanced => Colors.red,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('$levelName ${AppLocalizations.of(context).levelLabel}'),
      ),
      body: allProgressAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (allProgress) {
          final progressMap = {
            for (final p in allProgress) p.lessonId: p,
          };

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final progress = progressMap[lesson.id];
              final isCompleted = progress?.isCompleted ?? false;
              final bestScore = progress?.bestQuizScore ?? 0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonScreen(lesson: lesson),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Lesson number with completion state
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? levelColor
                                : levelColor.withAlpha(26),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: isCompleted
                              ? const Icon(Icons.check, color: Colors.white)
                              : Text(
                                  '${lesson.orderInLevel}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: levelColor,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        // Lesson info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.titleEnglish,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lesson.titleArabic,
                                style: const TextStyle(
                                  fontFamily: 'AmiriQuran',
                                  fontSize: 16,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lesson.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(153),
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (isCompleted && bestScore > 0) ...[
                                const SizedBox(height: 4),
                                Text(
                                  '${AppLocalizations.of(context).bestScore}: $bestScore%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: levelColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(102),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
