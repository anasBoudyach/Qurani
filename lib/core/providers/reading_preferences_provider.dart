import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _fontSizeKey = 'reading_font_size';
const _translationKey = 'default_translation';
const _reciterKey = 'default_reciter';
const _tajweedKey = 'show_tajweed_colors';
const _numeralStyleKey = 'numeral_style';
const _readingModeKey = 'last_reading_mode';
const _startupScreenKey = 'startup_screen';

// ─── Font Size ───

final fontSizeProvider =
    StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier();
});

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(28.0) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getDouble(_fontSizeKey) ?? 28.0;
  }

  Future<void> setFontSize(double size) async {
    state = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, size);
  }
}

const fontSizeOptions = [
  FontSizeOption(20, 'Small'),
  FontSizeOption(24, 'Medium Small'),
  FontSizeOption(28, 'Medium'),
  FontSizeOption(32, 'Large'),
  FontSizeOption(36, 'Extra Large'),
  FontSizeOption(42, 'Huge'),
];

class FontSizeOption {
  final double size;
  final String label;
  const FontSizeOption(this.size, this.label);
}

// ─── Default Translation ───

final defaultTranslationProvider =
    StateNotifierProvider<DefaultTranslationNotifier, TranslationOption>((ref) {
  return DefaultTranslationNotifier();
});

class DefaultTranslationNotifier extends StateNotifier<TranslationOption> {
  DefaultTranslationNotifier() : super(translationOptions[1]) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final edition = prefs.getString(_translationKey);
    if (edition != null) {
      final match = translationOptions.where((t) => t.edition == edition);
      if (match.isNotEmpty) state = match.first;
    }
  }

  Future<void> setTranslation(TranslationOption option) async {
    state = option;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_translationKey, option.edition);
  }
}

const translationOptions = [
  TranslationOption(0, 'none', 'None', 'No translation'),
  TranslationOption(1, 'en.sahih', 'Saheeh International', 'English'),
  TranslationOption(2, 'en.pickthall', 'Pickthall', 'English'),
  TranslationOption(3, 'en.yusufali', 'Yusuf Ali', 'English'),
  TranslationOption(4, 'ar.muyassar', 'Al-Muyassar', 'Arabic'),
  TranslationOption(5, 'fr.hamidullah', 'Hamidullah', 'French'),
  TranslationOption(6, 'tr.diyanet', 'Diyanet Isleri', 'Turkish'),
  TranslationOption(7, 'ur.jalandhry', 'Jalandhry', 'Urdu'),
  TranslationOption(8, 'id.indonesian', 'Indonesian Ministry', 'Indonesian'),
  TranslationOption(9, 'bn.bengali', 'Muhiuddin Khan', 'Bengali'),
  TranslationOption(10, 'de.bubenheim', 'Bubenheim & Elyas', 'German'),
  TranslationOption(11, 'es.cortes', 'Julio Cortes', 'Spanish'),
  TranslationOption(12, 'ru.kuliev', 'Elmir Kuliev', 'Russian'),
  TranslationOption(13, 'hi.hindi', 'Suhel Farooq Khan', 'Hindi'),
  TranslationOption(14, 'ms.basmeih', 'Abdullah Basmeih', 'Malay'),
  TranslationOption(15, 'ja.japanese', 'Japanese Translation', 'Japanese'),
  TranslationOption(16, 'ko.korean', 'Korean Translation', 'Korean'),
  TranslationOption(17, 'pt.elhayek', 'Samir El-Hayek', 'Portuguese'),
  TranslationOption(18, 'nl.siregar', 'Sofian Siregar', 'Dutch'),
  TranslationOption(19, 'it.piccardo', 'Hamza Piccardo', 'Italian'),
  TranslationOption(20, 'zh.majian', 'Ma Jian', 'Chinese'),
  TranslationOption(21, 'fa.makarem', 'Makarem Shirazi', 'Persian'),
  TranslationOption(22, 'th.thai', 'Thai Translation', 'Thai'),
  TranslationOption(23, 'sw.barwani', 'Ali Muhsin Al-Barwani', 'Swahili'),
  TranslationOption(24, 'ha.gumi', 'Abubakar Gumi', 'Hausa'),
];

class TranslationOption {
  final int resourceId;
  final String edition;
  final String name;
  final String language;
  const TranslationOption(this.resourceId, this.edition, this.name, this.language);
}

