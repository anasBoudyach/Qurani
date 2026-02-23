import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/gradient_header.dart';
import '../../../../shared/widgets/staggered_grid.dart';
import '../../data/models/achievement_def.dart';
import '../providers/gamification_providers.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unlockedAsync = ref.watch(unlockedAchievementsProvider);

    final unlockedIds = unlockedAsync.whenOrNull(
          data: (list) => list.map((a) => a.achievementId).toSet(),
        ) ??
        <String>{};

    final unlockedMap = <String, DateTime>{};
    unlockedAsync.whenData((list) {
      for (final a in list) {
        unlockedMap[a.achievementId] = a.unlockedAt;
      }
    });

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            gradient: isDark
                ? AppColors.gradientGoldDark
                : AppColors.gradientGold,
            height: 160,
            showMosque: true,
            padding: EdgeInsets.fromLTRB(
              24, MediaQuery.of(context).padding.top + 8, 24, 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Achievements',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white.withAlpha(200),
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${unlockedIds.length} / ${AchievementDef.all.length} earned',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: StaggeredAnimationGrid(
              crossAxisCount: 3,
              childAspectRatio: 0.72,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: AchievementDef.all.map((def) {
                final isUnlocked = unlockedIds.contains(def.id);
                return _AchievementCard(
                  def: def,
                  isUnlocked: isUnlocked,
                  unlockedAt: unlockedMap[def.id],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final AchievementDef def;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const _AchievementCard({
    required this.def,
    required this.isUnlocked,
    this.unlockedAt,
  });

  @override
  Widget build(BuildContext context) {
    final color = isUnlocked ? def.color : Colors.grey;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
            ? color.withAlpha(15)
            : Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? color.withAlpha(60) : Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with badge
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withAlpha(isUnlocked ? 30 : 15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isUnlocked ? def.icon : Icons.lock_rounded,
                  color: color.withAlpha(isUnlocked ? 255 : 100),
                  size: 26,
                ),
              ),
              if (isUnlocked)
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            def.title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isUnlocked
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onSurface.withAlpha(100),
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Description
          Text(
            def.description,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(
                        isUnlocked ? 120 : 70,
                      ),
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
