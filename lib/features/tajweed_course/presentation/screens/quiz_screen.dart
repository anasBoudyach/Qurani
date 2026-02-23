import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/widgets/celebration_overlay.dart';
import '../../../gamification/data/models/daily_goal.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../../quran/presentation/providers/quran_providers.dart';
import '../../data/models/tajweed_lesson.dart';

/// Interactive quiz screen for a tajweed lesson.
class QuizScreen extends ConsumerStatefulWidget {
  final TajweedLesson lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int _currentIndex = 0;
  int _correctAnswers = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _quizComplete = false;

  List<QuizQuestion> get questions => widget.lesson.quizQuestions;
  QuizQuestion get currentQuestion => questions[_currentIndex];

  int get scorePercent =>
      questions.isEmpty ? 0 : ((_correctAnswers / questions.length) * 100).round();
  bool get passed => scorePercent >= 70;

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == currentQuestion.correctIndex) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      setState(() => _quizComplete = true);
      _saveProgress();
      if (passed) {
        ref.read(gamificationServiceProvider).recordActivity(ActivityType.tajweedLesson);
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) CelebrationOverlay.show(context, color: Colors.amber);
        });
      }
    }
  }

  Future<void> _saveProgress() async {
    final db = ref.read(databaseProvider);
    final existing = await db.getLessonProgress(widget.lesson.id);
    final newScore = scorePercent;

    await db.saveLessonProgress(LessonProgressCompanion(
      lessonId: Value(widget.lesson.id),
      isCompleted: Value(passed || (existing?.isCompleted ?? false)),
      bestQuizScore: Value(
        newScore > (existing?.bestQuizScore ?? 0)
            ? newScore
            : (existing?.bestQuizScore ?? 0),
      ),
      attemptCount: Value((existing?.attemptCount ?? 0) + 1),
      completedAt: passed ? Value(DateTime.now()) : const Value.absent(),
      lastAttemptAt: Value(DateTime.now()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_quizComplete) return _buildResultsScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.lesson.titleEnglish}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / questions.length,
            backgroundColor:
                Theme.of(context).colorScheme.outline.withAlpha(51),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress text
            Text(
              'Question ${_currentIndex + 1} of ${questions.length}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            // Question
            Text(
              currentQuestion.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // Arabic text if present
            if (currentQuestion.arabicText != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentQuestion.arabicText!,
                  style: const TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 24,
                    height: 2.0,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 24),
            // Options
            ...List.generate(currentQuestion.options.length, (index) {
              final isSelected = _selectedAnswer == index;
              final isCorrect = index == currentQuestion.correctIndex;

              Color? cardColor;
              if (_answered) {
                if (isCorrect) {
                  cardColor = Colors.green.withAlpha(26);
                } else if (isSelected && !isCorrect) {
                  cardColor = Colors.red.withAlpha(26);
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => _selectAnswer(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor ??
                          Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _answered
                            ? (isCorrect
                                ? Colors.green
                                : (isSelected ? Colors.red : Colors.transparent))
                            : (isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withAlpha(77)),
                        width: isSelected || (_answered && isCorrect) ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withAlpha(51),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            currentQuestion.options[index],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        if (_answered && isCorrect)
                          const Icon(Icons.check_circle, color: Colors.green),
                        if (_answered && isSelected && !isCorrect)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              );
            }),
            // Explanation
            if (_answered && currentQuestion.explanation != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withAlpha(77),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: 20, color: Theme.of(context).colorScheme.tertiary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        currentQuestion.explanation!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            // Next button
            if (_answered)
              FilledButton(
                onPressed: _nextQuestion,
                child: Text(
                  _currentIndex < questions.length - 1
                      ? 'Next Question'
                      : 'See Results',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Result icon
              Icon(
                passed ? Icons.emoji_events_rounded : Icons.refresh_rounded,
                size: 80,
                color: passed ? Colors.amber : Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                passed ? 'Congratulations!' : 'Keep Practicing!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'You scored $scorePercent%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: passed ? Colors.green : Colors.red,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '$_correctAnswers out of ${questions.length} correct',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                passed
                    ? 'You passed! This lesson is now marked as complete.'
                    : 'You need 70% to pass. Review the lesson and try again.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
              const SizedBox(height: 32),
              // Action buttons
              if (!passed)
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                      _correctAnswers = 0;
                      _selectedAnswer = null;
                      _answered = false;
                      _quizComplete = false;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry Quiz'),
                ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  // Pop back to level overview
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Back to Lessons'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
