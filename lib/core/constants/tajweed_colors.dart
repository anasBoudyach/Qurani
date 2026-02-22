import 'package:flutter/material.dart';

/// Tajweed rule categories matching Quran.com API CSS classes.
enum TajweedRuleCategory {
  hamzaWasl,
  laamShamsiyyah,
  silentLetter,
  qalqalah,
  ghunnah,
  maddNormal,
  maddPermissible,
  maddObligatory,
  maddNecessary,
  ikhfa,
  ikhfaShafawi,
  idghamGhunnah,
  idghamNoGhunnah,
  idghamShafawi,
  idghamMutajanisayn,
  idghamMutaqaribayn,
  iqlab,
  none,
}

class TajweedColors {
  TajweedColors._();

  // Light theme colors (from AlQuran.cloud tajweed guide)
  static const Color hamzaWasl = Color(0xFFAAAAAA);
  static const Color silentLetter = Color(0xFFAAAAAA);
  static const Color laamShamsiyyah = Color(0xFFAAAAAA);

  // Madd variations (blue spectrum - darker = longer duration)
  static const Color maddNormal = Color(0xFF537FFF);
  static const Color maddPermissible = Color(0xFF4050FF);
  static const Color maddObligatory = Color(0xFF2144C1);
  static const Color maddNecessary = Color(0xFF000EBC);

  // Qalqalah
  static const Color qalqalah = Color(0xFFDD0008);

  // Ikhfa
  static const Color ikhfa = Color(0xFF9400A8);
  static const Color ikhfaShafawi = Color(0xFFD500B7);

  // Idgham
  static const Color idghamGhunnah = Color(0xFF169777);
  static const Color idghamNoGhunnah = Color(0xFF169200);
  static const Color idghamShafawi = Color(0xFF58B800);
  static const Color idghamMutajanisayn = Color(0xFFA1A1A1);

  // Iqlab
  static const Color iqlab = Color(0xFF26BFFD);

  // Ghunnah
  static const Color ghunnah = Color(0xFFFF7E1E);

  /// CSS class name -> Color
  static const Map<String, Color> cssClassToColor = {
    'ham_wasl': hamzaWasl,
    'slnt': silentLetter,
    'laam_shamsiyah': laamShamsiyyah,
    'madda_normal': maddNormal,
    'madda_permissible': maddPermissible,
    'madda_obligatory': maddObligatory,
    'madda_necessary': maddNecessary,
    'qlq': qalqalah,
    'ikhf': ikhfa,
    'ikhf_shfw': ikhfaShafawi,
    'idgh_ghn': idghamGhunnah,
    'idgh_w_ghn': idghamNoGhunnah,
    'idghm_shfw': idghamShafawi,
    'idgh_mus': idghamMutajanisayn,
    'iqlb': iqlab,
    'ghn': ghunnah,
  };

  /// CSS class name -> TajweedRuleCategory
  static const Map<String, TajweedRuleCategory> cssClassToCategory = {
    'ham_wasl': TajweedRuleCategory.hamzaWasl,
    'slnt': TajweedRuleCategory.silentLetter,
    'laam_shamsiyah': TajweedRuleCategory.laamShamsiyyah,
    'madda_normal': TajweedRuleCategory.maddNormal,
    'madda_permissible': TajweedRuleCategory.maddPermissible,
    'madda_obligatory': TajweedRuleCategory.maddObligatory,
    'madda_necessary': TajweedRuleCategory.maddNecessary,
    'qlq': TajweedRuleCategory.qalqalah,
    'ikhf': TajweedRuleCategory.ikhfa,
    'ikhf_shfw': TajweedRuleCategory.ikhfaShafawi,
    'idgh_ghn': TajweedRuleCategory.idghamGhunnah,
    'idgh_w_ghn': TajweedRuleCategory.idghamNoGhunnah,
    'idghm_shfw': TajweedRuleCategory.idghamShafawi,
    'idgh_mus': TajweedRuleCategory.idghamMutajanisayn,
    'iqlb': TajweedRuleCategory.iqlab,
    'ghn': TajweedRuleCategory.ghunnah,
  };

