import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

// ── Helper: resolve pattern color for light/dark mode ──────────────────────

Color _patternColor(BuildContext context, Color? color) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  if (color != null) return color;
  return isDark ? AppColors.oliveLight : AppColors.olive;
}

Color _accentColor(BuildContext context, Color? color) {
  if (color != null) return color;
  return AppColors.beige;
}

// ============================================================================
// (a) IslamicGeometricPattern — 8-pointed star tiling background
// ============================================================================

/// A tiling background based on Islamic 8-pointed star geometry with double
/// lines and dot accents at intersections.
///
/// Place behind screen content at 0.08-0.12 opacity.
class IslamicGeometricPattern extends StatelessWidget {
  const IslamicGeometricPattern({
    super.key,
    this.color,
    this.opacity = 0.10,
  });

  final Color? color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    return RepaintBoundary(
      child: CustomPaint(
        painter: _GeometricPatternPainter(color: c, opacity: opacity),
        size: Size.infinite,
      ),
    );
  }
}

class _GeometricPatternPainter extends CustomPainter {
  _GeometricPatternPainter({required this.color, required this.opacity});

  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final outerPaint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final innerPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final dotPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.fill;

    const tileSize = 44.0;
    final cols = (size.width / tileSize).ceil() + 1;
    final rows = (size.height / tileSize).ceil() + 1;

    for (var row = -1; row < rows; row++) {
      for (var col = -1; col < cols; col++) {
        final cx = col * tileSize + tileSize / 2;
        final cy = row * tileSize + tileSize / 2;
        _drawEightPointedStar(canvas, outerPaint, innerPaint, dotPaint, cx, cy,
            tileSize * 0.38);
      }
    }
  }

  void _drawEightPointedStar(Canvas canvas, Paint outerPaint, Paint innerPaint,
      Paint dotPaint, double cx, double cy, double radius) {
    final innerRadius = radius * 0.42;

    // Outer star
    final outerPath = Path();
    for (var i = 0; i < 8; i++) {
      final outerAngle = (i * pi / 4) - pi / 8;
      final innerAngle = outerAngle + pi / 8;

      final ox = cx + radius * cos(outerAngle);
      final oy = cy + radius * sin(outerAngle);
      final ix = cx + innerRadius * cos(innerAngle);
      final iy = cy + innerRadius * sin(innerAngle);

      if (i == 0) {
        outerPath.moveTo(ox, oy);
      } else {
        outerPath.lineTo(ox, oy);
      }
      outerPath.lineTo(ix, iy);
    }
    outerPath.close();
    canvas.drawPath(outerPath, outerPaint);

    // Inner star (double-line effect) — slightly smaller
    final innerStarRadius = radius * 0.85;
    final innerStarInner = innerRadius * 0.85;
    final innerStarPath = Path();
    for (var i = 0; i < 8; i++) {
      final outerAngle = (i * pi / 4) - pi / 8;
      final innerAngle = outerAngle + pi / 8;

      final ox = cx + innerStarRadius * cos(outerAngle);
      final oy = cy + innerStarRadius * sin(outerAngle);
      final ix = cx + innerStarInner * cos(innerAngle);
      final iy = cy + innerStarInner * sin(innerAngle);

      if (i == 0) {
        innerStarPath.moveTo(ox, oy);
      } else {
        innerStarPath.lineTo(ox, oy);
      }
      innerStarPath.lineTo(ix, iy);
    }
    innerStarPath.close();
    canvas.drawPath(innerStarPath, innerPaint);

    // Inner octagon
    final innerOctPath = Path();
    final innerOctRadius = radius * 0.28;
    for (var i = 0; i < 8; i++) {
      final angle = (i * pi / 4) - pi / 8;
      final x = cx + innerOctRadius * cos(angle);
      final y = cy + innerOctRadius * sin(angle);
      if (i == 0) {
        innerOctPath.moveTo(x, y);
      } else {
        innerOctPath.lineTo(x, y);
      }
    }
    innerOctPath.close();
    canvas.drawPath(innerOctPath, outerPaint);

    // Dot accents at the 8 outer points
    for (var i = 0; i < 8; i++) {
      final angle = (i * pi / 4) - pi / 8;
      final dx = cx + radius * cos(angle);
      final dy = cy + radius * sin(angle);
      canvas.drawCircle(Offset(dx, dy), 1.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_GeometricPatternPainter oldDelegate) => false;
}

// ============================================================================
// (b) ArabesqueDivider — rich horizontal divider with elaborate ornament
// ============================================================================

/// A horizontal divider with a central 8-pointed star surrounded by
/// leaf/teardrop radiating shapes, curving vine tendrils extending left
/// and right, and small dot accents along the vine.
class ArabesqueDivider extends StatelessWidget {
  const ArabesqueDivider({
    super.key,
    this.color,
    this.opacity = 0.35,
    this.width,
    this.height = 32,
  });

  final Color? color;
  final double opacity;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    return RepaintBoundary(
      child: CustomPaint(
        painter: _ArabesqueDividerPainter(color: c, opacity: opacity),
        size: Size(width ?? double.infinity, height),
      ),
    );
  }
}

