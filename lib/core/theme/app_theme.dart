import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum AppThemeMode { light, dark, sepia, amoled }

class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(
        brightness: Brightness.light,
        primary: AppColors.primaryGreen,
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFFE8F5E9),
        secondary: AppColors.secondaryGold,
        onSecondary: Colors.white,
        secondaryContainer: const Color(0xFFFFF8E1),
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        scaffoldBackground: AppColors.lightBackground,
      );

  static ThemeData get dark => _buildTheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryGreenLight,
        onPrimary: AppColors.primaryGreenDark,
        primaryContainer: const Color(0xFF1B3A1E),
        secondary: AppColors.secondaryGoldLight,
        onSecondary: AppColors.secondaryGoldDark,
        secondaryContainer: AppColors.secondaryGoldDark,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        scaffoldBackground: AppColors.darkBackground,
      );

  static ThemeData get sepia => _buildTheme(
        brightness: Brightness.light,
        primary: AppColors.sepiaPrimary,
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFFD7CCC8),
        secondary: AppColors.secondaryGold,
        onSecondary: Colors.white,
        secondaryContainer: const Color(0xFFFFF8E1),
        surface: AppColors.sepiaSurface,
        onSurface: AppColors.sepiaOnSurface,
        scaffoldBackground: AppColors.sepiaBackground,
      );

  static ThemeData get amoled => _buildTheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryGreenLight,
        onPrimary: AppColors.primaryGreenDark,
        primaryContainer: const Color(0xFF1B3A1E),
        secondary: AppColors.secondaryGoldLight,
        onSecondary: AppColors.secondaryGoldDark,
        secondaryContainer: AppColors.secondaryGoldDark,
        surface: AppColors.amoledSurface,
        onSurface: AppColors.amoledOnSurface,
        scaffoldBackground: AppColors.amoledBackground,
      );

  static ThemeData forMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return light;
      case AppThemeMode.dark:
        return dark;
      case AppThemeMode.sepia:
        return sepia;
      case AppThemeMode.amoled:
        return amoled;
    }
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primary,
    required Color onPrimary,
    required Color primaryContainer,
    required Color secondary,
    required Color onSecondary,
    required Color secondaryContainer,
    required Color surface,
    required Color onSurface,
    required Color scaffoldBackground,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onSurface,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSurface,
      surface: surface,
      onSurface: onSurface,
      error: AppColors.error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: onSurface.withAlpha(153),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      fontFamily: 'NotoSansArabic',
    );
  }
}
