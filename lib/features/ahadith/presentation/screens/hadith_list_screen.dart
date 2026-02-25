import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../providers/hadith_providers.dart';

class HadithListScreen extends ConsumerWidget {
  final String collectionKey;
  final String collectionName;
  final int sectionNumber;
  final String sectionName;

  const HadithListScreen({
    super.key,
    required this.collectionKey,
    required this.collectionName,
    required this.sectionNumber,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hadithsAsync = ref.watch(hadithListProvider(
      (collectionKey: collectionKey, sectionNumber: sectionNumber),
    ));

    return Scaffold(
      appBar: AppBar(title: Text(sectionName)),
      body: hadithsAsync.when(
        loading: () => _buildShimmer(context),
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
                  onPressed: () => ref.invalidate(hadithListProvider(
                    (
                      collectionKey: collectionKey,
                      sectionNumber: sectionNumber,
                    ),
                  )),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(AppLocalizations.of(context).retry),
                ),
              ],
            ),
          ),
        ),
        data: (hadiths) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: hadiths.length,
          itemBuilder: (context, index) {
            final hadith = hadiths[index];
            return _HadithCard(
              hadithNumber: hadith.hadithNumber,
              arabicText: hadith.textArabic,
              englishText: hadith.textEnglish,
              collectionName: collectionName,
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HadithCard extends StatelessWidget {
  final int hadithNumber;
  final String arabicText;
  final String englishText;
  final String collectionName;

  const _HadithCard({
    required this.hadithNumber,
    required this.arabicText,
    required this.englishText,
    required this.collectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentAhadith.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '#$hadithNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.accentAhadith,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                    text:
                        '$arabicText\n\n$englishText\n\n— $collectionName #$hadithNumber',
                  ));
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context).hadithCopied),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ));
                },
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
            arabicText,
            style: const TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 20,
              height: 2.0,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          if (englishText.isNotEmpty) ...[
            const SizedBox(height: 12),
            Divider(
              color: Theme.of(context).colorScheme.outline.withAlpha(40),
            ),
            const SizedBox(height: 8),
            // English translation
            Text(
              englishText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(200),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
