import 'package:flutter/material.dart';

/// Simple localization system for Qurani.
/// Supports 14 languages: English, Arabic, French, Turkish, Urdu, Indonesian,
/// Spanish, German, Russian, Bengali, Malay, Hindi, Portuguese, Chinese.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('en'), // English
    Locale('ar'), // Arabic
    Locale('fr'), // French
    Locale('tr'), // Turkish
    Locale('ur'), // Urdu
    Locale('id'), // Indonesian
    Locale('es'), // Spanish
    Locale('de'), // German
    Locale('ru'), // Russian
    Locale('bn'), // Bengali
    Locale('ms'), // Malay
    Locale('hi'), // Hindi
    Locale('pt'), // Portuguese
    Locale('zh'), // Chinese
  ];

  String get(String key) {
    final langStrings = _localizedStrings[locale.languageCode];
    return langStrings?[key] ?? _localizedStrings['en']?[key] ?? key;
  }

  // Convenience getters for common strings
  String get appName => get('app_name');
  String get home => get('home');
  String get quran => get('quran');
  String get listen => get('listen');
  String get learn => get('learn');
  String get more => get('more');
  String get settings => get('settings');
  String get search => get('search');
  String get prayerTimes => get('prayer_times');
  String get azkar => get('azkar');
  String get qibla => get('qibla');
  String get hijri => get('hijri');
  String get hifz => get('hifz');
  String get khatmah => get('khatmah');
  String get donate => get('donate');
  String get nextPrayer => get('next_prayer');
  String get continueReading => get('continue_reading');
  String get dailyAyah => get('daily_ayah');
  String get theme => get('theme');
  String get language => get('language');
  String get reciter => get('reciter');
  String get translation => get('translation');
  String get fontSize => get('font_size');
  String get retry => get('retry');
  String get cancel => get('cancel');
  String get done => get('done');
  String get save => get('save');
  String get delete => get('delete');
  String get share => get('share');
  String get about => get('about');
  String get playOnce => get('play_once');
  String get continuous => get('continuous');
  String get repeatSurah => get('repeat_surah');
  String get repeatAyah => get('repeat_ayah');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'fr', 'tr', 'ur', 'id', 'es', 'de', 'ru', 'bn', 'ms', 'hi', 'pt', 'zh']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

// ─── Localized Strings ───