class _ArabesqueDividerPainter extends CustomPainter {
  _ArabesqueDividerPainter({required this.color, required this.opacity});

  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final ornamentPaint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.3)
      ..style = PaintingStyle.fill;

    final vinePaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final dotPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.7)
      ..style = PaintingStyle.fill;

    final ornamentRadius = size.height * 0.32;

    // Central 8-pointed star
    _drawSmallStar(canvas, ornamentPaint, cx, cy, ornamentRadius);

    // Teardrop/leaf shapes radiating from center (lotus effect)
    for (var i = 0; i < 8; i++) {
      final angle = (i * pi / 4);
      final leafStart = ornamentRadius * 0.6;
      final leafEnd = ornamentRadius * 1.3;
      final sx = cx + leafStart * cos(angle);
      final sy = cy + leafStart * sin(angle);
      final ex = cx + leafEnd * cos(angle);
      final ey = cy + leafEnd * sin(angle);

      final perpAngle = angle + pi / 2;
      final bulge = ornamentRadius * 0.2;
      final cpx = (sx + ex) / 2 + bulge * cos(perpAngle);
      final cpy = (sy + ey) / 2 + bulge * sin(perpAngle);
      final cpx2 = (sx + ex) / 2 - bulge * cos(perpAngle);
      final cpy2 = (sy + ey) / 2 - bulge * sin(perpAngle);

      final leafPath = Path()
        ..moveTo(sx, sy)
        ..quadraticBezierTo(cpx, cpy, ex, ey)
        ..quadraticBezierTo(cpx2, cpy2, sx, sy);
      canvas.drawPath(leafPath, ornamentPaint);
      canvas.drawPath(leafPath, fillPaint);
    }

    // Small diamond accents at cardinal points
    final accentSize = ornamentRadius * 0.2;
    final accentDist = ornamentRadius * 1.5;
    for (var i = 0; i < 4; i++) {
      final angle = i * pi / 2;
      final dx = cx + accentDist * cos(angle);
      final dy = cy + accentDist * sin(angle);
      _drawSmallDiamond(canvas, ornamentPaint, dx, dy, accentSize);
    }

    // Vine tendrils extending left and right
    final vineStart = ornamentRadius * 1.8;
    final vineEnd = size.width * 0.44;
    final waveAmp = size.height * 0.08;
    final vineSegments = 20;

    for (final dir in [-1.0, 1.0]) {
      final vinePath = Path();
      for (var i = 0; i <= vineSegments; i++) {
        final t = i / vineSegments;
        final x = cx + dir * (vineStart + (vineEnd - vineStart) * t);
        final y = cy + sin(t * pi * 3) * waveAmp * (1.0 - t * 0.5);
        if (i == 0) {
          vinePath.moveTo(x, y);
        } else {
          vinePath.lineTo(x, y);
        }
      }
      canvas.drawPath(vinePath, vinePaint);

      // Dot accents along the vine
      for (var i = 1; i <= 4; i++) {
        final t = i / 5;
        final x = cx + dir * (vineStart + (vineEnd - vineStart) * t);
        final y = cy + sin(t * pi * 3) * waveAmp * (1.0 - t * 0.5);
        canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
      }
    }
  }

  void _drawSmallStar(
      Canvas canvas, Paint paint, double cx, double cy, double radius) {
    final path = Path();
    final innerRadius = radius * 0.45;

    for (var i = 0; i < 8; i++) {
      final outerAngle = (i * pi / 4) - pi / 8;
      final innerAngle = outerAngle + pi / 8;

      final ox = cx + radius * cos(outerAngle);
      final oy = cy + radius * sin(outerAngle);
      final ix = cx + innerRadius * cos(innerAngle);
      final iy = cy + innerRadius * sin(innerAngle);

      if (i == 0) {
        path.moveTo(ox, oy);
      } else {
        path.lineTo(ox, oy);
      }
      path.lineTo(ix, iy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSmallDiamond(
      Canvas canvas, Paint paint, double cx, double cy, double size) {
    final path = Path()
      ..moveTo(cx, cy - size)
      ..lineTo(cx + size * 0.6, cy)
      ..lineTo(cx, cy + size)
      ..lineTo(cx - size * 0.6, cy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArabesqueDividerPainter oldDelegate) => false;
}

// ============================================================================
// (c) IslamicCornerOrnament — geometric corner decoration
// ============================================================================

/// A delicate geometric/floral corner piece inspired by Quran page borders.
///
/// Place at corners of cards or frames. Uses [corner] to set orientation.
class IslamicCornerOrnament extends StatelessWidget {
  const IslamicCornerOrnament({
    super.key,
    this.color,
    this.opacity = 0.30,
    this.size = 32,
    this.corner = CornerPosition.topLeft,
  });

  final Color? color;
  final double opacity;
  final double size;
  final CornerPosition corner;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    return RepaintBoundary(
      child: CustomPaint(
        painter: _CornerOrnamentPainter(
          color: c,
          opacity: opacity,
          corner: corner,
        ),
        size: Size(size, size),
      ),
    );
  }
}

enum CornerPosition { topLeft, topRight, bottomLeft, bottomRight }

class _CornerOrnamentPainter extends CustomPainter {
  _CornerOrnamentPainter({
    required this.color,
    required this.opacity,
    required this.corner,
  });

  final Color color;
  final double opacity;
  final CornerPosition corner;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.2)
      ..style = PaintingStyle.fill;

    canvas.save();

    switch (corner) {
      case CornerPosition.topLeft:
        break;
      case CornerPosition.topRight:
        canvas.translate(size.width, 0);
        canvas.scale(-1, 1);
      case CornerPosition.bottomLeft:
        canvas.translate(0, size.height);
        canvas.scale(1, -1);
      case CornerPosition.bottomRight:
        canvas.translate(size.width, size.height);
        canvas.scale(-1, -1);
    }

    final s = size.width;

    // Outer L-shaped bracket
    final path = Path();
    path.moveTo(s * 0.05, s * 0.6);
    path.lineTo(s * 0.05, s * 0.05);
    path.lineTo(s * 0.6, s * 0.05);
    canvas.drawPath(path, paint);

    // Inner L-shaped bracket (double line)
    final innerPath = Path();
    innerPath.moveTo(s * 0.10, s * 0.52);
    innerPath.lineTo(s * 0.10, s * 0.10);
    innerPath.lineTo(s * 0.52, s * 0.10);
    canvas.drawPath(innerPath, paint..strokeWidth = 0.6);
    paint.strokeWidth = 0.9;

    // Inner decorative curve
    final curvePath = Path();
    curvePath.moveTo(s * 0.14, s * 0.42);
    curvePath.quadraticBezierTo(s * 0.14, s * 0.14, s * 0.42, s * 0.14);
    canvas.drawPath(curvePath, paint);

    // Leaf/petal flourishes at the corner
    final leafPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    // Leaf 1 - downward
    final leaf1 = Path();
    leaf1.moveTo(s * 0.15, s * 0.15);
    leaf1.quadraticBezierTo(s * 0.06, s * 0.24, s * 0.15, s * 0.32);
    canvas.drawPath(leaf1, leafPaint);

    // Leaf 2 - rightward
    final leaf2 = Path();
    leaf2.moveTo(s * 0.15, s * 0.15);
    leaf2.quadraticBezierTo(s * 0.24, s * 0.06, s * 0.32, s * 0.15);
    canvas.drawPath(leaf2, leafPaint);

    // Filled teardrop at corner
    final teardrop = Path()
      ..moveTo(s * 0.15, s * 0.15)
      ..quadraticBezierTo(s * 0.06, s * 0.24, s * 0.15, s * 0.32)
      ..quadraticBezierTo(s * 0.20, s * 0.24, s * 0.15, s * 0.15);
    canvas.drawPath(teardrop, fillPaint);

    final teardrop2 = Path()
      ..moveTo(s * 0.15, s * 0.15)
      ..quadraticBezierTo(s * 0.24, s * 0.06, s * 0.32, s * 0.15)
      ..quadraticBezierTo(s * 0.24, s * 0.20, s * 0.15, s * 0.15);
    canvas.drawPath(teardrop2, fillPaint);

    // Diamond at corner intersection
    final diamondPath = Path()
      ..moveTo(s * 0.15, s * 0.09)
      ..lineTo(s * 0.21, s * 0.15)
      ..lineTo(s * 0.15, s * 0.21)
      ..lineTo(s * 0.09, s * 0.15)
      ..close();
    canvas.drawPath(diamondPath, leafPaint);

    // Small dot accents at ends of bracket
    final dotPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(s * 0.05, s * 0.6), 1.5, dotPaint);
    canvas.drawCircle(Offset(s * 0.6, s * 0.05), 1.5, dotPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CornerOrnamentPainter oldDelegate) => false;
}

