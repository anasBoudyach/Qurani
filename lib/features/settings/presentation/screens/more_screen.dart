import 'package:flutter/material.dart';
import '../../../azkar/presentation/screens/azkar_screen.dart';
import '../../../prayer_times/presentation/screens/prayer_times_screen.dart';
import '../../../prayer_times/presentation/screens/qibla_screen.dart';
import '../../../prayer_times/presentation/screens/hijri_screen.dart';
import '../../../donate/presentation/screens/donate_screen.dart';
import '../../../hifz/presentation/screens/hifz_setup_screen.dart';
import '../../../reading_plans/presentation/screens/khatmah_screen.dart';
import 'settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Feature grid
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _FeatureTile(
                icon: Icons.access_time_rounded,
                label: 'Prayer Times',
                color: Colors.teal,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PrayerTimesScreen()),
                ),
              ),
              _FeatureTile(
                icon: Icons.auto_awesome_rounded,
                label: 'Azkar',
                color: Colors.indigo,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AzkarScreen()),
                ),
              ),
              _FeatureTile(
                icon: Icons.explore_rounded,
                label: 'Qibla',
                color: Colors.deepOrange,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QiblaScreen()),
                ),
              ),
              _FeatureTile(
                icon: Icons.calendar_month_rounded,
                label: 'Hijri',
                color: Colors.purple,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HijriScreen()),
                ),
              ),
              _FeatureTile(
                icon: Icons.menu_book_rounded,
                label: 'Hifz',
                color: Colors.green,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const HifzSetupScreen()),
                ),
              ),
              _FeatureTile(
                icon: Icons.track_changes_rounded,
                label: 'Khatmah',
                color: Colors.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const KhatmahScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Settings and about
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withAlpha(77),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.settings_rounded,
                  color: Theme.of(context).colorScheme.primary),
            ),
            title: const Text('Settings'),
            subtitle: const Text('Theme, language, audio preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.pink.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.favorite_rounded, color: Colors.pink),
            ),
            title: const Text('Support Qurani'),
            subtitle:
                const Text('Help keep this app free - Sadaqah Jariyah'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DonateScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FeatureTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(51)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
