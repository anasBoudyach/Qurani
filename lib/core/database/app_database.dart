import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ─── Quran Text Tables ───

class Surahs extends Table {
  IntColumn get id => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameEnglish => text()();
  TextColumn get nameTransliteration => text()();
  IntColumn get ayahCount => integer()();
  TextColumn get revelationType => text()(); // 'meccan' or 'medinan'
  IntColumn get revelationOrder => integer()();
  IntColumn get juzStart => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class Ayahs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahId => integer().references(Surahs, #id)();
  IntColumn get ayahNumber => integer()();
  TextColumn get textUthmani => text()();
  TextColumn get textUthmaniTajweed => text().nullable()();
  IntColumn get juzNumber => integer()();
  IntColumn get hizbQuarter => integer()();
  IntColumn get pageNumber => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {surahId, ayahNumber}
      ];
}

class AyahTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahId => integer().references(Surahs, #id)();
  IntColumn get ayahNumber => integer()();
  TextColumn get translationText => text()();
  TextColumn get languageCode => text()();
  TextColumn get translatorName => text()();
  IntColumn get resourceId => integer()();
}

// ─── Audio & Reciters ───

class Reciters extends Table {
  IntColumn get id => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameEnglish => text()();
  TextColumn get style => text().withDefault(const Constant('murattal'))();
  TextColumn get serverUrl => text().nullable()();
  TextColumn get photoUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DownloadedAudio extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reciterId => integer().references(Reciters, #id)();
  IntColumn get surahId => integer().references(Surahs, #id)();
  TextColumn get filePath => text()();
  IntColumn get fileSize => integer()();
  DateTimeColumn get downloadedAt => dateTime()();
}

// ─── User Data ───

class UserNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahId => integer().references(Surahs, #id)();
  IntColumn get ayahNumber => integer()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class ReadingProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahId => integer().references(Surahs, #id)();
  IntColumn get ayahNumber => integer()();
  IntColumn get pageNumber => integer()();
  DateTimeColumn get lastReadAt => dateTime()();
}

// ─── Tajweed Course Progress ───

class LessonProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonId => integer()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get bestQuizScore => integer().withDefault(const Constant(0))();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
}

class UserStreaks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActivityDate => dateTime().nullable()();
  IntColumn get totalRecordings => integer().withDefault(const Constant(0))();
  IntColumn get totalPracticeSeconds =>
      integer().withDefault(const Constant(0))();
}

class Achievements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get achievementId => text()();
  DateTimeColumn get unlockedAt => dateTime()();
}

// ─── Gamification ───

class DailyActivityLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get activityType => text()(); // ActivityType.name
  DateTimeColumn get completedAt => dateTime()();
  TextColumn get date => text()(); // 'YYYY-MM-DD' for easy grouping
}

class RecordingSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonId => integer()();
  IntColumn get surahId => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get userAudioPath => text()();
  TextColumn get sheikhAudioUrl => text()();
  DateTimeColumn get recordedAt => dateTime()();
  IntColumn get durationMs => integer()();
  IntColumn get selfRating => integer().nullable()();
}

// ─── Hadith Cache ───

class CachedHadithSections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectionKey => text()();
  IntColumn get sectionNumber => integer()();
  TextColumn get name => text()();
  TextColumn get nameArabic => text().withDefault(const Constant(''))();
  IntColumn get hadithStartNumber =>
      integer().withDefault(const Constant(0))();
  IntColumn get hadithEndNumber => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {collectionKey, sectionNumber}
      ];
}

class CachedHadiths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectionKey => text()();
  IntColumn get sectionNumber => integer()();
  IntColumn get hadithNumber => integer()();
  TextColumn get textArabic => text()();
  TextColumn get textEnglish => text().withDefault(const Constant(''))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {collectionKey, hadithNumber}
      ];
}

// ─── Ayah Bookmarks ───

class AyahBookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahId => integer().references(Surahs, #id)();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {surahId, ayahNumber}
      ];
}