// ============================================================================
// (d) MoroccanArchHeader — decorative pointed arch silhouette
// ============================================================================

/// The classic pointed Moroccan/Islamic arch outline.
class MoroccanArchHeader extends StatelessWidget {
  const MoroccanArchHeader({
    super.key,
    this.color,
    this.opacity = 0.15,
    this.width = 200,
    this.height = 120,
  });

  final Color? color;
  final double opacity;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    return RepaintBoundary(
      child: CustomPaint(
        painter: _MoroccanArchPainter(color: c, opacity: opacity),
        size: Size(width, height),
      ),
    );
  }
}

class _MoroccanArchPainter extends CustomPainter {
  _MoroccanArchPainter({required this.color, required this.opacity});

  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final w = size.width;
    final h = size.height;

    _drawArch(canvas, paint, 0, 0, w, h);

    final innerPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    final inset = w * 0.06;
    _drawArch(
        canvas, innerPaint, inset, inset * 0.5, w - inset * 2, h - inset);
  }

  void _drawArch(
      Canvas canvas, Paint paint, double x, double y, double w, double h) {
    final path = Path();
    final baseY = y + h;
    final peakY = y + h * 0.05;
    final cx = x + w / 2;

    path.moveTo(x, baseY);
    path.lineTo(x, y + h * 0.45);
    path.cubicTo(
      x, y + h * 0.15,
      cx - w * 0.05, peakY,
      cx, peakY,
    );
    path.cubicTo(
      cx + w * 0.05, peakY,
      x + w, y + h * 0.15,
      x + w, y + h * 0.45,
    );
    path.lineTo(x + w, baseY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MoroccanArchPainter oldDelegate) => false;
}

