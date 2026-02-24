import 'package:home_widget/home_widget.dart';
import '../../core/utils/hijri_utils.dart';
import '../islamic_events/data/islamic_events_service.dart';

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

  /// Update the Hijri Date widget with today's date and next event.
  static Future<void> updateHijriWidget() async {
    final hijri = gregorianToHijri(DateTime.now());
    final nextEvent = IslamicEventsService.getNextMajorEvent();

    await HomeWidget.saveWidgetData('hijri_date', hijri.formatCompact());
    await HomeWidget.saveWidgetData('hijri_date_arabic', hijri.formatArabic());

    if (nextEvent != null) {
      final daysText = nextEvent.daysUntil == 0
          ? '${nextEvent.name} - Today!'
          : '${nextEvent.name} in ${nextEvent.daysUntil} days';
      await HomeWidget.saveWidgetData('next_event_text', daysText);
    } else {
      await HomeWidget.saveWidgetData('next_event_text', '');
    }

    await HomeWidget.updateWidget(
      androidName: 'HijriDateWidgetProvider',
    );
  }

  /// Update the Daily Azkar widget.
  /// Shows morning azkar (Fajr-Asr) or evening azkar (Asr-Fajr).
  static Future<void> updateAzkarWidget() async {
    final hour = DateTime.now().hour;
    final isMorning = hour >= 4 && hour < 16; // Fajr ~ 4AM to Asr ~ 4PM

    final title = isMorning ? 'Morning Azkar' : 'Evening Azkar';

    // Rotate through azkar daily
    final dayIndex = DateTime.now().difference(DateTime(2026)).inDays.abs();
    final azkarList = isMorning ? _morningAzkar : _eveningAzkar;
    final azkar = azkarList[dayIndex % azkarList.length];

    await HomeWidget.saveWidgetData('azkar_title', title);
    await HomeWidget.saveWidgetData('azkar_arabic', azkar.arabic);
    await HomeWidget.saveWidgetData('azkar_repeat', azkar.repeat);

    await HomeWidget.updateWidget(
      androidName: 'DailyAzkarWidgetProvider',
    );
  }

  /// Update the Daily Hadith widget.
  static Future<void> updateHadithWidget() async {
    final dayIndex = DateTime.now().difference(DateTime(2026)).inDays.abs();
    final hadith = _dailyHadiths[dayIndex % _dailyHadiths.length];

    await HomeWidget.saveWidgetData('hadith_text', hadith.arabic);
    await HomeWidget.saveWidgetData('hadith_collection', hadith.collection);
    await HomeWidget.saveWidgetData('hadith_grade', hadith.grade);

    await HomeWidget.updateWidget(
      androidName: 'DailyHadithWidgetProvider',
    );
  }

  /// Initialize all widgets on app start.
  static Future<void> initialize() async {
    await updateDailyAyahWidget();
    await updateHijriWidget();
    await updateAzkarWidget();
    await updateHadithWidget();
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

// ── Azkar data for widget (static fallback) ──

class _Azkar {
  final String arabic;
  final String repeat;
  const _Azkar(this.arabic, this.repeat);
}

const _morningAzkar = [
  _Azkar('أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ', 'Once'),
  _Azkar('اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ', 'Once'),
  _Azkar('اللَّهُمَّ أَنْتَ رَبِّي لاَ إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ', 'Once'),
  _Azkar('اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ', 'Once'),
  _Azkar('بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلاَ فِي السَّمَاءِ', 'Repeat 3 times'),
  _Azkar('رَضِيتُ بِاللَّهِ رَبًّا وَبِالإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا', 'Repeat 3 times'),
  _Azkar('سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', 'Repeat 100 times'),
  _Azkar('لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ', 'Repeat 10 times'),
  _Azkar('سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَا نَفْسِهِ', 'Repeat 3 times'),
  _Azkar('أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ', 'Repeat 3 times'),
];

const _eveningAzkar = [
  _Azkar('أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ', 'Once'),
  _Azkar('اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ', 'Once'),
  _Azkar('اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ', 'Once'),
  _Azkar('اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي', 'Repeat 3 times'),
  _Azkar('بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلاَ فِي السَّمَاءِ', 'Repeat 3 times'),
  _Azkar('أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ', 'Repeat 3 times'),
  _Azkar('اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ', 'Once'),
  _Azkar('رَضِيتُ بِاللَّهِ رَبًّا وَبِالإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا', 'Repeat 3 times'),
  _Azkar('سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', 'Repeat 100 times'),
  _Azkar('أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ', 'Repeat 100 times'),
];

// ── Hadith data for widget (static fallback) ──

class _Hadith {
  final String arabic;
  final String collection;
  final String grade;
  const _Hadith(this.arabic, this.collection, this.grade);
}

const _dailyHadiths = [
  _Hadith('إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى', 'Bukhari', 'Sahih'),
  _Hadith('مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ', 'Bukhari', 'Sahih'),
  _Hadith('لا يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ', 'Bukhari', 'Sahih'),
  _Hadith('مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ طَرِيقًا إِلَى الْجَنَّةِ', 'Muslim', 'Sahih'),
  _Hadith('الطُّهُورُ شَطْرُ الإِيمَانِ', 'Muslim', 'Sahih'),
  _Hadith('تَبَسُّمُكَ فِي وَجْهِ أَخِيكَ لَكَ صَدَقَةٌ', 'Tirmidhi', 'Sahih'),
  _Hadith('خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ', 'Bukhari', 'Sahih'),
  _Hadith('الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ', 'Bukhari', 'Sahih'),
  _Hadith('إِنَّ اللَّهَ لاَ يَنْظُرُ إِلَى صُوَرِكُمْ وَأَمْوَالِكُمْ وَلَكِنْ يَنْظُرُ إِلَى قُلُوبِكُمْ وَأَعْمَالِكُمْ', 'Muslim', 'Sahih'),
  _Hadith('الدُّنْيَا سِجْنُ الْمُؤْمِنِ وَجَنَّةُ الْكَافِرِ', 'Muslim', 'Sahih'),
  _Hadith('مَنْ صَلَّى عَلَيَّ صَلاَةً صَلَّى اللَّهُ عَلَيْهِ بِهَا عَشْرًا', 'Muslim', 'Sahih'),
  _Hadith('الْمُؤْمِنُ الْقَوِيُّ خَيْرٌ وَأَحَبُّ إِلَى اللَّهِ مِنَ الْمُؤْمِنِ الضَّعِيفِ', 'Muslim', 'Sahih'),
  _Hadith('إِذَا مَاتَ الإِنْسَانُ انْقَطَعَ عَمَلُهُ إِلاَّ مِنْ ثَلاَثٍ', 'Muslim', 'Sahih'),
  _Hadith('لاَ تَحَاسَدُوا وَلاَ تَنَاجَشُوا وَلاَ تَبَاغَضُوا وَلاَ تَدَابَرُوا', 'Muslim', 'Sahih'),
  _Hadith('اتَّقِ اللَّهَ حَيْثُمَا كُنْتَ وَأَتْبِعِ السَّيِّئَةَ الْحَسَنَةَ تَمْحُهَا', 'Tirmidhi', 'Hasan'),
  _Hadith('الْكَلِمَةُ الطَّيِّبَةُ صَدَقَةٌ', 'Bukhari', 'Sahih'),
  _Hadith('مَا مَلأَ آدَمِيٌّ وِعَاءً شَرًّا مِنْ بَطْنٍ', 'Tirmidhi', 'Sahih'),
  _Hadith('أَحَبُّ الأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ', 'Bukhari', 'Sahih'),
  _Hadith('مَنْ يُرِدِ اللَّهُ بِهِ خَيْرًا يُفَقِّهْهُ فِي الدِّينِ', 'Bukhari', 'Sahih'),
  _Hadith('الرَّاحِمُونَ يَرْحَمُهُمُ الرَّحْمَنُ، ارْحَمُوا مَنْ فِي الأَرْضِ يَرْحَمْكُمْ مَنْ فِي السَّمَاءِ', 'Tirmidhi', 'Sahih'),
  _Hadith('مَا نَقَصَتْ صَدَقَةٌ مِنْ مَالٍ', 'Muslim', 'Sahih'),
  _Hadith('لاَ يَدْخُلُ الْجَنَّةَ مَنْ كَانَ فِي قَلْبِهِ مِثْقَالُ ذَرَّةٍ مِنْ كِبْرٍ', 'Muslim', 'Sahih'),
  _Hadith('خَيْرُ النَّاسِ أَنْفَعُهُمْ لِلنَّاسِ', 'Tabarani', 'Hasan'),
  _Hadith('الْجَنَّةُ تَحْتَ أَقْدَامِ الأُمَّهَاتِ', 'Nasai', 'Hasan'),
  _Hadith('مَنْ غَشَّنَا فَلَيْسَ مِنَّا', 'Muslim', 'Sahih'),
  _Hadith('أَفْضَلُ الْجِهَادِ كَلِمَةُ حَقٍّ عِنْدَ سُلْطَانٍ جَائِرٍ', 'Abu Dawud', 'Sahih'),
  _Hadith('إِنَّ اللَّهَ يُحِبُّ إِذَا عَمِلَ أَحَدُكُمْ عَمَلاً أَنْ يُتْقِنَهُ', 'Tabarani', 'Hasan'),
  _Hadith('الْحَيَاءُ لاَ يَأْتِي إِلاَّ بِخَيْرٍ', 'Bukhari', 'Sahih'),
  _Hadith('مَنْ صَامَ رَمَضَانَ إِيمَانًا وَاحْتِسَابًا غُفِرَ لَهُ مَا تَقَدَّمَ مِنْ ذَنْبِهِ', 'Bukhari', 'Sahih'),
  _Hadith('الصَّلاَةُ نُورٌ، وَالصَّدَقَةُ بُرْهَانٌ، وَالصَّبْرُ ضِيَاءٌ', 'Muslim', 'Sahih'),
  _Hadith('مَنْ قَامَ لَيْلَةَ الْقَدْرِ إِيمَانًا وَاحْتِسَابًا غُفِرَ لَهُ مَا تَقَدَّمَ مِنْ ذَنْبِهِ', 'Bukhari', 'Sahih'),
];
