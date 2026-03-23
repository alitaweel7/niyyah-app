import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';

class DuaGateContent extends StatelessWidget {
  const DuaGateContent({
    required this.titleArabic,
    required this.titleEnglish,
    required this.arabicText,
    required this.translationText,
    required this.source,
    required this.isDark,
    this.showTranslation = true,
    this.fontSize = 26,
    super.key,
  });

  final String titleArabic;
  final String titleEnglish;
  final String arabicText;
  final String translationText;
  final String source;
  final bool isDark;
  final bool showTranslation;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          arabicText,
          style: AppTypography.arabicBody(isDark: isDark, fontSize: fontSize),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        if (showTranslation) ...[
          const SizedBox(height: 24),
          Text(
            translationText,
            style: AppTypography.translation(isDark: isDark),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 16),
        Text(
          source,
          style: AppTypography.sourceReference(isDark: isDark),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
