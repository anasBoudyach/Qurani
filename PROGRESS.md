# Qurani - Development Progress Tracker

## Project Overview
- **App**: Qurani - Full-featured Quran Android app
- **Stack**: Flutter (Dart), Android-only
- **Architecture**: Offline-first, clean architecture, no backend
- **Monetization**: Free + donations (no premium gating)
- **Plan file**: `C:\Users\boudy\.claude\plans\peaceful-mixing-globe.md`

---

## Phase 0: Project Setup [COMPLETED]

- [x] Flutter project created (com.qurani, Android-only)
- [x] Folder structure (clean architecture with feature modules)
- [x] Dependencies installed (Riverpod, go_router, Drift, Dio, just_audio, etc.)
- [x] Arabic fonts downloaded (Amiri Quran, Noto Sans Arabic)
- [x] Theme system: 4 themes (Light/Dark/Sepia/AMOLED)
- [x] Tajweed colors (17 rules) + tajweed HTML parser
- [x] GoRouter with 5-tab StatefulShellRoute
- [x] AppShell with NavigationBar
- [x] API client (multi-API Dio) + API orchestrator (fallback chain)
- [x] Drift database with 12 tables
- [x] All tests passing, analysis clean

---

## Phase 1: Core Quran Reader [COMPLETED]

- [x] `TajweedTextWidget` - Color-coded tajweed rendering with tap-to-explain
- [x] `SurahInfo` - Static data model for all 114 surahs
- [x] `SurahListTile` - Widget for surah list items
- [x] `QuranBrowseScreen` - Surah/Juz/Page browsing with search
- [x] `ReadingScreen` - 3 reading modes (translation, mushaf, split)
- [x] `QuranRepository` - Offline-first data layer (API -> Drift cache)
- [x] Riverpod providers for ayahs, translations, pages, juz
- [x] `BookmarkRepository` - Add/remove/toggle bookmarks
- [x] Reading progress tracking (saves on screen exit)
- [x] `BookmarksScreen` - List with swipe-to-delete
- [x] Enhanced `DashboardScreen` - Continue reading, quick actions, daily ayah
- [x] Surah header with bismillah + gradient info card
- [x] Font size controls + mode switching
- [x] Arabic-Indic numeral rendering in mushaf mode

---

## Phase 2: Audio System [COMPLETED]

- [x] `AudioPlayerService` - just_audio wrapper with state management
- [x] MP3Quran CDN support (surah-level, 260+ reciters)
- [x] EveryAyah CDN support (verse-level audio)
- [x] Repeat modes (none, ayah, range, surah)
- [x] Background audio playback with notification + lock screen controls
- [x] `MiniPlayerWidget` - 56dp persistent player across all tabs
- [x] `FullPlayerScreen` - Seek bar, controls, surah artwork, reciter name
- [x] `ReciterModel` - Data model from MP3Quran API
- [x] `ReciterListScreen` - Search + alphabetical grouping
- [x] `ReciterDetailScreen` - Surah list with play buttons
- [x] `AudioRepository` - Fetch 260+ reciters from API
- [x] Riverpod providers for audio state, reciters, player service
- [x] Mini player wired into AppShell bottom navigation
- [x] Skip next/previous navigation (surah-level + ayah-level)
- [x] Auto-advance to next surah on completion (continuous mode)
- [x] Background audio: AudioServiceActivity for notification/lock screen controls
- [x] Single-player fix: RecordingScreen reuses shared AudioPlayer (just_audio_background constraint)
- [x] Unified playback mode button: Single → Continuous → Repeat Surah → Repeat Ayah
- [x] Surah repeat handled manually in _handleCompletion (LoopMode.all == LoopMode.one on single source)
- [x] Playback mode snackbar notification on mode change

---

## Phase 3: Tajweed Course [COMPLETED]

- [x] `TajweedLesson` data model with theory, examples, quiz questions
- [x] `TajweedCurriculum` - Complete 24 lessons across 3 levels
- [x] Beginner (8): Intro, Hamza Wasl, Laam Shamsiyyah, Silent Letters, Qalqalah, Ghunnah, Natural Madd, Review
- [x] Intermediate (8): Ikhfa, Ikhfa Shafawi, Idgham w/ Ghunnah, Idgham w/o Ghunnah, Idgham Shafawi, Idgham Mutajanisayn, Idgham Mutaqaribayn, Iqlab
- [x] Advanced (8): Madd Munfasil, Madd Muttasil, Madd Lazim, Tafkheem/Tarqeeq, Waqf, Ibtida, Advanced Ghunnah, Comprehensive Review
- [x] `CourseHomeScreen` - 3 level cards with progress rings and streak indicator
- [x] `LevelOverviewScreen` - Lesson list with completion state
- [x] `LessonScreen` - Theory/Examples/Quiz tabs
- [x] `QuizScreen` - Multiple choice, true/false, score tracking, 70% pass threshold
- [x] Riverpod providers for lesson progress, streaks, level completion
- [x] All 24 lessons completely free (no gating)

