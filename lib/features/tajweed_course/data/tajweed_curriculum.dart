import 'models/tajweed_lesson.dart';

/// Complete tajweed curriculum: 24 lessons across 3 levels.
/// All lessons are completely free - no gating.
class TajweedCurriculum {
  TajweedCurriculum._();

  static const List<TajweedLesson> allLessons = [
    // ─── BEGINNER (8 lessons) ───

    TajweedLesson(
      id: 1,
      level: TajweedLevel.beginner,
      orderInLevel: 1,
      titleArabic: 'مقدمة في التجويد',
      titleEnglish: 'Introduction to Tajweed',
      description: 'Learn what tajweed is, why it matters, and the basic rules of Quran recitation.',
      theory: '''Tajweed (تجويد) literally means "beautification" or "improvement." In the context of Quran recitation, it refers to the set of rules that govern how each letter should be pronounced.

The purpose of tajweed is to recite the Quran exactly as it was revealed to Prophet Muhammad ﷺ, preserving the proper pronunciation of every letter.

Key concepts:
• Makharij (مخارج) - Points of articulation (where sounds originate)
• Sifaat (صفات) - Characteristics of letters
• Ahkam (أحكام) - Rules of recitation

Learning tajweed is considered Fard Kifayah (communal obligation) by scholars, meaning some members of the community must learn it, but applying basic tajweed when reciting is considered obligatory for every Muslim.''',
      examples: [
        TajweedExample(
          arabicText: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 1,
          explanation: 'The Bismillah demonstrates multiple tajweed rules in a single verse.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What does "Tajweed" literally mean?',
          options: ['Speed', 'Beautification', 'Memorization', 'Translation'],
          correctIndex: 1,
          explanation: 'Tajweed literally means beautification or improvement of recitation.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'Tajweed rules are optional and not important for Quran recitation.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'Applying tajweed is considered obligatory by Islamic scholars.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What does "Makharij" refer to?',
          options: ['Types of verses', 'Points of articulation', 'Recitation speeds', 'Types of surahs'],
          correctIndex: 1,
          explanation: 'Makharij (مخارج) are the points of articulation where sounds originate.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which is NOT a key concept in tajweed?',
          options: ['Makharij', 'Sifaat', 'Ahkam', 'Tarjamah'],
          correctIndex: 3,
          explanation: 'Tarjamah (translation) is not a tajweed concept. The three main concepts are Makharij, Sifaat, and Ahkam.',
        ),
      ],
    ),

    TajweedLesson(
      id: 2,
      level: TajweedLevel.beginner,
      orderInLevel: 2,
      titleArabic: 'همزة الوصل',
      titleEnglish: 'Hamza Al-Wasl',
      description: 'Learn about the connecting hamza and when to pronounce or skip it.',
      theory: '''Hamzat Al-Wasl (همزة الوصل) is a hamza that appears at the beginning of a word. It is pronounced when starting a sentence but dropped when connecting from a previous word.

How to identify: It appears as an alif (ا) without a hamza sign above or below it. In Uthmanic script, it often appears as ٱ.

Rules:
• When starting: Pronounce with a kasrah (ِ), dammah (ُ), or fathah (َ) depending on the word
• When connecting: Skip it entirely and connect to the next letter

Common examples:
• ٱلْحَمْدُ (al-hamdu) - The "al" article
• ٱهْدِنَا (ihdina) - The verb "guide us"
• ٱسْتَغْفِرْ (istaghfir) - The verb "seek forgiveness"''',
      examples: [
        TajweedExample(
          arabicText: 'ٱهْدِنَا ٱلصِّرَاطَ ٱلْمُسْتَقِيمَ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 6,
          explanation: 'The hamzat al-wasl in "ٱهْدِنَا" is pronounced at the start, and in "ٱلصِّرَاطَ" and "ٱلْمُسْتَقِيمَ" it connects smoothly.',
          highlightedWord: 'ٱهْدِنَا',
        ),
        TajweedExample(
          arabicText: 'بِسْمِ ٱللَّهِ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 1,
          explanation: 'The hamzat al-wasl in "ٱللَّهِ" is silent when connected from "بِسْمِ".',
          highlightedWord: 'ٱللَّهِ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'When is Hamzat Al-Wasl pronounced?',
          options: ['Always', 'When starting a sentence', 'When in the middle of a word', 'Never'],
          correctIndex: 1,
          explanation: 'Hamzat Al-Wasl is only pronounced when you start reciting from that word.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'Hamzat Al-Wasl is always dropped when connecting from a previous word.',
          options: ['True', 'False'],
          correctIndex: 0,
          explanation: 'Correct! When connecting, the hamzat al-wasl is dropped and you flow into the next letter.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which symbol represents Hamzat Al-Wasl in Uthmanic script?',
          options: ['أ', 'ٱ', 'إ', 'ء'],
          correctIndex: 1,
          explanation: 'ٱ (alif with wasla mark) represents hamzat al-wasl in Uthmanic script.',
        ),
      ],
    ),

    TajweedLesson(
      id: 3,
      level: TajweedLevel.beginner,
      orderInLevel: 3,
      titleArabic: 'اللام الشمسية والقمرية',
      titleEnglish: 'Laam Shamsiyyah & Qamariyyah',
      description: 'Master the sun and moon letters and how they affect the pronunciation of "Al".',
      theory: '''The Arabic definite article "Al" (ال) is pronounced differently depending on the letter that follows it.

Laam Shamsiyyah (اللام الشمسية) - Sun Letters:
The laam is silent and the following letter is doubled (with shaddah).
Sun letters: ت ث د ذ ر ز س ش ص ض ط ظ ل ن (14 letters)
Example: الشَّمْس (ash-shams) - the "L" is silent

Laam Qamariyyah (اللام القمرية) - Moon Letters:
The laam is pronounced clearly.
Moon letters: أ ب ج ح خ ع غ ف ق ك م هـ و ي (14 letters)
Example: القَمَر (al-qamar) - the "L" is pronounced

Memory tip: The word "شمس" (sun) starts with a sun letter, and "قمر" (moon) starts with a moon letter!''',
      examples: [
        TajweedExample(
          arabicText: 'ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 1,
          explanation: 'Both "ر" are sun letters, so the laam is silent: "ar-Rahman ar-Raheem".',
        ),
        TajweedExample(
          arabicText: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 2,
          explanation: '"ح" and "ع" are moon letters, so the laam is pronounced: "al-Hamdu" and "al-aalameen".',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What happens to the laam with a sun letter?',
          options: ['It is pronounced clearly', 'It is silent and the next letter is doubled', 'It is always dropped', 'Nothing changes'],
          correctIndex: 1,
          explanation: 'With sun letters, the laam becomes silent and the following letter gets a shaddah (doubling).',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which of these is a sun letter?',
          options: ['ب (ba)', 'ق (qaf)', 'ش (shin)', 'ك (kaf)'],
          correctIndex: 2,
          explanation: 'ش (shin) is a sun letter. The word "الشمس" (the sun) itself uses a sun letter!',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'In "القمر" (al-qamar), the laam is silent.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'False! ق is a moon letter, so the laam is pronounced clearly: "al-qamar".',
        ),
      ],
    ),

    TajweedLesson(
      id: 4,
      level: TajweedLevel.beginner,
      orderInLevel: 4,
      titleArabic: 'الحروف الساكنة',
      titleEnglish: 'Silent Letters',
      description: 'Understand sukoon and how silent letters work in Quranic recitation.',
      theory: '''A sukoon (سُكُون) is a small circle (ْ) placed above a letter to indicate it has no vowel sound. The letter is pronounced with its basic sound only, without any added vowel.

Key points:
• A letter with sukoon cannot start a word in Arabic
• When stopping on a word, the last letter often gets a temporary sukoon
• Sukoon creates consonant clusters that require smooth transitions

Types of sukoon:
1. Original sukoon (سكون أصلي) - Written in the mushaf
2. Temporary sukoon (سكون عارض) - When stopping mid-sentence

Examples:
• مِنْ (min) - the noon has sukoon
• عَبْدِ (abdi) - the ba has sukoon
• يَهْدِي (yahdi) - the ha has sukoon''',
      examples: [
        TajweedExample(
          arabicText: 'صِرَاطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 7,
          explanation: 'Multiple letters with sukoon: the meem in "أَنْعَمْتَ" and "عَلَيْهِمْ".',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What does sukoon indicate?',
          options: ['The letter is doubled', 'The letter has no vowel', 'The letter is stretched', 'The letter is nasal'],
          correctIndex: 1,
          explanation: 'Sukoon (ْ) indicates the letter has no vowel and is pronounced with its basic consonant sound only.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'A word in Arabic can start with a letter that has sukoon.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'False! Arabic words cannot begin with a consonant that has sukoon.',
        ),
      ],
    ),

    TajweedLesson(
      id: 5,
      level: TajweedLevel.beginner,
      orderInLevel: 5,
      titleArabic: 'القلقلة',
      titleEnglish: 'Qalqalah',
      description: 'Learn the bouncing sound of the five qalqalah letters.',
      theory: '''Qalqalah (قلقلة) literally means "shaking" or "echoing." It is a slight bouncing sound added to certain letters when they have a sukoon.

The 5 Qalqalah letters are: ق ط ب ج د
Memory aid: Combine them into "قُطْبُ جَدٍّ" (Qutbu Jadd)

Levels of Qalqalah:
1. Minor (صغرى) - When the letter has sukoon in the middle of a word
   Example: يَقْتُلُونَ - the qaf bounces slightly
2. Major (كبرى) - When the letter has sukoon at the end of a word (when stopping)
   Example: الفلق - when stopping on the qaf, it bounces more strongly

Important: Qalqalah is only applied when the letter has sukoon (ْ), never when it has a vowel.''',
      examples: [
        TajweedExample(
          arabicText: 'قُلْ هُوَ ٱللَّهُ أَحَدٌ',
          surahName: 'Al-Ikhlas',
          surahNumber: 112,
          ayahNumber: 1,
          explanation: 'The "ل" in "قُلْ" - though laam is not a qalqalah letter. But "أَحَدٌ" when stopping has major qalqalah on the dal.',
          highlightedWord: 'أَحَدٌ',
        ),
        TajweedExample(
          arabicText: 'تَبَّتْ يَدَا أَبِي لَهَبٍ',
          surahName: 'Al-Masad',
          surahNumber: 111,
          ayahNumber: 1,
          explanation: 'The "ب" in "تَبَّتْ" - the ta has sukoon (not a qalqalah letter), but stopping on "لَهَبٍ" gives major qalqalah to the ba.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which letters have qalqalah?',
          options: ['م ن و ي', 'ق ط ب ج د', 'ا و ي', 'ت ث س ش'],
          correctIndex: 1,
          explanation: 'The five qalqalah letters are ق ط ب ج د, remembered as "قُطْبُ جَدٍّ".',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'When is qalqalah applied?',
          options: ['When the letter has fathah', 'When the letter has sukoon', 'Always', 'Only at the start of a word'],
          correctIndex: 1,
          explanation: 'Qalqalah only applies when a qalqalah letter has sukoon.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'Major qalqalah occurs when a qalqalah letter has sukoon at the end of a word.',
          options: ['True', 'False'],
          correctIndex: 0,
          explanation: 'Correct! Major qalqalah is stronger and occurs at the end of words when stopping.',
        ),
      ],
    ),

    TajweedLesson(
      id: 6,
      level: TajweedLevel.beginner,
      orderInLevel: 6,
      titleArabic: 'الغنة',
      titleEnglish: 'Ghunnah',
      description: 'Master the nasal sound that accompanies noon and meem.',
      theory: '''Ghunnah (غنة) is a nasal sound that resonates from the nasal cavity. It naturally accompanies the letters noon (ن) and meem (م).

Duration: The ghunnah is typically held for 2 counts (حركتين).

When ghunnah occurs:
1. Noon or meem with shaddah (نّ or مّ) - Full ghunnah, 2 counts
2. During idgham with ghunnah - When noon sakinah merges into ي ن م و
3. During ikhfa - When noon sakinah is partially hidden
4. During iqlab - When noon sakinah changes to meem before ba

The ghunnah sound should be pleasant, clear, and come from the nose. You can test by holding your nose - if the sound changes, you're producing ghunnah correctly.''',
      examples: [
        TajweedExample(
          arabicText: 'إِنَّ ٱللَّهَ وَمَلَـٰئِكَتَهُ',
          surahName: 'Al-Ahzab',
          surahNumber: 33,
          ayahNumber: 56,
          explanation: 'The noon with shaddah in "إِنَّ" produces a full ghunnah held for 2 counts.',
          highlightedWord: 'إِنَّ',
        ),
        TajweedExample(
          arabicText: 'ثُمَّ إِنَّ عَلَيْنَا بَيَانَهُ',
          surahName: 'Al-Qiyamah',
          surahNumber: 75,
          ayahNumber: 19,
          explanation: 'Both "ثُمَّ" (meem with shaddah) and "إِنَّ" (noon with shaddah) have full ghunnah.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Ghunnah is a sound that comes from:',
          options: ['The throat', 'The nasal cavity', 'The tongue', 'The lips'],
          correctIndex: 1,
          explanation: 'Ghunnah is a nasal resonance that comes from the nasal cavity.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'How long is a full ghunnah held?',
          options: ['1 count', '2 counts', '4 counts', '6 counts'],
          correctIndex: 1,
          explanation: 'A full ghunnah is held for 2 counts (حركتين).',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'Ghunnah only occurs with the letter noon.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'False! Ghunnah occurs with both noon (ن) and meem (م).',
        ),
      ],
    ),

    TajweedLesson(
      id: 7,
      level: TajweedLevel.beginner,
      orderInLevel: 7,
      titleArabic: 'المد الطبيعي',
      titleEnglish: 'Natural Madd',
      description: 'Learn the basic elongation of vowel sounds.',
      theory: '''Madd (مد) means "elongation" or "stretching." Natural Madd (المد الطبيعي) is the basic stretching of a vowel sound for exactly 2 counts.

Natural Madd occurs with the three madd letters:
1. Alif (ا) preceded by fathah - قَالَ (qaala)
2. Waw (و) preceded by dammah - يَقُولُ (yaqoolu)
3. Ya (ي) preceded by kasrah - قِيلَ (qeela)

Rules:
• Duration: Always exactly 2 counts (حركتين)
• No hamza or sukoon after the madd letter
• It is the foundation for all other types of madd

This is called "natural" because it occurs naturally and the letter cannot be pronounced without this minimum stretching.''',
      examples: [
        TajweedExample(
          arabicText: 'قَالَ رَبِّي يَعْلَمُ',
          surahName: 'Al-Anbiya',
          surahNumber: 21,
          ayahNumber: 4,
          explanation: 'The alif after "ق" in "قَالَ" is a natural madd - stretched for 2 counts.',
          highlightedWord: 'قَالَ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'How long is Natural Madd held?',
          options: ['1 count', '2 counts', '4 counts', '6 counts'],
          correctIndex: 1,
          explanation: 'Natural Madd is always held for exactly 2 counts.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which are the three madd letters?',
          options: ['ا و ي', 'ب ت ث', 'ق ط د', 'م ن ل'],
          correctIndex: 0,
          explanation: 'The three madd letters are alif (ا), waw (و), and ya (ي).',
        ),
      ],
    ),

    TajweedLesson(
      id: 8,
      level: TajweedLevel.beginner,
      orderInLevel: 8,
      titleArabic: 'مراجعة وتطبيق',
      titleEnglish: 'Review & Practice',
      description: 'Review all beginner concepts and practice with Quranic verses.',
      theory: '''Congratulations on completing the Beginner level! Let's review the key concepts:

1. Tajweed Basics: Rules for proper Quran recitation
2. Hamzat Al-Wasl: Connecting hamza (pronounced at start, dropped when connecting)
3. Laam Shamsiyyah/Qamariyyah: Sun letters (laam silent) vs Moon letters (laam pronounced)
4. Silent Letters: Sukoon indicates no vowel on a letter
5. Qalqalah: Bouncing sound on ق ط ب ج د with sukoon
6. Ghunnah: Nasal sound with noon and meem (2 counts)
7. Natural Madd: Basic elongation with ا و ي (2 counts)

Practice tip: Try reciting Surah Al-Fatihah applying all these rules. Listen to a skilled reciter and compare your recitation.''',
      examples: [
        TajweedExample(
          arabicText: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 1,
          explanation: 'Contains hamzat al-wasl (ٱللَّهِ, ٱلرَّحْمَـٰنِ, ٱلرَّحِيمِ), laam shamsiyyah (الرَّحْمَـٰنِ), and natural madd.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which rule applies to the letter "ق" when it has sukoon?',
          options: ['Ghunnah', 'Madd', 'Qalqalah', 'Idgham'],
          correctIndex: 2,
          explanation: 'ق is one of the five qalqalah letters (ق ط ب ج د).',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'In "الشَّمْس", the laam is:',
          options: ['Pronounced clearly', 'Silent (sun letter)', 'Doubled', 'Elongated'],
          correctIndex: 1,
          explanation: 'ش is a sun letter, so the laam is silent and the sheen is doubled.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'Natural Madd can be held for 4 or 6 counts.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'False! Natural Madd is always exactly 2 counts. Longer durations belong to other types of madd.',
        ),
      ],
    ),

    // ─── INTERMEDIATE (8 lessons) ───

    TajweedLesson(
      id: 9,
      level: TajweedLevel.intermediate,
      orderInLevel: 1,
      titleArabic: 'الإخفاء',
      titleEnglish: 'Ikhfa',
      description: 'Learn the hiding of noon sakinah before 15 specific letters.',
      theory: '''Ikhfa (إخفاء) means "hiding" or "concealment." When a noon sakinah (نْ) or tanween is followed by one of 15 specific letters, the noon is partially hidden - not fully pronounced, not fully assimilated.

The 15 Ikhfa letters: ت ث ج د ذ ز س ش ص ض ط ظ ف ق ك
Memory aid: All Arabic letters EXCEPT those used in Ith-har (أ هـ ع ح غ خ), Idgham (ي ر م ل و ن), and Iqlab (ب).

How to pronounce: The tongue does not touch its usual position for noon. Instead, a ghunnah (nasal sound) is produced for 2 counts while the mouth prepares for the next letter.

The degree of hiding varies based on the letter - letters closer to noon's articulation point have stronger hiding.''',
      examples: [
        TajweedExample(
          arabicText: 'مِنْ قَبْلِ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 25,
          explanation: 'The noon sakinah before "ق" (qaf) - ikhfa is applied with ghunnah.',
          highlightedWord: 'مِنْ قَبْلِ',
        ),
        TajweedExample(
          arabicText: 'أَنْتُمْ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 85,
          explanation: 'The noon sakinah before "ت" (ta) - the noon is hidden with nasal sound.',
          highlightedWord: 'أَنْتُمْ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'How many letters trigger ikhfa?',
          options: ['6', '10', '15', '20'],
          correctIndex: 2,
          explanation: 'There are 15 letters that trigger ikhfa when they come after noon sakinah or tanween.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'During ikhfa, the noon is completely silent.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'False! During ikhfa, the noon is partially hidden - a ghunnah is still produced.',
        ),
      ],
    ),

    TajweedLesson(
      id: 10,
      level: TajweedLevel.intermediate,
      orderInLevel: 2,
      titleArabic: 'الإخفاء الشفوي',
      titleEnglish: 'Ikhfa Shafawi',
      description: 'The oral hiding of meem sakinah before the letter ba.',
      theory: '''Ikhfa Shafawi (إخفاء شفوي) means "oral/lip hiding." It occurs when meem sakinah (مْ) is followed by the letter ba (ب).

Rule: When مْ comes before ب, the meem is partially hidden with a ghunnah (nasal sound) for 2 counts. The lips come close together but don't fully close.

This is called "shafawi" (oral/lip) because both meem and ba are produced from the lips.

Note: This is the only case where meem sakinah is hidden. In all other cases, meem sakinah is either:
• Merged (idgham shafawi) when followed by another meem
• Pronounced clearly (ith-har shafawi) when followed by any other letter''',
      examples: [
        TajweedExample(
          arabicText: 'تَرْمِيهِم بِحِجَارَةٍ',
          surahName: 'Al-Fil',
          surahNumber: 105,
          ayahNumber: 4,
          explanation: 'The meem sakinah in "تَرْمِيهِم" before "بِ" - ikhfa shafawi with ghunnah.',
          highlightedWord: 'هِم بِ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Ikhfa Shafawi occurs when meem sakinah is before:',
          options: ['Any letter', 'Noon', 'Ba', 'Laam'],
          correctIndex: 2,
          explanation: 'Ikhfa Shafawi only occurs when meem sakinah (مْ) is followed by ba (ب).',
        ),
      ],
    ),

    TajweedLesson(
      id: 11,
      level: TajweedLevel.intermediate,
      orderInLevel: 3,
      titleArabic: 'الإدغام بغنة',
      titleEnglish: 'Idgham with Ghunnah',
      description: 'Merging noon sakinah into specific letters with nasal sound.',
      theory: '''Idgham (إدغام) means "merging" or "assimilation." Idgham with Ghunnah occurs when noon sakinah or tanween is followed by one of these 4 letters: ي ن م و
Memory aid: These letters form the word "يَنْمُو" (yanmu - to grow).

How it works: The noon sakinah is completely merged into the following letter, and a ghunnah (nasal sound) is produced for 2 counts.

Important conditions:
• The noon and the following letter must be in separate words
• If they are in the same word, it becomes ith-har (clear pronunciation) instead
• Exception: The word "دُنْيَا" - the noon is pronounced clearly despite ya following it

Examples of non-application: "بُنْيَانٌ" - noon and ya are in the same word, so no idgham.''',
      examples: [
        TajweedExample(
          arabicText: 'مِن يَقُولُ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 8,
          explanation: 'Noon sakinah before ya - idgham with ghunnah: the noon merges into ya with nasal sound.',
          highlightedWord: 'مِن يَ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which letters trigger Idgham with Ghunnah?',
          options: ['ق ط ب ج د', 'أ هـ ع ح غ خ', 'ي ن م و', 'ر ل'],
          correctIndex: 2,
          explanation: 'The letters ي ن م و trigger Idgham with Ghunnah (remembered as يَنْمُو).',
        ),
      ],
    ),

    TajweedLesson(
      id: 12,
      level: TajweedLevel.intermediate,
      orderInLevel: 4,
      titleArabic: 'الإدغام بلا غنة',
      titleEnglish: 'Idgham without Ghunnah',
      description: 'Merging noon sakinah into laam and ra without nasal sound.',
      theory: '''Idgham without Ghunnah occurs when noon sakinah or tanween is followed by either ل (laam) or ر (ra).

How it works: The noon is completely merged into the following letter WITHOUT any nasal sound. The following letter is doubled.

Key difference from Idgham with Ghunnah: NO nasal sound is produced. The merger is complete and clean.

Examples:
• "مِن رَّبِّهِمْ" - the noon merges completely into ra
• "مِن لَّدُنْهُ" - the noon merges completely into laam

Same condition: The noon and following letter must be in separate words.''',
      examples: [
        TajweedExample(
          arabicText: 'مِن رَّبِّهِمْ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 5,
          explanation: 'Noon sakinah before ra - idgham without ghunnah: complete merger with no nasal sound.',
          highlightedWord: 'مِن رَّ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which letters trigger Idgham without Ghunnah?',
          options: ['ي م', 'ل ر', 'ن و', 'ب ت'],
          correctIndex: 1,
          explanation: 'Only laam (ل) and ra (ر) trigger Idgham without Ghunnah.',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'Idgham without Ghunnah produces a nasal sound.',
          options: ['True', 'False'],
          correctIndex: 1,
          explanation: 'False! Unlike Idgham with Ghunnah, there is NO nasal sound produced.',
        ),
      ],
    ),

    TajweedLesson(
      id: 13,
      level: TajweedLevel.intermediate,
      orderInLevel: 5,
      titleArabic: 'الإدغام الشفوي',
      titleEnglish: 'Idgham Shafawi',
      description: 'Merging meem sakinah into another meem.',
      theory: '''Idgham Shafawi (إدغام شفوي) occurs when meem sakinah (مْ) is followed by another meem (م).

Rule: The two meems merge into one meem with shaddah, and a ghunnah (nasal sound) is produced for 2 counts.

This is called "shafawi" (oral/lip) because meem is a labial letter produced from the lips.

It is the simplest of the meem sakinah rules - just merge the two meems together with a nasal sound.''',
      examples: [
        TajweedExample(
          arabicText: 'لَهُم مَّا يَشَاءُونَ',
          surahName: 'An-Nahl',
          surahNumber: 16,
          ayahNumber: 31,
          explanation: 'Meem sakinah followed by meem - they merge into one prolonged meem with ghunnah.',
          highlightedWord: 'لَهُم مَّ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Idgham Shafawi occurs when meem sakinah is followed by:',
          options: ['Ba', 'Noon', 'Another meem', 'Any letter'],
          correctIndex: 2,
          explanation: 'Idgham Shafawi occurs when meem sakinah is followed by another meem.',
        ),
      ],
    ),

    TajweedLesson(
      id: 14,
      level: TajweedLevel.intermediate,
      orderInLevel: 6,
      titleArabic: 'إدغام المتجانسين',
      titleEnglish: 'Idgham Mutajanisayn',
      description: 'Merging letters from the same articulation point.',
      theory: '''Idgham Al-Mutajanisayn (إدغام المتجانسين) means "merging of similar letters." It occurs when two letters share the same articulation point but have different characteristics.

Common pairs:
1. ت + د or ت + ط → The first letter merges into the second
   Example: "أُجِيبَتْ دَعْوَتُكُمَا" - the ta merges into dal
2. ذ + ظ → The dhal merges into dha
   Example: "إِذْ ظَلَمُوا" - the dhal merges into dha
3. ب + م → The ba merges into meem
   Example: "ٱرْكَب مَعَنَا" - the ba merges into meem

The key principle: Letters from the same articulation point can smoothly merge because the mouth is already in the right position.''',
      examples: [
        TajweedExample(
          arabicText: 'قَد تَّبَيَّنَ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 256,
          explanation: 'The dal (د) merges into ta (ت) because they share the same articulation point.',
          highlightedWord: 'قَد تَّ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What characterizes Idgham Mutajanisayn?',
          options: ['Same letter repeating', 'Same articulation point, different characteristics', 'Letters from different origins', 'Only noon and meem'],
          correctIndex: 1,
          explanation: 'Idgham Mutajanisayn involves letters that share the same articulation point but differ in characteristics.',
        ),
      ],
    ),

    TajweedLesson(
      id: 15,
      level: TajweedLevel.intermediate,
      orderInLevel: 7,
      titleArabic: 'إدغام المتقاربين',
      titleEnglish: 'Idgham Mutaqaribayn',
      description: 'Merging letters from close articulation points.',
      theory: '''Idgham Al-Mutaqaribayn (إدغام المتقاربين) means "merging of close letters." It occurs when two letters have close (but not identical) articulation points.

The most common case in the Quran:
• لَ + ر → The laam merges into ra
  Example: "قُل رَّبِّ" - the laam merges into ra

Other cases are less common and mostly occur with:
• ق + ك → Qaf merging into kaf (rare)
• Some scholars consider ن + ر and ن + ل as mutaqaribayn rather than specific noon rules

The general principle: When two close letters appear consecutively with the first having sukoon, they merge for smoother recitation.''',
      examples: [
        TajweedExample(
          arabicText: 'قُل رَّبِّ',
          surahName: 'Al-Mu\'minun',
          surahNumber: 23,
          ayahNumber: 97,
          explanation: 'The laam merges into ra because they come from close articulation points.',
          highlightedWord: 'قُل رَّ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'The most common Idgham Mutaqaribayn in the Quran involves:',
          options: ['Noon and meem', 'Laam and ra', 'Ba and meem', 'Ta and dal'],
          correctIndex: 1,
          explanation: 'The most frequent case of Idgham Mutaqaribayn is laam merging into ra.',
        ),
      ],
    ),

    TajweedLesson(
      id: 16,
      level: TajweedLevel.intermediate,
      orderInLevel: 8,
      titleArabic: 'الإقلاب',
      titleEnglish: 'Iqlab',
      description: 'Converting noon sakinah to meem before the letter ba.',
      theory: '''Iqlab (إقلاب) means "conversion" or "flipping." It occurs when noon sakinah (نْ) or tanween is followed by the letter ba (ب).

Rule: The noon is converted to a meem sound, and a ghunnah (nasal sound) is held for 2 counts. The lips close slightly as if pronouncing meem.

This is the simplest noon sakinah rule because it only involves one letter (ba).

Steps:
1. See noon sakinah or tanween before ba
2. Convert the noon sound to meem
3. Hold the ghunnah for 2 counts
4. Then pronounce the ba

In the mushaf, iqlab is often indicated by a small meem (مـ) above the noon.''',
      examples: [
        TajweedExample(
          arabicText: 'مِن بَعْدِ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 27,
          explanation: 'Noon sakinah before ba - the noon is converted to meem: pronounced as "mim ba\'di" with ghunnah.',
          highlightedWord: 'مِن بَ',
        ),
        TajweedExample(
          arabicText: 'سَمِيعٌ بَصِيرٌ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 127,
          explanation: 'Tanween before ba - the tanween on "سَمِيعٌ" is converted to meem before "بَصِيرٌ".',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What does Iqlab mean?',
          options: ['Hiding', 'Merging', 'Conversion', 'Elongation'],
          correctIndex: 2,
          explanation: 'Iqlab means conversion - the noon sound is converted to meem.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Iqlab occurs before which letter?',
          options: ['Meem', 'Ba', 'Laam', 'Ra'],
          correctIndex: 1,
          explanation: 'Iqlab only occurs when noon sakinah or tanween is followed by ba (ب).',
        ),
        QuizQuestion(
          type: QuizType.trueFalse,
          question: 'During Iqlab, the noon sound changes to a meem sound.',
          options: ['True', 'False'],
          correctIndex: 0,
          explanation: 'Correct! The noon is converted to a meem sound with ghunnah before the ba.',
        ),
      ],
    ),

    // ─── ADVANCED (8 lessons) ───

    TajweedLesson(
      id: 17,
      level: TajweedLevel.advanced,
      orderInLevel: 1,
      titleArabic: 'المد الجائز المنفصل',
      titleEnglish: 'Permissible Madd (Munfasil)',
      description: 'The optional elongation when a madd letter is followed by hamza in the next word.',
      theory: '''Madd Munfasil (المد المنفصل) - "Separated Madd" occurs when a madd letter at the end of a word is followed by a hamza at the start of the next word.

Duration: 2, 4, or 5 counts (depending on the recitation style/riwayah)
In Hafs 'an Asim: Typically 4-5 counts

It is called "permissible" (جائز) because there is flexibility in its length, and "separated" (منفصل) because the madd letter and hamza are in separate words.

Examples:
• "بِمَا أُنْزِلَ" - alif at end of "بِمَا" + hamza at start of "أُنْزِلَ"
• "فِي أَنْفُسِكُمْ" - ya at end of "فِي" + hamza at start of "أَنْفُسِكُمْ"''',
      examples: [
        TajweedExample(
          arabicText: 'بِمَا أُنْزِلَ إِلَيْكَ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 4,
          explanation: 'The alif in "بِمَا" before the hamza in "أُنْزِلَ" creates a separated madd (4-5 counts).',
          highlightedWord: 'بِمَا أُ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Madd Munfasil occurs when a madd letter and hamza are:',
          options: ['In the same word', 'In separate words', 'At the end of an ayah', 'Before sukoon'],
          correctIndex: 1,
          explanation: 'Munfasil means "separated" - the madd letter and hamza are in different words.',
        ),
      ],
    ),

    TajweedLesson(
      id: 18,
      level: TajweedLevel.advanced,
      orderInLevel: 2,
      titleArabic: 'المد الواجب المتصل',
      titleEnglish: 'Obligatory Madd (Muttasil)',
      description: 'The required elongation when madd letter and hamza are in the same word.',
      theory: '''Madd Muttasil (المد المتصل) - "Connected Madd" occurs when a madd letter is followed by a hamza within the same word.

Duration: 4-5 counts (obligatory - must be elongated)
It is called "obligatory" (واجب) because it must be stretched longer than natural madd, and "connected" (متصل) because the madd letter and hamza are in the same word.

This madd is stronger than Madd Munfasil because the connection within one word makes it mandatory.

Examples:
• "جَاءَ" (jaa-a) - alif followed by hamza in same word
• "سُوءُ" (soo-u) - waw followed by hamza in same word
• "جِيءَ" (jee-a) - ya followed by hamza in same word''',
      examples: [
        TajweedExample(
          arabicText: 'إِذَا جَاءَ نَصْرُ ٱللَّهِ',
          surahName: 'An-Nasr',
          surahNumber: 110,
          ayahNumber: 1,
          explanation: 'The alif in "جَاءَ" before the hamza - connected madd, must be stretched 4-5 counts.',
          highlightedWord: 'جَاءَ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What makes Madd Muttasil obligatory?',
          options: ['The madd letter and hamza are in the same word', 'It comes at the end of an ayah', 'It follows a sukoon', 'It comes before a stop'],
          correctIndex: 0,
          explanation: 'Madd Muttasil is obligatory because the madd letter and hamza are connected within the same word.',
        ),
      ],
    ),

    TajweedLesson(
      id: 19,
      level: TajweedLevel.advanced,
      orderInLevel: 3,
      titleArabic: 'المد اللازم',
      titleEnglish: 'Necessary Madd',
      description: 'The maximum elongation when madd letter is followed by sukoon or shaddah.',
      theory: '''Madd Lazim (المد اللازم) - "Necessary Madd" occurs when a madd letter is followed by a sukoon or shaddah in the same word. This is the longest madd.

Duration: Always 6 counts (mandatory)

Types:
1. Kalimi Muthaqqal (كلمي مثقل): Madd letter + shaddah in a word
   Example: "الضَّالِّينَ" - alif + laam with shaddah
2. Kalimi Mukhaffaf (كلمي مخفف): Madd letter + sukoon in a word
   Example: "ءَالْـَٰنَ" - extremely rare
3. Harfi Muthaqqal: In disconnected letters at the start of surahs
   Example: "الم" - the laam is spelled "لام" with a 6-count madd
4. Harfi Mukhaffaf: In disconnected letters with lighter pronunciation

The disconnected letters (الحروف المقطعة): ن ق ص ع س ل ك م all have Madd Lazim when spelled out.''',
      examples: [
        TajweedExample(
          arabicText: 'وَلَا ٱلضَّالِّينَ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 7,
          explanation: 'The alif before the laam with shaddah in "ٱلضَّالِّينَ" - Madd Lazim held for 6 counts.',
          highlightedWord: 'ٱلضَّالِّينَ',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'How long is Madd Lazim held?',
          options: ['2 counts', '4 counts', '5 counts', '6 counts'],
          correctIndex: 3,
          explanation: 'Madd Lazim is always held for 6 counts - the longest madd.',
        ),
      ],
    ),

    TajweedLesson(
      id: 20,
      level: TajweedLevel.advanced,
      orderInLevel: 4,
      titleArabic: 'التفخيم والترقيق',
      titleEnglish: 'Tafkheem & Tarqeeq',
      description: 'Heavy (thick) vs. light (thin) pronunciation of letters.',
      theory: '''Tafkheem (تفخيم) means making a letter heavy/thick, and Tarqeeq (ترقيق) means making it light/thin.

Always Heavy (مستعلية) - 7 letters: خ ص ض غ ط ق ظ
Memory aid: "خُصَّ ضَغْطٍ قِظْ"
These letters are ALWAYS pronounced with tafkheem regardless of their vowel.

Always Light: Most other Arabic letters are always pronounced light.

Special cases:
• Ra (ر): Can be heavy or light depending on context
  - Heavy: When it has fathah, dammah, or sukoon after fathah/dammah
  - Light: When it has kasrah, or sukoon after kasrah
• Laam in "Allah" (لله):
  - Heavy (tafkheem): After fathah or dammah - "قَالَ ٱللَّهُ"
  - Light (tarqeeq): After kasrah - "بِسْمِ ٱللَّهِ"
• Alif: Takes the quality of the letter before it''',
      examples: [
        TajweedExample(
          arabicText: 'قُلْ هُوَ ٱللَّهُ أَحَدٌ',
          surahName: 'Al-Ikhlas',
          surahNumber: 112,
          ayahNumber: 1,
          explanation: 'The qaf (ق) in "قُلْ" is always heavy. The laam in "ٱللَّهُ" is heavy here because it follows a dammah.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'How many letters are always pronounced with tafkheem?',
          options: ['3', '5', '7', '14'],
          correctIndex: 2,
          explanation: 'There are 7 always-heavy letters: خ ص ض غ ط ق ظ',
        ),
      ],
    ),

    TajweedLesson(
      id: 21,
      level: TajweedLevel.advanced,
      orderInLevel: 5,
      titleArabic: 'الوقف',
      titleEnglish: 'Waqf (Stopping Rules)',
      description: 'Learn where and how to stop during Quran recitation.',
      theory: '''Waqf (وقف) means "stopping" - the rules for pausing during Quran recitation. Proper stopping is crucial to preserve meaning.

Types of stops:
1. Waqf Lazim (وقف لازم) - Obligatory stop (marked مـ): Must stop here to preserve meaning
2. Waqf Ja'iz (وقف جائز) - Permissible stop (marked ج): May stop or continue
3. Waqf Mamnoo' (وقف ممنوع) - Forbidden stop (marked لا): Must not stop here
4. Waqf Mu'anaqah (وقف معانقة) - Linked stops (marked ∴): Stop at one but not both

How to stop:
• Replace the last vowel with sukoon
• If the word ends with ta marbuta (ة), pronounce it as ha (هـ)
• If stopping on tanween: fathah tanween becomes alif, others drop

End-of-verse stops are always permissible regardless of marks.''',
      examples: [
        TajweedExample(
          arabicText: 'ذَٰلِكَ ٱلْكِتَابُ لَا رَيْبَ فِيهِ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 2,
          explanation: 'Where you stop changes meaning: stopping after "فِيهِ" vs "لَا رَيْبَ" changes the interpretation.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What does the symbol "مـ" indicate?',
          options: ['Continue reading', 'Obligatory stop', 'Forbidden stop', 'Optional stop'],
          correctIndex: 1,
          explanation: 'The symbol "مـ" indicates an obligatory stop (وقف لازم).',
        ),
      ],
    ),

    TajweedLesson(
      id: 22,
      level: TajweedLevel.advanced,
      orderInLevel: 6,
      titleArabic: 'الابتداء',
      titleEnglish: 'Ibtida (Starting Rules)',
      description: 'Rules for beginning recitation from a specific point.',
      theory: '''Ibtida' (ابتداء) means "beginning" - the rules for starting recitation from a specific point in the Quran.

Key principles:
1. Start from a meaningful point - never start in the middle of a phrase that distorts meaning
2. Always begin with "أعوذ بالله من الشيطان الرجيم" when starting a new session
3. Recite Bismillah at the start of every surah except At-Tawbah (Surah 9)

Starting rules:
• If starting at the beginning of a verse: Start normally
• If starting mid-verse: Ensure the starting point makes complete sense
• Hamzat Al-Wasl: When starting from a word with hamzat al-wasl, pronounce the hamza with the appropriate vowel
• Never start from a point that contradicts the intended meaning (e.g., starting from "لا إله" without "إلا الله")

Between two surahs (in sequence):
1. Bismillah + start: Most common
2. Stop + Bismillah + start: Also acceptable
3. Connect last ayah to Bismillah to next surah: Acceptable
4. Connect last ayah directly to next surah (no Bismillah): NOT permissible (except for Surah 8 → 9)''',
      examples: [
        TajweedExample(
          arabicText: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 1,
          explanation: 'The Bismillah is recited when beginning any surah except At-Tawbah.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which surah does NOT start with Bismillah?',
          options: ['Al-Fatihah', 'Al-Baqarah', 'At-Tawbah', 'Ya-Sin'],
          correctIndex: 2,
          explanation: 'Surah At-Tawbah (Surah 9) is the only surah that does not start with Bismillah.',
        ),
      ],
    ),

    TajweedLesson(
      id: 23,
      level: TajweedLevel.advanced,
      orderInLevel: 7,
      titleArabic: 'أحكام الغنة المتقدمة',
      titleEnglish: 'Advanced Ghunnah Precision',
      description: 'Fine-tune your ghunnah pronunciation across all contexts.',
      theory: '''This lesson focuses on mastering the subtle differences in ghunnah across its various contexts.

Levels of Ghunnah (from strongest to lightest):
1. Shaddah (strongest): نّ or مّ - Full ghunnah, 2 counts
2. Idgham: When noon merges into ي ن م و - Strong ghunnah, 2 counts
3. Ikhfa: When noon is hidden before 15 letters - Medium ghunnah, 2 counts
4. Iqlab: When noon becomes meem before ba - Medium ghunnah, 2 counts
5. Ith-har (lightest): No ghunnah - noon pronounced clearly

Within Ikhfa, the intensity varies:
• Strongest: Before ط ت د (closest to noon's articulation point)
• Medium: Before ث ذ ز ض ظ ج ش ص
• Lightest: Before ق ك ف (furthest from noon's articulation point)

Practice: Recite Surah Al-Baqarah verses 1-5, identifying and correctly applying each ghunnah level.''',
      examples: [
        TajweedExample(
          arabicText: 'ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ',
          surahName: 'Al-Baqarah',
          surahNumber: 2,
          ayahNumber: 3,
          explanation: 'Multiple ghunnah contexts: the noon in "يُؤْمِنُونَ بِ" has ikhfa before ba (actually this is iqlab).',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which ghunnah context is the STRONGEST?',
          options: ['Ikhfa', 'Iqlab', 'Noon/Meem with Shaddah', 'Idgham'],
          correctIndex: 2,
          explanation: 'Ghunnah with shaddah (نّ or مّ) produces the strongest nasal resonance.',
        ),
      ],
    ),

    TajweedLesson(
      id: 24,
      level: TajweedLevel.advanced,
      orderInLevel: 8,
      titleArabic: 'المراجعة الشاملة',
      titleEnglish: 'Comprehensive Review',
      description: 'Final review of all tajweed rules with comprehensive practice.',
      theory: '''Congratulations! You have completed all 24 lessons of the Tajweed Course!

Summary of all rules covered:

BEGINNER:
1. Introduction to Tajweed - Makharij, Sifaat, Ahkam
2. Hamzat Al-Wasl - Connecting hamza
3. Laam Shamsiyyah/Qamariyyah - Sun and moon letters
4. Silent Letters - Sukoon
5. Qalqalah - Bouncing on ق ط ب ج د
6. Ghunnah - Nasal sound with noon/meem
7. Natural Madd - Basic elongation (2 counts)

INTERMEDIATE:
8. Ikhfa - Hiding noon before 15 letters
9. Ikhfa Shafawi - Hiding meem before ba
10. Idgham with Ghunnah - Merging into ي ن م و
11. Idgham without Ghunnah - Merging into ل ر
12. Idgham Shafawi - Merging meem into meem
13. Idgham Mutajanisayn - Same articulation point
14. Idgham Mutaqaribayn - Close articulation points
15. Iqlab - Converting noon to meem before ba

ADVANCED:
16. Madd Munfasil - Separated madd (4-5 counts)
17. Madd Muttasil - Connected madd (4-5 counts)
18. Madd Lazim - Necessary madd (6 counts)
19. Tafkheem/Tarqeeq - Heavy vs light letters
20. Waqf - Stopping rules
21. Ibtida' - Starting rules
22. Advanced Ghunnah - Precision across contexts

May Allah accept your efforts and grant you beautiful recitation of His Book. 🤲''',
      examples: [
        TajweedExample(
          arabicText: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
          surahName: 'Al-Fatihah',
          surahNumber: 1,
          ayahNumber: 1,
          explanation: 'Apply all your tajweed knowledge to recite Surah Al-Fatihah perfectly.',
        ),
      ],
      quizQuestions: [
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'What is the longest madd in tajweed?',
          options: ['Natural Madd (2 counts)', 'Madd Munfasil (4-5 counts)', 'Madd Muttasil (4-5 counts)', 'Madd Lazim (6 counts)'],
          correctIndex: 3,
          explanation: 'Madd Lazim is the longest at 6 counts.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'How many noon sakinah rules are there in total?',
          options: ['2', '3', '4', '5'],
          correctIndex: 2,
          explanation: 'There are 4 noon sakinah rules: Ith-har, Idgham, Ikhfa, and Iqlab.',
        ),
        QuizQuestion(
          type: QuizType.multipleChoice,
          question: 'Which rule converts noon to meem?',
          options: ['Ikhfa', 'Idgham', 'Iqlab', 'Ith-har'],
          correctIndex: 2,
          explanation: 'Iqlab converts the noon sound to meem when followed by ba.',
        ),
      ],
    ),
  ];

  /// Get lessons for a specific level.
  static List<TajweedLesson> getLessonsForLevel(TajweedLevel level) {
    return allLessons.where((l) => l.level == level).toList();
  }

  /// Get a lesson by ID.
  static TajweedLesson? getLessonById(int id) {
    try {
      return allLessons.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Total number of lessons per level.
  static const int lessonsPerLevel = 8;

  /// Total number of levels.
  static const int totalLevels = 3;
}
