import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/locale_provider.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../audio/presentation/screens/downloads_screen.dart';
import '../../../donate/presentation/screens/donate_screen.dart';
import '../../../prayer_times/presentation/screens/prayer_notification_settings_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final currentLocale = ref.watch(localeProvider);
    final currentFontSize = ref.watch(fontSizeProvider);
    final currentTranslation = ref.watch(defaultTranslationProvider);
    final currentReciter = ref.watch(defaultReciterProvider);
    final currentTafsir = ref.watch(defaultTafsirProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // ─── Appearance ───
          _SectionHeader(title: 'Appearance'),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            subtitle: Text(_themeName(currentTheme)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemePicker(context, ref, currentTheme),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(_currentLanguageName(currentLocale)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguagePicker(context, ref, currentLocale),
          ),

          // ─── Quran Reading ───
          _SectionHeader(title: 'Quran Reading'),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('Default Translation'),
            subtitle:
                Text('${currentTranslation.name} (${currentTranslation.language})'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showTranslationPicker(context, ref, currentTranslation),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: const Text('Default Tafsir'),
            subtitle: Text(currentTafsir.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showTafsirPicker(context, ref, currentTafsir),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Default Font Size'),
            subtitle: Text(_fontSizeLabel(currentFontSize)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showFontSizePicker(context, ref, currentFontSize),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.color_lens_outlined),
            title: const Text('Tajweed Colors'),
            subtitle: const Text('Show colored tajweed rules on text'),
            value: ref.watch(tajweedProvider),
            onChanged: (_) => ref.read(tajweedProvider.notifier).toggle(),
          ),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: const Text('Ayah Numbers'),
            subtitle: Text(ref.watch(numeralStyleProvider) == NumeralStyle.arabic
                ? 'Arabic-Indic (١ ٢ ٣)'
                : 'Western (1 2 3)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showNumeralStylePicker(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.open_in_new_rounded),
            title: const Text('App Startup'),
            subtitle: Text(
                ref.watch(startupScreenProvider) == StartupScreen.home
                    ? 'Home Screen'
                    : 'Last Reading Position'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showStartupPicker(context, ref),
          ),

          // ─── Audio ───
          _SectionHeader(title: 'Audio'),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Default Reciter'),
            subtitle: Text(currentReciter.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showReciterPicker(context, ref, currentReciter),
          ),

          // ─── Notifications ───
          _SectionHeader(title: 'Notifications'),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Prayer Reminders'),
            subtitle: const Text('Get notified before prayer times'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrayerNotificationSettingsScreen(),
              ),
            ),
          ),

          // ─── Data ───
          _SectionHeader(title: 'Data'),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Downloads'),
            subtitle: const Text('Manage offline audio'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DownloadsScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Clear Cache'),
            subtitle: const Text('Free up storage space'),
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Clear Cache?'),
                  content: const Text(
                      'This will remove cached data. Downloaded audio will not be affected.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cache cleared')),
                        );
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),

          // ─── About ───
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Qurani'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Qurani',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    'A free Quran app with tajweed teaching.\nSadaqah Jariyah - All features free.',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Support Us'),
            subtitle: const Text('Help keep this app free'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DonateScreen()),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ─── Theme Picker ───

  void _showThemePicker(
      BuildContext context, WidgetRef ref, AppThemeMode current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomSheetHandle(),
            const SizedBox(height: 20),
            Text(
              'Choose Theme',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...AppThemeMode.values.map((mode) => RadioListTile<AppThemeMode>(
                  value: mode,
                  groupValue: current,
                  title: Text(_themeName(mode)),
                  subtitle: Text(_themeDescription(mode)),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setTheme(value);
                      Navigator.pop(context);
                    }
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Language Picker ───

  String _currentLanguageName(Locale? locale) {
    if (locale == null) return 'System Default';
    for (final lang in supportedLanguages) {
      if (lang.code == locale.languageCode) {
        return '${lang.name} (${lang.nativeName})';
      }
    }
    return locale.languageCode;
  }

  void _showLanguagePicker(
      BuildContext context, WidgetRef ref, Locale? current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomSheetHandle(),
            const SizedBox(height: 20),
            Text(
              'Choose Language',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            RadioListTile<String?>(
              value: null,
              groupValue: current?.languageCode,
              title: const Text('System Default'),
              onChanged: (_) {
                ref.read(localeProvider.notifier).setLocale(null);
                Navigator.pop(context);
              },
            ),
            ...supportedLanguages.map((lang) => RadioListTile<String?>(
                  value: lang.code,
                  groupValue: current?.languageCode,
                  title: Text(lang.name),
                  subtitle: Text(lang.nativeName),
                  onChanged: (_) {
                    ref
                        .read(localeProvider.notifier)
                        .setLocale(Locale(lang.code));
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Translation Picker ───

  void _showTranslationPicker(
      BuildContext context, WidgetRef ref, TranslationOption current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bottomSheetHandle(),
              const SizedBox(height: 20),
              Text(
                'Default Translation',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: translationOptions
                      .map((option) => RadioListTile<String>(
                            value: option.edition,
                            groupValue: current.edition,
                            title: Text(option.name),
                            subtitle: Text(option.language),
                            onChanged: (_) {
                              ref
                                  .read(defaultTranslationProvider.notifier)
                                  .setTranslation(option);
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Tafsir Picker ───

  void _showTafsirPicker(
      BuildContext context, WidgetRef ref, TafsirOption current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomSheetHandle(),
            const SizedBox(height: 20),
            Text(
              'Default Tafsir',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Used when viewing tafsir in the reader',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(153),
                  ),
            ),
            const SizedBox(height: 16),
            ...tafsirOptions.map((option) => RadioListTile<String>(
                  value: option.slug,
                  groupValue: current.slug,
                  title: Text(option.name),
                  onChanged: (_) {
                    ref
                        .read(defaultTafsirProvider.notifier)
                        .setTafsir(option);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Font Size Picker ───

  String _fontSizeLabel(double size) {
    for (final option in fontSizeOptions) {
      if (option.size == size) return '${option.label} (${size.toInt()})';
    }
    return '${size.toInt()}';
  }

  void _showFontSizePicker(
      BuildContext context, WidgetRef ref, double current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomSheetHandle(),
            const SizedBox(height: 20),
            Text(
              'Default Font Size',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            // Preview text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'بِسْمِ ٱللَّهِ',
                style: TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: current,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            ...fontSizeOptions.map((option) => RadioListTile<double>(
                  value: option.size,
                  groupValue: current,
                  title: Text(option.label),
                  subtitle: Text('${option.size.toInt()} pt'),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(fontSizeProvider.notifier).setFontSize(value);
                      Navigator.pop(context);
                    }
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Reciter Picker ───

  void _showReciterPicker(
      BuildContext context, WidgetRef ref, ReciterOption current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bottomSheetHandle(),
              const SizedBox(height: 20),
              Text(
                'Default Reciter',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Used for ayah playback in the reader',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: reciterOptions
                      .map((option) => RadioListTile<String>(
                            value: option.id,
                            groupValue: current.id,
                            title: Text(option.name),
                            onChanged: (_) {
                              ref
                                  .read(defaultReciterProvider.notifier)
                                  .setReciter(option);
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Startup Screen Picker ───

  void _showStartupPicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(startupScreenProvider);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomSheetHandle(),
            const SizedBox(height: 20),
            Text(
              'App Startup',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            RadioListTile<StartupScreen>(
              value: StartupScreen.home,
              groupValue: current,
              title: const Text('Home Screen'),
              subtitle: const Text('Always open to the dashboard'),
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(startupScreenProvider.notifier)
                      .setStartupScreen(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<StartupScreen>(
              value: StartupScreen.lastPosition,
              groupValue: current,
              title: const Text('Last Reading Position'),
              subtitle: const Text('Continue right where you left off'),
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(startupScreenProvider.notifier)
                      .setStartupScreen(value);
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Numeral Style Picker ───

  void _showNumeralStylePicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(numeralStyleProvider);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomSheetHandle(),
            const SizedBox(height: 20),
            Text(
              'Ayah Numbers Style',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            RadioListTile<NumeralStyle>(
              value: NumeralStyle.arabic,
              groupValue: current,
              title: const Text('Arabic-Indic'),
              subtitle: const Text('١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩'),
              onChanged: (value) {
                if (value != null) {
                  ref.read(numeralStyleProvider.notifier).setStyle(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<NumeralStyle>(
              value: NumeralStyle.western,
              groupValue: current,
              title: const Text('Western'),
              subtitle: const Text('1 2 3 4 5 6 7 8 9'),
              onChanged: (value) {
                if (value != null) {
                  ref.read(numeralStyleProvider.notifier).setStyle(value);
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Helpers ───

  Widget _bottomSheetHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  String _themeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.sepia:
        return 'Sepia';
      case AppThemeMode.amoled:
        return 'AMOLED';
    }
  }

  String _themeDescription(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Warm off-white background';
      case AppThemeMode.dark:
        return 'Standard dark theme';
      case AppThemeMode.sepia:
        return 'Parchment-style, easy on eyes';
      case AppThemeMode.amoled:
        return 'Pure black, saves battery';
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
