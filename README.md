<p align="center">
  <img src="assets/store/feature_graphic.png" width="100%" alt="Qurani Feature Graphic"/>
</p>

<p align="center">
  <img src="assets/store/icon.png" width="120" alt="Qurani Icon"/>
</p>

<h1 align="center">Qurani قُرآني</h1>

<p align="center">
  <strong>The all-in-one Islamic app that other apps charge you for — completely free.</strong><br/>
  No ads. No subscriptions. No "premium" lock. Every feature, every reciter, every lesson — free for the sake of Allah.
</p>

<p align="center">
  <a href="https://github.com/sponsors/anasBoudyach"><img src="https://img.shields.io/badge/Sponsor-❤-db61a2?style=for-the-badge" alt="Sponsor"/></a>
  <img src="https://img.shields.io/badge/Platform-Android-3ddc84?style=for-the-badge&logo=android&logoColor=white" alt="Android"/>
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License"/>
</p>

<p align="center">
  <code>260+ Reciters</code> &nbsp;·&nbsp;
  <code>40,000+ Hadiths</code> &nbsp;·&nbsp;
  <code>132 Azkar Categories</code> &nbsp;·&nbsp;
  <code>24 Tajweed Lessons</code> &nbsp;·&nbsp;
  <code>14 Languages</code> &nbsp;·&nbsp;
  <code>5 Home Widgets</code>
</p>

<p align="center"><em>Built with love as Sadaqah Jariyah (ongoing charity)</em></p>

---

## Why Qurani?

Most popular Islamic apps either lock features behind a paywall or only cover one area (just prayer times, just audio, just reading). Qurani gives you **everything in one app, for free**.

| Feature | Qurani | Muslim Pro | Athan | Quran.com | Tarteel |
|---------|:------:|:----------:|:-----:|:---------:|:-------:|
| **Reciters** | **260+** | ~40 | ~10 | ~20 | ~10 |
| **Tajweed course** | **24 lessons FREE** | No | No | No | Premium |
| **Record & compare** | **FREE** | No | No | No | Premium |
| **Hadiths** | **40,000+** (6 collections) | Limited | No | No | No |
| **Azkar** | **132 categories** | Basic | Basic | No | No |
| **Du'as** | **23 categories** | Basic | No | No | No |
| **Fiqh / Ahkam** | **4 madhabs** | No | No | No | No |
| **Hifz mode** | **3 levels FREE** | Premium | No | No | Premium |
| **Offline downloads** | **FREE** | Premium | No | Partial | No |
| **Home screen widgets** | **5 widgets** | Premium | 1 | No | No |
| **Gamification** | **Goals + streaks + badges** | No | No | No | No |
| **Prayer reminders** | **Per-prayer + offsets** | Yes | Yes | No | No |
| **Islamic events** | **10 events + countdown** | Yes | Yes | No | No |
| **Themes** | **4** (Light/Dark/Sepia/AMOLED) | 2 | 2 | 2 | 1 |
| **Price** | **Free forever** | $4.99/mo | Ads | Free | $9.99/mo |
| **Ads** | **None** | Yes (free tier) | Yes | No | No |

---

## Features

### Read the Quran Your Way
- **Recitation mode**: ayah-by-ayah cards with optional translation (24 translations, 20+ languages)
- **Mushaf mode**: authentic page-by-page layout
- Tajweed color-coded text — all 17 rules highlighted, tap any word to learn
- Auto-save your reading position — pick up exactly where you left off
- Audio auto-scroll: the text follows along as you listen
- Bookmark any ayah, search Arabic + translation, access tafsir with one tap

### Listen to 260+ Reciters
More than any other app. Mishary, Sudais, Abdul Basit, Maher Al Muaiqly, and 256+ more.
- Stream or download entire surahs for offline listening
- Background playback with notification + lock screen controls
- Playback modes: Single, Continuous, Repeat Surah, Repeat Ayah
- Mini player stays visible across all tabs

### Learn Tajweed — 24 Free Lessons
No other app teaches all tajweed rules for free.
- 3 levels: Beginner (8), Intermediate (8), Advanced (8)
- Theory, sheikh audio examples, practice exercises, and quizzes
- Record yourself and compare side-by-side with the sheikh
- 70% pass threshold with progress tracking

