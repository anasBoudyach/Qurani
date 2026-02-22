import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_orchestrator.dart';
import '../../data/repositories/quran_repository.dart';

/// Singleton database provider.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// API client provider.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// API orchestrator provider.
final apiOrchestratorProvider = Provider<ApiOrchestrator>((ref) {
  return ApiOrchestrator(ref.watch(apiClientProvider));
});

/// Quran repository provider.
final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  return QuranRepository(
    db: ref.watch(databaseProvider),
    api: ref.watch(apiOrchestratorProvider),
  );
});

/// Fetches ayahs for a surah.
final surahAyahsProvider =
    FutureProvider.family<List<Ayah>, int>((ref, surahNumber) async {
  final repo = ref.watch(quranRepositoryProvider);
  return repo.getAyahsForSurah(surahNumber);
});

/// Fetches translation for a surah using Al Quran Cloud edition string.
final surahTranslationProvider = FutureProvider.family<List<AyahTranslation>,
    ({int surahNumber, String edition})>((ref, params) async {
  final repo = ref.watch(quranRepositoryProvider);
  return repo.getTranslation(
    surahNumber: params.surahNumber,
    edition: params.edition,
  );
});

/// Fetches ayahs for a page.
final pageAyahsProvider =
    FutureProvider.family<List<Ayah>, int>((ref, pageNumber) async {
  final repo = ref.watch(quranRepositoryProvider);
  return repo.getAyahsForPage(pageNumber);
});

/// Fetches ayahs for a juz.
final juzAyahsProvider =
    FutureProvider.family<List<Ayah>, int>((ref, juzNumber) async {
  final repo = ref.watch(quranRepositoryProvider);
  return repo.getAyahsForJuz(juzNumber);
});
