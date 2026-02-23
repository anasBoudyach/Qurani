import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/models/daily_goal.dart';
import '../../data/services/gamification_service.dart';

/// Provides the gamification service instance.
final gamificationServiceProvider = Provider<GamificationService>((ref) {
  final db = ref.watch(databaseProvider);
  return GamificationService(db);
});

/// Current streak data.
final dailyStreakProvider = FutureProvider<UserStreak?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getUserStreak();
});

/// Today's daily goals with completion status.
final dailyGoalsProvider = FutureProvider<List<DailyGoal>>((ref) async {
  final service = ref.watch(gamificationServiceProvider);
  return service.getDailyGoals();
});

/// All unlocked achievements.
final unlockedAchievementsProvider =
    FutureProvider<List<Achievement>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getUnlockedAchievements();
});

/// Count of unlocked achievements.
final achievementCountProvider = FutureProvider<int>((ref) async {
  final achievements = await ref.watch(unlockedAchievementsProvider.future);
  return achievements.length;
});