// ============================================================================
// (e) GeometricStarIcon — small 8-pointed star widget
// ============================================================================

/// A small 8-pointed Islamic geometric star.
class GeometricStarIcon extends StatelessWidget {
  const GeometricStarIcon({
    super.key,
    this.color,
    this.opacity = 0.30,
    this.size = 16,
  });

  final Color? color;
  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    return RepaintBoundary(
      child: CustomPaint(
        painter: _GeometricStarPainter(color: c, opacity: opacity),
        size: Size(size, size),
      ),
    );
  }
}

class _GeometricStarPainter extends CustomPainter {
  _GeometricStarPainter({required this.color, required this.opacity});

  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.width * 0.45;
    final innerRadius = radius * 0.42;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final path = Path();
    for (var i = 0; i < 8; i++) {
      final outerAngle = (i * pi / 4) - pi / 2;
      final innerAngle = outerAngle + pi / 8;

      final ox = cx + radius * cos(outerAngle);
      final oy = cy + radius * sin(outerAngle);
      final ix = cx + innerRadius * cos(innerAngle);
      final iy = cy + innerRadius * sin(innerAngle);

      if (i == 0) {
        path.moveTo(ox, oy);
      } else {
        path.lineTo(ox, oy);
      }
      path.lineTo(ix, iy);
    }
    path.close();
    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(cx, cy), radius * 0.18, paint);
  }

  @override
  bool shouldRepaint(_GeometricStarPainter oldDelegate) => false;
}

