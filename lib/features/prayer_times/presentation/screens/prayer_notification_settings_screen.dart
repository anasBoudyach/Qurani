import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/notification_service.dart';
import '../../data/prayer_reminder_provider.dart';
import '../../data/prayer_reminder_service.dart';

class PrayerNotificationSettingsScreen extends ConsumerWidget {
  const PrayerNotificationSettingsScreen({super.key});

  static const _offsetOptions = [
    (value: 0, label: 'At prayer time'),
    (value: 5, label: '5 minutes before'),
    (value: 10, label: '10 minutes before'),
    (value: 15, label: '15 minutes before'),
    (value: 30, label: '30 minutes before'),
  ];

  static const _prayerIcons = {
    'Fajr': Icons.wb_twilight,
    'Dhuhr': Icons.wb_sunny,
    'Asr': Icons.sunny_snowing,
    'Maghrib': Icons.wb_twilight,
    'Isha': Icons.nightlight_round,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(prayerReminderSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).prayerNotifications)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Info card
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withAlpha(77),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).notifLocationInfo,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ),

          // Prayer toggles
          ...reminderPrayers.map((prayer) {
            final enabled = settings.isEnabled(prayer);
            final offset = settings.getOffset(prayer);
            final icon = _prayerIcons[prayer] ?? Icons.access_time;
            final arabic = prayerArabicName(prayer);

            return Column(
              children: [
                SwitchListTile(
                  secondary: Icon(
                    icon,
                    color: enabled
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  title: Row(
                    children: [
                      Text(
                        prayer,
                        style: TextStyle(
                          fontWeight:
                              enabled ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        arabic,
                        style: TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(128),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  subtitle: enabled
                      ? Text(_offsetLabel(context, offset))
                      : Text(AppLocalizations.of(context).tapToEnable),
                  value: enabled,
                  onChanged: (_) async {
                    await ref
                        .read(prayerReminderSettingsProvider.notifier)
                        .togglePrayer(prayer);
                    final updated =
                        ref.read(prayerReminderSettingsProvider);
                    await PrayerReminderService.scheduleAllReminders(updated);
                  },
                ),
                if (enabled)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 72, right: 16, bottom: 8),
                    child: _OffsetSelector(
                      currentOffset: offset,
                      onChanged: (newOffset) async {
                        await ref
                            .read(prayerReminderSettingsProvider.notifier)
                            .setOffset(prayer, newOffset);
                        final updated =
                            ref.read(prayerReminderSettingsProvider);
                        await PrayerReminderService.scheduleAllReminders(
                            updated);
                      },
                    ),
                  ),
                const Divider(height: 1, indent: 72),
              ],
            );
          }),

          const SizedBox(height: 24),

          // Test notification button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () async {
                await NotificationService.instance.showTestNotification();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context).testNotifSent),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.notifications_active_outlined),
              label: Text(AppLocalizations.of(context).sendTest),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _offsetLabel(BuildContext context, int minutes) {
    if (minutes == 0) return AppLocalizations.of(context).atPrayerTime;
    return '$minutes ${AppLocalizations.of(context).minutesBefore}';
  }
}

class _OffsetSelector extends StatelessWidget {
  final int currentOffset;
  final ValueChanged<int> onChanged;

  const _OffsetSelector({
    required this.currentOffset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: PrayerNotificationSettingsScreen._offsetOptions.map((opt) {
        final selected = opt.value == currentOffset;
        return ChoiceChip(
          label: Text(
            opt.label,
            style: TextStyle(fontSize: 12, color: selected ? Colors.white : null),
          ),
          selected: selected,
          onSelected: (_) => onChanged(opt.value),
          selectedColor: Theme.of(context).colorScheme.primary,
          visualDensity: VisualDensity.compact,
        );
      }).toList(),
    );
  }
}
