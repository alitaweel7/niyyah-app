import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class GateTimer extends StatelessWidget {
  const GateTimer({
    required this.progress,
    required this.timeText,
    required this.isDark,
    super.key,
  });

  final double progress;
  final String timeText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Linear progress bar — calm and minimal
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: isDark
                ? AppColors.dividerDark
                : AppColors.dividerLight,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.timerAccent,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          timeText,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: isDark
                ? AppColors.onSurfaceDark
                : AppColors.onSurfaceLight,
          ),
        ),
      ],
    );
  }
}