// ─── Default Reciter ───

final defaultReciterProvider =
    StateNotifierProvider<DefaultReciterNotifier, ReciterOption>((ref) {
  return DefaultReciterNotifier();
});

class DefaultReciterNotifier extends StateNotifier<ReciterOption> {
  DefaultReciterNotifier() : super(reciterOptions.first) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_reciterKey);
    if (id != null) {
      final match = reciterOptions.where((r) => r.id == id);
      if (match.isNotEmpty) state = match.first;
    }
  }

  Future<void> setReciter(ReciterOption option) async {
    state = option;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_reciterKey, option.id);
  }
}

const reciterOptions = [
  ReciterOption('Alafasy_128kbps', 'Mishary Alafasy'),
  ReciterOption('Abdul_Basit_Murattal_192kbps', 'Abdul Basit (Murattal)'),
  ReciterOption('Abdul_Basit_Mujawwad_128kbps', 'Abdul Basit (Mujawwad)'),
  ReciterOption('Husary_128kbps', 'Mahmoud Khalil Al-Husary'),
  ReciterOption('Hudhaify_128kbps', 'Ali Al-Hudhaify'),
  ReciterOption('Minshawy_Murattal_128kbps', 'Mohamed Siddiq Al-Minshawi'),
  ReciterOption('Saood_ash-Shuraym_128kbps', 'Saud Al-Shuraim'),
  ReciterOption('Abdurrahmaan_As-Sudais_192kbps', 'Abdurrahman As-Sudais'),
  ReciterOption('Maher_AlMuaiqly_128kbps', 'Maher Al-Muaiqly'),
  ReciterOption('Ahmed_ibn_Ali_al-Ajamy_128kbps_ketaballah.net', 'Ahmed Al-Ajamy'),
];

class ReciterOption {
  final String id;
  final String name;
  const ReciterOption(this.id, this.name);
}

// ─── Tajweed Colors Toggle ───

final tajweedProvider =
    StateNotifierProvider<TajweedNotifier, bool>((ref) {
  return TajweedNotifier();
});

class TajweedNotifier extends StateNotifier<bool> {
  TajweedNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_tajweedKey) ?? false;
  }

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tajweedKey, state);
  }
}

// ─── Numeral Style (Arabic-Indic vs Western) ───

enum NumeralStyle { arabic, western }

final numeralStyleProvider =
    StateNotifierProvider<NumeralStyleNotifier, NumeralStyle>((ref) {
  return NumeralStyleNotifier();
});

class NumeralStyleNotifier extends StateNotifier<NumeralStyle> {
  NumeralStyleNotifier() : super(NumeralStyle.arabic) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_numeralStyleKey);
    if (value == 'western') state = NumeralStyle.western;
  }

  Future<void> setStyle(NumeralStyle style) async {
    state = style;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_numeralStyleKey, style.name);
  }
}

/// Format a number according to the chosen numeral style.
String formatAyahNumber(int number, NumeralStyle style) {
  if (style == NumeralStyle.western) return '$number';
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.toString().split('').map((d) => arabicDigits[int.parse(d)]).join();
}

// ─── Reading Mode (Recitation vs Mushaf) ───

enum ReadingMode { recitation, mushaf }

final readingModeProvider =
    StateNotifierProvider<ReadingModeNotifier, ReadingMode>((ref) {
  return ReadingModeNotifier();
});

class ReadingModeNotifier extends StateNotifier<ReadingMode> {
  ReadingModeNotifier() : super(ReadingMode.recitation) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_readingModeKey);
    if (value == 'mushaf') state = ReadingMode.mushaf;
  }

  Future<void> setMode(ReadingMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_readingModeKey, mode.name);
  }
}

// ─── Startup Screen (Home vs Last Reading Position) ───

enum StartupScreen { home, lastPosition }

final startupScreenProvider =
    StateNotifierProvider<StartupScreenNotifier, StartupScreen>((ref) {
  return StartupScreenNotifier();
});

class StartupScreenNotifier extends StateNotifier<StartupScreen> {
  StartupScreenNotifier() : super(StartupScreen.home) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_startupScreenKey);
    if (value == 'lastPosition') state = StartupScreen.lastPosition;
  }

  Future<void> setStartupScreen(StartupScreen screen) async {
    state = screen;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_startupScreenKey, screen.name);
  }
}
