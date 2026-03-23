import 'package:flutter/material.dart';

abstract final class AppColors {
  // Light theme
  static const Color primaryLight = Color(0xFF0D7377); // Deep teal
  static const Color primaryVariantLight = Color(0xFF0A5C5F);
  static const Color backgroundLight = Color(0xFFF8F6F3); // Warm off-white
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF0EDE8);
  static const Color onBackgroundLight = Color(0xFF1A1A1A);
  static const Color onSurfaceLight = Color(0xFF2D2D2D);
  static const Color onSurfaceVariantLight = Color(0xFF6B6B6B);
  static const Color dividerLight = Color(0xFFE8E4DF);

  // Dark theme
  static const Color primaryDark = Color(0xFF4DB8BB); // Lighter teal for dark
  static const Color primaryVariantDark = Color(0xFF6DCFD2);
  static const Color backgroundDark = Color(0xFF1A1A2E); // Deep charcoal
  static const Color surfaceDark = Color(0xFF222240);
  static const Color surfaceVariantDark = Color(0xFF2A2A48);
  static const Color onBackgroundDark = Color(0xFFF0ECE6); // Warm off-white
  static const Color onSurfaceDark = Color(0xFFE8E4DE);
  static const Color onSurfaceVariantDark = Color(0xFF9E9E9E);
  static const Color dividerDark = Color(0xFF3A3A58);

  // Semantic colors (shared)
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Gate screen specific
  static const Color gateBackgroundLight = Color(0xFFFAF8F5); // Even warmer
  static const Color gateBackgroundDark = Color(0xFF161630);
  static const Color arabicTextLight = Color(0xFF1A1A1A);
  static const Color arabicTextDark = Color(0xFFF5F0E8); // Slightly brighter than UI text
  static const Color translationTextLight = Color(0xFF5A5A5A);
  static const Color translationTextDark = Color(0xFFB0A89E);
  static const Color timerAccent = Color(0xFF0D7377);

  // Accent / gold (used sparingly)
  static const Color gold = Color(0xFFB8860B);
  static const Color goldLight = Color(0xFFD4A843);
}
