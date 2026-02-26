import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Reusable gradient header with optional mosque silhouette overlay.
///
/// Used across dashboard, azkar, prayer times, du'as, ahkam, ahadith screens.
/// Renders a gradient container with rounded bottom corners, optional
/// decorative mosque silhouette via [CustomPainter], and content overlay.
class GradientHeader extends StatelessWidget {
  final List<Color> gradient;
  final double? height;
  final Widget? child;
  final bool showMosque;
  final EdgeInsets padding;

  /// Scroll offset for parallax effect. When provided, mosque and
  /// decorative circles translate at different speeds for depth.
  final double scrollOffset;

  const GradientHeader({
    super.key,
    required this.gradient,
    this.height,
    this.child,
    this.showMosque = false,
    this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 24),
    this.scrollOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        child: Stack(
          children: [
            if (showMosque)
              Positioned(
                right: -20,
                bottom: -10 + scrollOffset * 0.3,
                child: CustomPaint(
                  size: const Size(180, 140),
                  painter: _MosqueSilhouettePainter(
                    color: Colors.white.withAlpha(18),
                  ),
                ),
              ),
            // Decorative circles with parallax
            Positioned(
              left: -30,
              top: -30 + scrollOffset * 0.5,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(13),
                ),
              ),
            ),
            Positioned(
              right: -15,
              top: 20 + scrollOffset * 0.4,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(10),
                ),
              ),
            ),
            if (child != null)
              Padding(
                padding: padding,
                child: child,
              ),
          ],
        ),
      ),
    );
  }
}

/// Paints a simplified mosque silhouette.
class _MosqueSilhouettePainter extends CustomPainter {
  final Color color;

  _MosqueSilhouettePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Main dome
    final domePath = Path();
    domePath.moveTo(w * 0.25, h * 0.55);
    domePath.quadraticBezierTo(w * 0.5, h * 0.05, w * 0.75, h * 0.55);
    domePath.lineTo(w * 0.75, h);
    domePath.lineTo(w * 0.25, h);
    domePath.close();
    canvas.drawPath(domePath, paint);

    // Central minaret
    final minaretRect = Rect.fromLTWH(w * 0.46, h * 0.0, w * 0.08, h * 0.55);
    canvas.drawRect(minaretRect, paint);

    // Minaret top (crescent ball)
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.0),
      w * 0.03,
      paint,
    );

    // Left minaret
    final leftMinaret = Rect.fromLTWH(w * 0.12, h * 0.25, w * 0.06, h * 0.75);
    canvas.drawRect(leftMinaret, paint);
    // Left minaret cap
    canvas.drawArc(
      Rect.fromLTWH(w * 0.10, h * 0.18, w * 0.10, h * 0.14),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Right minaret
    final rightMinaret = Rect.fromLTWH(w * 0.82, h * 0.25, w * 0.06, h * 0.75);
    canvas.drawRect(rightMinaret, paint);
    // Right minaret cap
    canvas.drawArc(
      Rect.fromLTWH(w * 0.80, h * 0.18, w * 0.10, h * 0.14),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Base rectangle
    canvas.drawRect(
      Rect.fromLTWH(w * 0.15, h * 0.55, w * 0.70, h * 0.45),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _MosqueSilhouettePainter oldDelegate) =>
      color != oldDelegate.color;
}
