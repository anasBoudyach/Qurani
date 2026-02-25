import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/repositories/duas_repository.dart';
import '../../data/services/duas_api_service.dart';

final duasApiServiceProvider = Provider((ref) {
  return DuasApiService(client: ref.watch(apiClientProvider));
});

final duasRepositoryProvider = Provider((ref) {
  return DuasRepository(
    db: ref.watch(databaseProvider),
    api: ref.watch(duasApiServiceProvider),
  );
});

/// Provides du'as for a specific category.
final duasListProvider = FutureProvider.family<List<CachedAzkarData>,
    ({int categoryId, String categoryTitle})>(
  (ref, params) {
    final offline = ref.watch(offlineModeProvider);
    return ref.watch(duasRepositoryProvider).getDuasForCategory(
          params.categoryId,
          params.categoryTitle,
          offlineOnly: offline,
        );
  },
);

/// Du'a category model for UI display.
class DuaCategoryInfo {
  final int categoryId; // HisnMuslim category ID
  final String title;
  final String titleArabic;
  final IconData icon;

  const DuaCategoryInfo({
    required this.categoryId,
    required this.title,
    required this.titleArabic,
    required this.icon,
  });
}

/// Curated du'a categories from HisnMuslim (supplication-focused ones).
const duaCategoryList = [
  DuaCategoryInfo(categoryId: 26, title: 'Istikhara', titleArabic: 'دعاء صلاة الاستخارة', icon: Icons.lightbulb_rounded),
  DuaCategoryInfo(categoryId: 35, title: 'Anxiety & Sorrow', titleArabic: 'دعاء الهم والحزن', icon: Icons.sentiment_dissatisfied_rounded),
  DuaCategoryInfo(categoryId: 36, title: 'Distress', titleArabic: 'دعاء الكرب', icon: Icons.support_rounded),
  DuaCategoryInfo(categoryId: 42, title: 'Settling Debt', titleArabic: 'دعاء قضاء الدين', icon: Icons.account_balance_wallet_rounded),
  DuaCategoryInfo(categoryId: 44, title: 'Difficulty', titleArabic: 'دعاء من استصعب عليه أمر', icon: Icons.trending_up_rounded),
  DuaCategoryInfo(categoryId: 45, title: 'After Sin', titleArabic: 'ما يقول ويفعل من أذنب ذنباً', icon: Icons.replay_rounded),
  DuaCategoryInfo(categoryId: 50, title: 'Visiting the Sick', titleArabic: 'الدعاء للمريض في عيادته', icon: Icons.local_hospital_rounded),
  DuaCategoryInfo(categoryId: 56, title: 'Janazah Prayer', titleArabic: 'الدعاء للميت في صلاة الجنازة', icon: Icons.mosque_rounded),
  DuaCategoryInfo(categoryId: 58, title: 'Condolence', titleArabic: 'دعاء التعزية', icon: Icons.favorite_rounded),
  DuaCategoryInfo(categoryId: 64, title: 'Asking for Rain', titleArabic: 'من أدعية الاستسقاء', icon: Icons.water_rounded),
  DuaCategoryInfo(categoryId: 69, title: 'Breaking Fast', titleArabic: 'الدعاء عند الإفطار', icon: Icons.restaurant_rounded),
  DuaCategoryInfo(categoryId: 70, title: 'Before Eating', titleArabic: 'الدعاء قبل الطعام', icon: Icons.dinner_dining_rounded),
  DuaCategoryInfo(categoryId: 71, title: 'After Eating', titleArabic: 'الدعاء عند الفراغ من الطعام', icon: Icons.done_rounded),
  DuaCategoryInfo(categoryId: 80, title: 'For Newlywed', titleArabic: 'الدعاء للمتزوج', icon: Icons.favorite_rounded),
  DuaCategoryInfo(categoryId: 82, title: 'Anger', titleArabic: 'دعاء الغضب', icon: Icons.whatshot_rounded),
  DuaCategoryInfo(categoryId: 92, title: 'Fear of Shirk', titleArabic: 'دعاء خوف الشرك', icon: Icons.warning_amber_rounded),
  DuaCategoryInfo(categoryId: 96, title: 'Travel', titleArabic: 'دعاء السفر', icon: Icons.flight_rounded),
  DuaCategoryInfo(categoryId: 105, title: 'Returning from Travel', titleArabic: 'ذكر الرجوع من السفر', icon: Icons.home_rounded),
  DuaCategoryInfo(categoryId: 107, title: 'Feeling Pain', titleArabic: 'ما يقول ويفعل من أحس وجعاً في جسده', icon: Icons.healing_rounded),
  DuaCategoryInfo(categoryId: 112, title: 'Istighfar & Tawbah', titleArabic: 'الاستغفار والتوبة', icon: Icons.replay_rounded),
  DuaCategoryInfo(categoryId: 115, title: 'General Du\'as', titleArabic: 'من أنواع الخير والآداب الجامعة', icon: Icons.menu_book_rounded),
  DuaCategoryInfo(categoryId: 125, title: 'Hajj Talbiyah', titleArabic: 'ما يقول المُحرِم في الحج أو العمرة', icon: Icons.place_rounded),
  DuaCategoryInfo(categoryId: 129, title: 'Day of Arafah', titleArabic: 'الدعاء يوم عرفة', icon: Icons.wb_sunny_outlined),
];