---

## Phase 4: Recording & Comparison [COMPLETED]

- [x] `RecordingScreen` - audio_waveforms integration with live waveform
- [x] Sheikh audio playback (EveryAyah CDN, Mishary Alafasy)
- [x] User recording with waveform visualization
- [x] Dual playback comparison (sequential: sheikh then user)
- [x] Self-assessment flow (1-5 stars with labels)
- [x] `AiAnalysisService` abstract interface + `NoOpAiAnalysisService` stub
- [x] Practice button wired into lesson examples tab
- [x] Microphone permission handling

---

## Phase 5: Additional Features [COMPLETED]

- [x] `SettingsScreen` - Theme picker, translation, audio, data, about
- [x] `MoreScreen` - Feature grid (6 tiles) + settings/donate links
- [x] `AzkarScreen` - 4 categories (morning, evening, after salah, sleep)
- [x] Azkar list with tap-to-count tasbih counter + haptic feedback
- [x] `PrayerTimesScreen` - Real prayer times via adhan_dart + geolocator (12 calc methods, live countdown)
- [x] `TafsirScreen` - Quran.com API + Al Quran Cloud fallback, HTML stripping
- [x] Tafsir button wired into ReadingScreen ayah actions
- [x] `SearchScreen` - Drift query search with quick-find surah chips
- [x] Search button added to QuranBrowseScreen AppBar
- [x] `QiblaScreen` - Compass with flutter_compass + geolocator + bearing calc
- [x] `HijriScreen` - Kuwaiti algorithm conversion, month reference, date picker
- [x] `OnboardingScreen` - 5 pages (welcome, features, theme, preferences, get started)
- [x] Onboarding wired into app.dart with SharedPreferences persistence
- [x] `HifzSetupScreen` - Surah picker with search, range selection, popular presets
- [x] `HifzScreen` - 3 difficulty levels (easy/medium/hard), progressive reveal, type challenge, self-assessment rating
- [x] `KhatmahScreen` - 4 plans (30/60/90/365 days), progress tracking, daily targets
- [x] Reading preferences provider (font size, default translation, default reciter) with SharedPreferences
- [x] Font size, translation, and reciter pickers in Settings screen
- [x] Onboarding preferences page wired with live pickers (theme, font, translation, reciter, tajweed, numeral style)
- [x] Numeral style preference (Arabic-Indic ١٢٣ vs Western 123) with provider + settings + onboarding
- [x] Tajweed colors toggle in settings + onboarding (default off for simpler reading)
- [x] App bar cleanup: consolidated options into 3-dot menus on reading + hifz screens
- [x] Fixed duplicate ayah numbers in mushaf mode + stripped from card modes
- [x] Ayah play button wired to AudioPlayerService (EveryAyah CDN)
- [x] Download manager: DownloadService, DownloadsScreen, offline toggle on reciter detail
- [x] Surah download with progress, batch download all, delete management
- [x] Juz navigation with 30 juz-to-surah/ayah start mapping
- [x] Page navigation with 604-page Madani mushaf surah mapping
- [x] All TODO placeholders resolved (0 remaining)

---

## Phase 6: Polish & Release [NEARLY COMPLETE]

- [x] `DonateScreen` - Sadaqah Jariyah, external links (PayPal, Buy Me a Coffee)
- [x] Donation screen wired into More tab
- [x] Android home screen widgets (Daily Ayah + Prayer Time) with home_widget package
- [x] All 4 themes polished (Colors.white → colorScheme.onPrimary/onSecondary, primaryColor → colorScheme.primary)
- [x] `AppLocalizations` - 14 languages (English, Arabic, French, Turkish, Urdu, Indonesian, Spanish, German, Russian, Bengali, Malay, Hindi, Portuguese, Chinese)
- [x] flutter_localizations wired into MaterialApp
- [x] Language selector in Settings with bottom sheet picker
- [x] `LocaleNotifier` - Locale state with SharedPreferences persistence
- [x] Translation system: 24 translations (Al Quran Cloud edition-based), in-reader picker
- [x] Reading screen uses user's selected translation preference (no more hardcoded ID)
- [x] Performance profiling (select()-based rebuilds, singleton ApiClient, static RegExp, translation Map, cacheExtent)
- [x] Accessibility audit (tooltips on all IconButtons, Semantics on mini player, touch targets fixed)
- [x] Splash screen (native Android green + Flutter animated splash with Arabic branding)
- [x] Adaptive app icon (vector foreground: open book + gold star, green background)
- [x] Reciter avatars: mic icons with hash-based color palette (replaces ugly letter avatars)
- [x] Localization review: all 14 languages verified, Russian/Chinese fixes
- [ ] Google Play Store listing

