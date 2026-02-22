import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../audio/presentation/providers/audio_providers.dart';
import '../../data/models/tajweed_lesson.dart';

/// Recording & comparison screen for tajweed practice.
/// Users record themselves reading a Quranic example, then compare
/// side-by-side with the sheikh's audio.
class RecordingScreen extends ConsumerStatefulWidget {
  final TajweedLesson lesson;
  final TajweedExample example;

  const RecordingScreen({
    super.key,
    required this.lesson,
    required this.example,
  });

  @override
  ConsumerState<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  // Recording
  late RecorderController _recorderController;
  bool _isRecording = false;
  bool _hasRecording = false;
  String? _recordingPath;

  // Playback
  late PlayerController _userPlayerController;
  bool _isPlayingUser = false;

  // Sheikh audio (reuses shared player — just_audio_background allows only one)
  late final AudioPlayer _sheikhPlayer;
  bool _isPlayingSheikh = false;

  // Self-assessment
  int _selfRating = 0;
  bool _showAssessment = false;

  @override
  void initState() {
    super.initState();
    _sheikhPlayer = ref.read(audioPlayerServiceProvider).player;
    _recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..sampleRate = 44100;
    _userPlayerController = PlayerController();
  }

  @override
  void dispose() {
    _recorderController.dispose();
    _userPlayerController.dispose();
    // Don't dispose _sheikhPlayer — it's the shared AudioPlayerService player
    // Clean up recording file
    if (_recordingPath != null) {
      File(_recordingPath!).delete().ignore();
    }
    super.dispose();
  }

