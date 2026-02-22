import '../constants/tajweed_colors.dart';

/// A parsed segment of tajweed text with its associated rule.
class TajweedToken {
  final String text;
  final TajweedRuleCategory rule;

  const TajweedToken({
    required this.text,
    required this.rule,
  });

  bool get hasTajweedRule => rule != TajweedRuleCategory.none;
}

/// Parses HTML tajweed text from Quran.com API into structured tokens.
///
/// Input format:  `بِسْمِ <tajweed class=ham_wasl>ٱ</tajweed>للَّهِ`
/// Output: List of [TajweedToken] with rule categories for colored rendering.
class TajweedParser {
  TajweedParser._();

  static final RegExp _tajweedTagRegex = RegExp(
    r'''<tajweed\s+class=["']?(\w+)["']?>(.*?)</tajweed>''',
    dotAll: true,
  );

  static final RegExp _htmlTagRegex = RegExp(r'<[^>]+>');

  /// Parse HTML tajweed string into tokens.
  static List<TajweedToken> parse(String htmlText) {
    final tokens = <TajweedToken>[];
    int lastEnd = 0;

    for (final match in _tajweedTagRegex.allMatches(htmlText)) {
      // Plain text before this tag
      if (match.start > lastEnd) {
        final plainText = _stripHtml(htmlText.substring(lastEnd, match.start));
        if (plainText.isNotEmpty) {
          tokens.add(TajweedToken(
            text: plainText,
            rule: TajweedRuleCategory.none,
          ));
        }
      }

      // Tagged text
      final cssClass = match.group(1)!;
      final content = match.group(2)!;
      final category =
          TajweedColors.cssClassToCategory[cssClass] ?? TajweedRuleCategory.none;

      tokens.add(TajweedToken(
        text: content,
        rule: category,
      ));

      lastEnd = match.end;
    }

    // Trailing plain text
    if (lastEnd < htmlText.length) {
      final remaining = _stripHtml(htmlText.substring(lastEnd));
      if (remaining.isNotEmpty) {
        tokens.add(TajweedToken(
          text: remaining,
          rule: TajweedRuleCategory.none,
        ));
      }
    }

    // If no tags found, return the whole text as a single plain token
    if (tokens.isEmpty && htmlText.isNotEmpty) {
      tokens.add(TajweedToken(
        text: _stripHtml(htmlText),
        rule: TajweedRuleCategory.none,
      ));
    }

    return tokens;
  }

  /// Strips any remaining HTML tags from text.
  static String _stripHtml(String text) {
    return text.replaceAll(_htmlTagRegex, '').trim();
  }
}