// ─── Tafsir Cache ───

class CachedTafsirs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahId => integer()();
  IntColumn get ayahNumber => integer()();
  IntColumn get resourceId => integer()();
  TextColumn get tafsirText => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {surahId, ayahNumber, resourceId}
      ];
}

// ─── Azkar & Du'as Cache ───

class CachedAzkar extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get categoryTitle => text()();
  IntColumn get itemId => integer()();
  TextColumn get arabicText => text()();
  IntColumn get repeatCount => integer().withDefault(const Constant(1))();
  TextColumn get audioUrl => text().withDefault(const Constant(''))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {categoryId, itemId}
      ];
}

// ─── Database ───

@DriftDatabase(tables: [
  Surahs,
  Ayahs,
  AyahTranslations,
  Reciters,
  DownloadedAudio,
  UserNotes,
  ReadingProgress,
  LessonProgress,
  UserStreaks,
  Achievements,
  RecordingSessions,
  DailyActivityLog,
  CachedHadithSections,
  CachedHadiths,
  CachedAzkar,
  AyahBookmarks,
  CachedTafsirs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(dailyActivityLog);
          }
          if (from < 3) {
            await m.createTable(cachedHadithSections);
            await m.createTable(cachedHadiths);
            await m.createTable(cachedAzkar);
          }
          if (from < 4) {
            await m.createTable(ayahBookmarks);
          }
          if (from < 5) {
            await m.createTable(cachedTafsirs);
          }
        },
      );

  // ─── Surah Queries ───

  Future<List<Surah>> getAllSurahs() => select(surahs).get();

  Future<Surah> getSurah(int id) =>
      (select(surahs)..where((s) => s.id.equals(id))).getSingle();

  // ─── Ayah Queries ───

  Future<List<Ayah>> getAyahsForSurah(int surahId) =>
      (select(ayahs)..where((a) => a.surahId.equals(surahId))).get();

  Future<List<Ayah>> getAyahsForPage(int pageNumber) =>
      (select(ayahs)..where((a) => a.pageNumber.equals(pageNumber))).get();

  Future<List<Ayah>> getAyahsForJuz(int juzNumber) =>
      (select(ayahs)..where((a) => a.juzNumber.equals(juzNumber))).get();

  // ─── Reading Progress ───

  Future<ReadingProgressData?> getLastReadingPosition() =>
      (select(readingProgress)
            ..orderBy([(r) => OrderingTerm.desc(r.lastReadAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<void> saveReadingPosition(ReadingProgressCompanion position) =>
      into(readingProgress).insertOnConflictUpdate(position);

  // ─── Lesson Progress ───

  Future<List<LessonProgressData>> getAllLessonProgress() =>
      select(lessonProgress).get();

  Future<LessonProgressData?> getLessonProgress(int lessonId) =>
      (select(lessonProgress)..where((l) => l.lessonId.equals(lessonId)))
          .getSingleOrNull();

  Future<void> saveLessonProgress(LessonProgressCompanion data) =>
      into(lessonProgress).insertOnConflictUpdate(data);

  // ─── Streaks ───

  Future<UserStreak?> getUserStreak() =>
      (select(userStreaks)..limit(1)).getSingleOrNull();

  Future<void> saveUserStreak(UserStreaksCompanion streak) =>
      into(userStreaks).insertOnConflictUpdate(streak);

  // ─── Achievements ───

  Future<List<Achievement>> getUnlockedAchievements() =>
      select(achievements).get();

  Future<int> unlockAchievement(AchievementsCompanion achievement) =>
      into(achievements).insert(achievement);

  // ─── Daily Activity Log ───

  Future<List<DailyActivityLogData>> getActivitiesForDate(String date) =>
      (select(dailyActivityLog)..where((a) => a.date.equals(date))).get();

  Future<List<DailyActivityLogData>> getAllActivities() =>
      select(dailyActivityLog).get();

  Future<int> logActivity(DailyActivityLogCompanion data) =>
      into(dailyActivityLog).insert(data);

  // ─── Downloads ───

  Future<List<DownloadedAudioData>> getAllDownloads() =>
      (select(downloadedAudio)
            ..orderBy([(d) => OrderingTerm.desc(d.downloadedAt)]))
          .get();

  Future<List<DownloadedAudioData>> getDownloadsForReciter(int reciterId) =>
      (select(downloadedAudio)
            ..where((d) => d.reciterId.equals(reciterId)))
          .get();

  Future<DownloadedAudioData?> getDownload(int reciterId, int surahId) =>
      (select(downloadedAudio)
            ..where((d) =>
                d.reciterId.equals(reciterId) & d.surahId.equals(surahId)))
          .getSingleOrNull();

  Future<bool> isAudioDownloaded(int reciterId, int surahId) async {
    final result = await getDownload(reciterId, surahId);
    return result != null;
  }

  Future<int> insertDownload(DownloadedAudioCompanion data) =>
      into(downloadedAudio).insert(data);

  Future<int> deleteDownload(int id) =>
      (delete(downloadedAudio)..where((d) => d.id.equals(id))).go();

  Future<int> deleteDownloadsForReciter(int reciterId) =>
      (delete(downloadedAudio)..where((d) => d.reciterId.equals(reciterId)))
          .go();

  Future<int> getTotalDownloadSize() async {
    final all = await select(downloadedAudio).get();
    return all.fold<int>(0, (sum, d) => sum + d.fileSize);
  }

  // ─── Hadith Cache Queries ───

  Future<List<CachedHadithSection>> getHadithSections(String collectionKey) =>
      (select(cachedHadithSections)
            ..where((s) => s.collectionKey.equals(collectionKey))
            ..orderBy([(s) => OrderingTerm.asc(s.sectionNumber)]))
          .get();

  Future<List<CachedHadith>> getHadithsForSection(
          String collectionKey, int sectionNumber) =>
      (select(cachedHadiths)
            ..where((h) =>
                h.collectionKey.equals(collectionKey) &
                h.sectionNumber.equals(sectionNumber))
            ..orderBy([(h) => OrderingTerm.asc(h.hadithNumber)]))
          .get();

  // ─── Azkar Cache Queries ───

  Future<List<CachedAzkarData>> getAzkarForCategory(int categoryId) =>
      (select(cachedAzkar)
            ..where((a) => a.categoryId.equals(categoryId))
            ..orderBy([(a) => OrderingTerm.asc(a.itemId)]))
          .get();

  // ─── Tafsir Cache Queries ───

  Future<CachedTafsir?> getCachedTafsir(
          int surahId, int ayahNumber, int resourceId) =>
      (select(cachedTafsirs)
            ..where((t) =>
                t.surahId.equals(surahId) &
                t.ayahNumber.equals(ayahNumber) &
                t.resourceId.equals(resourceId)))
          .getSingleOrNull();

  Future<void> cacheTafsir(CachedTafsirsCompanion data) =>
      into(cachedTafsirs).insertOnConflictUpdate(data);

  // ─── Ayah Bookmark Queries ───

  Future<List<AyahBookmark>> getAllBookmarks() =>
      (select(ayahBookmarks)
            ..orderBy([(b) => OrderingTerm.desc(b.createdAt)]))
          .get();

  Future<AyahBookmark?> getBookmark(int surahId, int ayahNumber) =>
      (select(ayahBookmarks)
            ..where((b) =>
                b.surahId.equals(surahId) & b.ayahNumber.equals(ayahNumber)))
          .getSingleOrNull();

  Future<int> addBookmark(AyahBookmarksCompanion bookmark) =>
      into(ayahBookmarks).insert(bookmark);

  Future<int> removeBookmark(int surahId, int ayahNumber) =>
      (delete(ayahBookmarks)
            ..where((b) =>
                b.surahId.equals(surahId) & b.ayahNumber.equals(ayahNumber)))
          .go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'qurani.db'));
    return NativeDatabase.createInBackground(file);
  });
}
