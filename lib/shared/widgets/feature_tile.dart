import 'package:flutter/material.dart';

/// Colorful rounded-square tile for feature grids.
///
/// Displays an icon on a tinted background with a label underneath.
/// Used in the dashboard feature grid and More screen.
class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  /// When true, uses smaller icon (48x48, 24px icon) for 4-column grids.
  final bool compact;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgAlpha = isDark ? 40 : 30;
    final iconColor = isDark ? color.withAlpha(220) : color;
    final boxSize = compact ? 48.0 : 56.0;
    final iconSize = compact ? 24.0 : 28.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              color: color.withAlpha(bgAlpha),
              borderRadius: BorderRadius.circular(compact ? 14 : 16),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          SizedBox(height: compact ? 6 : 8),
          Text(
            label,
            style: (compact
                    ? Theme.of(context).textTheme.labelSmall
                    : Theme.of(context).textTheme.bodySmall)
                ?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
