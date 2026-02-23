import 'package:flutter/material.dart';

/// Types of daily goals the user can complete.
enum DailyGoalType {
  readQuran,
  listenQuran,
  morningAzkar,
  eveningAzkar,
  makeDua,
  tajweedLesson,
}

/// Types of activities that can be logged.
enum ActivityType {
  readQuran,
  listenQuran,
  morningAzkar,
  eveningAzkar,
  makeDua,
  tajweedLesson,
}

/// A daily goal with its completion status.
class DailyGoal {
  final DailyGoalType type;
  final String title;
  final String titleArabic;
  final IconData icon;
  final bool isCompleted;

  const DailyGoal({
    required this.type,
    required this.title,
    required this.titleArabic,
    required this.icon,
    this.isCompleted = false,
  });

  DailyGoal copyWith({bool? isCompleted}) {
    return DailyGoal(
      type: type,
      title: title,
      titleArabic: titleArabic,
      icon: icon,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// The default daily goals shown on the dashboard.
  static const List<DailyGoal> defaults = [
    DailyGoal(
      type: DailyGoalType.readQuran,
      title: 'Read',
      titleArabic: 'قراءة',
      icon: Icons.menu_book_rounded,
    ),
    DailyGoal(
      type: DailyGoalType.listenQuran,
      title: 'Listen',
      titleArabic: 'استماع',
      icon: Icons.headphones_rounded,
    ),
    DailyGoal(
      type: DailyGoalType.morningAzkar,
      title: 'Azkar',
      titleArabic: 'أذكار',
      icon: Icons.auto_awesome_rounded,
    ),
    DailyGoal(
      type: DailyGoalType.makeDua,
      title: "Du'a",
      titleArabic: 'دعاء',
      icon: Icons.volunteer_activism_rounded,
    ),
  ];
}