  Future<bool> _requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) return true;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required to record.'),
        ),
      );
    }
    return false;
  }

  Future<void> _startRecording() async {
    if (!await _requestMicPermission()) return;

    final dir = await getTemporaryDirectory();
    _recordingPath =
        '${dir.path}/tajweed_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorderController.record(path: _recordingPath!);
    setState(() {
      _isRecording = true;
      _hasRecording = false;
      _showAssessment = false;
      _selfRating = 0;
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorderController.stop();
    if (path != null) {
      _recordingPath = path;
      await _userPlayerController.preparePlayer(
        path: _recordingPath!,
        shouldExtractWaveform: true,
        noOfSamples: 100,
      );
    }
    setState(() {
      _isRecording = false;
      _hasRecording = path != null;
    });
  }

  Future<void> _toggleUserPlayback() async {
    if (_isPlayingUser) {
      await _userPlayerController.pausePlayer();
    } else {
      await _userPlayerController.startPlayer();
    }
    setState(() => _isPlayingUser = !_isPlayingUser);

    // Listen for completion
    _userPlayerController.onCompletion.listen((_) {
      if (mounted) setState(() => _isPlayingUser = false);
    });
  }

  Future<void> _toggleSheikhPlayback() async {
    if (_isPlayingSheikh) {
      await _sheikhPlayer.pause();
      setState(() => _isPlayingSheikh = false);
    } else {
      // Use EveryAyah CDN for verse-level audio (Mishary Alafasy)
      final surahStr = widget.example.surahNumber.toString().padLeft(3, '0');
      final ayahStr = widget.example.ayahNumber.toString().padLeft(3, '0');
      final url =
          'https://everyayah.com/data/Alafasy_128kbps/$surahStr$ayahStr.mp3';

      try {
        await _sheikhPlayer.setUrl(url);
        await _sheikhPlayer.play();
        setState(() => _isPlayingSheikh = true);

        _sheikhPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed && mounted) {
            setState(() => _isPlayingSheikh = false);
          }
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not load sheikh audio: $e')),
          );
        }
      }
    }
  }

  Future<void> _playBothSequential() async {
    // Play sheikh first, then user
    setState(() => _isPlayingSheikh = true);
    final surahStr = widget.example.surahNumber.toString().padLeft(3, '0');
    final ayahStr = widget.example.ayahNumber.toString().padLeft(3, '0');
    final url =
        'https://everyayah.com/data/Alafasy_128kbps/$surahStr$ayahStr.mp3';

    try {
      await _sheikhPlayer.setUrl(url);
      await _sheikhPlayer.play();

      // Wait for sheikh to finish
      await _sheikhPlayer.playerStateStream.firstWhere(
        (state) => state.processingState == ProcessingState.completed,
      );
      if (!mounted) return;
      setState(() => _isPlayingSheikh = false);

      // Small pause between
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      // Play user recording
      setState(() => _isPlayingUser = true);
      await _userPlayerController.startPlayer();
      _userPlayerController.onCompletion.listen((_) {
        if (mounted) {
          setState(() {
            _isPlayingUser = false;
            _showAssessment = true;
          });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isPlayingSheikh = false;
          _isPlayingUser = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Recording'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Ayah to practice
          _buildAyahCard(),
          const SizedBox(height: 24),

          // Sheikh audio section
          _buildSheikhSection(),
          const SizedBox(height: 24),

          // Recording section
          _buildRecordingSection(),

          // Comparison section (after recording)
          if (_hasRecording) ...[
            const SizedBox(height: 24),
            _buildComparisonSection(),
          ],

          // Self-assessment
          if (_showAssessment || (_hasRecording && !_isRecording)) ...[
            const SizedBox(height: 24),
            _buildSelfAssessment(),
          ],
        ],
      ),
    );
  }

  Widget _buildAyahCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withAlpha(179),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            widget.lesson.titleEnglish,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(204),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.example.arabicText,
            style: const TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 28,
              color: Colors.white,
              height: 2.0,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.example.surahName} ${widget.example.surahNumber}:${widget.example.ayahNumber}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withAlpha(179),
            ),
          ),
          if (widget.example.highlightedWord != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Focus: ${widget.example.highlightedWord}',
                style: const TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: 14,
                  color: Colors.white,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSheikhSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(128),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Sheikh Recitation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                'Mishary Alafasy',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Play button
          Center(
            child: FilledButton.tonalIcon(
              onPressed: _toggleSheikhPlayback,
              icon: Icon(
                _isPlayingSheikh ? Icons.pause_rounded : Icons.play_arrow_rounded,
              ),
              label: Text(_isPlayingSheikh ? 'Pause' : 'Listen to Sheikh'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isRecording
            ? Colors.red.withAlpha(20)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isRecording
              ? Colors.red.withAlpha(102)
              : Theme.of(context).colorScheme.outline.withAlpha(51),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.mic_rounded,
                color: _isRecording ? Colors.red : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Your Recording',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _isRecording ? Colors.red : Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Live waveform during recording
          if (_isRecording)
            AudioWaveforms(
              size: Size(MediaQuery.of(context).size.width - 72, 60),
              recorderController: _recorderController,
              enableGesture: false,
              waveStyle: WaveStyle(
                waveColor: Colors.red,
                middleLineColor: Colors.red.withAlpha(128),
                showMiddleLine: true,
                extendWaveform: true,
                showDurationLabel: true,
                durationLinesColor: Colors.red.withAlpha(77),
              ),
            ),
          // Recorded waveform
          if (_hasRecording && !_isRecording)
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width - 72, 60),
              playerController: _userPlayerController,
              enableSeekGesture: true,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: Theme.of(context).colorScheme.primary.withAlpha(102),
                liveWaveColor: Theme.of(context).colorScheme.primary,
                seekLineColor: Theme.of(context).colorScheme.primary,
                showSeekLine: true,
              ),
            ),
          if (!_isRecording && !_hasRecording)
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  'Tap the button below to start recording',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(128),
                      ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          // Record/Stop button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Record button
              GestureDetector(
                onTap: _isRecording ? _stopRecording : _startRecording,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _isRecording ? Colors.red : Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isRecording ? Colors.red : Theme.of(context).colorScheme.primary)
                            .withAlpha(77),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              // Play user recording button
              if (_hasRecording && !_isRecording) ...[
                const SizedBox(width: 20),
                IconButton.filledTonal(
                  onPressed: _toggleUserPlayback,
                  icon: Icon(
                    _isPlayingUser ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  ),
                  iconSize: 28,
                ),
              ],
              // Re-record button
              if (_hasRecording && !_isRecording) ...[
                const SizedBox(width: 12),
                IconButton.outlined(
                  onPressed: _startRecording,
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: 'Re-record',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer.withAlpha(51),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary.withAlpha(77),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.compare_arrows_rounded,
                  color: Theme.of(context).colorScheme.tertiary),
              const SizedBox(width: 8),
              Text(
                'Compare',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Listen to the sheikh, then your recording — back to back.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(153),
                ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _playBothSequential,
            icon: const Icon(Icons.play_circle_outline_rounded),
            label: const Text('Play Comparison'),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 8),
          // Status indicator
          if (_isPlayingSheikh)
            _buildPlayingIndicator('Playing sheikh...', Colors.blue),
          if (_isPlayingUser)
            _buildPlayingIndicator('Playing your recording...', Colors.green),
        ],
      ),
    );
  }

  Widget _buildPlayingIndicator(String label, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: color, fontSize: 13)),
      ],
    );
  }

  Widget _buildSelfAssessment() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(51),
        ),
      ),
      child: Column(
        children: [
          Text(
            'How did you do?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Rate your recitation accuracy',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(153),
                ),
          ),
          const SizedBox(height: 16),
          // Star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              return GestureDetector(
                onTap: () => setState(() => _selfRating = starNumber),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    starNumber <= _selfRating
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    size: 40,
                    color: starNumber <= _selfRating
                        ? Colors.amber
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(102),
                  ),
                ),
              );
            }),
          ),
          if (_selfRating > 0) ...[
            const SizedBox(height: 12),
            Text(
              _ratingLabel(_selfRating),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _hasRecording = false;
                      _showAssessment = false;
                      _selfRating = 0;
                    });
                  },
                  child: const Text('Try Again'),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _ratingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Keep practicing!';
      case 2:
        return 'Getting there!';
      case 3:
        return 'Good effort!';
      case 4:
        return 'Very good!';
      case 5:
        return 'Excellent! Ma sha Allah!';
      default:
        return '';
    }
  }
}

/// Abstract AI analysis service interface for future integration.
/// Currently a no-op stub — will be replaced with real ML model in Phase 2.
abstract class AiAnalysisService {
  Future<TajweedAnalysisResult> analyzeRecording({
    required String audioPath,
    required int surahNumber,
    required int ayahNumber,
    required String expectedRule,
  });
}

class TajweedAnalysisResult {
  final double overallScore;
  final List<String> detectedRules;
  final List<String> missedRules;
  final String feedback;

  const TajweedAnalysisResult({
    required this.overallScore,
    required this.detectedRules,
    required this.missedRules,
    required this.feedback,
  });
}

/// No-op implementation for Phase 1.
class NoOpAiAnalysisService implements AiAnalysisService {
  @override
  Future<TajweedAnalysisResult> analyzeRecording({
    required String audioPath,
    required int surahNumber,
    required int ayahNumber,
    required String expectedRule,
  }) async {
    return const TajweedAnalysisResult(
      overallScore: 0,
      detectedRules: [],
      missedRules: [],
      feedback: 'AI analysis coming soon!',
    );
  }
}
