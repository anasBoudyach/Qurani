import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Donation/Support screen with external links.
/// No in-app payments — purely external donation links (Sadaqah Jariyah).
class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Qurani')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Header
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
                const Icon(Icons.favorite_rounded, color: Colors.white, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Sadaqah Jariyah',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'صَدَقَةٌ جَارِيَة',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 22,
                    color: Colors.white.withAlpha(230),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),
                Text(
                  'Qurani is completely free — no ads, no subscriptions, '
                  'no premium features. Your support helps keep it that way '
                  'and rewards you with ongoing charity.',
                  style: TextStyle(
                    color: Colors.white.withAlpha(204),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Hadith
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withAlpha(128),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'إِذَا مَاتَ ابْنُ آدَمَ انْقَطَعَ عَمَلُهُ إِلَّا مِنْ ثَلَاث',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '"When a person dies, their deeds come to an end except three: '
                  'ongoing charity, beneficial knowledge, or a righteous child '
                  'who prays for them."',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(153),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '— Sahih Muslim',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(128),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Donation options
          Text(
            'Ways to Support',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _DonationOption(
            icon: Icons.favorite_rounded,
            title: 'GitHub Sponsors',
            subtitle: 'One-time or monthly support',
            color: const Color(0xFFDB61A2),
            onTap: () => _launchUrl('https://github.com/sponsors/anasBoudyach'),
          ),
          _DonationOption(
            icon: Icons.coffee_rounded,
            title: 'Buy Me a Coffee',
            subtitle: 'One-time or monthly support',
            color: const Color(0xFFFFDD00),
            onTap: () => _launchUrl('https://buymeacoffee.com/anasboudyach'),
          ),
          _DonationOption(
            icon: Icons.payment_rounded,
            title: 'PayPal',
            subtitle: 'Direct donation via PayPal',
            color: const Color(0xFF003087),
            onTap: () => _launchUrl('https://paypal.me/AnasBOUDYACH'),
          ),
          _DonationOption(
            icon: Icons.star_rounded,
            title: 'Rate on Google Play',
            subtitle: 'Free way to support — leave a review',
            color: Colors.green,
            onTap: () =>
                _launchUrl('https://play.google.com/store/apps/details?id=com.qurani'),
          ),
          _DonationOption(
            icon: Icons.share_rounded,
            title: 'Share with Friends',
            subtitle: 'Spread the word about Qurani',
            color: Colors.blue,
            onTap: () =>
                _launchUrl('https://play.google.com/store/apps/details?id=com.qurani'),
          ),
          const SizedBox(height: 24),
          // What donations fund
          Text(
            'Your Support Helps',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _SupportItem(
            icon: Icons.cloud_outlined,
            text: 'Server costs for audio streaming',
          ),
          _SupportItem(
            icon: Icons.translate,
            text: 'New translations and languages',
          ),
          _SupportItem(
            icon: Icons.build_outlined,
            text: 'Ongoing development and bug fixes',
          ),
          _SupportItem(
            icon: Icons.no_encryption_outlined,
            text: 'Keeping the app free and ad-free forever',
          ),
          const SizedBox(height: 24),
          // Dua
          Center(
            child: Text(
              'جَزَاكُمُ ٱللَّهُ خَيْرًا',
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              'May Allah reward you with goodness.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(153),
                  ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _DonationOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _DonationOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(26),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.open_in_new, size: 18),
        onTap: onTap,
      ),
    );
  }
}

class _SupportItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SupportItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
