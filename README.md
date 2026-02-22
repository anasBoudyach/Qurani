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
- 12 calculation methods (MWL, Egyptian, Umm Al-Qura, Morocco, ISNA, etc.)
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

<!-- Add screenshots here -->

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

## Privacy Policy

See [PRIVACY_POLICY.md](PRIVACY_POLICY.md)

## License

MIT License — free to use, modify, and distribute.

---

*Built with love as Sadaqah Jariyah. May Allah accept it from us.*
