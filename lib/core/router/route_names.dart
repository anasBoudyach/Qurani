class RouteNames {
  RouteNames._();

  // Main tabs
  static const String quran = '/quran';
  static const String listen = '/listen';
  static const String home = '/home';
  static const String bookmarks = '/bookmarks';
  static const String more = '/more';

  // Quran sub-routes
  static const String surahReading = '/quran/surah/:surahId';
  static const String tafsir = '/quran/tafsir/:surahId/:ayahId';
  static const String search = '/quran/search';

  // Listen sub-routes
  static const String reciterDetail = '/listen/reciter/:reciterId';
  static const String player = '/listen/player';
  static const String downloads = '/listen/downloads';

  // Home sub-routes
  static const String notes = '/home/notes';

  // More sub-routes
  static const String azkar = '/more/azkar';
  static const String dua = '/more/dua';
  static const String prayerTimes = '/more/prayer-times';
  static const String settings = '/more/settings';
  static const String donate = '/more/donate';
  static const String about = '/more/about';

  // Full-screen (no bottom nav)
  static const String onboarding = '/onboarding';
}