const _localizedStrings = <String, Map<String, String>>{
  'en': {
    'app_name': 'Qurani',
    'home': 'Home',
    'quran': 'Quran',
    'listen': 'Listen',
    'learn': 'Learn',
    'more': 'More',
    'settings': 'Settings',
    'search': 'Search',

    'prayer_times': 'Prayer Times',
    'azkar': 'Azkar',
    'qibla': 'Qibla',
    'hijri': 'Hijri Calendar',
    'hifz': 'Hifz',
    'khatmah': 'Reading Plan',
    'donate': 'Support Qurani',
    'next_prayer': 'Next Prayer',
    'continue_reading': 'Continue Reading',
    'daily_ayah': 'Daily Ayah',
    'theme': 'Theme',
    'language': 'Language',
    'reciter': 'Reciter',
    'translation': 'Translation',
    'font_size': 'Font Size',
    'retry': 'Retry',
    'cancel': 'Cancel',
    'done': 'Done',
    'save': 'Save',
    'delete': 'Delete',
    'share': 'Share',
    'about': 'About',
    'play_once': 'Play once',
    'continuous': 'Continuous',
    'repeat_surah': 'Repeat surah',
    'repeat_ayah': 'Repeat ayah',
  },
  'ar': {
    'app_name': 'قُرآني',
    'home': 'الرئيسية',
    'quran': 'القرآن',
    'listen': 'استماع',
    'learn': 'تعلّم',
    'more': 'المزيد',
    'settings': 'الإعدادات',
    'search': 'بحث',

    'prayer_times': 'أوقات الصلاة',
    'azkar': 'أذكار',
    'qibla': 'القبلة',
    'hijri': 'التقويم الهجري',
    'hifz': 'حفظ',
    'khatmah': 'خطة القراءة',
    'donate': 'ادعم قُرآني',
    'next_prayer': 'الصلاة القادمة',
    'continue_reading': 'متابعة القراءة',
    'daily_ayah': 'آية اليوم',
    'theme': 'المظهر',
    'language': 'اللغة',
    'reciter': 'القارئ',
    'translation': 'الترجمة',
    'font_size': 'حجم الخط',
    'retry': 'إعادة المحاولة',
    'cancel': 'إلغاء',
    'done': 'تم',
    'save': 'حفظ',
    'delete': 'حذف',
    'share': 'مشاركة',
    'about': 'حول التطبيق',
    'play_once': 'تشغيل مرة واحدة',
    'continuous': 'تشغيل متواصل',
    'repeat_surah': 'تكرار السورة',
    'repeat_ayah': 'تكرار الآية',
  },
  'fr': {
    'app_name': 'Qurani',
    'home': 'Accueil',
    'quran': 'Coran',
    'listen': 'Écouter',
    'learn': 'Apprendre',
    'more': 'Plus',
    'settings': 'Paramètres',
    'search': 'Rechercher',

    'prayer_times': 'Heures de prière',
    'azkar': 'Azkar',
    'qibla': 'Qibla',
    'hijri': 'Calendrier hégirien',
    'hifz': 'Hifz',
    'khatmah': 'Plan de lecture',
    'donate': 'Soutenir Qurani',
    'next_prayer': 'Prochaine prière',
    'continue_reading': 'Continuer la lecture',
    'daily_ayah': 'Verset du jour',
    'theme': 'Thème',
    'language': 'Langue',
    'reciter': 'Récitateur',
    'translation': 'Traduction',
    'font_size': 'Taille de police',
    'retry': 'Réessayer',
    'cancel': 'Annuler',
    'done': 'Terminé',
    'save': 'Enregistrer',
    'delete': 'Supprimer',
    'share': 'Partager',
    'about': 'À propos',
    'play_once': 'Lire une fois',
    'continuous': 'Lecture continue',
    'repeat_surah': 'Répéter la sourate',
    'repeat_ayah': 'Répéter le verset',
  },
  'tr': {
    'app_name': 'Qurani',
    'home': 'Ana Sayfa',
    'quran': 'Kuran',
    'listen': 'Dinle',
    'learn': 'Öğren',
    'more': 'Daha Fazla',
    'settings': 'Ayarlar',
    'search': 'Ara',

    'prayer_times': 'Namaz Vakitleri',
    'azkar': 'Zikirler',
    'qibla': 'Kıble',
    'hijri': 'Hicri Takvim',
    'hifz': 'Hıfz',
    'khatmah': 'Okuma Planı',
    'donate': 'Destek Ol',
    'next_prayer': 'Sonraki Namaz',
    'continue_reading': 'Okumaya Devam Et',
    'daily_ayah': 'Günün Ayeti',
    'theme': 'Tema',
    'language': 'Dil',
    'reciter': 'Kari',
    'translation': 'Çeviri',
    'font_size': 'Yazı Boyutu',
    'retry': 'Tekrar Dene',
    'cancel': 'İptal',
    'done': 'Tamam',
    'save': 'Kaydet',
    'delete': 'Sil',
    'share': 'Paylaş',
    'about': 'Hakkında',
    'play_once': 'Bir kez çal',
    'continuous': 'Sürekli',
    'repeat_surah': 'Sureyi tekrarla',
    'repeat_ayah': 'Ayeti tekrarla',
  },
  'ur': {
    'app_name': 'قُرآنی',
    'home': 'ہوم',
    'quran': 'قرآن',
    'listen': 'سنیں',
    'learn': 'سیکھیں',
    'more': 'مزید',
    'settings': 'ترتیبات',
    'search': 'تلاش',

    'prayer_times': 'نماز کے اوقات',
    'azkar': 'اذکار',
    'qibla': 'قبلہ',
    'hijri': 'ہجری کیلنڈر',
    'hifz': 'حفظ',
    'khatmah': 'پڑھنے کا منصوبہ',
    'donate': 'تعاون کریں',
    'next_prayer': 'اگلی نماز',
    'continue_reading': 'پڑھنا جاری رکھیں',
    'daily_ayah': 'آج کی آیت',
    'theme': 'تھیم',
    'language': 'زبان',
    'reciter': 'قاری',
    'translation': 'ترجمہ',
    'font_size': 'فونٹ سائز',
    'retry': 'دوبارہ کوشش',
    'cancel': 'منسوخ',
    'done': 'ہو گیا',
    'save': 'محفوظ',
    'delete': 'حذف',
    'share': 'شیئر',
    'about': 'ایپ کے بارے میں',
    'play_once': 'ایک بار چلائیں',
    'continuous': 'مسلسل',
    'repeat_surah': 'سورت دہرائیں',
    'repeat_ayah': 'آیت دہرائیں',
  },
  'id': {
    'app_name': 'Qurani',
    'home': 'Beranda',
    'quran': 'Al-Quran',
    'listen': 'Dengarkan',
    'learn': 'Belajar',
    'more': 'Lainnya',
    'settings': 'Pengaturan',
    'search': 'Cari',

    'prayer_times': 'Waktu Sholat',
    'azkar': 'Dzikir',
    'qibla': 'Kiblat',
    'hijri': 'Kalender Hijriah',
    'hifz': 'Hafalan',
    'khatmah': 'Rencana Baca',
    'donate': 'Dukung Qurani',
    'next_prayer': 'Sholat Berikutnya',
    'continue_reading': 'Lanjutkan Membaca',
    'daily_ayah': 'Ayat Hari Ini',
    'theme': 'Tema',
    'language': 'Bahasa',
    'reciter': 'Qari',
    'translation': 'Terjemahan',
    'font_size': 'Ukuran Font',
    'retry': 'Coba Lagi',
    'cancel': 'Batal',
    'done': 'Selesai',
    'save': 'Simpan',
    'delete': 'Hapus',
    'share': 'Bagikan',
    'about': 'Tentang',
    'play_once': 'Putar sekali',
    'continuous': 'Berkelanjutan',
    'repeat_surah': 'Ulangi surah',
    'repeat_ayah': 'Ulangi ayat',
  },
  'es': {
    'app_name': 'Qurani',
    'home': 'Inicio',
    'quran': 'Corán',
    'listen': 'Escuchar',
    'learn': 'Aprender',
    'more': 'Más',
    'settings': 'Ajustes',
    'search': 'Buscar',

    'prayer_times': 'Horarios de oración',
    'azkar': 'Azkar',
    'qibla': 'Qibla',
    'hijri': 'Calendario Hijri',
    'hifz': 'Hifz',
    'khatmah': 'Plan de lectura',
    'donate': 'Apoya Qurani',
    'next_prayer': 'Próxima oración',
    'continue_reading': 'Continuar leyendo',
    'daily_ayah': 'Aleya del día',
    'theme': 'Tema',
    'language': 'Idioma',
    'reciter': 'Recitador',
    'translation': 'Traducción',
    'font_size': 'Tamaño de fuente',
    'retry': 'Reintentar',
    'cancel': 'Cancelar',
    'done': 'Hecho',
    'save': 'Guardar',
    'delete': 'Eliminar',
    'share': 'Compartir',
    'about': 'Acerca de',
    'play_once': 'Reproducir una vez',
    'continuous': 'Continuo',
    'repeat_surah': 'Repetir sura',
    'repeat_ayah': 'Repetir aleya',
  },
  'de': {
    'app_name': 'Qurani',
    'home': 'Startseite',
    'quran': 'Quran',
    'listen': 'Anhören',
    'learn': 'Lernen',
    'more': 'Mehr',
    'settings': 'Einstellungen',
    'search': 'Suchen',

    'prayer_times': 'Gebetszeiten',
    'azkar': 'Azkar',
    'qibla': 'Qibla',
    'hijri': 'Hijri-Kalender',
    'hifz': 'Hifz',
    'khatmah': 'Leseplan',
    'donate': 'Qurani unterstützen',
    'next_prayer': 'Nächstes Gebet',
    'continue_reading': 'Weiterlesen',
    'daily_ayah': 'Ayah des Tages',
    'theme': 'Design',
    'language': 'Sprache',
    'reciter': 'Rezitator',
    'translation': 'Übersetzung',
    'font_size': 'Schriftgröße',
    'retry': 'Erneut versuchen',
    'cancel': 'Abbrechen',
    'done': 'Fertig',
    'save': 'Speichern',
    'delete': 'Löschen',
    'share': 'Teilen',
    'about': 'Über',
    'play_once': 'Einmal abspielen',
    'continuous': 'Fortlaufend',
    'repeat_surah': 'Sure wiederholen',
    'repeat_ayah': 'Ayah wiederholen',
  },
  'ru': {
    'app_name': 'Qurani',
    'home': 'Главная',
    'quran': 'Коран',
    'listen': 'Слушать',
    'learn': 'Учиться',
    'more': 'Ещё',
    'settings': 'Настройки',
    'search': 'Поиск',

    'prayer_times': 'Время намаза',
    'azkar': 'Азкар',
    'qibla': 'Кибла',
    'hijri': 'Календарь хиджры',
    'hifz': 'Хифз',
    'khatmah': 'План чтения',
    'donate': 'Поддержать Qurani',
    'next_prayer': 'Следующий намаз',
    'continue_reading': 'Продолжить чтение',
    'daily_ayah': 'Аят дня',
    'theme': 'Тема',
    'language': 'Язык',
    'reciter': 'Чтец',
    'translation': 'Перевод',
    'font_size': 'Размер шрифта',
    'retry': 'Повторить',
    'cancel': 'Отмена',
    'done': 'Готово',
    'save': 'Сохранить',
    'delete': 'Удалить',
    'share': 'Поделиться',
    'about': 'О приложении',
    'play_once': 'Воспроизвести один раз',
    'continuous': 'Непрерывно',
    'repeat_surah': 'Повторить суру',
    'repeat_ayah': 'Повторить аят',
  },
  'bn': {
    'app_name': 'কুরআনী',
    'home': 'হোম',
    'quran': 'কুরআন',
    'listen': 'শুনুন',
    'learn': 'শিখুন',
    'more': 'আরও',
    'settings': 'সেটিংস',
    'search': 'অনুসন্ধান',

    'prayer_times': 'নামাজের সময়',
    'azkar': 'আযকার',
    'qibla': 'কিবলা',
    'hijri': 'হিজরি ক্যালেন্ডার',
    'hifz': 'হিফয',
    'khatmah': 'পড়ার পরিকল্পনা',
    'donate': 'কুরআনী সমর্থন করুন',
    'next_prayer': 'পরবর্তী নামাজ',
    'continue_reading': 'পড়া চালিয়ে যান',
    'daily_ayah': 'আজকের আয়াত',
    'theme': 'থিম',
    'language': 'ভাষা',
    'reciter': 'ক্বারী',
    'translation': 'অনুবাদ',
    'font_size': 'ফন্ট সাইজ',
    'retry': 'পুনরায় চেষ্টা',
    'cancel': 'বাতিল',
    'done': 'সম্পন্ন',
    'save': 'সংরক্ষণ',
    'delete': 'মুছুন',
    'share': 'শেয়ার',
    'about': 'সম্পর্কে',
    'play_once': 'একবার চালান',
    'continuous': 'ধারাবাহিক',
    'repeat_surah': 'সূরা পুনরাবৃত্তি',
    'repeat_ayah': 'আয়াত পুনরাবৃত্তি',
  },
  'ms': {
    'app_name': 'Qurani',
    'home': 'Laman Utama',
    'quran': 'Al-Quran',
    'listen': 'Dengar',
    'learn': 'Belajar',
    'more': 'Lagi',
    'settings': 'Tetapan',
    'search': 'Cari',

    'prayer_times': 'Waktu Solat',
    'azkar': 'Zikir',
    'qibla': 'Kiblat',
    'hijri': 'Kalendar Hijrah',
    'hifz': 'Hafazan',
    'khatmah': 'Pelan Bacaan',
    'donate': 'Sokong Qurani',
    'next_prayer': 'Solat Seterusnya',
    'continue_reading': 'Teruskan Membaca',
    'daily_ayah': 'Ayat Hari Ini',
    'theme': 'Tema',
    'language': 'Bahasa',
    'reciter': 'Qari',
    'translation': 'Terjemahan',
    'font_size': 'Saiz Fon',
    'retry': 'Cuba Lagi',
    'cancel': 'Batal',
    'done': 'Selesai',
    'save': 'Simpan',
    'delete': 'Padam',
    'share': 'Kongsi',
    'about': 'Perihal',
    'play_once': 'Main sekali',
    'continuous': 'Berterusan',
    'repeat_surah': 'Ulang surah',
    'repeat_ayah': 'Ulang ayat',
  },
  'hi': {
    'app_name': 'क़ुरआनी',
    'home': 'होम',
    'quran': 'क़ुरआन',
    'listen': 'सुनें',
    'learn': 'सीखें',
    'more': 'और',
    'settings': 'सेटिंग्स',
    'search': 'खोजें',

    'prayer_times': 'नमाज़ का समय',
    'azkar': 'अज़कार',
    'qibla': 'क़िबला',
    'hijri': 'हिजरी कैलेंडर',
    'hifz': 'हिफ़्ज़',
    'khatmah': 'पठन योजना',
    'donate': 'क़ुरआनी का समर्थन करें',
    'next_prayer': 'अगली नमाज़',
    'continue_reading': 'पढ़ना जारी रखें',
    'daily_ayah': 'आज की आयत',
    'theme': 'थीम',
    'language': 'भाषा',
    'reciter': 'क़ारी',
    'translation': 'अनुवाद',
    'font_size': 'फ़ॉन्ट साइज़',
    'retry': 'पुनः प्रयास',
    'cancel': 'रद्द करें',
    'done': 'हो गया',
    'save': 'सहेजें',
    'delete': 'हटाएँ',
    'share': 'शेयर करें',
    'about': 'ऐप के बारे में',
    'play_once': 'एक बार चलाएँ',
    'continuous': 'लगातार',
    'repeat_surah': 'सूरह दोहराएँ',
    'repeat_ayah': 'आयत दोहराएँ',
  },
  'pt': {
    'app_name': 'Qurani',
    'home': 'Início',
    'quran': 'Alcorão',
    'listen': 'Ouvir',
    'learn': 'Aprender',
    'more': 'Mais',
    'settings': 'Configurações',
    'search': 'Pesquisar',

    'prayer_times': 'Horários de Oração',
    'azkar': 'Azkar',
    'qibla': 'Qibla',
    'hijri': 'Calendário Hijri',
    'hifz': 'Hifz',
    'khatmah': 'Plano de Leitura',
    'donate': 'Apoie o Qurani',
    'next_prayer': 'Próxima Oração',
    'continue_reading': 'Continuar Lendo',
    'daily_ayah': 'Versículo do Dia',
    'theme': 'Tema',
    'language': 'Idioma',
    'reciter': 'Recitador',
    'translation': 'Tradução',
    'font_size': 'Tamanho da Fonte',
    'retry': 'Tentar Novamente',
    'cancel': 'Cancelar',
    'done': 'Concluído',
    'save': 'Salvar',
    'delete': 'Excluir',
    'share': 'Compartilhar',
    'about': 'Sobre',
    'play_once': 'Reproduzir uma vez',
    'continuous': 'Contínuo',
    'repeat_surah': 'Repetir surata',
    'repeat_ayah': 'Repetir versículo',
  },
  'zh': {
    'app_name': 'Qurani',
    'home': '首页',
    'quran': '古兰经',
    'listen': '聆听',
    'learn': '学习',
    'more': '更多',
    'settings': '设置',
    'search': '搜索',

    'prayer_times': '礼拜时间',
    'azkar': '祈祷词',
    'qibla': '朝向',
    'hijri': '伊斯兰历',
    'hifz': '背诵',
    'khatmah': '阅读计划',
    'donate': '支持我们',
    'next_prayer': '下次礼拜',
    'continue_reading': '继续阅读',
    'daily_ayah': '每日经文',
    'theme': '主题',
    'language': '语言',
    'reciter': '诵读者',
    'translation': '翻译',
    'font_size': '字体大小',
    'retry': '重试',
    'cancel': '取消',
    'done': '完成',
    'save': '保存',
    'delete': '删除',
    'share': '分享',
    'about': '关于',
    'play_once': '播放一次',
    'continuous': '连续播放',
    'repeat_surah': '重复章节',
    'repeat_ayah': '重复经文',
  },
};
