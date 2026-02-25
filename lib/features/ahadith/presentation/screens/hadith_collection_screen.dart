import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../data/services/hadith_api_service.dart';
import '../providers/hadith_providers.dart';
import 'hadith_list_screen.dart';

class HadithCollectionScreen extends ConsumerWidget {
  final HadithCollectionInfo collection;

  const HadithCollectionScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsAsync = ref.watch(hadithSectionsProvider(collection.key));

    return Scaffold(
      appBar: AppBar(title: Text(collection.name)),
      body: sectionsAsync.when(
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
                  onPressed: () =>
                      ref.invalidate(hadithSectionsProvider(collection.key)),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(AppLocalizations.of(context).retry),
                ),
              ],
            ),
          ),
        ),
        data: (sections) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            final hadithCount = section.hadithEndNumber > 0
                ? section.hadithEndNumber - section.hadithStartNumber + 1
                : 0;

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.accentAhadith.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${section.sectionNumber}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentAhadith,
                      fontSize: 13,
                    ),
                  ),
                ),
                title: Text(
                  section.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: hadithCount > 0
                    ? Text(
                        '$hadithCount',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(140),
                        ),
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HadithListScreen(
                        collectionKey: collection.key,
                        collectionName: collection.name,
                        sectionNumber: section.sectionNumber,
                        sectionName: section.name,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
            ),
            title: Container(
              height: 14,
              width: 180,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }
}
