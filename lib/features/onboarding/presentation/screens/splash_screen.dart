import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _pulseController;
  late final AnimationController _rotateController;
  late final AnimationController _particleController;

  // Staggered entrance animations
  late final Animation<double> _iconFade;
  late final Animation<double> _iconScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _taglineFade;
  late final Animation<double> _loaderFade;

  // Continuous animations
  late final Animation<double> _pulse;
  late final Animation<double> _rotate;

  final List<_Particle> _particles = [];
  final _random = Random();

  @override
  void initState() {
    super.initState();

    // Generate sparkle particles
    for (int i = 0; i < 20; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 3 + 1,
        speed: _random.nextDouble() * 0.3 + 0.1,
        opacity: _random.nextDouble() * 0.6 + 0.1,
        delay: _random.nextDouble(),
      ));
    }

    // Main entrance controller (2 seconds)
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Pulse controller (continuous)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Rotate controller (continuous, slow)
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    // Particle controller (continuous)
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // --- Staggered entrance animations ---

    // Icon: 0% - 40% (fade + scale with bounce)
    _iconFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _iconScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    // Arabic title: 20% - 55% (fade + slide up)
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.55, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // English subtitle: 35% - 65% (fade + slide up)
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    // Tagline: 50% - 80%
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    // Loader: 70% - 100%
    _loaderFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    // Pulse (glow effect on circle)
    _pulse = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotate (outer decorative ring)
    _rotate = Tween<double>(begin: 0.0, end: 2 * pi).animate(_rotateController);

    // Start animations
    _mainController.forward();
    _pulseController.repeat(reverse: true);
    _rotateController.repeat();
    _particleController.repeat();

    // Navigate after animations
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFF2E7D32),
              AppColors.primaryGreen,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating golden particles
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, _) => CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleController.value,
                  mainProgress: _mainController.value,
                ),
              ),
            ),

            // Main content
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _mainController,
                  _pulseController,
                  _rotateController,
                ]),
                builder: (context, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Decorative icon with glow and rotating ring
                    _buildIcon(),
                    const SizedBox(height: 36),
                    // Arabic title
                    _buildTitle(),
                    const SizedBox(height: 8),
                    // English subtitle
                    _buildSubtitle(),
                    const SizedBox(height: 28),
                    // Tagline
                    _buildTagline(),
                    const SizedBox(height: 48),
                    // Loading indicator
                    _buildLoader(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final glowOpacity = 0.15 + (_pulse.value * 0.15);

    return Opacity(
      opacity: _iconFade.value,
      child: Transform.scale(
        scale: _iconScale.value,
        child: SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow effect
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryGoldLight.withAlpha(
                        (glowOpacity * 255).round(),
                      ),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
              // Rotating outer ring
              Transform.rotate(
                angle: _rotate.value,
                child: Container(
                  width: 136,
                  height: 136,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withAlpha(40),
                      width: 1,
                    ),
                  ),
                  child: CustomPaint(
                    painter: _DottedCirclePainter(
                      color: AppColors.secondaryGoldLight.withAlpha(100),
                      dotCount: 12,
                      dotRadius: 2,
                    ),
                  ),
                ),
              ),
              // Inner circle with bismillah
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondaryGold.withAlpha(120),
                    width: 1.5,
                  ),
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withAlpha(20),
                      Colors.white.withAlpha(5),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    '﷽',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white.withAlpha(230),
                      fontFamily: 'AmiriQuran',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SlideTransition(
      position: _titleSlide,
      child: Opacity(
        opacity: _titleFade.value,
        child: const Text(
          'قُرآني',
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'AmiriQuran',
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Color(0x40000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return SlideTransition(
      position: _subtitleSlide,
      child: Opacity(
        opacity: _subtitleFade.value,
        child: Text(
          'QURANI',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white.withAlpha(200),
            letterSpacing: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildTagline() {
    return Opacity(
      opacity: _taglineFade.value,
      child: Text(
        'Read  •  Listen  •  Learn  •  Pray',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.secondaryGoldLight.withAlpha(180),
          letterSpacing: 1.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Opacity(
      opacity: _loaderFade.value,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.secondaryGoldLight.withAlpha(120),
          ),
        ),
      ),
    );
  }
}

// Dotted circle painter for the rotating ring
class _DottedCirclePainter extends CustomPainter {
  final Color color;
  final int dotCount;
  final double dotRadius;

  _DottedCirclePainter({
    required this.color,
    required this.dotCount,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * pi * i) / dotCount;
      final dotCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawCircle(dotCenter, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floating particle data
class _Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final double delay;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.delay,
  });
}

// Particle painter for golden sparkles
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final double mainProgress;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.mainProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (mainProgress < 0.3) return; // Don't show particles until icon appears

    final fadeIn = ((mainProgress - 0.3) / 0.3).clamp(0.0, 1.0);

    for (final p in particles) {
      final adjustedProgress = (progress + p.delay) % 1.0;
      final y = (p.y - adjustedProgress * p.speed) % 1.0;
      final twinkle = (sin(adjustedProgress * 2 * pi) + 1) / 2;

      final paint = Paint()
        ..color = Color(0xFFFFD54F).withAlpha(
          (p.opacity * twinkle * fadeIn * 255).round(),
        );

      canvas.drawCircle(
        Offset(p.x * size.width, y * size.height),
        p.size * (0.5 + twinkle * 0.5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
