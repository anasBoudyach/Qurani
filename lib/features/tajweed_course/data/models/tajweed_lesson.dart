/// Difficulty level of tajweed lessons.
enum TajweedLevel {
  beginner,
  intermediate,
  advanced,
}

/// A single tajweed lesson with theory, examples, and quiz.
class TajweedLesson {
  final int id;
  final TajweedLevel level;
  final int orderInLevel;
  final String titleArabic;
  final String titleEnglish;
  final String description;
  final String theory;
  final List<TajweedExample> examples;
  final List<QuizQuestion> quizQuestions;
  final String? mouthDiagramAsset;
  final String? audioClipUrl;

  const TajweedLesson({
    required this.id,
    required this.level,
    required this.orderInLevel,
    required this.titleArabic,
    required this.titleEnglish,
    required this.description,
    required this.theory,
    this.examples = const [],
    this.quizQuestions = const [],
    this.mouthDiagramAsset,
    this.audioClipUrl,
  });

  String get levelName {
    switch (level) {
      case TajweedLevel.beginner:
        return 'Beginner';
      case TajweedLevel.intermediate:
        return 'Intermediate';
      case TajweedLevel.advanced:
        return 'Advanced';
    }
  }
}

/// A Quranic example demonstrating a tajweed rule.
class TajweedExample {
  final String arabicText;
  final String surahName;
  final int surahNumber;
  final int ayahNumber;
  final String explanation;
  final String? highlightedWord;

  const TajweedExample({
    required this.arabicText,
    required this.surahName,
    required this.surahNumber,
    required this.ayahNumber,
    required this.explanation,
    this.highlightedWord,
  });
}

/// Quiz question types.
enum QuizType {
  identifyRule,    // Tap the word with a specific rule
  multipleChoice,  // Pick the correct answer
  trueFalse,       // True or false statement
  audioIdentify,   // Listen and identify the rule
  fillInBlank,     // Complete the sentence
  matchPairs,      // Match rules to descriptions
}

/// A single quiz question.
class QuizQuestion {
  final QuizType type;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
  final String? audioUrl;
  final String? arabicText;

  const QuizQuestion({
    required this.type,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.explanation,
    this.audioUrl,
    this.arabicText,
  });
}
