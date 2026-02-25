import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/utils/hijri_utils.dart';
import '../../../islamic_events/data/models/islamic_event.dart';
import '../../../islamic_events/presentation/providers/islamic_events_providers.dart';

/// Hijri calendar screen with date display, conversion, and events timeline.
class HijriScreen extends ConsumerStatefulWidget {
  const HijriScreen({super.key});

  @override
  ConsumerState<HijriScreen> createState() => _HijriScreenState();
}

class _HijriScreenState extends ConsumerState<HijriScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final hijri = gregorianToHijri(_selectedDate);
    final isToday = _isSameDay(_selectedDate, DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).hijri),
        actions: [
          if (!isToday)
            TextButton(
              onPressed: () => setState(() => _selectedDate = DateTime.now()),
              child: Text(AppLocalizations.of(context).today),
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
                  hijri.formatArabic(),
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
                    Text(
                      AppLocalizations.of(context).gregorianDate,
                      style: const TextStyle(fontSize: 12),
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
                isToday ? AppLocalizations.of(context).today : _formatGregorianShort(_selectedDate),
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
          const SizedBox(height: 16),
          // ── Upcoming Islamic Events (collapsible) ──
          _buildEventsCollapsible(),
          const SizedBox(height: 8),
          // ── Islamic Months (collapsible) ──
          _buildMonthsCollapsible(hijri),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEventsCollapsible() {
    final events = ref.watch(upcomingEventsProvider);
    if (events.isEmpty) return const SizedBox.shrink();

    // Find next upcoming event (first with daysUntil >= 0)
    final nextEvent = events.cast<IslamicEvent?>().firstWhere(
          (e) => (e!.daysUntil ?? 0) >= 0,
          orElse: () => events.first,
        );

    final subtitle = nextEvent != null
        ? '${nextEvent.name} — ${nextEvent.daysUntil == 0 ? '${AppLocalizations.of(context).today}!' : 'in ${nextEvent.daysUntil} days'}'
        : '${events.length} events';

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        leading: Icon(Icons.event, color: Colors.amber.shade700),
        title: Text(
          AppLocalizations.of(context).upcomingEvents,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context).datesMayVary,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(128),
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          ...events.map((event) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _EventTimelineItem(event: event),
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMonthsCollapsible(HijriDate hijri) {
    final currentMonthName = hijriMonthNames[(hijri.month - 1).clamp(0, 11)];

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        leading: Icon(Icons.date_range,
            color: Theme.of(context).colorScheme.primary),
        title: Text(
          AppLocalizations.of(context).islamicMonths,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$currentMonthName ${hijri.year} AH',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
          ),
        ),
        children: List.generate(12, (index) {
          final monthNum = index + 1;
          final isCurrent = monthNum == hijri.month;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
                    hijriMonthNames[index],
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
                  hijriMonthNamesArabic[index],
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
        })..add(const SizedBox(height: 8)),
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
}

class _EventTimelineItem extends StatelessWidget {
  final IslamicEvent event;
  const _EventTimelineItem({required this.event});

  @override
  Widget build(BuildContext context) {
    final isToday = event.daysUntil == 0;
    final isPast = (event.daysUntil ?? 0) < 0;
    final isMajor = event.isMajor;

    final dotColor = isMajor
        ? Colors.amber.shade700
        : Theme.of(context).colorScheme.primary;

    final daysText = isToday
        ? '${AppLocalizations.of(context).today}!'
        : '${event.daysUntil} day${event.daysUntil == 1 ? '' : 's'}';

    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isToday
              ? Colors.amber.withAlpha(20)
              : isMajor
                  ? Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(40)
                  : null,
          borderRadius: BorderRadius.circular(12),
          border: isMajor
              ? Border.all(
                  color: isToday
                      ? Colors.amber.withAlpha(120)
                      : Theme.of(context)
                          .colorScheme
                          .primary
                          .withAlpha(60),
                )
              : null,
        ),
        child: Row(
          children: [
            // Timeline dot
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            // Event info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: TextStyle(
                      fontWeight: isMajor ? FontWeight.bold : FontWeight.w500,
                      fontSize: isMajor ? 15 : 14,
                    ),
                  ),
                  Text(
                    event.nameArabic,
                    style: TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(160),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (event.gregorianDate != null)
                    Text(
                      '${event.hijriDay} ${hijriMonthNames[(event.hijriMonth - 1).clamp(0, 11)]} | ${_formatDate(event.gregorianDate!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(120),
                          ),
                    ),
                ],
              ),
            ),
            // Countdown badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isToday
                    ? Colors.amber.withAlpha(40)
                    : Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withAlpha(128),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                daysText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isToday
                      ? Colors.amber.shade800
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}
