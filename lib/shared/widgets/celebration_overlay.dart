import 'dart:math';
import 'package:flutter/material.dart';

/// A sparkle/confetti celebration animation.
///
/// Call `CelebrationOverlay.show(context)` to trigger a brief celebration
/// that auto-dismisses after 1.5 seconds. Uses CustomPainter for particles.
class CelebrationOverlay {
  static void show(BuildContext context, {Color? color}) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _CelebrationAnimation(
        color: color ?? Theme.of(context).colorScheme.primary,
        onComplete: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _CelebrationAnimation extends StatefulWidget {
  final Color color;
  final VoidCallback onComplete;

  const _CelebrationAnimation({
    required this.color,
    required this.onComplete,
  });

  @override
  State<_CelebrationAnimation> createState() => _CelebrationAnimationState();
}

class _CelebrationAnimationState extends State<_CelebrationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _particles = List.generate(40, (_) => _Particle(_random, widget.color));

    _controller.forward().then((_) {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return IgnorePointer(
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _ParticlePainter(
              particles: _particles,
              progress: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _Particle {
  final double startX; // 0-1 horizontal position
  final double startY; // Starting vertical position (0.3-0.5)
  final double velocityX; // Horizontal spread
  final double velocityY; // Upward velocity
  final double size;
  final Color color;
  final double rotationSpeed;

  _Particle(Random random, Color baseColor)
      : startX = random.nextDouble(),
        startY = 0.3 + random.nextDouble() * 0.2,
        velocityX = (random.nextDouble() - 0.5) * 2.0,
        velocityY = -0.5 - random.nextDouble() * 1.5,
        size = 3 + random.nextDouble() * 6,
        color = _randomColor(random, baseColor),
        rotationSpeed = random.nextDouble() * 4 - 2;

  static Color _randomColor(Random random, Color base) {
    final colors = [
      base,
      Colors.amber,
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.pink,
      Colors.purple,
    ];
    return colors[random.nextInt(colors.length)];
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      // Physics: gravity pulls down over time
      final t = progress;
      final gravity = 2.0;

      final x = size.width * p.startX + p.velocityX * t * size.width * 0.3;
      final y = size.height * p.startY +
          p.velocityY * t * size.height * 0.3 +
          gravity * t * t * size.height * 0.2;

      // Fade out in the last 40%
      final opacity = t > 0.6 ? (1.0 - (t - 0.6) / 0.4) : 1.0;
      if (opacity <= 0) continue;

      final paint = Paint()
        ..color = p.color.withAlpha((opacity * 200).toInt())
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotationSpeed * t * 3.14);

      // Draw small rectangles (confetti-like)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6),
          const Radius.circular(1),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