---

## Pre-Publish Checklist

### Code/Config
- [ ] Generate release signing key (`keytool -genkey ...`) and configure in `build.gradle.kts`
- [ ] Replace debug signing config with release signing config
- [ ] Generate proper mipmap PNGs from app icon design (use `flutter_launcher_icons`)
- [ ] Set version to `1.0.0+1` (already done)
- [ ] Run `flutter build appbundle --release` successfully

### Play Store Assets
- [ ] App icon: 512x512 PNG (hi-res, professional design)
- [ ] Feature graphic: 1024x500 banner image
- [ ] Phone screenshots: 4-8 screenshots from real device (home, quran, audio, tajweed, prayer, settings)
- [ ] App name: "Qurani - Quran, Tajweed, Azkar" (30 chars max)
- [ ] Short description (80 chars): "Free Quran with 260+ reciters, tajweed course, prayer times & azkar. No ads."
- [ ] Full description (4000 chars): keyword-rich, multilingual highlights
- [ ] Category: Books & Reference
- [ ] Content rating: complete IARC questionnaire
- [ ] Privacy policy URL (required — disclose location usage for prayer times/qibla)

### Testing
- [x] Real device testing on RMX3630
- [ ] Test all 5 tabs navigate correctly
- [ ] Test audio playback (streaming + downloaded + background)
- [ ] Test prayer times with GPS
- [ ] Test Qibla compass
- [ ] Test tajweed course lesson + quiz flow
- [ ] Test downloads + offline mode
- [ ] Test all 4 themes render correctly
- [ ] Test onboarding flow (fresh install)

---

## Play Store Listing Content

### App Name (30 chars max)
```
Qurani - Quran, Tajweed, Azkar
```

### Short Description (80 chars max)
```
Free Quran with 260+ reciters, tajweed course, prayer times & azkar. No ads.
```

### Full Description
```
Qurani is a completely free, ad-free Quran app with everything you need for your daily Islamic practice. No subscriptions, no premium features, no paywalls — everything is free for the sake of Allah.

QURAN READING
Read the Holy Quran in 3 modes: Mushaf (page-by-page), Translation, and Split (Arabic + translation side by side). Beautiful tajweed color-coded text highlights all 17 tajweed rules. Tap any colored word to learn the rule. Supports 24 translations in multiple languages.

260+ RECITERS
Listen to the Quran with over 260 reciters from around the world — more than any other app. Stream online or download surahs for offline listening. Background playback with lock screen controls. Skip between surahs, auto-advance with continuous mode.

TAJWEED COURSE — 24 FREE LESSONS
Learn tajweed with a structured 24-lesson course covering beginner, intermediate, and advanced levels. Each lesson includes theory, audio examples from sheikh recitations, practice exercises, and quizzes. Record yourself and compare with the sheikh. All lessons are completely free.

PRAYER TIMES & QIBLA
Accurate prayer times calculated offline from your GPS location — no internet needed. 12 calculation methods (MWL, Egyptian, Umm Al-Qura, ISNA, and more). Live countdown to next prayer. Qibla compass with real-time direction to the Kaaba.

AZKAR & TASBIH
Morning and evening azkar, after salah azkar, and sleep azkar with built-in tasbih counter and haptic feedback.

MEMORIZATION (HIFZ)
Memorize the Quran with progressive verse hiding. 3 difficulty levels: easy (first word shown), medium (fully hidden), and hard (type from memory).

MORE FEATURES
• Hijri calendar with date conversion
• Reading plans (Khatmah): finish the Quran in 30, 60, 90, or 365 days
• Tafsir integration (multiple tafsir sources)
• Quran search (Arabic and translation)
• 4 themes: Light, Dark, Sepia, AMOLED
• 14 languages: English, Arabic, French, Turkish, Urdu, Indonesian, Spanish, German, Russian, Bengali, Malay, Hindi, Portuguese, Chinese
• Offline-first: works without internet
• Home screen widgets (Daily Ayah, Prayer Time)
• Download surahs for offline listening
• Reading progress tracking

WHY QURANI?
• 100% FREE — no ads, no subscriptions, no premium
• 260+ reciters (competitors have 10-20)
• Full tajweed course (no other app teaches all 24 rules for free)
• Offline prayer times (pure math, no API dependency)
• Built with love as Sadaqah Jariyah

Support the project through voluntary donations — every feature stays free forever.
```

### Tags
quran, islam, prayer, tajweed, azkar

### Category
Books & Reference (primary)