// ============================================================================
// (f) FloralBorder — dense mushaf-style floral vine border
// ============================================================================

/// A floral vine pattern running vertically with 6-petal flowers, curling
/// tendrils, and alternating leaves. Creates a mushaf page border feel.
class FloralBorder extends StatelessWidget {
  const FloralBorder({
    super.key,
    this.color,
    this.opacity = 0.18,
    this.width = 22,
    this.alignment = Alignment.centerLeft,
  });

  final Color? color;
  final double opacity;
  final double width;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    final mirrored = alignment == Alignment.centerRight;
    return RepaintBoundary(
      child: Align(
        alignment: alignment,
        child: SizedBox(
          width: width,
          child: CustomPaint(
            painter: _FloralBorderPainter(
              color: c,
              opacity: opacity,
              mirrored: mirrored,
            ),
            size: Size(width, double.infinity),
          ),
        ),
      ),
    );
  }
}

class _FloralBorderPainter extends CustomPainter {
  _FloralBorderPainter({
    required this.color,
    required this.opacity,
    required this.mirrored,
  });

  final Color color;
  final double opacity;
  final bool mirrored;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.25)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.fill;

    final w = size.width;

    canvas.save();
    if (mirrored) {
      canvas.translate(w, 0);
      canvas.scale(-1, 1);
    }

    const segmentHeight = 32.0;
    final segments = (size.height / segmentHeight).ceil() + 1;

    // Central vine with subtle wave
    final vinePaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    final vinePath = Path();
    for (var i = 0; i <= segments * 4; i++) {
      final y = i * segmentHeight / 4;
      final x = w * 0.5 + sin(y * pi / segmentHeight) * w * 0.08;
      if (i == 0) {
        vinePath.moveTo(x, y);
      } else {
        vinePath.lineTo(x, y);
      }
    }
    canvas.drawPath(vinePath, vinePaint);

    for (var i = 0; i < segments; i++) {
      final y = i * segmentHeight;
      final isEven = i % 2 == 0;
      final vineX = w * 0.5;

      // Alternating leaf motifs — curving teardrop shapes
      final leafPath = Path();
      if (isEven) {
        leafPath.moveTo(vineX, y + segmentHeight * 0.15);
        leafPath.quadraticBezierTo(
          w * 0.88, y + segmentHeight * 0.30,
          vineX, y + segmentHeight * 0.45,
        );
      } else {
        leafPath.moveTo(vineX, y + segmentHeight * 0.15);
        leafPath.quadraticBezierTo(
          w * 0.12, y + segmentHeight * 0.30,
          vineX, y + segmentHeight * 0.45,
        );
      }
      canvas.drawPath(leafPath, paint);

      // Small curling tendril
      final tendrilPath = Path();
      final tendrilX = isEven ? w * 0.28 : w * 0.72;
      final tendrilDir = isEven ? -1.0 : 1.0;
      tendrilPath.moveTo(vineX, y + segmentHeight * 0.55);
      tendrilPath.quadraticBezierTo(
        vineX + tendrilDir * w * 0.15,
        y + segmentHeight * 0.62,
        tendrilX,
        y + segmentHeight * 0.70,
      );
      // Curl at end
      tendrilPath.quadraticBezierTo(
        tendrilX + tendrilDir * w * 0.05,
        y + segmentHeight * 0.78,
        tendrilX - tendrilDir * w * 0.03,
        y + segmentHeight * 0.75,
      );
      canvas.drawPath(tendrilPath, paint..strokeWidth = 0.5);
      paint.strokeWidth = 0.7;

      // Dot/bud at leaf tip
      final dotY = y + segmentHeight * 0.30;
      final dotX = isEven ? w * 0.75 : w * 0.25;
      canvas.drawCircle(Offset(dotX, dotY), 1.3, dotPaint);

      // 6-petal flower every other segment
      if (i % 2 == 0) {
        _drawSixPetalFlower(
          canvas,
          paint,
          fillPaint,
          vineX,
          y + segmentHeight * 0.85,
          w * 0.14,
        );
      }
    }

    canvas.restore();
  }

  void _drawSixPetalFlower(Canvas canvas, Paint strokePaint, Paint fillPaint,
      double cx, double cy, double radius) {
    for (var i = 0; i < 6; i++) {
      final angle = i * pi / 3;
      final px = cx + radius * cos(angle);
      final py = cy + radius * sin(angle);

      final perpAngle = angle + pi / 2;
      final bulge = radius * 0.45;

      final petal = Path()
        ..moveTo(cx, cy)
        ..quadraticBezierTo(
          (cx + px) / 2 + bulge * cos(perpAngle),
          (cy + py) / 2 + bulge * sin(perpAngle),
          px,
          py,
        )
        ..quadraticBezierTo(
          (cx + px) / 2 - bulge * cos(perpAngle),
          (cy + py) / 2 - bulge * sin(perpAngle),
          cx,
          cy,
        );
      canvas.drawPath(petal, strokePaint);
      canvas.drawPath(petal, fillPaint);
    }
    // Center dot
    canvas.drawCircle(Offset(cx, cy), 1.0, strokePaint);
  }

  @override
  bool shouldRepaint(_FloralBorderPainter oldDelegate) => false;
}

