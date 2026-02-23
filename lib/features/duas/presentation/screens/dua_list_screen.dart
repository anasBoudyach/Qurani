import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/celebration_overlay.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../data/models/dua.dart';

class DuaListScreen extends ConsumerStatefulWidget {
  final DuaCategory category;

  const DuaListScreen({super.key, required this.category});

  @override
  ConsumerState<DuaListScreen> createState() => _DuaListScreenState();
}

class _DuaListScreenState extends ConsumerState<DuaListScreen> {
  late List<int> _counters;

  @override
  void initState() {
    super.initState();
    _counters = List.filled(widget.category.duas.length, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.category.duas.length,
        itemBuilder: (context, index) {
          final dua = widget.category.duas[index];
          return _DuaCard(
            dua: dua,
            index: index + 1,
            counter: _counters[index],
            onTap: () {
              if (dua.repeatCount > 1) {
                if (_counters[index] < dua.repeatCount) {
                  setState(() {
                    _counters[index]++;
                    HapticFeedback.lightImpact();
                  });
                  // Check if all countable du'as are complete
                  if (_counters[index] >= dua.repeatCount) {
                    final allComplete = List.generate(
                      widget.category.duas.length,
                      (i) {
                        final d = widget.category.duas[i];
                        return d.repeatCount <= 1 || _counters[i] >= d.repeatCount;
                      },
                    ).every((c) => c);
                    if (allComplete) {
                      CelebrationOverlay.show(context, color: AppColors.accentDua);
                      ref.read(gamificationServiceProvider).recordActivity(ActivityType.makeDua);
                    }
                  }
                }
              }
            },
            onCopy: () {
              Clipboard.setData(ClipboardData(
                text: '${dua.arabic}\n\n${dua.transliteration}\n\n${dua.translation}\n\n— ${dua.reference}',
              ));
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(const SnackBar(
                  content: Text('Du\'a copied'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ));
            },
          );
        },
      ),
    );
  }
}

class _DuaCard extends StatelessWidget {
  final Dua dua;
  final int index;
  final int counter;
  final VoidCallback onTap;
  final VoidCallback onCopy;

  const _DuaCard({
    required this.dua,
    required this.index,
    required this.counter,
    required this.onTap,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = dua.repeatCount > 1 && counter >= dua.repeatCount;

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
              dua.arabic,
              style: const TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 22,
                height: 2.0,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Divider(
              color: Theme.of(context).colorScheme.outline.withAlpha(40),
            ),
            const SizedBox(height: 8),
            // Transliteration
            Text(
              dua.transliteration,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(160),
                  ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            // Translation
            Text(
              dua.translation,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(200),
                  ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 12),
            // Reference
            Text(
              dua.reference,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.accentDua,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
