import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/l10n/app_localizations.dart';

/// Qibla compass screen.
/// Uses device compass + GPS to calculate direction to Kaaba.
class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  // Kaaba coordinates
  static const _kaabaLat = 21.4225;
  static const _kaabaLng = 39.8262;

  double? _qiblaDirection; // Degrees from north
  double? _compassHeading;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Check location permission
    final locStatus = await Permission.location.request();
    if (!locStatus.isGranted) {
      setState(() {
        _error = 'location_required';
        _loading = false;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
      final qibla = _calculateQibla(position.latitude, position.longitude);
      setState(() {
        _qiblaDirection = qibla;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'location_error';
        _loading = false;
      });
    }

    // Listen to compass
    FlutterCompass.events?.listen((event) {
      if (mounted) {
        setState(() => _compassHeading = event.heading);
      }
    });
  }

  /// Calculate Qibla direction (bearing from user to Kaaba) in degrees.
  double _calculateQibla(double lat, double lng) {
    final latRad = lat * math.pi / 180;
    final lngRad = lng * math.pi / 180;
    final kaabaLatRad = _kaabaLat * math.pi / 180;
    final kaabaLngRad = _kaabaLng * math.pi / 180;

    final dLng = kaabaLngRad - lngRad;
    final y = math.sin(dLng) * math.cos(kaabaLatRad);
    final x = math.cos(latRad) * math.sin(kaabaLatRad) -
        math.sin(latRad) * math.cos(kaabaLatRad) * math.cos(dLng);

    var bearing = math.atan2(y, x) * 180 / math.pi;
    return (bearing + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).qibla)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _buildCompass(),
    );
  }

  String _localizedError(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (_error) {
      case 'location_required':
        return l10n.locationRequired;
      case 'location_error':
        return l10n.locationError;
      default:
        return _error!;
    }
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off,
                size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              _localizedError(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = null;
                });
                _initialize();
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompass() {
    final heading = _compassHeading ?? 0;
    final qibla = _qiblaDirection ?? 0;
    // Rotation: qibla direction relative to where phone is pointing
    final rotation = (qibla - heading) * math.pi / 180;

    return Column(
      children: [
        const SizedBox(height: 40),
        // Direction info
        Text(
          AppLocalizations.of(context).qiblaDirection,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(153),
              ),
        ),
        const SizedBox(height: 4),
        Text(
          '${qibla.toStringAsFixed(1)}° ${AppLocalizations.of(context).fromNorth}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 40),
        // Compass
        Expanded(
          child: Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Compass ring
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withAlpha(51),
                        width: 2,
                      ),
                    ),
                    child: Transform.rotate(
                      angle: -heading * math.pi / 180,
                      child: CustomPaint(
                        painter: _CompassPainter(
                          context: context,
                          primaryColor: Theme.of(context).colorScheme.primary,
                          textColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(153),
                        ),
                      ),
                    ),
                  ),
                  // Qibla arrow
                  Transform.rotate(
                    angle: rotation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.navigation_rounded,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Qibla',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Center Kaaba icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mosque_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Kaaba label
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'الكعبة المشرفة',
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        if (_compassHeading == null)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              AppLocalizations.of(context).compassNotAvailable,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(128),
                  ),
            ),
          ),
      ],
    );
  }
}

class _CompassPainter extends CustomPainter {
  final BuildContext context;
  final Color primaryColor;
  final Color textColor;

  _CompassPainter({
    required this.context,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 16;

    // Draw cardinal direction labels
    final directions = ['N', 'E', 'S', 'W'];
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 - math.pi / 2; // Start from top (N)
      final textOffset = Offset(
        center.dx + radius * math.cos(angle) - 6,
        center.dy + radius * math.sin(angle) - 8,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: directions[i],
          style: TextStyle(
            color: directions[i] == 'N' ? primaryColor : textColor,
            fontSize: directions[i] == 'N' ? 18 : 14,
            fontWeight:
                directions[i] == 'N' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, textOffset);
    }

    // Draw tick marks
    final tickPaint = Paint()
      ..color = textColor
      ..strokeWidth = 1;

    for (var i = 0; i < 36; i++) {
      final angle = i * math.pi / 18 - math.pi / 2;
      final inner = i % 9 == 0 ? radius - 20 : radius - 10;
      final start = Offset(
        center.dx + inner * math.cos(angle),
        center.dy + inner * math.sin(angle),
      );
      final end = Offset(
        center.dx + (radius - 4) * math.cos(angle),
        center.dy + (radius - 4) * math.sin(angle),
      );
      canvas.drawLine(start, end, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
