// Shared Hijri calendar utilities.
// Extracted from HijriScreen for reuse across homepage, widgets, events.

class HijriDate {
  final int day;
  final int month;
  final int year;
  final String monthName;
  final String monthNameArabic;
  final String dayName;

  const HijriDate({
    required this.day,
    required this.month,
    required this.year,
    required this.monthName,
    required this.monthNameArabic,
    required this.dayName,
  });

  /// Compact English format: "3 Sha'ban 1447 AH"
  String formatCompact() => '$day $monthName $year AH';

  /// Compact Arabic format: "٣ شعبان ١٤٤٧ هـ"
  String formatArabic() =>
      '${toArabicNumeral(day)} $monthNameArabic ${toArabicNumeral(year)} هـ';
}

const hijriMonthNames = [
  'Muharram', 'Safar', 'Rabi al-Awwal', 'Rabi al-Thani',
  'Jumada al-Ula', 'Jumada al-Thani', 'Rajab', "Sha'ban",
  'Ramadan', 'Shawwal', 'Dhul Qi\'dah', 'Dhul Hijjah',
];

const hijriMonthNamesArabic = [
  'مُحَرَّم', 'صَفَر', 'رَبِيع الأَوَّل', 'رَبِيع الثَّانِي',
  'جُمَادَى الأُولَى', 'جُمَادَى الثَّانِيَة', 'رَجَب', 'شَعْبَان',
  'رَمَضَان', 'شَوَّال', 'ذُو القَعْدَة', 'ذُو الحِجَّة',
];

const dayNames = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday',
  'Friday', 'Saturday', 'Sunday',
];

/// Convert Arabic-Indic numeral digits.
String toArabicNumeral(int number) {
  const arabicDigits = [
    '٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'
  ];
  return number
      .toString()
      .split('')
      .map((d) => arabicDigits[int.parse(d)])
      .join();
}

/// Approximate Gregorian to Hijri conversion using the Kuwaiti algorithm.
/// Accuracy: +/- 1 day. For production, use Umm al-Qura calendar tables.
HijriDate gregorianToHijri(DateTime date) {
  final y = date.year;
  final m = date.month;
  final d = date.day;

  // Julian Day Number
  final jd = ((1461 * (y + 4800 + ((m - 14) ~/ 12))) ~/ 4) +
      ((367 * (m - 2 - 12 * ((m - 14) ~/ 12))) ~/ 12) -
      ((3 * (((y + 4900 + ((m - 14) ~/ 12)) ~/ 100))) ~/ 4) +
      d -
      32075;

  // Kuwaiti algorithm
  final l = jd - 1948440 + 10632;
  final n = ((l - 1) ~/ 10631);
  final l2 = l - 10631 * n + 354;
  final j = ((10985 - l2) ~/ 5316) * ((50 * l2) ~/ 17719) +
      ((l2 ~/ 5670)) * ((43 * l2) ~/ 15238);
  final l3 = l2 - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) -
      ((j ~/ 16)) * ((15238 * j) ~/ 43) +
      29;
  final hijriMonth = ((24 * l3) ~/ 709);
  final hijriDay = l3 - ((709 * hijriMonth) ~/ 24);
  final hijriYear = 30 * n + j - 30;

  return HijriDate(
    day: hijriDay,
    month: hijriMonth,
    year: hijriYear,
    monthName: hijriMonthNames[(hijriMonth - 1).clamp(0, 11)],
    monthNameArabic: hijriMonthNamesArabic[(hijriMonth - 1).clamp(0, 11)],
    dayName: dayNames[date.weekday - 1],
  );
}

/// Approximate Hijri to Gregorian conversion (inverse of Kuwaiti algorithm).
/// Returns approximate date (+/- 1-2 days).
DateTime hijriToGregorian(int hijriYear, int hijriMonth, int hijriDay) {
  // Compute Julian Day Number from Hijri
  final jd = (((11 * hijriYear + 3) ~/ 30) +
      354 * hijriYear +
      30 * hijriMonth -
      ((hijriMonth - 1) ~/ 2) +
      hijriDay +
      1948440 -
      385);

  // Convert JD to Gregorian
  final l = jd + 68569;
  final n = ((4 * l) ~/ 146097);
  final l2 = l - ((146097 * n + 3) ~/ 4);
  final i = ((4000 * (l2 + 1)) ~/ 1461001);
  final l3 = l2 - ((1461 * i) ~/ 4) + 31;
  final j = ((80 * l3) ~/ 2447);
  final day = l3 - ((2447 * j) ~/ 80);
  final l4 = (j ~/ 11);
  final month = j + 2 - 12 * l4;
  final year = 100 * (n - 49) + i + l4;

  return DateTime(year, month, day);
}
