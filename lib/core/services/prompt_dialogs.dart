import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import '../router/app_router.dart' show rootNavigatorKey;
import '../../features/donate/presentation/screens/donate_screen.dart';

/// Gentle, non-aggressive prompt dialogs for review and donation.
/// Returns the user's choice: 'action', 'never', or null (not now / dismissed).
class PromptDialogs {
  PromptDialogs._();

  static const _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.qurani';

  /// Shows a gentle review prompt. Returns user choice.
  static Future<String?> showReviewPrompt(BuildContext context) async {
    final theme = Theme.of(context);
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(26),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.star_rounded,
            size: 32,
            color: theme.colorScheme.primary,
          ),
        ),
        title: const Text(
          'Enjoying Qurani?',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'If Qurani has been helpful in your journey, a review helps '
          'others discover it. It only takes a moment.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => rootNavigatorKey.currentState?.pop('never'),
            child: Text(
              'Don\'t Show Again',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          TextButton(
            onPressed: () => rootNavigatorKey.currentState?.pop(),
            child: const Text('Not Now'),
          ),
          FilledButton.icon(
            onPressed: () => rootNavigatorKey.currentState?.pop('action'),
            icon: const Icon(Icons.star_rounded, size: 18),
            label: const Text('Rate App'),
          ),
        ],
      ),
    );

    if (result == 'action') {
      await _launchReview();
    }

    return result;
  }

  /// Shows a gentle donation prompt. Returns user choice.
  static Future<String?> showDonationPrompt(BuildContext context) async {
    final theme = Theme.of(context);
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFD4A017).withAlpha(26),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite_rounded,
            size: 32,
            color: Color(0xFFD4A017),
          ),
        ),
        title: const Text(
          'Support Qurani',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Qurani is free and always will be — no ads, no subscriptions. '
          'If it\'s been useful to you, consider supporting its development '
          'as Sadaqah Jariyah.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => rootNavigatorKey.currentState?.pop('never'),
            child: Text(
              'Don\'t Show Again',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          TextButton(
            onPressed: () => rootNavigatorKey.currentState?.pop(),
            child: const Text('Not Now'),
          ),
          FilledButton.icon(
            onPressed: () => rootNavigatorKey.currentState?.pop('action'),
            icon: const Icon(Icons.favorite_rounded, size: 18),
            label: const Text('Support'),
          ),
        ],
      ),
    );

    if (result == 'action' && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const DonateScreen()),
      );
    }

    return result;
  }

  /// Try native in-app review, fall back to Play Store URL.
  static Future<void> _launchReview() async {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      final uri = Uri.parse(_playStoreUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }
}
