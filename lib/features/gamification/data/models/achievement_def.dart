import 'package:flutter/material.dart';

/// Definition of an achievement that can be unlocked.
class AchievementDef {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const AchievementDef({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  /// All available achievements in the app.
  static const List<AchievementDef> all = [
    // Reading
    AchievementDef(
      id: 'first_read',
      title: 'First Steps',
      description: 'Read your first surah',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF2E7D32),
    ),
    AchievementDef(
      id: 'surahs_10',
      title: 'Avid Reader',
      description: 'Read 10 different surahs',
      icon: Icons.auto_stories_rounded,
      color: Color(0xFF1B5E20),
    ),
    AchievementDef(
      id: 'surahs_30',
      title: 'Scholar',
      description: 'Read 30 different surahs',
      icon: Icons.school_rounded,
      color: Color(0xFF004D40),
    ),

    // Streaks
    AchievementDef(
      id: 'streak_3',
      title: 'Getting Started',
      description: 'Maintain a 3-day streak',
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFE65100),
    ),
    AchievementDef(
      id: 'streak_7',
      title: 'Consistent',
      description: 'Maintain a 7-day streak',
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFBF360C),
    ),
    AchievementDef(
      id: 'streak_30',
      title: 'Unstoppable',
      description: 'Maintain a 30-day streak',
      icon: Icons.whatshot_rounded,
      color: Color(0xFFB71C1C),
    ),

    // Azkar
    AchievementDef(
      id: 'azkar_morning',
      title: 'Morning Light',
      description: 'Complete morning azkar',
      icon: Icons.wb_sunny_rounded,
      color: Color(0xFFF9A825),
    ),
    AchievementDef(
      id: 'azkar_evening',
      title: 'Evening Peace',
      description: 'Complete evening azkar',
      icon: Icons.nightlight_round,
      color: Color(0xFF283593),
    ),

    // Tajweed
    AchievementDef(
      id: 'tajweed_beginner',
      title: 'Beginner Graduate',
      description: 'Complete beginner tajweed level',
      icon: Icons.school_rounded,
      color: Color(0xFF4CAF50),
    ),
    AchievementDef(
      id: 'tajweed_intermediate',
      title: 'Intermediate Graduate',
      description: 'Complete intermediate tajweed level',
      icon: Icons.workspace_premium_rounded,
      color: Color(0xFFFF9800),
    ),
    AchievementDef(
      id: 'tajweed_advanced',
      title: 'Tajweed Master',
      description: 'Complete advanced tajweed level',
      icon: Icons.emoji_events_rounded,
      color: Color(0xFFF44336),
    ),

    // Memorization
    AchievementDef(
      id: 'hifz_first',
      title: 'Hafiz Journey',
      description: 'Practice memorizing your first surah',
      icon: Icons.psychology_rounded,
      color: Color(0xFF43A047),
    ),

    // Listening
    AchievementDef(
      id: 'listener',
      title: 'Music to the Soul',
      description: 'Listen to 10 different reciters',
      icon: Icons.headphones_rounded,
      color: Color(0xFF6A1B9A),
    ),

    // Explorer
    AchievementDef(
      id: 'explorer',
      title: 'Explorer',
      description: 'Open every feature at least once',
      icon: Icons.explore_rounded,
      color: Color(0xFF00BCD4),
    ),

    // Dedication
    AchievementDef(
      id: 'dedicated',
      title: 'Dedicated',
      description: 'Use the app for 30 days total',
      icon: Icons.favorite_rounded,
      color: Color(0xFFE91E63),
    ),
  ];

  /// Look up an achievement by its ID.
  static AchievementDef? getById(String id) {
    try {
      return all.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}
