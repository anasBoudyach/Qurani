import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/tajweed_colors.dart';
import '../../../../core/utils/tajweed_parser.dart';

/// Renders Quran text with tajweed color coding.
///
/// Parses HTML tajweed tags from Quran.com API and displays each
/// segment in its corresponding tajweed color. Supports tap-to-explain
/// for individual tajweed rules.
///
/// Tokens are parsed once and cached — re-parsed only when the input changes.
class TajweedTextWidget extends StatefulWidget {
  final String textUthmaniTajweed;
  final double fontSize;
  final bool enableTapExplanation;
  final void Function(TajweedRuleCategory rule, String text)? onRuleTapped;

  const TajweedTextWidget({
    super.key,
    required this.textUthmaniTajweed,
    this.fontSize = 28,
    this.enableTapExplanation = true,
    this.onRuleTapped,
  });

  @override
  State<TajweedTextWidget> createState() => _TajweedTextWidgetState();
}

class _TajweedTextWidgetState extends State<TajweedTextWidget> {
  late List<TajweedToken> _tokens;

  @override
  void initState() {
    super.initState();
    _tokens = TajweedParser.parse(widget.textUthmaniTajweed);
  }

  @override
  void didUpdateWidget(TajweedTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textUthmaniTajweed != widget.textUthmaniTajweed) {
      _tokens = TajweedParser.parse(widget.textUthmaniTajweed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = Theme.of(context).colorScheme.onSurface;

    return Text.rich(
      TextSpan(
        children: _tokens.map((token) {
          Color? tokenColor;
          if (token.hasTajweedRule) {
            final baseColor =
                TajweedColors.cssClassToColor[_categoryToCssClass(token.rule)];
            if (baseColor != null) {
              tokenColor = isDark
                  ? TajweedColors.forDarkMode(baseColor)
                  : baseColor;
            }
          }

          return TextSpan(
            text: token.text,
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: widget.fontSize,
              height: 2.0,
              color: tokenColor ?? defaultColor,
              locale: const Locale('ar'),
            ),
            recognizer: widget.enableTapExplanation && token.hasTajweedRule
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (widget.onRuleTapped != null) {
                      widget.onRuleTapped!(token.rule, token.text);
                    } else {
                      _showRuleBottomSheet(context, token);
                    }
                  })
                : null,
          );
        }).toList(),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    );
  }

  void _showRuleBottomSheet(BuildContext context, TajweedToken token) {
    final ruleInfo = TajweedColors.ruleInfo[token.rule];
    if (ruleInfo == null) return;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? TajweedColors.forDarkMode(ruleInfo.color) : ruleInfo.color;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: color,
              radius: 24,
              child: Text(
                token.text.length > 2
                    ? token.text.substring(0, 2)
                    : token.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'AmiriQuran',
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              ruleInfo.nameArabic,
              style: const TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 24,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 4),
            Text(
              ruleInfo.nameEnglish,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              ruleInfo.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(179),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String? _categoryToCssClass(TajweedRuleCategory category) {
    for (final entry in TajweedColors.cssClassToCategory.entries) {
      if (entry.value == category) return entry.key;
    }
    return null;
  }
}