// ============================================================================
// (g) IlluminatedHeader — manuscript-style decorative header panel
// ============================================================================

/// A decorative panel inspired by Ottoman/Persian manuscript illumination
/// headers. Draws a rectangular frame with rounded inner corners, small floral
/// corner decorations, and a pointed finial at the top center.
///
/// Place behind text content for surah headers and title panels.
class IlluminatedHeader extends StatelessWidget {
  const IlluminatedHeader({
    super.key,
    this.color,
    this.accentColor,
    this.opacity = 0.25,
    this.useGoldAccent = false,
    this.width,
    this.height = 80,
    this.child,
  });

  final Color? color;
  final Color? accentColor;
  final double opacity;
  final bool useGoldAccent;
  final double? width;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    final accent = useGoldAccent ? _accentColor(context, accentColor) : c;
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: _IlluminatedHeaderPainter(
              color: c,
              accentColor: accent,
              opacity: opacity,
              useGoldAccent: useGoldAccent,
            ),
            size: Size(width ?? double.infinity, height),
          ),
          if (child != null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: child,
            ),
        ],
      ),
    );
  }
}

class _IlluminatedHeaderPainter extends CustomPainter {
  _IlluminatedHeaderPainter({
    required this.color,
    required this.accentColor,
    required this.opacity,
    required this.useGoldAccent,
  });

