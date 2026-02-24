import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/l10n/app_localizations.dart';
import 'core/l10n/locale_provider.dart';
import 'core/providers/reading_preferences_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/bookmarks/presentation/providers/bookmark_providers.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';
import 'features/quran/data/models/surah_info.dart';
import 'features/quran/presentation/screens/reading_screen.dart';

class QuranApp extends ConsumerStatefulWidget {
  const QuranApp({super.key});

  @override
  ConsumerState<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends ConsumerState<QuranApp> {
  bool _showSplash = true;
  bool _startupHandled = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    final onboardingDone = ref.watch(onboardingCompleteProvider);

    return MaterialApp.router(
      title: 'Qurani',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.forMode(themeMode),
      routerConfig: appRouter,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        // Show splash screen on every launch
        if (_showSplash) {
          return SplashScreen(
            onComplete: () {
              if (mounted) setState(() => _showSplash = false);
            },
          );
        }

        // Show onboarding overlay on first launch
        return onboardingDone.when(
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => child!,
          data: (done) {
            if (!done) {
              return Navigator(
                onGenerateRoute: (_) => MaterialPageRoute(
                  builder: (_) => OnboardingScreen(
                    onComplete: () =>
                        ref.invalidate(onboardingCompleteProvider),
                  ),
                ),
              );
            }

            // Handle "Last Reading Position" startup preference
            if (!_startupHandled) {
              _startupHandled = true;
              final startupPref = ref.read(startupScreenProvider);
              if (startupPref == StartupScreen.lastPosition) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final position =
                      await ref.read(lastReadingPositionProvider.future);
                  if (position != null && mounted) {
                    final surah = SurahInfo.all.firstWhere(
                      (s) => s.number == position.surahId,
                      orElse: () => SurahInfo.all.first,
                    );
                    rootNavigatorKey.currentState?.push(MaterialPageRoute(
                      builder: (_) => ReadingScreen(
                        surah: surah,
                        initialAyah: position.ayahNumber,
                      ),
                    ));
                  }
                });
              }
            }

            return child!;
          },
        );
      },
    );
  }
}
