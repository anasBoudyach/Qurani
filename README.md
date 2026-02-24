<p align="center">
  <img src="assets/store/feature_graphic.png" width="100%" alt="Qurani Feature Graphic"/>
</p>

<p align="center">
  <img src="assets/store/icon.png" width="120" alt="Qurani Icon"/>
</p>

<h1 align="center">Qurani قُرآني</h1>

<p align="center">
  A comprehensive, completely free Quran app for Android.<br/>
  No ads. No subscriptions. No premium features.<br/>
  Everything is free for the sake of Allah.
</p>

<p align="center">
  <a href="https://github.com/sponsors/anasBoudyach"><img src="https://img.shields.io/badge/Sponsor-❤-db61a2?style=for-the-badge" alt="Sponsor"/></a>
  <img src="https://img.shields.io/badge/Platform-Android-3ddc84?style=for-the-badge&logo=android&logoColor=white" alt="Android"/>
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License"/>
</p>

<p align="center"><em>Built with love as Sadaqah Jariyah (ongoing charity)</em></p>

## Features

### Quran Reading
- 2 reading modes: Recitation (ayah-by-ayah cards) and Mushaf (page-by-page)
- Optional translation overlay (24 translations in 20+ languages, or None)
- Tajweed color-coded text with all 17 rules highlighted
- Tap any colored word to learn the tajweed rule
- Auto-save reading position (resumes exactly where you left off)
- Audio auto-scroll: reading follows along as you listen
- Bookmark any ayah for quick access later
- Arabic-Indic or Western numeral styles
- Tafsir integration (multiple sources, tap any ayah)
- Full-text search (Arabic + translation)

### Audio — 260+ Reciters
- Stream from the world's largest collection of Quran reciters
- Download surahs for offline listening (batch download supported)
- Background playback with notification + lock screen controls
- Playback modes: Single, Continuous, Repeat Surah, Repeat Ayah
- Skip previous/next navigation (surah-level + ayah-level)
- Play any individual ayah directly from the reading screen
- Persistent mini player across all tabs with full controls

### Tajweed Course — 24 Free Lessons
- Structured curriculum: Beginner (8), Intermediate (8), Advanced (8)
- Theory, audio examples, practice exercises, and quizzes per lesson
- Record yourself and compare side-by-side with sheikh recitation
- 70% pass threshold with progress tracking
- All 24 lessons completely free

### Prayer Times, Qibla & Reminders
- Offline prayer time calculation from GPS (no API needed)
- 12 calculation methods (MWL, Egyptian, Umm Al-Qura, ISNA, Karachi, etc.)
- Live countdown to next prayer
- Per-prayer notification reminders (configurable: at time, 5/10/15/30 min before)
- Qibla compass with real-time bearing to the Kaaba
- Hijri calendar with Gregorian conversion
- Islamic events timeline (10 events: Ramadan, Eid al-Fitr, Eid al-Adha, Laylat al-Qadr, etc.)

### Azkar — 132 Categories from Hisn al-Muslim
- API-powered from HisnMuslim (complete Fortress of the Muslim)
- 132 categories: morning, evening, prayer, sleep, travel, rain, sickness, and more
- Searchable category grid with tap-to-count tasbih counter and haptic feedback
- Cached locally on first view for offline access

### Du'as — 23 Supplication Categories
- API-powered from HisnMuslim
- Categories: Istikhara, Anxiety, Distress, Travel, Sickness, Tawbah, Hajj, and more
- Arabic text with tap-to-count for repeated du'as
- Copy to clipboard, celebration on category completion

### Ahadith — 40,000+ Hadiths
- 6 major collections: Bukhari, Muslim, Abu Dawud, Tirmidhi, Nasa'i, Ibn Majah
- API-powered from Fawaz Ahmed Hadith CDN
- Arabic text with English translation, organized by sections/chapters
- Grade badges (Sahih, Hasan, Da'if) and narrator display
- Cached locally on first view for offline access

### Ahkam — Islamic Rulings (4 Madhabs)
- 8 categories: Purification, Prayer, Fasting, Zakat, Hajj, Marriage, Food, Daily Life
- Side-by-side rulings from Hanafi, Maliki, Shafi'i, and Hanbali schools
- Quran and Hadith evidence for each position
- 40+ topics with expandable details

### Memorization (Hifz)
- Progressive verse hiding (3 difficulty levels)
- Easy: first word shown | Medium: fully hidden | Hard: type from memory
- Self-assessment rating (correct/wrong) with score tracking

### Gamification
- 4 daily goals: Read Quran, Listen, Azkar, Du'a
- Daily streak counter with fire animation
- 15 unlockable achievements (badges for milestones)
- Celebration confetti on goal/achievement completion

### More
- Reading plans (Khatmah): finish the Quran in 30, 60, 90, or 365 days
- 5 Android home screen widgets: Daily Ayah, Prayer Time, Hijri Date, Daily Azkar, Hadith of the Day
- 4 themes: Light, Dark, Sepia, AMOLED
- 14 UI languages
- 5-page onboarding with live preference pickers
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