### SEO Keywords to Target
quran, coran, القرآن, al quran, quran app, quran mp3, quran offline,
prayer times, adhan, adan, salat times, namaz times,
tajweed, tajwid, learn quran, quran tajweed,
azkar, adhkar, morning azkar, evening azkar, azkar muslim,
qibla, qibla compass, qibla direction, qibla finder,
reciter, mishary, sudais, quran recitation, quran audio,
hifz, memorize quran, quran memorization,
hijri calendar, islamic calendar,
offline quran, quran without internet, free quran app, no ads quran,
tasbih, dhikr, islamic app, muslim app, ramadan

### Privacy Policy (Draft — host on GitHub Pages or similar)
```
Privacy Policy for Qurani

Last updated: February 2026

Qurani is a free Quran app. We respect your privacy.

DATA WE COLLECT:
- Location (GPS): Used ONLY locally on your device to calculate prayer times
  and Qibla direction. Your location is never sent to any server.
- Audio recordings: Used ONLY locally for tajweed practice comparison.
  Recordings are never uploaded or shared.

DATA WE DO NOT COLLECT:
- No personal information
- No email addresses or accounts
- No analytics or tracking
- No advertising identifiers
- No data shared with third parties

NETWORK USAGE:
- Quran text and translations: fetched from Quran.com and Al Quran Cloud APIs
- Audio streaming: fetched from MP3Quran.net and EveryAyah.com CDNs
- All fetched data is cached locally for offline use

PERMISSIONS:
- Internet: to stream audio and fetch Quran data
- Location: to calculate prayer times and Qibla (offline, never shared)
- Microphone: for tajweed recording practice (local only)
- Storage: to save downloaded audio for offline listening

Contact: anas.boudyach@gmail.com
```

### Release Signing Key Command
```bash
keytool -genkey -v -keystore ~/qurani-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias qurani
```
Keep this keystore file safe — you need it for every future update.

---

## GitHub README.md Content

```markdown
# Qurani قُرآني

A comprehensive, completely free Quran app for Android. No ads. No subscriptions. No premium features. Everything is free for the sake of Allah.

Built with Flutter as Sadaqah Jariyah (ongoing charity).

## Features

### Quran Reading
- 3 reading modes: Mushaf (page-by-page), Translation, and Split view
- Tajweed color-coded text with all 17 rules highlighted
- Tap any colored word to learn the tajweed rule
- 24 translations in multiple languages
- Reading progress tracking

### Audio — 260+ Reciters
- Stream from the world's largest collection of Quran reciters
- Download surahs for offline listening
- Background playback with lock screen controls
- Skip between surahs, auto-advance with continuous mode
- Repeat modes: ayah, surah, or continuous

### Tajweed Course — 24 Free Lessons
- Structured curriculum: Beginner (8), Intermediate (8), Advanced (8)
- Theory, audio examples, practice exercises, and quizzes per lesson
- Record yourself and compare with sheikh recitation
- 70% pass threshold with progress tracking
- All 24 lessons completely free

### Prayer Times & Qibla
- Offline prayer time calculation from GPS (no API needed)
- 12 calculation methods (MWL, Egyptian, Umm Al-Qura, ISNA, etc.)
- Live countdown to next prayer
- Qibla compass with real-time direction

### Azkar & Tasbih
- Morning, evening, after salah, and sleep azkar
- Built-in tasbih counter with haptic feedback

### Memorization (Hifz)
- Progressive verse hiding (3 difficulty levels)
- Easy: first word shown | Medium: fully hidden | Hard: type from memory

### More
- Hijri calendar with date conversion
- Reading plans (Khatmah): 30, 60, 90, or 365 days
- Tafsir integration (multiple sources)
- Quran search (Arabic + translation)
- 4 themes: Light, Dark, Sepia, AMOLED
- 14 languages
- Home screen widgets (Daily Ayah, Prayer Time)
- Offline-first architecture

## Tech Stack

| Technology | Purpose |
|-----------|---------|
| Flutter (Dart) | UI framework |
| Riverpod | State management |
| go_router | Navigation with shell routes |
| Drift (SQLite) | Local database (offline-first) |
| Dio | HTTP client with caching |
| just_audio | Audio playback + background |
| adhan_dart | Offline prayer time calculation |
| audio_waveforms | Recording + waveform visualization |
| flutter_compass | Qibla compass |
| geolocator | GPS location |

## APIs

| API | Purpose |
|-----|---------|
| [Quran.com](https://quran.com) | Primary text, tajweed, translations, tafsir |
| [Al Quran Cloud](https://alquran.cloud) | Fallback text and audio |
| [MP3Quran](https://mp3quran.net) | 260+ reciters, surah-level audio |
| [EveryAyah](https://everyayah.com) | Verse-by-verse audio |

## Architecture

```
lib/
  core/           # Theme, router, database, network, l10n
  features/       # Feature modules (clean architecture)
    quran/        # Reading, browsing, search, tafsir
    audio/        # Player, reciters, downloads
    tajweed_course/ # 24 lessons, quizzes, recording
    prayer_times/ # Prayer times, Qibla, Hijri
    azkar/        # Azkar with tasbih counter
    hifz/         # Memorization mode
    reading_plans/# Khatmah plans
    settings/     # App settings, more screen
    home/         # Dashboard
    onboarding/   # Welcome flow
    donate/       # Sadaqah Jariyah
  shared/         # Shared widgets (app shell, mini player)
