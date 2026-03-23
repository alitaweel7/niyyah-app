import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTypography {
  // Arabic text styles (Amiri font)
  static const String arabicFontFamily = 'Amiri';
  static const String quranFontFamily = 'AmiriQuran';

  static TextStyle arabicHeading({
    required bool isDark,
    double fontSize = 32,
  }) {
    return TextStyle(
      fontFamily: quranFontFamily,
      fontSize: fontSize,
      height: 2.0, // generous line height for diacritics
      color: isDark ? AppColors.arabicTextDark : AppColors.arabicTextLight,
      letterSpacing: 0,
    );
  }

  static TextStyle arabicBody({
    required bool isDark,
    double fontSize = 24,
  }) {
    return TextStyle(
      fontFamily: arabicFontFamily,
      fontSize: fontSize,
      height: 1.9,
      color: isDark ? AppColors.arabicTextDark : AppColors.arabicTextLight,
    );
  }

  static TextStyle translation({
    required bool isDark,
    double fontSize = 16,
  }) {
    return TextStyle(
      fontSize: fontSize,
      height: 1.6,
      color: isDark
          ? AppColors.translationTextDark
          : AppColors.translationTextLight,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle sourceReference({
    required bool isDark,
    double fontSize = 13,
  }) {
    return TextStyle(
      fontSize: fontSize,
      height: 1.4,
      color: isDark
          ? AppColors.onSurfaceVariantDark
          : AppColors.onSurfaceVariantLight,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    );
  }
}
