import 'package:flutter_test/flutter_test.dart';
import 'package:qurani/core/utils/tajweed_parser.dart';
import 'package:qurani/core/constants/tajweed_colors.dart';

void main() {
  group('TajweedParser', () {
    test('parses plain text without tags', () {
      final tokens = TajweedParser.parse('بِسْمِ اللَّهِ');
      expect(tokens.length, 1);
      expect(tokens.first.text, 'بِسْمِ اللَّهِ');
      expect(tokens.first.rule, TajweedRuleCategory.none);
    });

    test('parses single tajweed tag', () {
      final tokens = TajweedParser.parse(
        'بِسْمِ <tajweed class=ham_wasl>ٱ</tajweed>للَّهِ',
      );
      expect(tokens.length, 3);
      expect(tokens[0].text, 'بِسْمِ');
      expect(tokens[1].text, 'ٱ');
      expect(tokens[1].rule, TajweedRuleCategory.hamzaWasl);
      expect(tokens[2].text, 'للَّهِ');
    });

    test('parses multiple tajweed tags', () {
      final tokens = TajweedParser.parse(
        '<tajweed class=qlq>ق</tajweed> و <tajweed class=ghn>نّ</tajweed>',
      );
      expect(tokens.length, 3);
      expect(tokens[0].rule, TajweedRuleCategory.qalqalah);
      expect(tokens[2].rule, TajweedRuleCategory.ghunnah);
    });
  });
}
