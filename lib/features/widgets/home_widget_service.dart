import 'package:home_widget/home_widget.dart';

/// Service to update Android home screen widgets with Quran data.
class HomeWidgetService {
  HomeWidgetService._();

  /// Update the Daily Ayah widget with a random ayah.
  static Future<void> updateDailyAyahWidget() async {
    final ayah = _dailyAyahs[DateTime.now().day % _dailyAyahs.length];

    await HomeWidget.saveWidgetData('ayah_arabic', ayah.arabic);
    await HomeWidget.saveWidgetData('ayah_translation', ayah.translation);
    await HomeWidget.saveWidgetData('ayah_reference', ayah.reference);

    await HomeWidget.updateWidget(
      androidName: 'DailyAyahWidgetProvider',
    );
  }

  /// Update the Prayer Time widget.
  static Future<void> updatePrayerTimeWidget({
    required String prayerName,
    required String prayerTime,
    String? countdown,
  }) async {
    await HomeWidget.saveWidgetData('prayer_name', prayerName);
    await HomeWidget.saveWidgetData('prayer_time', prayerTime);
    await HomeWidget.saveWidgetData('prayer_countdown', countdown ?? '');

    await HomeWidget.updateWidget(
      androidName: 'PrayerTimeWidgetProvider',
    );
  }

  /// Initialize widgets on app start.
  static Future<void> initialize() async {
    await updateDailyAyahWidget();
    // Prayer time widget will be updated when location is available
  }
}

class _DailyAyah {
  final String arabic;
  final String translation;
  final String reference;
  const _DailyAyah(this.arabic, this.translation, this.reference);
}