  /// TajweedRuleCategory -> display info
  static const Map<TajweedRuleCategory, TajweedRuleInfo> ruleInfo = {
    TajweedRuleCategory.hamzaWasl: TajweedRuleInfo(
      nameArabic: 'همزة الوصل',
      nameEnglish: 'Hamzat ul-Wasl',
      color: hamzaWasl,
      description: 'A connecting hamza that is pronounced at the beginning of speech but silent when connected to the previous word.',
    ),
    TajweedRuleCategory.laamShamsiyyah: TajweedRuleInfo(
      nameArabic: 'لام شمسية',
      nameEnglish: 'Laam Shamsiyyah',
      color: laamShamsiyyah,
      description: 'The Laam in "Al" is silent and assimilated into the following sun letter.',
    ),
    TajweedRuleCategory.silentLetter: TajweedRuleInfo(
      nameArabic: 'حرف ساكن',
      nameEnglish: 'Silent Letter',
      color: silentLetter,
      description: 'A letter that is written but not pronounced.',
    ),
    TajweedRuleCategory.qalqalah: TajweedRuleInfo(
      nameArabic: 'قلقلة',
      nameEnglish: 'Qalqalah',
      color: qalqalah,
      description: 'An echoing/bouncing sound produced when one of the 5 Qalqalah letters (ق ط ب ج د) has a sukoon.',
    ),
    TajweedRuleCategory.ghunnah: TajweedRuleInfo(
      nameArabic: 'غنّة',
      nameEnglish: 'Ghunnah',
      color: ghunnah,
      description: 'A nasal sound lasting 2 counts, produced through the nose when pronouncing Noon or Meem with shaddah.',
    ),
    TajweedRuleCategory.maddNormal: TajweedRuleInfo(
      nameArabic: 'مد طبيعي',
      nameEnglish: 'Natural Madd',
      color: maddNormal,
      description: 'Natural prolongation of 2 counts using one of the 3 madd letters (ا و ي).',
    ),
    TajweedRuleCategory.maddPermissible: TajweedRuleInfo(
      nameArabic: 'مد جائز منفصل',
      nameEnglish: 'Permissible Madd',
      color: maddPermissible,
      description: 'Madd letter followed by hamza in the next word. Can be extended 2, 4, or 6 counts.',
    ),
    TajweedRuleCategory.maddObligatory: TajweedRuleInfo(
      nameArabic: 'مد واجب متصل',
      nameEnglish: 'Obligatory Madd',
      color: maddObligatory,
      description: 'Madd letter followed by hamza in the same word. Must be extended 4-5 counts.',
    ),
    TajweedRuleCategory.maddNecessary: TajweedRuleInfo(
      nameArabic: 'مد لازم',
      nameEnglish: 'Necessary Madd',
      color: maddNecessary,
      description: 'Madd letter followed by sukoon in the same word. Always extended 6 counts.',
    ),
    TajweedRuleCategory.ikhfa: TajweedRuleInfo(
      nameArabic: 'إخفاء',
      nameEnglish: 'Ikhfa',
      color: ikhfa,
      description: 'Noon saakin or tanween followed by one of 15 ikhfa letters. The noon is partially hidden with ghunnah.',
    ),
    TajweedRuleCategory.ikhfaShafawi: TajweedRuleInfo(
      nameArabic: 'إخفاء شفوي',
      nameEnglish: 'Ikhfa Shafawi',
      color: ikhfaShafawi,
      description: 'Meem saakin followed by Baa. The meem is partially hidden with a lip-based sound.',
    ),
    TajweedRuleCategory.idghamGhunnah: TajweedRuleInfo(
      nameArabic: 'إدغام بغنة',
      nameEnglish: 'Idgham with Ghunnah',
      color: idghamGhunnah,
      description: 'Noon saakin or tanween merging into Yaa, Noon, Meem, or Waaw with nasalization.',
    ),
    TajweedRuleCategory.idghamNoGhunnah: TajweedRuleInfo(
      nameArabic: 'إدغام بغير غنة',
      nameEnglish: 'Idgham without Ghunnah',
      color: idghamNoGhunnah,
      description: 'Noon saakin or tanween merging into Laam or Raa without nasalization.',
    ),
    TajweedRuleCategory.idghamShafawi: TajweedRuleInfo(
      nameArabic: 'إدغام شفوي',
      nameEnglish: 'Idgham Shafawi',
      color: idghamShafawi,
      description: 'Meem saakin followed by another Meem. Full merge with ghunnah.',
    ),
    TajweedRuleCategory.idghamMutajanisayn: TajweedRuleInfo(
      nameArabic: 'إدغام متجانسين',
      nameEnglish: 'Idgham Mutajanisayn',
      color: idghamMutajanisayn,
      description: 'Two letters sharing the same articulation point merge together.',
    ),
    TajweedRuleCategory.idghamMutaqaribayn: TajweedRuleInfo(
      nameArabic: 'إدغام متقاربين',
      nameEnglish: 'Idgham Mutaqaribayn',
      color: idghamMutajanisayn,
      description: 'Two letters from close articulation points merge together.',
    ),
    TajweedRuleCategory.iqlab: TajweedRuleInfo(
      nameArabic: 'إقلاب',
      nameEnglish: 'Iqlab',
      color: iqlab,
      description: 'Noon saakin or tanween before Baa converts to a Meem sound with ghunnah.',
    ),
  };

  /// Get brighter colors for dark mode
  static Color forDarkMode(Color lightColor) {
    final hsl = HSLColor.fromColor(lightColor);
    return hsl
        .withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0))
        .withSaturation((hsl.saturation + 0.1).clamp(0.0, 1.0))
        .toColor();
  }
}

class TajweedRuleInfo {
  final String nameArabic;
  final String nameEnglish;
  final Color color;
  final String description;

  const TajweedRuleInfo({
    required this.nameArabic,
    required this.nameEnglish,
    required this.color,
    required this.description,
  });
}
