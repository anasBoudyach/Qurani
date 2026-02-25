import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/utils/page_transitions.dart';
import '../../../../shared/widgets/gradient_header.dart';
import '../../../audio/presentation/screens/downloads_screen.dart';
import '../../../donate/presentation/screens/donate_screen.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../../gamification/presentation/screens/achievements_screen.dart';
import 'settings_screen.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final achievementCount =
        ref.watch(achievementCountProvider).whenOrNull(data: (c) => c) ?? 0;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            gradient: isDark
                ? AppColors.gradientGreenDark
                : AppColors.gradientGreen,
            height: 120,
            showMosque: true,
            padding: EdgeInsets.fromLTRB(
              24, MediaQuery.of(context).padding.top + 12, 24, 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  l10n.more,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.settingsUtilities,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withAlpha(170),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _UtilityTile(
                  icon: Icons.emoji_events_rounded,
                  iconColor: Colors.amber.shade700,
                  bgColor: Colors.amber,
                  title: l10n.achievements,
                  subtitle: '$achievementCount ${l10n.badgesUnlocked}',
                  onTap: () => _push(context, const AchievementsScreen()),
                ),
                _UtilityTile(
                  icon: Icons.download_rounded,
                  iconColor: Colors.blue.shade700,
                  bgColor: Colors.blue,
                  title: l10n.downloads,
                  subtitle: l10n.manageOfflineAudio,
                  onTap: () => _push(context, const DownloadsScreen()),
                ),
                _UtilityTile(
                  icon: Icons.settings_rounded,
                  iconColor: Theme.of(context).colorScheme.primary,
                  bgColor: Theme.of(context).colorScheme.primary,
                  title: l10n.settings,
                  subtitle: l10n.settingsUtilities,
                  onTap: () => _push(context, const SettingsScreen()),
                ),
                const Divider(height: 32),
                _UtilityTile(
                  icon: Icons.favorite_rounded,
                  iconColor: Colors.pink,
                  bgColor: Colors.pink,
                  title: l10n.donate,
                  subtitle: '${l10n.helpKeepFree} - ${l10n.sadaqahJariyah}',
                  onTap: () => _push(context, const DonateScreen()),
                ),
                _UtilityTile(
                  icon: Icons.info_outline_rounded,
                  iconColor: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                  bgColor: Theme.of(context).colorScheme.onSurface,
                  title: l10n.aboutQurani,
                  subtitle: l10n.versionLicenses,
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: 'Qurani',
                    applicationVersion: '1.0.0',
                    applicationLegalese:
                        'Built with love as Sadaqah Jariyah.\nMay Allah accept it from us.',
                    applicationIcon: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.push(context, SlideUpRoute(page: screen));
  }
}

class _UtilityTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _UtilityTile({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor.withAlpha(26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
            ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
      ),
      onTap: onTap,
    );
  }
}
