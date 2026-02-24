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
- Optional translation overlay (25 options including None)
- Tajweed color-coded text with all 17 rules highlighted
- Tap any colored word to learn the tajweed rule
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
- 12 calculation methods (MWL, Egyptian, Umm Al-Qura, Morocco, ISNA, etc.)
- Live countdown to next prayer
- Qibla compass with real-time direction

### Du'as — 100+ Authentic Supplications
- 12 categories: Morning, Evening, Sleep, Waking, Mosque, Eating, Travel, Rain, Healing, Forgiveness, Parents, Difficulty
- Arabic text with transliteration and English translation
- Authentic references from Quran, Bukhari, Muslim, and more
- Tap-to-count for repeated du'as, copy to clipboard

### Ahkam — Islamic Rulings (4 Madhabs)
- 8 categories: Purification, Prayer, Fasting, Zakat, Hajj, Marriage, Food, Daily Life
- Side-by-side rulings from Hanafi, Maliki, Shafi'i, and Hanbali schools
- Quran and Hadith evidence for each position
- 40+ topics with expandable details and key points

### Ahadith — Hadith Collections
- 6 major collections: Bukhari, Muslim, Abu Dawud, Tirmidhi, Nasa'i, Ibn Majah
- Arabic text with English translation
- Narrator chains and authenticity grading (Sahih, Hasan, Da'if)
- Fully offline — all data bundled in the app

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
    duas/         # 100+ du'as across 12 categories
    ahkam/        # Islamic rulings (4 madhabs)
    ahadith/      # 6 hadith collections
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
