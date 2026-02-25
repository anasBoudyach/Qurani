import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/providers/reading_preferences_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_provider.dart';

const _onboardingCompleteKey = 'onboarding_complete';

/// Provider to check if onboarding has been completed.
final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_onboardingCompleteKey) ?? false;
});

/// 5-screen onboarding flow:
/// 1. Welcome
/// 2. Features overview
/// 3. Theme selection
/// 4. Reading preferences
/// 5. Get started
class OnboardingScreen extends ConsumerStatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  static const _totalPages = 5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skip() => _completeOnboarding();

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
    ref.invalidate(onboardingCompleteProvider);
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _currentPage < _totalPages - 1
                    ? TextButton(
                        onPressed: _skip,
                        child: Text(AppLocalizations.of(context).skip),
                      )
                    : const SizedBox(height: 48),
              ),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _WelcomePage(),
                  _FeaturesPage(),
                  _ThemePage(ref: ref),
                  const _PreferencesPage(),
                  _GetStartedPage(),
                ],
              ),
            ),
            // Page indicator + next button
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Dots
                  Row(
                    children: List.generate(
                      _totalPages,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        width: i == _currentPage ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _currentPage
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(77),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Next/Get Started button
                  FilledButton(
                    onPressed: _nextPage,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      _currentPage == _totalPages - 1
                          ? AppLocalizations.of(context).getStarted
                          : AppLocalizations.of(context).nextBtn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Page 1: Welcome ───

class _WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App icon placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.menu_book_rounded,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Qurani',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 32),
          Text(
            AppLocalizations.of(context).yourCompleteCompanion,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(179),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).readListenLearn,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(153),
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Page 2: Features Overview ───

class _FeaturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final features = [
      _Feature(Icons.auto_stories_rounded, l10n.readTheQuran,
          l10n.beautifulTajweedDesc),
      _Feature(Icons.headphones_rounded, l10n.reciters260,
          l10n.streamDownloadDesc),
      _Feature(Icons.school_rounded, l10n.learnTajweed,
          l10n.learnTajweed24),
      _Feature(Icons.favorite_rounded, l10n.completelyFree,
          l10n.noAdsDesc),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.everythingYouNeed,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 40),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withAlpha(128),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(f.icon,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            f.subtitle,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(153),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Feature(this.icon, this.title, this.subtitle);
}

// ─── Page 3: Theme Selection ───

class _ThemePage extends StatelessWidget {
  final WidgetRef ref;
  const _ThemePage({required this.ref});

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).chooseYourTheme,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).changeLater,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(153),
                ),
          ),
          const SizedBox(height: 32),
          ...AppThemeMode.values.map((mode) => _ThemeOption(
                mode: mode,
                isSelected: currentTheme == mode,
                onTap: () =>
                    ref.read(themeProvider.notifier).setTheme(mode),
              )),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final AppThemeMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final info = _themeInfo(mode, context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer.withAlpha(102)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withAlpha(51),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: info.previewColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withAlpha(51),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  Text(
                    info.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(153),
                        ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }

  _ThemeInfo _themeInfo(AppThemeMode mode, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (mode) {
      case AppThemeMode.light:
        return _ThemeInfo(l10n.light, 'Warm off-white', const Color(0xFFFFFBF5));
      case AppThemeMode.dark:
        return _ThemeInfo(l10n.dark, 'Standard dark theme', const Color(0xFF1C1B1F));
      case AppThemeMode.sepia:
        return _ThemeInfo(l10n.sepia, 'Parchment-style', const Color(0xFFF5E6CA));
      case AppThemeMode.amoled:
        return _ThemeInfo(l10n.amoled, 'Pure black, saves battery', const Color(0xFF000000));
    }
  }
}

class _ThemeInfo {
  final String name;
  final String description;
  final Color previewColor;
  const _ThemeInfo(this.name, this.description, this.previewColor);
}

// ─── Page 4: Reading Preferences ───

