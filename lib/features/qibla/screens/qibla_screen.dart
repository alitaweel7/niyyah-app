import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_strings.dart';
import '../../../services/location_service.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

/// Live Qibla compass: points toward the Kaaba using the device magnetometer
/// and a great-circle bearing from the user's location.
class QiblaScreen extends ConsumerStatefulWidget {
  const QiblaScreen({super.key});

  @override
  ConsumerState<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends ConsumerState<QiblaScreen> {
  // Kaaba coordinates.
  static const _kaabaLat = 21.4225;
  static const _kaabaLng = 39.8262;

  double? _heading; // magnetic heading, degrees (0 = N, 90 = E)
  StreamSubscription<CompassEvent>? _sub;
  bool _compassAvailable = true;

  @override
  void initState() {
    super.initState();
    final stream = FlutterCompass.events;
    if (stream == null) {
      _compassAvailable = false;
    } else {
      _sub = stream.listen((event) {
        if (mounted) setState(() => _heading = event.heading);
      });
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Great-circle initial bearing from (lat,lng) to the Kaaba, degrees 0-360.
  /// (Uses magnetic heading from the device; small magnetic-declination error
  /// is acceptable for finding the Qibla direction.)
  double _qiblaBearing(double lat, double lng) {
    final phi1 = lat * math.pi / 180;
    final phi2 = _kaabaLat * math.pi / 180;
    final dLambda = (_kaabaLng - lng) * math.pi / 180;
    final y = math.sin(dLambda) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(dLambda);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(userLocationProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('qibla'))),
      body: Stack(
        children: [
          const ParchmentBackground(),
          locationAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _message(context, Icons.location_off_outlined,
                context.tr('qib_location_unavailable'),
                context.tr('qib_enable_location')),
            data: (loc) =>
                _buildCompass(context, loc, _qiblaBearing(loc.latitude, loc.longitude)),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass(BuildContext context, UserLocation loc, double qibla) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;

    if (!_compassAvailable) {
      return _message(context, Icons.explore_off_outlined,
          context.tr('compass_unavailable'), context.tr('qib_no_magnetometer'));
    }
    final heading = _heading;
    if (heading == null) {
      return _message(context, Icons.threesixty, context.tr('calibrating'),
          context.tr('calibrate_hint'));
    }

    final delta = (((qibla - heading) % 360) + 360) % 360;
    final angle = delta * math.pi / 180; // clockwise from top
    final isAligned = delta < 5 || delta > 355;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isAligned
                  ? context.tr('facing_kaaba')
                  : context.tr('turn_to_face'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isAligned ? primary : null,
                  ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer dial
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withValues(alpha: isAligned ? 0.10 : 0.04),
                      border: Border.all(
                        color:
                            primary.withValues(alpha: isAligned ? 0.55 : 0.22),
                        width: isAligned ? 2 : 1.5,
                      ),
                    ),
                  ),
                  // Inner concentric ring for depth
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primary.withValues(alpha: 0.12),
                        width: 1,
                      ),
                    ),
                  ),
                  // Cardinal tick marks
                  CustomPaint(
                    size: const Size(280, 280),
                    painter: _CompassTicksPainter(
                      color: primary.withValues(alpha: 0.25),
                    ),
                  ),
                  // Center hub
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withValues(alpha: 0.7),
                    ),
                  ),
                  // Qibla needle (points to the Kaaba)
                  Transform.rotate(
                    angle: angle,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.navigation, size: 44, color: primary),
                            const SizedBox(height: 2),
                            const Text('🕋', style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Bearing readout
            Text(
              '${qibla.toStringAsFixed(0)}°',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              context.tr('from_north'),
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: mutedColor),
            ),
            const SizedBox(height: 16),
            // Location caption
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.place_outlined, size: 14, color: mutedColor),
                const SizedBox(width: 4),
                Text(
                  loc.isFallback
                      ? context.tr('qib_default_location')
                      : (loc.cityName ?? ''),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: mutedColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _message(
      BuildContext context, IconData icon, String title, String body) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(body,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: mutedColor, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

/// Paints subtle cardinal tick marks (N/E/S/W) around the compass dial.
class _CompassTicksPainter extends CustomPainter {
  const _CompassTicksPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Four cardinal ticks at top/right/bottom/left.
    for (var i = 0; i < 4; i++) {
      final a = i * math.pi / 2 - math.pi / 2; // start at top
      final outer = Offset(
        center.dx + radius * math.cos(a),
        center.dy + radius * math.sin(a),
      );
      final inner = Offset(
        center.dx + (radius - 12) * math.cos(a),
        center.dy + (radius - 12) * math.sin(a),
      );
      canvas.drawLine(inner, outer, paint);
    }
  }

  @override
  bool shouldRepaint(_CompassTicksPainter oldDelegate) =>
      oldDelegate.color != color;
}
