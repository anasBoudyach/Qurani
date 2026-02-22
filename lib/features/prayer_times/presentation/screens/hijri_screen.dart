import 'package:flutter/material.dart';

/// Hijri calendar screen with date display and conversion.
/// Uses a simple Hijri date calculation algorithm.
class HijriScreen extends StatefulWidget {
  const HijriScreen({super.key});

  @override
  State<HijriScreen> createState() => _HijriScreenState();
}

class _HijriScreenState extends State<HijriScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final hijri = _gregorianToHijri(_selectedDate);
    final isToday = _isSameDay(_selectedDate, DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hijri Calendar'),
        actions: [
          if (!isToday)
            TextButton(
              onPressed: () => setState(() => _selectedDate = DateTime.now()),
              child: const Text('Today'),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Hijri date card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withAlpha(179),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  hijri.dayName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(204),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${hijri.day}',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${hijri.monthName} ${hijri.year} AH',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Arabic date
                Text(
                  '${_toArabicNumeral(hijri.day)} ${hijri.monthNameArabic} ${_toArabicNumeral(hijri.year)} هـ',
                  style: const TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 22,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Gregorian date
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withAlpha(128),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gregorian Date',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      _formatGregorian(_selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit_calendar),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Navigate days
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => setState(() {
                  _selectedDate =
                      _selectedDate.subtract(const Duration(days: 1));
                }),
                icon: const Icon(Icons.chevron_left),
              ),
              const SizedBox(width: 16),
              Text(
                isToday ? 'Today' : _formatGregorianShort(_selectedDate),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                onPressed: () => setState(() {
                  _selectedDate = _selectedDate.add(const Duration(days: 1));
                }),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Islamic months reference
          Text(
            'Islamic Months',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...List.generate(12, (index) {
            final monthNum = index + 1;
            final isCurrent = monthNum == hijri.month;
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isCurrent
                    ? Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(77)
                    : null,
                borderRadius: BorderRadius.circular(8),
                border: isCurrent
                    ? Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(102))
                    : null,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    child: Text(
                      '$monthNum',
                      style: TextStyle(
                        fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCurrent
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(128),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _hijriMonthNames[index],
                      style: TextStyle(
                        fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCurrent
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                  ),
                  Text(
                    _hijriMonthNamesArabic[index],
                    style: TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 16,
                      color: isCurrent
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(153),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatGregorian(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  String _formatGregorianShort(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}';
  }

  String _toArabicNumeral(int number) {
    const arabicDigits = [
      '٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'
    ];
    return number
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join();
  }
}

// ─── Hijri Date Calculation ───

const _hijriMonthNames = [
  'Muharram', 'Safar', 'Rabi al-Awwal', 'Rabi al-Thani',
  'Jumada al-Ula', 'Jumada al-Thani', 'Rajab', 'Shaban',
  'Ramadan', 'Shawwal', 'Dhul Qadah', 'Dhul Hijjah',
];

const _hijriMonthNamesArabic = [
  'مُحَرَّم', 'صَفَر', 'رَبِيع الأَوَّل', 'رَبِيع الثَّانِي',
  'جُمَادَى الأُولَى', 'جُمَادَى الثَّانِيَة', 'رَجَب', 'شَعْبَان',
  'رَمَضَان', 'شَوَّال', 'ذُو القَعْدَة', 'ذُو الحِجَّة',
];

const _dayNames = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday',
  'Friday', 'Saturday', 'Sunday',
];

class _HijriDate {
  final int day;
  final int month;
  final int year;
  final String monthName;
  final String monthNameArabic;
  final String dayName;

  const _HijriDate({
    required this.day,
    required this.month,
    required this.year,
    required this.monthName,
    required this.monthNameArabic,
    required this.dayName,
  });
}

/// Approximate Gregorian to Hijri conversion using the Kuwaiti algorithm.
/// Accuracy: +/- 1 day. For production, use Umm al-Qura calendar tables.
_HijriDate _gregorianToHijri(DateTime date) {
  // Julian Day Number
  final y = date.year;
  final m = date.month;
  final d = date.day;

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

  return _HijriDate(
    day: hijriDay,
    month: hijriMonth,
    year: hijriYear,
    monthName: _hijriMonthNames[(hijriMonth - 1).clamp(0, 11)],
    monthNameArabic: _hijriMonthNamesArabic[(hijriMonth - 1).clamp(0, 11)],
    dayName: _dayNames[date.weekday - 1],
  );
}