class _PreferencesPage extends ConsumerWidget {
  const _PreferencesPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = ref.watch(defaultTranslationProvider);
    final tafsir = ref.watch(defaultTafsirProvider);
    final reciter = ref.watch(defaultReciterProvider);
    final fontSize = ref.watch(fontSizeProvider);
    final showTajweed = ref.watch(tajweedProvider);
    final numeralStyle = ref.watch(numeralStyleProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context).readingPreferences,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).personalizeDesc,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(153),
                ),
          ),
          const SizedBox(height: 24),
          // Tajweed toggle
          _ToggleCard(
            icon: Icons.color_lens_outlined,
            title: 'Tajweed Colors',
            subtitle: showTajweed ? AppLocalizations.of(context).coloredTajweedOn : AppLocalizations.of(context).plainArabic,
            value: showTajweed,
            onChanged: (_) => ref.read(tajweedProvider.notifier).toggle(),
          ),
          // Numeral style
          _PreferenceCard(
            icon: Icons.format_list_numbered,
            title: 'Ayah Numbers',
            subtitle: numeralStyle == NumeralStyle.arabic
                ? 'Arabic-Indic (١ ٢ ٣)'
                : 'Western (1 2 3)',
            onTap: () {
              final next = numeralStyle == NumeralStyle.arabic
                  ? NumeralStyle.western
                  : NumeralStyle.arabic;
              ref.read(numeralStyleProvider.notifier).setStyle(next);
            },
          ),
          _PreferenceCard(
            icon: Icons.translate,
            title: 'Translation',
            subtitle: '${translation.name} (${translation.language})',
            onTap: () => _showTranslationPicker(context, ref),
          ),
          _PreferenceCard(
            icon: Icons.menu_book_outlined,
            title: 'Default Tafsir',
            subtitle: tafsir.name,
            onTap: () => _showTafsirPicker(context, ref),
          ),
          _PreferenceCard(
            icon: Icons.person_outline,
            title: 'Default Reciter',
            subtitle: reciter.name,
            onTap: () => _showReciterPicker(context, ref),
          ),
          _PreferenceCard(
            icon: Icons.text_fields,
            title: 'Font Size',
            subtitle: _fontSizeLabel(fontSize),
            onTap: () => _showFontSizePicker(context, ref),
          ),
          _PreferenceCard(
            icon: Icons.open_in_new_rounded,
            title: 'App Startup',
            subtitle: ref.watch(startupScreenProvider) == StartupScreen.home
                ? AppLocalizations.of(context).homeScreen
                : AppLocalizations.of(context).lastReadingPosition,
            onTap: () => _showStartupPicker(context, ref),
          ),
          _ToggleCard(
            icon: Icons.cloud_off_outlined,
            title: AppLocalizations.of(context).offlineMode,
            subtitle: ref.watch(offlineModeProvider)
                ? AppLocalizations.of(context).offlineModeDesc
                : AppLocalizations.of(context).offlineModeDesc,
            value: ref.watch(offlineModeProvider),
            onChanged: (_) =>
                ref.read(offlineModeProvider.notifier).toggle(),
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context).changeInSettings,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(128),
                ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _fontSizeLabel(double size) {
    for (final option in fontSizeOptions) {
      if (option.size == size) return '${option.label} (${size.toInt()})';
    }
    return '${size.toInt()}';
  }

  void _showStartupPicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(startupScreenProvider);
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<StartupScreen>(
              value: StartupScreen.home,
              groupValue: current,
              title: Text(AppLocalizations.of(context).homeScreen),
              subtitle: Text(AppLocalizations.of(context).alwaysOpenDashboard),
              onChanged: (_) {
                ref
                    .read(startupScreenProvider.notifier)
                    .setStartupScreen(StartupScreen.home);
                Navigator.pop(sheetContext);
              },
            ),
            RadioListTile<StartupScreen>(
              value: StartupScreen.lastPosition,
              groupValue: current,
              title: Text(AppLocalizations.of(context).lastReadingPosition),
              subtitle: Text(AppLocalizations.of(context).continueWhereLeft),
              onChanged: (_) {
                ref
                    .read(startupScreenProvider.notifier)
                    .setStartupScreen(StartupScreen.lastPosition);
                Navigator.pop(sheetContext);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showTranslationPicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(defaultTranslationProvider);
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.8,
        minChildSize: 0.3,
        expand: false,
        builder: (_, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
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
                      Navigator.pop(sheetContext);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showTafsirPicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(defaultTafsirProvider);
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...tafsirOptions.map((option) => RadioListTile<String>(
                  value: option.slug,
                  groupValue: current.slug,
                  title: Text(option.name),
                  onChanged: (_) {
                    ref
                        .read(defaultTafsirProvider.notifier)
                        .setTafsir(option);
                    Navigator.pop(sheetContext);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showReciterPicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(defaultReciterProvider);
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.8,
        minChildSize: 0.3,
        expand: false,
        builder: (_, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          children: reciterOptions
              .map((option) => RadioListTile<String>(
                    value: option.id,
                    groupValue: current.id,
                    title: Text(option.name),
                    onChanged: (_) {
                      ref
                          .read(defaultReciterProvider.notifier)
                          .setReciter(option);
                      Navigator.pop(sheetContext);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showFontSizePicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(fontSizeProvider);
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...fontSizeOptions.map((option) => RadioListTile<double>(
                  value: option.size,
                  groupValue: current,
                  title: Text(option.label),
                  subtitle: Text('${option.size.toInt()} pt'),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(fontSizeProvider.notifier).setFontSize(value);
                      Navigator.pop(sheetContext);
                    }
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PreferenceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PreferenceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: SwitchListTile(
        secondary: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

// ─── Page 5: Get Started ───

class _GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            AppLocalizations.of(context).youreAllSet,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            '${AppLocalizations.of(context).startJourney}\n${AppLocalizations.of(context).mayAllahBless}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(179),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'جَعَلَنَا ٱللَّهُ مِنْ أَهْلِ ٱلْقُرْآن',
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 22,
              color: Theme.of(context).colorScheme.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            'May Allah make us among the people of the Quran.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(153),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
