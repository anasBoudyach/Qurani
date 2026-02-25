import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'app.dart';
import 'core/services/notification_service.dart';
import 'features/widgets/home_widget_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize background audio (notification + lock screen controls)
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.qurani.audio',
    androidNotificationChannelName: 'Qurani Audio',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'drawable/ic_notification',
  );

  // Initialize notification service (prayer reminders, Islamic events)
  await NotificationService.instance.init();

  // Initialize home screen widgets
  HomeWidgetService.initialize();

  runApp(
    const ProviderScope(
      child: QuranApp(),
    ),
  );
}
