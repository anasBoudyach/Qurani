import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../models/daily_goal.dart';

/// Central service for tracking activities, streaks, and achievements.
///
/// All gamification logic flows through this service:
/// - Activities are logged to DailyActivityLog
/// - Streak is updated based on activity dates
/// - Achievements are checked after each activity
class GamificationService {
  final AppDatabase _db;

  GamificationService(this._db);

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Record a user activity. Updates streak and checks achievements.
  Future<void> recordActivity(ActivityType type) async {
    final today = _todayKey();

    // Check if already logged today for this type
    final existing = await _db.getActivitiesForDate(today);
    final alreadyLogged = existing.any((a) => a.activityType == type.name);
    if (alreadyLogged) return;

    // Log the activity
    await _db.logActivity(
      DailyActivityLogCompanion(
        activityType: Value(type.name),
        completedAt: Value(DateTime.now()),
        date: Value(today),
      ),
    );

    // Update streak
    await _updateStreak();

    // Check achievements
    await checkAndUnlockAchievements();
  }

  /// Update the user's streak based on activity history.
  Future<void> _updateStreak() async {
    final today = _todayKey();
    final yesterday = _yesterdayKey();

    final streak = await _db.getUserStreak();

    if (streak == null) {
      // First ever activity — create streak
      await _db.saveUserStreak(UserStreaksCompanion(
        id: const Value(1),
        currentStreak: const Value(1),
        longestStreak: const Value(1),
        lastActivityDate: Value(DateTime.now()),
      ));
      return;
    }

    final lastDate = streak.lastActivityDate;
    if (lastDate == null) {
      await _db.saveUserStreak(UserStreaksCompanion(
        id: const Value(1),
        currentStreak: const Value(1),
        longestStreak: Value(streak.longestStreak < 1 ? 1 : streak.longestStreak),
        lastActivityDate: Value(DateTime.now()),
      ));
      return;
    }

    final lastKey = '${lastDate.year}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')}';

    if (lastKey == today) {
      // Already logged today — no streak change
      return;
    }

    int newStreak;
    if (lastKey == yesterday) {
      // Consecutive day — increment
      newStreak = streak.currentStreak + 1;
    } else {
      // Missed a day — reset
      newStreak = 1;
    }

    final newLongest =
        newStreak > streak.longestStreak ? newStreak : streak.longestStreak;

    await _db.saveUserStreak(UserStreaksCompanion(
      id: const Value(1),
      currentStreak: Value(newStreak),
      longestStreak: Value(newLongest),
      lastActivityDate: Value(DateTime.now()),
    ));
  }

  String _yesterdayKey() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';
  }

  /// Get today's daily goals with completion status.
  Future<List<DailyGoal>> getDailyGoals() async {
    final today = _todayKey();
    final activities = await _db.getActivitiesForDate(today);
    final completedTypes = activities.map((a) => a.activityType).toSet();

    return DailyGoal.defaults.map((goal) {
      final activityName = _goalToActivityName(goal.type);
      return goal.copyWith(isCompleted: completedTypes.contains(activityName));
    }).toList();
  }

  String _goalToActivityName(DailyGoalType type) {
    switch (type) {
      case DailyGoalType.readQuran:
        return ActivityType.readQuran.name;
      case DailyGoalType.listenQuran:
        return ActivityType.listenQuran.name;
      case DailyGoalType.morningAzkar:
        return ActivityType.morningAzkar.name;
      case DailyGoalType.eveningAzkar:
        return ActivityType.eveningAzkar.name;
      case DailyGoalType.makeDua:
        return ActivityType.makeDua.name;
      case DailyGoalType.tajweedLesson:
        return ActivityType.tajweedLesson.name;
    }
  }

  /// Check all achievement conditions and unlock any newly earned ones.
  Future<List<String>> checkAndUnlockAchievements() async {
    final unlocked = await _db.getUnlockedAchievements();
    final unlockedIds = unlocked.map((a) => a.achievementId).toSet();
    final newlyUnlocked = <String>[];

    // Streak-based achievements
    final streak = await _db.getUserStreak();
    final currentStreak = streak?.currentStreak ?? 0;
    final longestStreak = streak?.longestStreak ?? 0;
    final bestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;

    if (bestStreak >= 3 && !unlockedIds.contains('streak_3')) {
      await _unlock('streak_3');
      newlyUnlocked.add('streak_3');
    }
    if (bestStreak >= 7 && !unlockedIds.contains('streak_7')) {
      await _unlock('streak_7');
      newlyUnlocked.add('streak_7');
    }
    if (bestStreak >= 30 && !unlockedIds.contains('streak_30')) {
      await _unlock('streak_30');
      newlyUnlocked.add('streak_30');
    }

    // Activity-based achievements
    final allActivities = await _db.getAllActivities();

    // First read
    final hasRead = allActivities.any((a) => a.activityType == 'readQuran');
    if (hasRead && !unlockedIds.contains('first_read')) {
      await _unlock('first_read');
      newlyUnlocked.add('first_read');
    }

    // Azkar achievements
    final hasMorningAzkar = allActivities.any((a) => a.activityType == 'morningAzkar');
    if (hasMorningAzkar && !unlockedIds.contains('azkar_morning')) {
      await _unlock('azkar_morning');
      newlyUnlocked.add('azkar_morning');
    }
    final hasEveningAzkar = allActivities.any((a) => a.activityType == 'eveningAzkar');
    if (hasEveningAzkar && !unlockedIds.contains('azkar_evening')) {
      await _unlock('azkar_evening');
      newlyUnlocked.add('azkar_evening');
    }

    // Hifz
    final hasHifz = allActivities.any((a) => a.activityType == 'hifzPractice');
    if (hasHifz && !unlockedIds.contains('hifz_first')) {
      await _unlock('hifz_first');
      newlyUnlocked.add('hifz_first');
    }

    // Tajweed level completions — check lesson progress
    final lessonProgress = await _db.getAllLessonProgress();
    final completedLessons = lessonProgress.where((l) => l.isCompleted).map((l) => l.lessonId).toSet();

    // Beginner: lessons 1-8
    final beginnerComplete = {1, 2, 3, 4, 5, 6, 7, 8}.every(completedLessons.contains);
    if (beginnerComplete && !unlockedIds.contains('tajweed_beginner')) {
      await _unlock('tajweed_beginner');
      newlyUnlocked.add('tajweed_beginner');
    }

    // Intermediate: lessons 9-16
    final intermediateComplete = {9, 10, 11, 12, 13, 14, 15, 16}.every(completedLessons.contains);
    if (intermediateComplete && !unlockedIds.contains('tajweed_intermediate')) {
      await _unlock('tajweed_intermediate');
      newlyUnlocked.add('tajweed_intermediate');
    }

    // Advanced: lessons 17-24
    final advancedComplete = {17, 18, 19, 20, 21, 22, 23, 24}.every(completedLessons.contains);
    if (advancedComplete && !unlockedIds.contains('tajweed_advanced')) {
      await _unlock('tajweed_advanced');
      newlyUnlocked.add('tajweed_advanced');
    }

    // Dedicated: 30 unique days with activity
    final uniqueDays = allActivities.map((a) => a.date).toSet();
    if (uniqueDays.length >= 30 && !unlockedIds.contains('dedicated')) {
      await _unlock('dedicated');
      newlyUnlocked.add('dedicated');
    }

    // Read 10 unique surahs — tracked by unique readQuran days as proxy
    final readDays = allActivities.where((a) => a.activityType == 'readQuran').map((a) => a.date).toSet();
    if (readDays.length >= 10 && !unlockedIds.contains('surahs_10')) {
      await _unlock('surahs_10');
      newlyUnlocked.add('surahs_10');
    }
    if (readDays.length >= 30 && !unlockedIds.contains('surahs_30')) {
      await _unlock('surahs_30');
      newlyUnlocked.add('surahs_30');
    }

    // Listen to 10 different days (proxy for different reciters)
    final listenDays = allActivities.where((a) => a.activityType == 'listenQuran').map((a) => a.date).toSet();
    if (listenDays.length >= 10 && !unlockedIds.contains('listener')) {
      await _unlock('listener');
      newlyUnlocked.add('listener');
    }

    return newlyUnlocked;
  }

  Future<void> _unlock(String achievementId) async {
    await _db.unlockAchievement(AchievementsCompanion(
      achievementId: Value(achievementId),
      unlockedAt: Value(DateTime.now()),
    ));
  }
}
