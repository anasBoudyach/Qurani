import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/widgets/celebration_overlay.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../providers/duas_providers.dart';

class DuaListScreen extends ConsumerStatefulWidget {
  final int categoryId;
  final String categoryTitle;
  final String displayTitle;

  const DuaListScreen({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
    required this.displayTitle,
  });

  @override
  ConsumerState<DuaListScreen> createState() => _DuaListScreenState();
}

class _DuaListScreenState extends ConsumerState<DuaListScreen> {
  final Map<int, int> _counters = {};

  @override
  Widget build(BuildContext context) {
    final duasAsync = ref.watch(duasListProvider((
      categoryId: widget.categoryId,
      categoryTitle: widget.categoryTitle,
    )));

    return Scaffold(
      appBar: AppBar(title: Text(widget.displayTitle)),
      body: duasAsync.when(
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
                  onPressed: () => ref.invalidate(duasListProvider((
                    categoryId: widget.categoryId,
                    categoryTitle: widget.categoryTitle,
                  ))),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(AppLocalizations.of(context).retry),
                ),
              ],
            ),
          ),
        ),
        data: (duasList) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: duasList.length,
            itemBuilder: (context, index) {
              final dua = duasList[index];
              final count = _counters[index] ?? 0;
              final isCompleted =
                  dua.repeatCount > 1 && count >= dua.repeatCount;

              return _DuaCard(
                dua: dua,
                index: index + 1,
                counter: count,
                isCompleted: isCompleted,
                onTap: () {
                  if (dua.repeatCount > 1 && count < dua.repeatCount) {
                    setState(() {
                      _counters[index] = count + 1;
                      HapticFeedback.lightImpact();
                    });
                    if ((_counters[index] ?? 0) >= dua.repeatCount) {
                      final allComplete = List.generate(
                        duasList.length,
                        (i) {
                          final d = duasList[i];
                          return d.repeatCount <= 1 ||
                              (_counters[i] ?? 0) >= d.repeatCount;
                        },
                      ).every((c) => c);
                      if (allComplete) {
                        CelebrationOverlay.show(context,
                            color: AppColors.accentDua);
                        ref
                            .read(gamificationServiceProvider)
                            .recordActivity(ActivityType.makeDua);
                      }
                    }
                  }
                },
                onCopy: () {
                  Clipboard.setData(
                      ClipboardData(text: dua.arabicText));
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context).duaCopied),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _DuaCard extends StatelessWidget {
  final dynamic dua;
  final int index;
  final int counter;
  final bool isCompleted;
  final VoidCallback onTap;
  final VoidCallback onCopy;

  const _DuaCard({
    required this.dua,
    required this.index,
    required this.counter,
    required this.isCompleted,
    required this.onTap,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isCompleted
              ? AppColors.success.withAlpha(15)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withAlpha(8),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: isCompleted
              ? Border.all(color: AppColors.success.withAlpha(80))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.accentDua.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.accentDua,
                    ),
                  ),
                ),
                const Spacer(),
                if (dua.repeatCount > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.success.withAlpha(25)
                          : AppColors.accentDua.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$counter/${dua.repeatCount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: isCompleted
                            ? AppColors.success
                            : AppColors.accentDua,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onCopy,
                  child: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(120),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Arabic text
            Text(
              dua.arabicText,
              style: const TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 22,
                height: 2.0,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