const _dailyAyahs = [
  _DailyAyah(
    'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
    'In the name of Allah, the Most Gracious, the Most Merciful',
    'Al-Fatihah 1:1',
  ),
  _DailyAyah(
    'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
    'All praise is due to Allah, Lord of the worlds',
    'Al-Fatihah 1:2',
  ),
  _DailyAyah(
    'إِنَّ مَعَ ٱلْعُسْرِ يُسْرًا',
    'Indeed, with hardship comes ease',
    'Ash-Sharh 94:6',
  ),
  _DailyAyah(
    'وَمَن يَتَوَكَّلْ عَلَى ٱللَّهِ فَهُوَ حَسْبُهُۥ',
    'And whoever relies upon Allah - then He is sufficient for him',
    'At-Talaq 65:3',
  ),
  _DailyAyah(
    'فَٱذْكُرُونِىٓ أَذْكُرْكُمْ',
    'So remember Me; I will remember you',
    'Al-Baqarah 2:152',
  ),
  _DailyAyah(
    'وَقُل رَّبِّ زِدْنِى عِلْمًا',
    'And say, "My Lord, increase me in knowledge"',
    'Ta-Ha 20:114',
  ),
  _DailyAyah(
    'إِنَّ ٱللَّهَ مَعَ ٱلصَّـٰبِرِينَ',
    'Indeed, Allah is with the patient',
    'Al-Baqarah 2:153',
  ),
  _DailyAyah(
    'رَبَّنَآ ءَاتِنَا فِى ٱلدُّنْيَا حَسَنَةً وَفِى ٱلْـَٔاخِرَةِ حَسَنَةً',
    'Our Lord, give us good in this world and good in the Hereafter',
    'Al-Baqarah 2:201',
  ),
  _DailyAyah(
    'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰٓ',
    'And your Lord is going to give you, and you will be satisfied',
    'Ad-Duha 93:5',
  ),
  _DailyAyah(
    'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ',
    'And He is with you wherever you are',
    'Al-Hadid 57:4',
  ),
  _DailyAyah(
    'لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
    'Allah does not burden a soul beyond that it can bear',
    'Al-Baqarah 2:286',
  ),
  _DailyAyah(
    'وَنَحْنُ أَقْرَبُ إِلَيْهِ مِنْ حَبْلِ ٱلْوَرِيدِ',
    'And We are closer to him than his jugular vein',
    'Qaf 50:16',
  ),
  _DailyAyah(
    'أَلَا بِذِكْرِ ٱللَّهِ تَطْمَئِنُّ ٱلْقُلُوبُ',
    'Verily, in the remembrance of Allah do hearts find rest',
    'Ar-Ra\'d 13:28',
  ),
  _DailyAyah(
    'وَإِذَا سَأَلَكَ عِبَادِى عَنِّى فَإِنِّى قَرِيبٌ',
    'And when My servants ask you about Me - indeed I am near',
    'Al-Baqarah 2:186',
  ),
  _DailyAyah(
    'قُلْ هُوَ ٱللَّهُ أَحَدٌ',
    'Say, "He is Allah, the One"',
    'Al-Ikhlas 112:1',
  ),
  _DailyAyah(
    'ٱللَّهُ لَآ إِلَـٰهَ إِلَّا هُوَ ٱلْحَىُّ ٱلْقَيُّومُ',
    'Allah - there is no deity except Him, the Ever-Living, the Sustainer',
    'Al-Baqarah 2:255',
  ),
  _DailyAyah(
    'وَمَنْ يَتَّقِ ٱللَّهَ يَجْعَل لَّهُۥ مَخْرَجًا',
    'And whoever fears Allah - He will make for him a way out',
    'At-Talaq 65:2',
  ),
  _DailyAyah(
    'إِنَّا فَتَحْنَا لَكَ فَتْحًا مُّبِينًا',
    'Indeed, We have given you a clear conquest',
    'Al-Fath 48:1',
  ),
  _DailyAyah(
    'وَلَا تَيْـَٔسُوا۟ مِن رَّوْحِ ٱللَّهِ',
    'And do not despair of the mercy of Allah',
    'Yusuf 12:87',
  ),
  _DailyAyah(
    'فَإِنَّ مَعَ ٱلْعُسْرِ يُسْرًا',
    'For indeed, with hardship will be ease',
    'Ash-Sharh 94:5',
  ),
  _DailyAyah(
    'رَبِّ ٱشْرَحْ لِى صَدْرِى',
    'My Lord, expand for me my breast',
    'Ta-Ha 20:25',
  ),
  _DailyAyah(
    'حَسْبُنَا ٱللَّهُ وَنِعْمَ ٱلْوَكِيلُ',
    'Sufficient for us is Allah, and He is the best Disposer of affairs',
    'Ali \'Imran 3:173',
  ),
  _DailyAyah(
    'وَٱصْبِرْ فَإِنَّ ٱللَّهَ لَا يُضِيعُ أَجْرَ ٱلْمُحْسِنِينَ',
    'And be patient, for indeed, Allah does not allow to be lost the reward of those who do good',
    'Hud 11:115',
  ),
  _DailyAyah(
    'ٱدْعُونِىٓ أَسْتَجِبْ لَكُمْ',
    'Call upon Me; I will respond to you',
    'Ghafir 40:60',
  ),
  _DailyAyah(
    'وَلَنَبْلُوَنَّكُم بِشَىْءٍ مِّنَ ٱلْخَوْفِ وَٱلْجُوعِ',
    'And We will surely test you with something of fear and hunger',
    'Al-Baqarah 2:155',
  ),
  _DailyAyah(
    'إِنَّ ٱللَّهَ لَا يُغَيِّرُ مَا بِقَوْمٍ حَتَّىٰ يُغَيِّرُوا۟ مَا بِأَنفُسِهِمْ',
    'Indeed, Allah will not change the condition of a people until they change what is in themselves',
    'Ar-Ra\'d 13:11',
  ),
  _DailyAyah(
    'وَتَوَكَّلْ عَلَى ٱللَّهِ ۚ وَكَفَىٰ بِٱللَّهِ وَكِيلًا',
    'And rely upon Allah; and sufficient is Allah as Disposer of affairs',
    'Al-Ahzab 33:3',
  ),
  _DailyAyah(
    'يَـٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱسْتَعِينُوا۟ بِٱلصَّبْرِ وَٱلصَّلَوٰةِ',
    'O you who believe, seek help through patience and prayer',
    'Al-Baqarah 2:153',
  ),
  _DailyAyah(
    'وَفِىٓ أَنفُسِكُمْ ۚ أَفَلَا تُبْصِرُونَ',
    'And within yourselves. Then will you not see?',
    'Adh-Dhariyat 51:21',
  ),
  _DailyAyah(
    'قُلْ يَـٰعِبَادِىَ ٱلَّذِينَ أَسْرَفُوا۟ عَلَىٰٓ أَنفُسِهِمْ لَا تَقْنَطُوا۟ مِن رَّحْمَةِ ٱللَّهِ',
    'Say, "O My servants who have transgressed against themselves, do not despair of the mercy of Allah"',
    'Az-Zumar 39:53',
  ),
  _DailyAyah(
    'سَيَجْعَلُ ٱللَّهُ بَعْدَ عُسْرٍ يُسْرًا',
    'Allah will bring about, after hardship, ease',
    'At-Talaq 65:7',
  ),
];
