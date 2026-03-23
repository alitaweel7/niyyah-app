import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../widgets/gate_timer.dart';

enum GateState { reading, timerComplete, continuing }

class GateScreen extends ConsumerStatefulWidget {
  const GateScreen({
    this.blockedAppId,
    this.blockedAppName,
    super.key,
  });

  final int? blockedAppId;
  final String? blockedAppName;

  @override
  ConsumerState<GateScreen> createState() => _GateScreenState();
}

class _GateScreenState extends ConsumerState<GateScreen> {
  GateState _gateState = GateState.reading;
  final int _timerSeconds = 300; // will be loaded from prefs
  int _elapsedSeconds = 0;
  int _extraReadingSeconds = 0;
  Timer? _timer;
  Timer? _extraTimer;

  // Demo content — will be replaced with real data from repositories
  String _arabicText = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';
  String _translationText =
      'In the name of God, the Most Gracious, the Most Merciful.';
  final String _contentTitle = 'Al-Fatiha · الفاتحة';
  final String _contentSubtitle = 'Surah 1 · 7 Ayahs · Meccan';
  String? _sourceReference;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _loadContent();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _extraTimer?.cancel();
    super.dispose();
  }

  void _loadContent() {
    // TODO: Load from QuranRepository/DuaRepository based on preferences
    // For now, show Surah Al-Fatiha as demo content
    setState(() {
      _arabicText =
          'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ ﴿١﴾\n'
          'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ ﴿٢﴾\n'
          'ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ ﴿٣﴾\n'
          'مَـٰلِكِ يَوْمِ ٱلدِّينِ ﴿٤﴾\n'
          'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ﴿٥﴾\n'
          'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ ﴿٦﴾\n'
          'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ ﴿٧﴾';
      _translationText =
          'In the name of God, the Most Gracious, the Most Merciful.\n'
          'All praise is due to God, Lord of all the worlds.\n'
          'The Most Gracious, the Most Merciful.\n'
          'Master of the Day of Judgment.\n'
          'You alone we worship, and You alone we ask for help.\n'
          'Guide us on the Straight Path.\n'
          'The path of those who have received Your grace; '
          'not the path of those who have brought down wrath upon themselves, '
          'nor of those who have gone astray.';
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        if (_elapsedSeconds >= _timerSeconds) {
          _timer?.cancel();
          _gateState = GateState.timerComplete;
        }
      });
    });
  }

  void _startExtraReadingTimer() {
    setState(() {
      _gateState = GateState.continuing;
    });
    _extraTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _extraReadingSeconds++;
      });
    });
  }

  void _unlockApp() {
    _extraTimer?.cancel();
    // TODO: Create unlock session, grant temporary unlock via platform channel
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/dashboard');
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final remaining = (_timerSeconds - _elapsedSeconds).clamp(0, _timerSeconds);
    final progress = _elapsedSeconds / _timerSeconds;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.gateBackgroundDark : AppColors.gateBackgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Content header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                children: [
                  Text(
                    _contentTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _contentSubtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.onSurfaceVariantDark
                              : AppColors.onSurfaceVariantLight,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Arabic text
                    Text(
                      _arabicText,
                      style: AppTypography.arabicHeading(
                        isDark: isDark,
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),

                    const SizedBox(height: 32),

                    // Translation
                    Text(
                      _translationText,
                      style: AppTypography.translation(isDark: isDark),
                      textAlign: TextAlign.center,
                    ),

                    // Source reference (for duas)
                    if (_sourceReference != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _sourceReference!,
                        style: AppTypography.sourceReference(isDark: isDark),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Timer and action area
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_gateState == GateState.reading) ...[
                    // Timer progress
                    GateTimer(
                      progress: progress.clamp(0.0, 1.0),
                      timeText: _formatTime(remaining),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Spend time with these words',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppColors.onSurfaceVariantDark
                                : AppColors.onSurfaceVariantLight,
                          ),
                    ),
                  ] else if (_gateState == GateState.timerComplete) ...[
                    // Timer complete — two options
                    Text(
                      'Reading complete',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _unlockApp,
                        child: Text(widget.blockedAppName != null
                            ? 'Continue to ${widget.blockedAppName}'
                            : 'Done'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _startExtraReadingTimer,
                        child: const Text('Continue Reading'),
                      ),
                    ),
                  ] else ...[
                    // Continuing to read — extra time counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_stories,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Extra reading: ${_formatTime(_extraReadingSeconds)}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _unlockApp,
                        child: Text(widget.blockedAppName != null
                            ? 'Continue to ${widget.blockedAppName}'
                            : 'Done'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