  final Color color;
  final Color accentColor;
  final double opacity;
  final bool useGoldAccent;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final framePaint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.08)
      ..style = PaintingStyle.fill;

    final accentPaint = Paint()
      ..color = accentColor.withValues(alpha: useGoldAccent ? opacity * 0.5 : opacity * 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final accentFill = Paint()
      ..color = accentColor.withValues(alpha: useGoldAccent ? opacity * 0.15 : opacity * 0.1)
      ..style = PaintingStyle.fill;

    final margin = 8.0;
    final innerCornerRadius = 10.0;

    // Outer frame
    final outerRect = RRect.fromLTRBR(
      margin, margin, w - margin, h - margin,
      const Radius.circular(2),
    );
    canvas.drawRRect(outerRect, framePaint);

    // Inner frame with rounded corners
    final innerMargin = margin + 4;
    final innerRect = RRect.fromLTRBR(
      innerMargin,
      innerMargin,
      w - innerMargin,
      h - innerMargin,
      Radius.circular(innerCornerRadius),
    );
    canvas.drawRRect(innerRect, accentPaint);
    canvas.drawRRect(innerRect, fillPaint);

    // Floral corner decorations (inside the frame)
    final cornerSize = h * 0.22;
    _drawCornerFloral(canvas, accentPaint, accentFill, innerMargin + 4, innerMargin + 4, cornerSize, false, false);
    _drawCornerFloral(canvas, accentPaint, accentFill, w - innerMargin - 4, innerMargin + 4, cornerSize, true, false);
    _drawCornerFloral(canvas, accentPaint, accentFill, innerMargin + 4, h - innerMargin - 4, cornerSize, false, true);
    _drawCornerFloral(canvas, accentPaint, accentFill, w - innerMargin - 4, h - innerMargin - 4, cornerSize, true, true);

    // Top finial — pointed lotus/arch shape at top center
    final finialW = w * 0.08;
    final finialH = h * 0.18;
    final fcx = w / 2;
    final fTop = margin - finialH * 0.3;

    final finialPath = Path()
      ..moveTo(fcx - finialW, margin)
      ..quadraticBezierTo(fcx - finialW * 0.3, margin, fcx, fTop)
      ..quadraticBezierTo(fcx + finialW * 0.3, margin, fcx + finialW, margin);
    canvas.drawPath(finialPath, framePaint);
    canvas.drawPath(finialPath, accentFill);

    // Small dot at finial tip
    canvas.drawCircle(
      Offset(fcx, fTop + 1),
      1.5,
      Paint()..color = color.withValues(alpha: opacity * 0.7)..style = PaintingStyle.fill,
    );
  }

  void _drawCornerFloral(Canvas canvas, Paint strokePaint, Paint fillPaint,
      double cx, double cy, double size, bool flipX, bool flipY) {
    final dx = flipX ? -1.0 : 1.0;
    final dy = flipY ? -1.0 : 1.0;

    // Small 3-petal flower
    for (var i = 0; i < 3; i++) {
      final baseAngle = (flipX ? pi : 0) + (flipY ? -pi / 4 : pi / 4);
      final angle = baseAngle + (i - 1) * pi / 6;
      final px = cx + size * cos(angle) * dx.sign;
      final py = cy + size * sin(angle) * dy.sign;

      final perpAngle = angle + pi / 2;
      final bulge = size * 0.35;

      final petal = Path()
        ..moveTo(cx, cy)
        ..quadraticBezierTo(
          (cx + px) / 2 + bulge * cos(perpAngle),
          (cy + py) / 2 + bulge * sin(perpAngle),
          px, py,
        )
        ..quadraticBezierTo(
          (cx + px) / 2 - bulge * cos(perpAngle),
          (cy + py) / 2 - bulge * sin(perpAngle),
          cx, cy,
        );
      canvas.drawPath(petal, strokePaint);
      canvas.drawPath(petal, fillPaint);
    }
  }

  @override
  bool shouldRepaint(_IlluminatedHeaderPainter oldDelegate) => false;
}

// ============================================================================
// (h) OrnateFrame — decorative border wrapping content
// ============================================================================

/// A decorative border inspired by mushaf and manuscript frames. Features a
/// thin outer line, inner line with geometric corner pieces, and small
/// leaf/floral accents at each side's midpoint.
class OrnateFrame extends StatelessWidget {
  const OrnateFrame({
    super.key,
    this.color,
    this.accentColor,
    this.opacity = 0.20,
    this.useGoldAccent = false,
    this.padding = const EdgeInsets.all(16),
    required this.child,
  });

  final Color? color;
  final Color? accentColor;
  final double opacity;
  final bool useGoldAccent;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = _patternColor(context, color);
    final accent = useGoldAccent ? _accentColor(context, accentColor) : c;
    return RepaintBoundary(
      child: CustomPaint(
        painter: _OrnateFramePainter(
          color: c,
          accentColor: accent,
          opacity: opacity,
          useGoldAccent: useGoldAccent,
        ),
        child: Padding(
          padding: padding + const EdgeInsets.all(6),
          child: child,
        ),
      ),
    );
  }
}

