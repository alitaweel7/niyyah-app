import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/islamic_patterns.dart';
import '../../../shared/widgets/manuscript_decorations.dart';
import 'gate_screen.dart';

/// The content picker that appears when a gated app is opened.
/// User chooses Quran, Duas, or Stories, then enters the reading experience.
class GatePickerScreen extends ConsumerStatefulWidget {
  const GatePickerScreen({
    this.blockedAppId,
    this.blockedAppName,
    super.key,
  });

  final int? blockedAppId;
  final String? blockedAppName;

  @override
  ConsumerState<GatePickerScreen> createState() => _GatePickerScreenState();
}

class _GatePickerScreenState extends ConsumerState<GatePickerScreen> {
  // Prayer time state
  String _nextPrayerName = '';
  String _nextPrayerTime = '';
  String _timeUntilPrayer = '';
  Timer? _prayerTimer;

  // Reading progress state
  String _quranProgress = 'Start reading';
  String _duaProgress = 'Start learning';
  String _storiesProgress = 'Begin journey';
  int _timerSeconds = 300;

  /// The name of the app the user was trying to open (e.g. "Instagram")
  String? _blockedAppName;

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _loadBlockedAppName();
    _calculatePrayerTimes();
    // Update prayer countdown every minute
    _prayerTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _calculatePrayerTimes();
    });
  }

  Future<void> _loadBlockedAppName() async {
    // Use the name passed via navigation, or fetch from native side
    if (widget.blockedAppName != null) {
      setState(() => _blockedAppName = widget.blockedAppName);
      return;
    }
    try {
      final gateService = ref.read(appGateServiceProvider);
      final name = await gateService.getLastBlockedAppName();
      if (name != null && mounted) {
        setState(() => _blockedAppName = name);
      }
    } catch (e) {
      debugPrint('Last blocked app name fetch failed: $e');
    }
  }

  @override
  void dispose() {
    _prayerTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final prefs =
        await ref.read(preferencesRepositoryProvider).getPreferences();
    _timerSeconds = prefs.gateDurationSeconds;

    // Quran progress
    final seqSurah = prefs.sequentialPositionSurah;
    final seqAyah = prefs.sequentialPositionAyah;
    try {
      final surah = await ref.read(quranRepositoryProvider).getSurah(seqSurah);
      if (!mounted) return;
      _quranProgress =
          '${context.tr('pick_continue')} · ${surah.nameEnglish}، ${context.tr('pick_ayah')} $seqAyah';
    } catch (e) {
      debugPrint('Quran progress load failed: $e');
      if (mounted) _quranProgress = context.tr('pick_start_reading');
    }

    // Dua progress
    try {
      final progressRepo = ref.read(readingProgressRepositoryProvider);
      final duasRead = await progressRepo.getUniqueContentCount('dua');
      if (!mounted) return;
      _duaProgress = '$duasRead ${context.tr('pick_duas_learned')}';
    } catch (e) {
      debugPrint('Dua progress load failed: $e');
      if (mounted) _duaProgress = context.tr('pick_start_learning');
    }

    // Stories progress — placeholder until stories are loaded
    if (!mounted) return;
    _storiesProgress = context.tr('pick_coming_soon');

    if (mounted) setState(() {});
  }

  Future<void> _calculatePrayerTimes() async {
    try {
      final result = await ref.read(prayerTimesProvider.future);

      if (result != null && mounted) {
        final hours = result.minutesUntilNext ~/ 60;
        final mins = result.minutesUntilNext % 60;

        // Format the prayer time for display
        final timeParts = result.nextPrayer.time.split(':');
        final pHour =
            timeParts.isNotEmpty ? int.tryParse(timeParts[0]) ?? 0 : 0;
        final pMin = timeParts.length > 1 ? timeParts[1] : '00';
        final displayTime =
            '${pHour > 12 ? pHour - 12 : pHour}:$pMin ${pHour >= 12 ? 'PM' : 'AM'}';

        setState(() {
          _nextPrayerName = result.nextPrayer.name;
          _nextPrayerTime = displayTime;
          _timeUntilPrayer = hours > 0
              ? '$hours${context.tr('pick_hours_abbr')} $mins${context.tr('pick_minutes_abbr')}'
              : '$mins ${context.tr('minutes')}';
        });
      }
    } catch (e) {
      // Silently fail — prayer bar just won't show
      debugPrint('Prayer times error: $e');
    }
  }

  void _openContent(String contentType) {
    // Remember the user's content choice so next time the notification
    // can skip the picker and go straight to this content type
    try {
      ref.read(appGateServiceProvider).syncPrefsToAppGroup(
        gateDurationSeconds: _timerSeconds,
        unlockDurationSeconds: 600,
        preferredContentType: contentType,
      );
    } catch (e) {
      debugPrint('Sync prefs to App Group failed: $e');
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => GateScreen(
          blockedAppId: widget.blockedAppId,
          blockedAppName: _blockedAppName ?? widget.blockedAppName,
          initialContentType: contentType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Parchment background (light) / gold speckles (dark)
            const Positioned.fill(
              child: ParchmentBackground(),
            ),
            // Geometric background pattern
            Positioned.fill(
              child: IslamicGeometricPattern(
                opacity: isDark ? 0.06 : 0.08,
              ),
            ),
            Column(
          children: [
            // Prayer tracker bar
            if (_nextPrayerName.isNotEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: isDark
                    ? AppColors.surfaceVariantDark
                    : AppColors.oliveVeryLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      size: 16,
                      color: isDark
                          ? AppColors.primaryDark
                          : AppColors.oliveDark,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_nextPrayerName ${context.tr('pick_prayer_in')} $_timeUntilPrayer · $_nextPrayerTime',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.primaryDark
                                : AppColors.oliveDark,
                          ),
                    ),
                  ],
                ),
              ),

            // Greeting with geometric star
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const RoseAccent(size: 28),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('pick_bismillah'),
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 28,
                          height: 1.4,
                          color: isDark
                              ? AppColors.onBackgroundDark
                              : AppColors.oliveDark,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GeometricStarIcon(
                        size: 18,
                        opacity: isDark ? 0.20 : 0.25,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _blockedAppName != null
                        ? '${context.tr('pick_read_to_unlock')} $_blockedAppName'
                        : context.tr('pick_what_to_read'),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.onSurfaceVariantDark
                              : AppColors.onSurfaceVariantLight,
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Content buttons wrapped in OrnateFrame
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  OrnateFrame(
                    opacity: isDark ? 0.12 : 0.18,
                    useGoldAccent: true,
                    padding: EdgeInsets.zero,
                    child: _ContentCard(
                      icon: Icons.menu_book_rounded,
                      title: context.tr('pick_quran'),
                      subtitle: _quranProgress,
                      isDark: isDark,
                      onTap: () => _openContent('quran'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OrnateFrame(
                    opacity: isDark ? 0.12 : 0.18,
                    useGoldAccent: true,
                    padding: EdgeInsets.zero,
                    child: _ContentCard(
                      icon: Icons.favorite_outline_rounded,
                      title: context.tr('pick_duas'),
                      subtitle: _duaProgress,
                      isDark: isDark,
                      onTap: () => _openContent('dua'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OrnateFrame(
                    opacity: isDark ? 0.12 : 0.18,
                    useGoldAccent: true,
                    padding: EdgeInsets.zero,
                    child: _ContentCard(
                      icon: Icons.school_outlined,
                      title: context.tr('pick_hadith'),
                      subtitle: context.tr('pick_hadith_subtitle'),
                      isDark: isDark,
                      onTap: () => _openContent('islamic_teaching'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OrnateFrame(
                    opacity: isDark ? 0.12 : 0.18,
                    useGoldAccent: true,
                    padding: EdgeInsets.zero,
                    child: _ContentCard(
                      icon: Icons.auto_stories_rounded,
                      title: context.tr('pick_stories'),
                      subtitle: _storiesProgress,
                      isDark: isDark,
                      enabled: false,
                      onTap: () => _openContent('prophet_story'),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            const Center(child: ManuscriptDivider(height: 24)),

            // Timer info at bottom
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 28),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? AppColors.dividerDark
                        : AppColors.dividerLight,
                    width: 0.5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Progress bar placeholder
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: double.infinity,
                      height: 4,
                      color: isDark
                          ? AppColors.surfaceVariantDark
                          : AppColors.oliveVeryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _formatTime(_timerSeconds),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      letterSpacing: -1,
                      color: isDark
                          ? AppColors.onBackgroundDark
                          : AppColors.onBackgroundLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr('pick_choose_speaks'),
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
          ],
        ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDark;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(18),
        child: Opacity(
          opacity: enabled ? 1.0 : 0.5,
          child: Container(
            width: double.infinity,
            height: 84,
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceVariantDark
                        : AppColors.oliveVeryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isDark ? AppColors.primaryDark : AppColors.olive,
                  ),
                ),
                const SizedBox(width: 16),
                // Text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.onSurfaceDark
                                  : AppColors.onSurfaceLight,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? AppColors.onSurfaceVariantDark
                                      : AppColors.onSurfaceVariantLight,
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Arrow
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: isDark
                      ? AppColors.onSurfaceVariantDark
                      : AppColors.onSurfaceVariantLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
