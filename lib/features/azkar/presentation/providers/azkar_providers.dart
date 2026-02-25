import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/repositories/azkar_repository.dart';
import '../../data/services/azkar_api_service.dart';

final azkarApiServiceProvider = Provider((ref) {
  return AzkarApiService(client: ref.watch(apiClientProvider));
});

final azkarRepositoryProvider = Provider((ref) {
  return AzkarRepository(
    db: ref.watch(databaseProvider),
    api: ref.watch(azkarApiServiceProvider),
  );
});

/// Provides azkar items for a specific category.
final azkarListProvider = FutureProvider.family<List<CachedAzkarData>,
    ({int categoryId, String categoryTitle})>(
  (ref, params) {
    final offline = ref.watch(offlineModeProvider);
    return ref.watch(azkarRepositoryProvider).getAzkarForCategory(
          params.categoryId,
          params.categoryTitle,
          offlineOnly: offline,
        );
  },
);
