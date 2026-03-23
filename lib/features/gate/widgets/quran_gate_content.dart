import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';

class QuranGateContent extends StatelessWidget {
  const QuranGateContent({
    required this.arabicText,
    required this.translationText,
    required this.isDark,
    this.showTranslation = true,
    this.fontSize = 28,
    super.key,
  });

  final String arabicText;
  final String? translationText;
  final bool isDark;
  final bool showTranslation;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          arabicText,
          style: AppTypography.arabicHeading(isDark: isDark, fontSize: fontSize),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        if (showTranslation && translationText != null) ...[
          const SizedBox(height: 24),
          Text(
            translationText!,
            style: AppTypography.translation(isDark: isDark),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