```

## Building

```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Build release APK
flutter build apk --release

# Build release App Bundle (for Play Store)
flutter build appbundle --release
```

## Screenshots

<!-- Add screenshots from your device here -->

## Contributing

This is a Sadaqah Jariyah project. Contributions are welcome:
- Report bugs via Issues
- Submit feature requests
- Open pull requests

## Support

This app is free and will always be free. If you'd like to support the project:
- Make dua for the developers
- Share the app with others
- Leave a review on the Play Store
- [Buy Me a Coffee](https://buymeacoffee.com/) / [PayPal](https://paypal.me/)

## License

MIT License — free to use, modify, and distribute.

---

*Built with love as Sadaqah Jariyah. May Allah accept it from us.*
```

---

## APIs Used
| API | Base URL | Auth | Purpose |
|-----|----------|------|---------|
| Quran.com v4 | `https://api.quran.com/api/v4` | OAuth2 | Primary text/tajweed/translations/tafsir |
| Al Quran Cloud | `https://api.alquran.cloud/v1` | None | Fallback text/tajweed/audio |
| MP3Quran | `https://mp3quran.net/api/v3` | None | 260+ reciters |
| EveryAyah | `https://everyayah.com/data` | None | Offline MP3 downloads |
| Tanzil.net | `https://tanzil.net` | None | Bundled text data |
| QuranHub | `https://api.quranhub.com` | None | 156+ tafsir editions |

