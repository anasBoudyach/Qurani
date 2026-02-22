import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/models/tajweed_lesson.dart';
import '../../data/tajweed_curriculum.dart';

/// All lessons for a given level.
final levelLessonsProvider =
    Provider.family<List<TajweedLesson>, TajweedLevel>((ref, level) {
  return TajweedCurriculum.getLessonsForLevel(level);
});

/// A single lesson by ID.
final lessonProvider = Provider.family<TajweedLesson?, int>((ref, id) {
  return TajweedCurriculum.getLessonById(id);
});

/// All lesson progress data from the database.
final allLessonProgressProvider =
    FutureProvider<List<LessonProgressData>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllLessonProgress();
});

/// Progress for a specific lesson.
final lessonProgressProvider =
    FutureProvider.family<LessonProgressData?, int>((ref, lessonId) async {
  final db = ref.watch(databaseProvider);
  return db.getLessonProgress(lessonId);
});

/// User streak data.
final userStreakProvider = FutureProvider<UserStreak?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getUserStreak();
});

/// Count of completed lessons per level.
final levelCompletionProvider =
    FutureProvider.family<int, TajweedLevel>((ref, level) async {
  final allProgress = await ref.watch(allLessonProgressProvider.future);
  final levelLessons = TajweedCurriculum.getLessonsForLevel(level);
  final lessonIds = levelLessons.map((l) => l.id).toSet();

  return allProgress
      .where((p) => lessonIds.contains(p.lessonId) && p.isCompleted)
      .length;
});