### Prayer Times, Qibla & Reminders
- Offline calculation from GPS — works without internet (12 methods: MWL, Egyptian, Umm Al-Qura, ISNA, Karachi, etc.)
- Live countdown to next prayer
- Per-prayer notification reminders (at time, or 5/10/15/30 min before)
- Qibla compass with real-time bearing
- Hijri calendar + 10 Islamic events timeline with countdown

### Azkar & Du'as — Complete Hisn al-Muslim
- **132 azkar categories**: morning, evening, prayer, sleep, travel, rain, sickness, and more
- **23 du'a categories**: Istikhara, Anxiety, Travel, Sickness, Tawbah, Hajj, and more
- Tap-to-count tasbih with haptic feedback
- All from HisnMuslim API, cached offline

### 40,000+ Hadiths
- 6 major collections: Bukhari, Muslim, Abu Dawud, Tirmidhi, Nasa'i, Ibn Majah
- Arabic + English text, organized by chapters
- Authenticity grades: Sahih, Hasan, Da'if
- Cached locally for offline reading

### Islamic Rulings (Ahkam) — 4 Madhabs Side by Side
- 8 categories: Purification, Prayer, Fasting, Zakat, Hajj, Marriage, Food, Daily Life
- Each topic shows Hanafi, Maliki, Shafi'i, and Hanbali positions with Quran/Hadith evidence

### Memorize the Quran (Hifz)
- Progressive verse hiding — 3 difficulty levels
- Easy (first word shown), Medium (fully hidden), Hard (type from memory)
- Self-assessment with score tracking

### Gamification — Build Consistent Habits
- 4 daily goals: Read, Listen, Azkar, Du'a
- Daily streak with fire counter
- 15 achievements to unlock
- Celebration confetti when you hit milestones

### Even More
- **Khatmah**: finish the Quran in 30, 60, 90, or 365 days
- **5 home screen widgets**: Daily Ayah, Prayer Time, Hijri Date, Daily Azkar, Hadith of the Day
- **4 themes**: Light, Dark, Sepia, AMOLED
- **14 UI languages**: English, Arabic, French, Turkish, Urdu, Indonesian, Spanish, German, Russian, Bengali, Malay, Hindi, Portuguese, Chinese
- **Offline-first**: everything cached locally after first load

---

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
| [Fawaz Ahmed Hadith API](https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1) | 40,000+ hadiths, 6 collections |
| [HisnMuslim API](https://www.hisnmuslim.com) | 132 azkar/du'a categories |

## Architecture

```
lib/
  core/             # Theme, router, database, network, l10n, services
  features/         # Feature modules (clean architecture)
    quran/          # Reading, browsing, search, tafsir
    audio/          # Player, reciters, downloads
    bookmarks/      # Ayah bookmarks
    tajweed_course/ # 24 lessons, quizzes, recording
    prayer_times/   # Prayer times, Qibla, Hijri, reminders
    islamic_events/ # 10 recurring Islamic events
    azkar/          # 132 azkar categories (HisnMuslim API)
    duas/           # 23 du'a categories (HisnMuslim API)
    ahkam/          # Islamic rulings (4 madhabs)
    ahadith/        # 40K+ hadiths, 6 collections (Hadith API)
    hifz/           # Memorization mode
    reading_plans/  # Khatmah plans
    gamification/   # Daily goals, streaks, 15 achievements
    widgets/        # 5 Android home screen widgets
    settings/       # App settings, more screen
    home/           # Dashboard with feature grid
    onboarding/     # 5-page welcome flow
    donate/         # Sadaqah Jariyah
  shared/           # Shared widgets (app shell, mini player)
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

<!-- Add device screenshots here -->
<!-- Example:
<p align="center">
  <img src="assets/store/screenshot1.png" width="24%" />
  <img src="assets/store/screenshot2.png" width="24%" />
  <img src="assets/store/screenshot3.png" width="24%" />
  <img src="assets/store/screenshot4.png" width="24%" />
</p>
-->

## Contributing

This is a Sadaqah Jariyah project. Contributions are welcome:
- Report bugs via Issues
- Submit feature requests
- Open pull requests

## Support

This app is free and will always be free. If you'd like to support the project:
- [**Sponsor on GitHub**](https://github.com/sponsors/anasBoudyach) — one-time or monthly
- Make dua for the developers
- Share the app with others
- Leave a review on the Play Store

## Privacy Policy

See [PRIVACY_POLICY.md](PRIVACY_POLICY.md)

## License

MIT License — free to use, modify, and distribute.

---

<p align="center"><em>بارك الله فيكم — May Allah accept it from us.</em></p>