## Key Files Reference
| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/app.dart` | MaterialApp.router setup |
| `lib/core/theme/app_theme.dart` | 4 theme definitions |
| `lib/core/router/app_router.dart` | GoRouter with 5 shell branches |
| `lib/core/utils/tajweed_parser.dart` | HTML tajweed -> TajweedToken parser |
| `lib/core/constants/tajweed_colors.dart` | 17 tajweed rule colors + info |
| `lib/core/network/api_client.dart` | Dio clients for all APIs |
| `lib/core/network/api_orchestrator.dart` | Multi-API fallback logic |
| `lib/core/database/app_database.dart` | Drift database (12 tables) |
| `lib/shared/widgets/app_shell.dart` | Scaffold + bottom nav + mini player |
| `lib/features/quran/presentation/screens/reading_screen.dart` | 3-mode reader |
| `lib/features/quran/presentation/screens/quran_browse_screen.dart` | Surah/Juz/Page browse |
| `lib/features/quran/data/repositories/quran_repository.dart` | Offline-first data |
| `lib/features/quran/presentation/providers/quran_providers.dart` | Riverpod providers |
| `lib/features/quran/presentation/widgets/tajweed_text_widget.dart` | Tajweed color text |
| `lib/features/quran/data/models/surah_info.dart` | 114 surah metadata |
| `lib/features/bookmarks/data/repositories/bookmark_repository.dart` | Reading progress |
| `lib/features/home/presentation/screens/dashboard_screen.dart` | Home dashboard |
| `lib/features/audio/data/services/audio_player_service.dart` | Audio player service |
| `lib/features/audio/data/models/reciter.dart` | Reciter data model |
| `lib/features/audio/data/repositories/audio_repository.dart` | Reciter API repo |
| `lib/features/audio/presentation/widgets/mini_player_widget.dart` | Mini player |
| `lib/features/audio/presentation/screens/full_player_screen.dart` | Full player |
| `lib/features/audio/presentation/screens/reciter_list_screen.dart` | Reciter list |
| `lib/features/audio/presentation/screens/reciter_detail_screen.dart` | Reciter detail |
| `lib/features/tajweed_course/data/models/tajweed_lesson.dart` | Lesson data model |
| `lib/features/tajweed_course/data/tajweed_curriculum.dart` | 24 lessons content |
| `lib/features/tajweed_course/presentation/screens/course_home_screen.dart` | Course home |
| `lib/features/tajweed_course/presentation/screens/level_overview_screen.dart` | Level lessons |
| `lib/features/tajweed_course/presentation/screens/lesson_screen.dart` | Lesson view |
| `lib/features/tajweed_course/presentation/screens/quiz_screen.dart` | Quiz system |
| `lib/features/settings/presentation/screens/settings_screen.dart` | App settings |
| `lib/features/settings/presentation/screens/more_screen.dart` | More menu |
| `lib/features/azkar/presentation/screens/azkar_screen.dart` | Azkar + tasbih |
| `lib/features/prayer_times/presentation/screens/prayer_times_screen.dart` | Prayer times |
| `lib/features/prayer_times/presentation/screens/qibla_screen.dart` | Qibla compass |
| `lib/features/prayer_times/presentation/screens/hijri_screen.dart` | Hijri calendar |
| `lib/features/quran/presentation/screens/search_screen.dart` | Quran search |
| `lib/features/quran/presentation/screens/tafsir_screen.dart` | Tafsir viewer |
| `lib/features/tajweed_course/presentation/screens/recording_screen.dart` | Recording & comparison |
| `lib/features/onboarding/presentation/screens/onboarding_screen.dart` | Onboarding flow |
| `lib/features/donate/presentation/screens/donate_screen.dart` | Donation screen |
| `lib/features/hifz/presentation/screens/hifz_screen.dart` | Hifz memorization |
| `lib/features/hifz/presentation/screens/hifz_setup_screen.dart` | Hifz setup/picker |
| `lib/features/reading_plans/presentation/screens/khatmah_screen.dart` | Khatmah reading plans |
| `lib/core/l10n/app_localizations.dart` | Custom localization (14 languages) |
| `lib/core/l10n/locale_provider.dart` | Locale state + persistence |
| `lib/features/onboarding/presentation/screens/splash_screen.dart` | Animated splash screen |
| `lib/core/providers/reading_preferences_provider.dart` | Font size, translation, reciter prefs |
| `lib/features/widgets/home_widget_service.dart` | Android home screen widget data service |

## Git Commits
1. `10380cd` - Phase 0: Initial Flutter project setup
2. `4fcaf4e` - Phase 0: App shell, placeholder screens, and entry point
3. `9fbb80c` - Phase 0: Drift database with all tables
4. `31e0533` - Phase 1: Surah browsing UI + TajweedTextWidget + SurahListTile
5. `a08c9ec` - Phase 1: ReadingScreen with 3 modes + QuranRepository + providers
6. `9313da5` - Phase 1: Bookmarks, reading progress, and enhanced dashboard
7. `539d577` - Phase 2: Audio system - player service, reciters, mini/full player
8. `b8d1c05` - Phase 3: Tajweed course - 24 lessons, quiz system, progress tracking
9. `e979d9c` - Phase 5: Settings, Azkar with tasbih, prayer times, more screen
10. `3643d65` - Update PROGRESS.md with all completed phases
11. `0415221` - Phase 5: Search screen and tafsir integration
12. `5f124a7` - Phase 4-6: Recording, onboarding, Qibla, Hijri, donation
13. `3596415` - Update PROGRESS.md with Phase 4-6 completion
14. `a6fa710` - Phase 5: Hifz memorization mode and Khatmah reading plans
15. `ff5ac7f` - Update PROGRESS.md with Hifz and Khatmah completion
16. `37c104b` - Phase 6: Localization framework with 6 languages
17. `caa1137` - Phase 6: Splash screen, language selector, and theme polish
18. `14d0d27` - Resolve all TODO placeholders across the codebase
19. `9b483ff` - Update PROGRESS.md with TODO resolution and new commits
20. `0f7cb46` - Phase 6: Home screen widgets, accessibility, and adaptive app icon
21. `24940c4` - Fix audio playback, onboarding, and reading screen bugs
22. `6b932b0` - Translation system overhaul and 14-language UI support
23. `66a2986` - Performance profiling: fix excessive rebuilds, memory leaks, and O(N) lookups
24. `4d6ed2b` - Update PROGRESS.md with performance profiling completion
25. `55fe091` - Remove bookmark system entirely, keep reading progress
26. `d4bc0ca` - Remove share button from reading screen ayah cards
27. `dae049f` - Update PROGRESS.md with bookmark removal and share button cleanup
28. `d7ce6dd` - Fix FullPlayerScreen UI freeze: remove post-frame callback deadlock
29. `acc4261` - Fix dashboard: wire Quick Action buttons, rotate Daily Ayah by date
30. `aab60c1` - Real prayer times with adhan_dart, fix settings placeholders, add Android permissions
31. `3889583` - Download manager: offline audio downloads with progress, storage management
32. `994e0a0` - Fix dialog cancel buttons using wrong BuildContext
33. `fe6ca24` - Audio player: replace seek buttons with skip next/previous navigation
34. `c6df3ff` - Background audio playback with notification and lock screen controls
35. `6a390eb` - UI polish: reciter mic icons with unique colors, fix localization
36. `cee6ecd` - Fresh repo: clean single-commit push to GitHub (anasBoudyach/Qurani)

## Session Work (Feb 22, 2026)

### Fixes
- Background audio: `AudioServiceActivity` in MainActivity.kt for notification/lock screen controls
- Single-player fix: RecordingScreen reuses shared AudioPlayer (just_audio_background only allows one)
- Surah repeat: handled manually in `_handleCompletion` (LoopMode.all == LoopMode.one on single source)

### UI Changes
- Unified playback mode button: Single → Continuous → Repeat Surah → Repeat Ayah (was 2 confusing buttons)
- Playback mode snackbar at top of screen on mode change
- Removed "Now Playing" title from full player screen
- Playback mode labels localized (14 languages)

### Repo & Docs
- GitHub repo created: https://github.com/anasBoudyach/Qurani (public)
- README.md: full feature list, tech stack, architecture, build instructions
- PRIVACY_POLICY.md: for Google Play Store listing
- `.claude/` and `.vscode/` added to .gitignore
- Git history cleaned: single commit, no Co-Authored-By lines

## Session Work (Feb 23, 2026) — UI Overhaul + New Features

### UI Design Overhaul
- **Color palette**: 12 feature accent colors + 6 gradient pairs (with dark variants) in `app_colors.dart`
- **Theme upgrade**: Card border radius 12→16, elevation 2 with shadow, tertiary color in ColorScheme
- **GradientHeader**: Reusable gradient header widget with mosque silhouette (CustomPainter)
- **FeatureTile**: Shared colorful rounded-square icon tile for feature grids
- **Dashboard overhaul**: Sky gradient header with greeting + daily ayah, continue reading card with progress bar, 3x2 feature grid
- **Mini player polish**: Height 56→64, rounded top corners, thin progress line at top, shadow (visual only — zero audio changes)
- **Reading screen**: Ayah cards radius 12→16, subtle shadow instead of border
- **Azkar screen**: Gold gradient header replacing plain AppBar
- **More screen**: Green gradient header, 3x3 feature grid with Du'as/Ahkam/Ahadith tiles, shared FeatureTile component

### New Features: Du'as
- `lib/features/duas/` — complete feature with data + screens
- `DuaCategory` + `Dua` models (arabic, transliteration, translation, reference, repeatCount)
- ~100 authentic du'as across 12 categories (Morning, Evening, Sleep, Waking, Mosque, Eating, Travel, Rain, Healing, Forgiveness, Parents, Difficulty)
- Category list screen with orange gradient header
- Du'a detail with tap-to-count, copy button, reference display

### New Features: Ahkam (Islamic Rulings)
- `lib/features/ahkam/` — complete feature with data + screens
- `AhkamCategory` + `AhkamTopic` + `MadhabRuling` models
- ~40 topics across 8 categories: Taharah, Salah, Sawm, Zakat, Hajj, Nikah, Food, Daily Life
- Multi-madhab: each topic shows rulings from Hanafi, Maliki, Shafi'i, Hanbali with Quran/Hadith evidence
- Expandable topic cards with color-coded madhab ruling cards
- Cyan gradient header

### New Features: Ahadith (Hadith Collections)
- `lib/features/ahadith/` — complete feature with data + screens
- `HadithCollection` + `HadithBook` + `Hadith` models with grade enum
- 6 collections: Bukhari, Muslim, Abu Dawud, Tirmidhi, Nasa'i, Ibn Majah
- 3 books per collection, 5 hadiths per book (90 total bundled, static offline)
- Grade badges (Sahih=green, Hasan=amber, Da'if=red), narrator display, copy button
- Deep red gradient header, collection → books → hadiths navigation

## Session Work (Feb 23, 2026) — Homepage Redesign + Gamification + Animations

### Animation Infrastructure
- **StaggeredAnimationGrid**: Reusable widget with fade + scale + slide-up per child (50ms stagger, 400ms duration)
- **AnimatedCounter**: TweenAnimationBuilder for smooth number roll-up (streak count, stats)
- **SlideUpRoute / FadeScaleRoute**: Custom page transitions replacing MaterialPageRoute
- **CelebrationOverlay**: Confetti particles via CustomPainter, auto-dismiss after 1.5s
- **Parallax header**: GradientHeader now accepts scrollOffset for mosque/circle parallax

### Gamification System
- **DailyActivityLog** table added to Drift DB (schema v2 with migration)
- **ActivityType** enum: readQuran, listenQuran, morningAzkar, eveningAzkar, makeDua, tajweedLesson
- **GamificationService**: Records activities, updates streak, checks achievement conditions
- **DailyGoal** model: 4 default goals (Read, Listen, Azkar, Du'a) with auto-completion tracking
- **15 AchievementDefs**: first_read, streak_3/7/30, azkar_morning/evening, tajweed levels, hifz, listener, explorer, dedicated
- **Riverpod providers**: dailyStreakProvider, dailyGoalsProvider, unlockedAchievementsProvider, gamificationServiceProvider

### Dashboard Rewrite
- All 12 features on homepage (4x3 grid with staggered animation) — no need for More screen
- Streak & Daily Goals card: fire icon + AnimatedCounter + circular progress ring + 4 goal chips
- Achievements preview section: shows 4 most recent unlocked badges
- Parallax gradient header with ScrollController
- Compact FeatureTile mode (48x48 icons) for 4-column grid
- All navigation uses SlideUpRoute custom page transition

### More Screen Simplification
- Removed 9-tile feature grid (all features now on dashboard)
- Clean utility list: Achievements, Downloads, Settings, Support, About
- AchievementsScreen: 3-column grid of 15 badges (unlocked=color, locked=grey+lock icon)

### Gamification Wiring
- ReadingScreen: records readQuran on initState
- ReciterDetailScreen: records listenQuran on play
- AzkarListScreen: records morningAzkar/eveningAzkar on category completion + celebration
- DuaListScreen: records makeDua on all du'as completed + celebration
- QuizScreen: records tajweedLesson on pass + celebration

### Celebration Animations
- Azkar: triggers when all items in a category are counted
- Du'as: triggers when all repeatable du'as in a category are done
- Quiz: triggers on passing score (70%+) with 300ms delay

## Session Work (Feb 23, 2026) — UX Polish + Preferences

### Hifz Self-Assessment System
- Replaced auto-correct with user self-rating: correct (✓) / wrong (✗) buttons after reveal
- State now uses 3 Sets (`_revealedAyahs`, `_correctAyahs`, `_wrongAyahs`) instead of counters
- Green/red score tracking in progress bar with icons
- Colored card borders for rated ayahs (green = correct, red = wrong)
- `_RatingButton` widget for consistent rating UI

### App Bar Cleanup (3-Dot Menus)
- **Reading screen**: Replaced 5 separate icon buttons with single `PopupMenuButton<String>` (3-dot menu)
  - Grouped sections: Reading Mode, Font Size, divider, Tajweed toggle, Translation, Continuous Play
  - Each item has icon + text label + checkmark for active state
- **Hifz screen**: Same treatment — replaced 4 action icons with single 3-dot menu
  - Items: Difficulty level, Tajweed toggle, Show All, Reset Progress
- Added `_checkItem` and `_hifzCheckItem` helper methods for clean menu items

### Default Reading Mode
- Changed tajweed default from `true` to `false` (plain text by default, tajweed opt-in)

### Split View Play Button
- Added play/pause button to split reading mode (was missing, only translation mode had it)

### Ayah Number Deduplication
- API returns ayah text with embedded end-of-ayah marker (۝) + Arabic-Indic digits
- **Translation/Split modes**: Strip trailing ayah numbers with regex (`_plainTextNoNumber()`) — redundant with card badge
- **Mushaf mode**: Removed our manually-added duplicate `\u06DD` + numeral — API text already has numbers
- Removed unused `_toArabicNumeral` method

### Numeral Style Preference
- Added `NumeralStyle` enum (arabic/western) + `NumeralStyleNotifier` + `numeralStyleProvider`
- `formatAyahNumber()` helper: converts int to Arabic-Indic (١٢٣) or Western (123)
- **Settings screen**: Added numeral style picker (bottom sheet with RadioListTile)
- **Onboarding page 4**: Added numeral style toggle card (tap to switch between styles)
- **Reading screen**: Wired into translation card badge + split mode number badge
- **Hifz screen**: Wired into ayah number badge

### Settings & Onboarding Updates
- **Settings**: Added Tajweed Colors SwitchListTile + Ayah Numbers picker in "Quran Reading" section
- **Onboarding**: Added `_ToggleCard` widget for tajweed + numeral style on preferences page
- Wrapped preferences page content in `SingleChildScrollView` (more items now fit)

## Session Work (Feb 24, 2026) — Reading Screen Simplification

### Reading Mode Cleanup
- Simplified from 3 modes to 2: **Recitation** (ayah-by-ayah cards) + **Mushaf** (page-by-page)
- Removed **Split** mode entirely (redundant now that translation is optional)
- Renamed `ReadingMode.translation` → `ReadingMode.recitation` across enum and UI

### Translation as Optional Toggle
- Added **"None"** option to translation picker (first in list, edition `'none'`)
- Translation visibility driven by selected translation: pick a language = shown, pick "None" = hidden
- Skips API call entirely when translation is set to "None" (no wasted network)
- Default for new users remains Saheeh International (English)
- Removed `_showTranslation` local state variable — no longer needed

### Font Size Cleanup
- Removed font size picker from reading screen 3-dot menu
- Reading screen now uses `ref.watch(fontSizeProvider)` from Riverpod provider (persisted in Settings)
- Single source of truth: font size only changeable in Settings → Default Font Size
- Removed local `_fontSize` state variable

### Store Assets Organization
- Moved `feature_graphic.png` and `icon.png` from root to `assets/store/`
- Added `background.png` to `assets/store/`
- Updated README with feature graphic banner, app icon, badges, and GitHub Sponsors link
- Added GitHub Sponsors donation option to DonateScreen
