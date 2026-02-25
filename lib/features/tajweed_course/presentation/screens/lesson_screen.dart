import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../data/models/tajweed_lesson.dart';
import 'quiz_screen.dart';
import 'recording_screen.dart';

/// Lesson screen with tabbed sections: Theory, Examples, Quiz.
class LessonScreen extends ConsumerWidget {
  final TajweedLesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lesson.titleEnglish, style: const TextStyle(fontSize: 16)),
              Text(
                lesson.titleArabic,
                style: const TextStyle(fontFamily: 'AmiriQuran', fontSize: 14),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context).theoryTab),
              Tab(text: AppLocalizations.of(context).examplesTab),
              Tab(text: AppLocalizations.of(context).quiz),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _TheoryTab(lesson: lesson),
            _ExamplesTab(lesson: lesson),
            _QuizTab(lesson: lesson),
          ],
        ),
      ),
    );
  }
}

class _TheoryTab extends StatelessWidget {
  final TajweedLesson lesson;
  const _TheoryTab({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Lesson header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withAlpha(77),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                lesson.titleArabic,
                style: const TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: 28,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 8),
              Text(
                lesson.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(179),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Theory content
        Text(
          lesson.theory,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
              ),
        ),
      ],
    );
  }
}

class _ExamplesTab extends StatelessWidget {
  final TajweedLesson lesson;
  const _ExamplesTab({required this.lesson});

  @override
  Widget build(BuildContext context) {
    if (lesson.examples.isEmpty) {
      return Center(
        child: Text(
          'No examples available yet',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lesson.examples.length,
      itemBuilder: (context, index) {
        final example = lesson.examples[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Surah reference
                Text(
                  '${example.surahName} ${example.surahNumber}:${example.ayahNumber}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 12),
                // Arabic text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    example.arabicText,
                    style: const TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 26,
                      height: 2.0,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (example.highlightedWord != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_upward_rounded,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        'Focus: ${example.highlightedWord}',
                        style: TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                // Explanation
                Text(
                  example.explanation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 12),
                // Practice button
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecordingScreen(
                          lesson: lesson,
                          example: example,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.mic_rounded, size: 18),
                  label: Text(AppLocalizations.of(context).practice),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuizTab extends StatelessWidget {
  final TajweedLesson lesson;
  const _QuizTab({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.quiz_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Ready for the Quiz?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${lesson.quizQuestions.length} questions\nScore 70% or higher to pass',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(153),
                  ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: lesson.quizQuestions.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(lesson: lesson),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(AppLocalizations.of(context).startQuiz),
            ),
          ],
        ),
      ),
    );
  }
}
