import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _localeKey = 'app_locale';

final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});

/// Manages the app locale. null = system default.
class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier() : super(null) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (code != null) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale != null) {
      await prefs.setString(_localeKey, locale.languageCode);
    } else {
      await prefs.remove(_localeKey);
    }
  }
}

/// Language display info.
class LanguageInfo {
  final String code;
  final String name;
  final String nativeName;

  const LanguageInfo(this.code, this.name, this.nativeName);
}

const supportedLanguages = [
  LanguageInfo('en', 'English', 'English'),
  LanguageInfo('ar', 'Arabic', 'العربية'),
  LanguageInfo('fr', 'French', 'Français'),
  LanguageInfo('tr', 'Turkish', 'Türkçe'),
  LanguageInfo('ur', 'Urdu', 'اردو'),
  LanguageInfo('id', 'Indonesian', 'Bahasa Indonesia'),
  LanguageInfo('es', 'Spanish', 'Español'),
  LanguageInfo('de', 'German', 'Deutsch'),
  LanguageInfo('ru', 'Russian', 'Русский'),
  LanguageInfo('bn', 'Bengali', 'বাংলা'),
  LanguageInfo('ms', 'Malay', 'Bahasa Melayu'),
  LanguageInfo('hi', 'Hindi', 'हिन्दी'),
  LanguageInfo('pt', 'Portuguese', 'Português'),
  LanguageInfo('zh', 'Chinese', '中文'),
];
