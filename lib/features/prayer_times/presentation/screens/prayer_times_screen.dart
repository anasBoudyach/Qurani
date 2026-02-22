import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Prayer times screen using adhan_dart for offline calculation.
/// Calculates prayer times from GPS coordinates — no API needed.
class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  bool _loading = true;
  String? _error;
  String _locationName = '';
  List<_PrayerTime>? _prayers;
  int _nextPrayerIndex = -1;
  String _countdown = '';
  Timer? _countdownTimer;

  // Calculation method (user preference, default: Muslim World League)
  adhan.CalculationParameters _params =
      adhan.CalculationMethodParameters.muslimWorldLeague();

  static const _calcMethodKey = 'prayer_calc_method';

  // Available calculation methods
  static final _methods = <String, adhan.CalculationParameters Function()>{
    'Muslim World League': adhan.CalculationMethodParameters.muslimWorldLeague,
    'Egyptian': adhan.CalculationMethodParameters.egyptian,
    'Karachi': adhan.CalculationMethodParameters.karachi,
    'Umm Al-Qura': adhan.CalculationMethodParameters.ummAlQura,
    'Dubai': adhan.CalculationMethodParameters.dubai,
    'North America (ISNA)': adhan.CalculationMethodParameters.northAmerica,
    'Kuwait': adhan.CalculationMethodParameters.kuwait,
    'Qatar': adhan.CalculationMethodParameters.qatar,
    'Singapore': adhan.CalculationMethodParameters.singapore,
    'Turkey': adhan.CalculationMethodParameters.turkiye,
    'Tehran': adhan.CalculationMethodParameters.tehran,
    'Morocco': adhan.CalculationMethodParameters.morocco,
  };

  String _selectedMethodName = 'Muslim World League';

  @override
  void initState() {
    super.initState();
    _loadPrefsAndCalculate();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadPrefsAndCalculate() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_calcMethodKey);
    if (saved != null && _methods.containsKey(saved)) {
      _selectedMethodName = saved;
      _params = _methods[saved]!();
    }
    await _calculatePrayerTimes();
  }

  Future<void> _calculatePrayerTimes() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = 'Location services are disabled.\nPlease enable GPS in your device settings.';
          _loading = false;
        });
        return;
      }

      // Check / request permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = 'Location permission denied.\nPrayer times need your location to be accurate.';
            _loading = false;
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _error = 'Location permission permanently denied.\nPlease enable it in app settings.';
          _loading = false;
        });
        return;
      }

      // Get position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      // Save coords for next time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('prayer_lat', position.latitude);
      await prefs.setDouble('prayer_lng', position.longitude);

      _computeFromCoords(position.latitude, position.longitude);
    } catch (e) {
      // Fallback to saved coordinates
      final prefs = await SharedPreferences.getInstance();
      final savedLat = prefs.getDouble('prayer_lat');
      final savedLng = prefs.getDouble('prayer_lng');
      if (savedLat != null && savedLng != null) {
        _computeFromCoords(savedLat, savedLng);
        return;
      }
      setState(() {
        _error = 'Could not get location.\nPlease enable GPS and try again.';
        _loading = false;
      });
    }
  }

  void _computeFromCoords(double lat, double lng) {
    final coordinates = adhan.Coordinates(lat, lng);
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);

    _params.madhab = adhan.Madhab.shafi;

    final prayerTimes = adhan.PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: _params,
    );

    final prayers = [
      _PrayerTime(
        name: 'Fajr',
        nameArabic: 'الفجر',
        time: prayerTimes.fajr.toLocal(),
        icon: Icons.wb_twilight,
      ),
      _PrayerTime(
        name: 'Sunrise',
        nameArabic: 'الشروق',
        time: prayerTimes.sunrise.toLocal(),
        icon: Icons.wb_sunny_outlined,
      ),
      _PrayerTime(
        name: 'Dhuhr',
        nameArabic: 'الظهر',
        time: prayerTimes.dhuhr.toLocal(),
        icon: Icons.wb_sunny,
      ),
      _PrayerTime(
        name: 'Asr',
        nameArabic: 'العصر',
        time: prayerTimes.asr.toLocal(),
        icon: Icons.sunny_snowing,
      ),
      _PrayerTime(
        name: 'Maghrib',
        nameArabic: 'المغرب',
        time: prayerTimes.maghrib.toLocal(),
        icon: Icons.wb_twilight,
      ),
      _PrayerTime(
        name: 'Isha',
        nameArabic: 'العشاء',
        time: prayerTimes.isha.toLocal(),
        icon: Icons.nightlight_round,
      ),
    ];

    // Find next prayer
    int nextIdx = -1;
    for (var i = 0; i < prayers.length; i++) {
      if (prayers[i].time.isAfter(now)) {
        nextIdx = i;
        break;
      }
    }

    // If all prayers passed today, next is tomorrow's Fajr
    if (nextIdx == -1) {
      // Calculate tomorrow's Fajr
      final tomorrow = date.add(const Duration(days: 1));
      final tomorrowPrayers = adhan.PrayerTimes(
        coordinates: coordinates,
        date: tomorrow,
        calculationParameters: _params,
      );
      prayers.add(_PrayerTime(
        name: 'Fajr (tomorrow)',
        nameArabic: 'فجر الغد',
        time: tomorrowPrayers.fajr.toLocal(),
        icon: Icons.wb_twilight,
      ));
      nextIdx = prayers.length - 1;
    }

    _locationName = '${lat.toStringAsFixed(2)}°, ${lng.toStringAsFixed(2)}°';

    setState(() {
      _prayers = prayers;
      _nextPrayerIndex = nextIdx;
      _loading = false;
    });

    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _updateCountdown();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    if (_prayers == null || _nextPrayerIndex < 0) return;
    final now = DateTime.now();
    final next = _prayers![_nextPrayerIndex].time;
    final diff = next.difference(now);

    if (diff.isNegative) {
      // Prayer passed, recalculate
      _countdownTimer?.cancel();
      _loadPrefsAndCalculate();
      return;
    }

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    final seconds = diff.inSeconds % 60;

    if (mounted) {
      setState(() {
        if (hours > 0) {
          _countdown = '${hours}h ${minutes}m ${seconds}s';
        } else if (minutes > 0) {
          _countdown = '${minutes}m ${seconds}s';
        } else {
          _countdown = '${seconds}s';
        }
      });
    }
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = h >= 12 ? 'PM' : 'AM';
    final hour12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$hour12:$m $period';
  }

  void _showMethodPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Calculation Method',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Different regions use different sun angle calculations',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(153),
                  ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: _methods.keys.map((name) {
                  return RadioListTile<String>(
                    value: name,
                    groupValue: _selectedMethodName,
                    title: Text(name),
                    onChanged: (value) async {
                      if (value != null) {
                        Navigator.pop(context);
                        _selectedMethodName = value;
                        _params = _methods[value]!();
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(_calcMethodKey, value);
                        _loadPrefsAndCalculate();
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate_outlined),
            tooltip: 'Calculation method',
            onPressed: _showMethodPicker,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh location',
            onPressed: _calculatePrayerTimes,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _buildContent(),
    );
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
              _error!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _calculatePrayerTimes,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Geolocator.openAppSettings(),
              child: const Text('Open App Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final prayers = _prayers!;
    // Show only 6 main prayers for list (exclude "Fajr (tomorrow)" row if present)
    final mainPrayers = prayers.length > 6 ? prayers.sublist(0, 6) : prayers;
    final nextPrayer = prayers[_nextPrayerIndex];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Next prayer countdown card
        Container(
          padding: const EdgeInsets.all(24),
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
                'Next Prayer',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(179),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                nextPrayer.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatTime(nextPrayer.time),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'in $_countdown',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(204),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Location + method info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withAlpha(128),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on,
                  size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _locationName,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      _selectedMethodName,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(128),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _showMethodPicker,
                child: const Text('Change'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Prayer times list
        ...List.generate(mainPrayers.length, (index) {
          final prayer = mainPrayers[index];
          final isNext = index == _nextPrayerIndex;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isNext
                  ? Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(77)
                  : null,
              borderRadius: BorderRadius.circular(12),
              border: isNext
                  ? Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withAlpha(102))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  prayer.icon,
                  color: isNext
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prayer.name,
                        style: TextStyle(
                          fontWeight:
                              isNext ? FontWeight.bold : FontWeight.normal,
                          color: isNext
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                      Text(
                        prayer.nameArabic,
                        style: TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(128),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatTime(prayer.time),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
                    color: isNext
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _PrayerTime {
  final String name;
  final String nameArabic;
  final DateTime time;
  final IconData icon;

  const _PrayerTime({
    required this.name,
    required this.nameArabic,
    required this.time,
    required this.icon,
  });
}
