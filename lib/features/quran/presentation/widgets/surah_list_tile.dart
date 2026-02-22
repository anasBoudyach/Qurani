import 'package:flutter/material.dart';
import '../../data/models/surah_info.dart';

class SurahListTile extends StatelessWidget {
  final SurahInfo surah;
  final VoidCallback? onTap;

  const SurahListTile({
    super.key,
    required this.surah,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${surah.number}',
          style: TextStyle(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      title: Text(
        surah.nameTransliteration,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        '${surah.nameEnglish} • ${surah.ayahCount} ayahs',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(153),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            surah.nameArabic,
            style: const TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 18,
            ),
          ),
          Text(
            surah.isMeccan ? 'Meccan' : 'Medinan',
            style: theme.textTheme.labelSmall?.copyWith(
              color: surah.isMeccan
                  ? theme.colorScheme.primary
                  : theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
