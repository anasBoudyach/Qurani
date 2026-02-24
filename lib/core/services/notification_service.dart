import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Singleton service for scheduling local notifications.
/// Handles prayer reminders and Islamic event reminders.
class NotificationService {
  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  // ── Notification ID ranges ──
  // Prayer reminders: 100-105 (Fajr=100, Sunrise=101, Dhuhr=102, Asr=103, Maghrib=104, Isha=105)
  // Islamic events:   200-299
  // Test:             999
  static const int fajrId = 100;
  static const int sunriseId = 101;
  static const int dhuhrId = 102;
  static const int asrId = 103;
  static const int maghribId = 104;
  static const int ishaId = 105;
  static const int testId = 999;

  // ── Notification Channels ──
  static const _prayerChannel = AndroidNotificationDetails(
    'prayer_reminders',
    'Prayer Reminders',
    channelDescription: 'Notifications for prayer times',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    icon: '@drawable/ic_notification',
  );

  static const _eventChannel = AndroidNotificationDetails(
    'islamic_events',
    'Islamic Events',
    channelDescription: 'Notifications for Islamic holidays and events',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
    icon: '@drawable/ic_notification',
  );

  /// Initialize the notification system. Call once in main().
  Future<void> init() async {
    if (_initialized) return;

    // 1. Initialize timezone data
    tz.initializeTimeZones();
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone.toString()));
    } catch (e) {
      // Fallback to UTC if timezone detection fails
      debugPrint('NotificationService: timezone fallback to UTC: $e');
    }

    // 2. Android initialization settings
    const androidSettings = AndroidInitializationSettings('@drawable/ic_notification');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // 3. Request notification permission (Android 13+)
    await _requestPermission();

    _initialized = true;
    debugPrint('NotificationService initialized');
  }

  Future<void> _requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.requestNotificationsPermission();
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Could navigate to specific screen based on payload
    debugPrint('Notification tapped: ${response.payload}');
  }

  /// Schedule a prayer reminder notification at a specific time.
  Future<void> schedulePrayerReminder({
    required int id,
    required String prayerName,
    required String prayerNameArabic,
    required DateTime scheduledTime,
    int offsetMinutes = 0,
  }) async {
    if (!_initialized) return;

    final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

    // Don't schedule if time already passed
    if (tzTime.isBefore(tz.TZDateTime.now(tz.local))) return;

    String title;
    String body;
    if (offsetMinutes > 0) {
      title = '$prayerName in $offsetMinutes minutes';
      body = '$prayerNameArabic — ${_formatTime(scheduledTime.add(Duration(minutes: offsetMinutes)))}';
    } else {
      title = "It's time for $prayerName";
      body = '$prayerNameArabic — ${_formatTime(scheduledTime)}';
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      const NotificationDetails(android: _prayerChannel),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'prayer_$prayerName',
    );
  }

  /// Schedule an Islamic event reminder.
  Future<void> scheduleEventReminder({
    required int id,
    required String eventName,
    required String eventNameArabic,
    required DateTime scheduledTime,
    bool isDayBefore = false,
  }) async {
    if (!_initialized) return;

    final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);
    if (tzTime.isBefore(tz.TZDateTime.now(tz.local))) return;

    final title = isDayBefore ? 'Tomorrow: $eventName' : 'Today: $eventName';
    final body = eventNameArabic;

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      const NotificationDetails(android: _eventChannel),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'event_$eventName',
    );
  }

  /// Show a test notification immediately.
  Future<void> showTestNotification() async {
    if (!_initialized) return;

    await _plugin.show(
      testId,
      'Qurani - Test Notification',
      'Prayer reminders are working correctly!',
      const NotificationDetails(android: _prayerChannel),
    );
  }

  /// Cancel a specific notification by ID.
  Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  /// Cancel all prayer reminder notifications (IDs 100-105).
  Future<void> cancelAllPrayerReminders() async {
    for (var id = 100; id <= 105; id++) {
      await _plugin.cancel(id);
    }
  }

  /// Cancel all notifications.
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = h >= 12 ? 'PM' : 'AM';
    final hour12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$hour12:$m $period';
  }
}