class _OrnateFramePainter extends CustomPainter {
  _OrnateFramePainter({
    required this.color,
    required this.accentColor,
    required this.opacity,
    required this.useGoldAccent,
  });

  final Color color;
  final Color accentColor;
  final double opacity;
  final bool useGoldAccent;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final outerPaint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final innerPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final accentPaint = Paint()
      ..color = accentColor.withValues(alpha: useGoldAccent ? opacity * 0.6 : opacity * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    final accentFill = Paint()
      ..color = accentColor.withValues(alpha: useGoldAccent ? opacity * 0.15 : opacity * 0.08)
      ..style = PaintingStyle.fill;

    // Outer line
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), outerPaint);

    // Inner line
    const inset = 4.0;
    canvas.drawRect(Rect.fromLTWH(inset, inset, w - inset * 2, h - inset * 2), innerPaint);

    // Corner geometric pieces (small L-shapes with diamonds)
    final cornerLen = min(w, h) * 0.08;
    _drawCornerPiece(canvas, accentPaint, accentFill, inset, inset, cornerLen, 1, 1);
    _drawCornerPiece(canvas, accentPaint, accentFill, w - inset, inset, cornerLen, -1, 1);
    _drawCornerPiece(canvas, accentPaint, accentFill, inset, h - inset, cornerLen, 1, -1);
    _drawCornerPiece(canvas, accentPaint, accentFill, w - inset, h - inset, cornerLen, -1, -1);

    // Midpoint floral/leaf accents
    final leafSize = min(w, h) * 0.03;
    _drawMidpointLeaf(canvas, accentPaint, accentFill, w / 2, inset, leafSize, true);
    _drawMidpointLeaf(canvas, accentPaint, accentFill, w / 2, h - inset, leafSize, true);
    _drawMidpointLeaf(canvas, accentPaint, accentFill, inset, h / 2, leafSize, false);
    _drawMidpointLeaf(canvas, accentPaint, accentFill, w - inset, h / 2, leafSize, false);
  }

  void _drawCornerPiece(Canvas canvas, Paint strokePaint, Paint fillPaint,
      double cx, double cy, double len, double dx, double dy) {
    // L-shape
    final path = Path()
      ..moveTo(cx, cy + dy * len)
      ..lineTo(cx, cy)
      ..lineTo(cx + dx * len, cy);
    canvas.drawPath(path, strokePaint);

    // Small diamond at corner
    final ds = len * 0.35;
    final diamond = Path()
      ..moveTo(cx, cy + dy * ds)
      ..lineTo(cx + dx * ds * 0.6, cy)
      ..lineTo(cx, cy - dy * ds * 0.3)
      ..lineTo(cx - dx * ds * 0.6, cy)
      ..close();
    canvas.drawPath(diamond, strokePaint);
    canvas.drawPath(diamond, fillPaint);
  }

  void _drawMidpointLeaf(Canvas canvas, Paint strokePaint, Paint fillPaint,
      double cx, double cy, double size, bool horizontal) {
    if (horizontal) {
      // Two small leaves pointing up and down
      final up = Path()
        ..moveTo(cx - size, cy)
        ..quadraticBezierTo(cx, cy - size * 2, cx + size, cy);
      canvas.drawPath(up, strokePaint);
      canvas.drawPath(up, fillPaint);

      final down = Path()
        ..moveTo(cx - size, cy)
        ..quadraticBezierTo(cx, cy + size * 2, cx + size, cy);
      canvas.drawPath(down, strokePaint);
      canvas.drawPath(down, fillPaint);
    } else {
      // Two small leaves pointing left and right
      final left = Path()
        ..moveTo(cx, cy - size)
        ..quadraticBezierTo(cx - size * 2, cy, cx, cy + size);
      canvas.drawPath(left, strokePaint);
      canvas.drawPath(left, fillPaint);

      final right = Path()
        ..moveTo(cx, cy - size)
        ..quadraticBezierTo(cx + size * 2, cy, cx, cy + size);
      canvas.drawPath(right, strokePaint);
      canvas.drawPath(right, fillPaint);
    }
  }

  @override
  bool shouldRepaint(_OrnateFramePainter oldDelegate) => false;
}
