import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/widgets/celebration_overlay.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../data/models/azkar_models.dart';
import '../providers/azkar_providers.dart';

class AzkarDetailScreen extends ConsumerStatefulWidget {
  final AzkarCategory category;

  const AzkarDetailScreen({super.key, required this.category});

  @override
  ConsumerState<AzkarDetailScreen> createState() => _AzkarDetailScreenState();
}

class _AzkarDetailScreenState extends ConsumerState<AzkarDetailScreen> {
  final Map<int, int> _counters = {};

  void _increment(int index, int target) {
    final current = _counters[index] ?? 0;
    if (current < target) {
      setState(() => _counters[index] = current + 1);
      HapticFeedback.lightImpact();
    }
    if ((_counters[index] ?? 0) >= target) {
      HapticFeedback.heavyImpact();
    }
  }

  void _checkAllComplete(int totalItems, List<int> targets) {
    final allComplete = List.generate(
      totalItems,
      (i) => (_counters[i] ?? 0) >= targets[i],
    ).every((c) => c);
    if (allComplete) {
      CelebrationOverlay.show(context, color: widget.category.color);
      final title = widget.category.name.toLowerCase();
      if (title.contains('morning')) {
        ref
            .read(gamificationServiceProvider)
            .recordActivity(ActivityType.morningAzkar);
      } else if (title.contains('evening')) {
        ref
            .read(gamificationServiceProvider)
            .recordActivity(ActivityType.eveningAzkar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final azkarAsync = ref.watch(azkarListProvider((
      categoryId: widget.category.categoryId,
      categoryTitle: widget.category.nameArabic,
    )));

    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: azkarAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off_rounded,
                    size: 48,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(100)),
                const SizedBox(height: 16),
                Text(
                  '${AppLocalizations.of(context).couldNotLoad}\n${AppLocalizations.of(context).checkConnection}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(160),
                      ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(azkarListProvider((
                    categoryId: widget.category.categoryId,
                    categoryTitle: widget.category.nameArabic,
                  ))),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(AppLocalizations.of(context).retry),
                ),
              ],
            ),
          ),
        ),
        data: (azkarList) {
          final targets = azkarList.map((a) => a.repeatCount).toList();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: azkarList.length,
            itemBuilder: (context, index) {
              final dhikr = azkarList[index];
              final count = _counters[index] ?? 0;
              final complete = count >= dhikr.repeatCount;

              return GestureDetector(
                onTap: () {
                  _increment(index, dhikr.repeatCount);
                  _checkAllComplete(azkarList.length, targets);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: complete
                        ? AppColors.success.withAlpha(20)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: complete
                          ? AppColors.success.withAlpha(102)
                          : Theme.of(context)
                              .colorScheme
                              .outline
                              .withAlpha(51),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Arabic text
                      Text(
                        dhikr.arabicText,
                        style: const TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: 22,
                          height: 2.0,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // Counter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (complete)
                            const Icon(Icons.check_circle,
                                color: AppColors.success, size: 20),
                          if (complete) const SizedBox(width: 8),
                          Text(
                            '$count / ${dhikr.repeatCount}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: complete
                                  ? AppColors.success
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      if (!complete) ...[
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context).tapToCount,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(102),
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
