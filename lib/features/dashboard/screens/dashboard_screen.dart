import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/prayer_tracker_repository.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/islamic_patterns.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesStreamProvider);
    final blockedAppsAsync = ref.watch(blockedAppsStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const RoseAccent(size: 24),
            const SizedBox(width: 8),
            Text(
              'Niyyah',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: isDark ? null : AppColors.oliveDark,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.explore_outlined),
            tooltip: context.tr('qibla'),
            onPressed: () => context.push(AppRoutes.qibla),
          ),
          IconButton(
            icon: const Icon(Icons.play_circle_outline),
            tooltip: context.tr('open_gate_now'),
            onPressed: () => context.push(AppRoutes.gate),
          ),
        ],
      ),
      body: Stack(
        children: [
          const ParchmentBackground(),
          SafeArea(
        child: prefsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('${context.tr('dash_error')}: $e')),
          data: (prefs) {
            final isPaused = prefs.pauseUntilTimestamp != null &&
                DateTime.now().millisecondsSinceEpoch <
                    (prefs.pauseUntilTimestamp! * 1000);

            final prayerAsync = ref.watch(prayerTimesProvider);

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Warm greeting
                Text(
                  context.tr('dash_greeting'),
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.onSurfaceDark
                        : AppColors.oliveDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  context.tr('dash_greeting_sub'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                      ),
                ),
                const SizedBox(height: 18),

                // Prayer times + Hijri date bar
                prayerAsync.whenOrNull(
                  data: (result) {
                    if (result == null) return const SizedBox.shrink();
                    final hours = result.minutesUntilNext ~/ 60;
                    final mins = result.minutesUntilNext % 60;
                    final timeStr = hours > 0
                        ? '$hours${context.tr('dash_hour_short')} $mins${context.tr('dash_min_short')}'
                        : '$mins ${context.tr('minutes')}';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceVariantDark
                                  : AppColors.oliveVeryLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.wb_sunny_outlined,
                                    size: 16,
                                    color: isDark
                                        ? AppColors.primaryDark
                                        : AppColors.oliveDark),
                                const SizedBox(width: 8),
                                Text(
                                  '${context.tr(result.nextPrayer.name.toLowerCase())} ${context.tr('dash_prayer_in')} $timeStr',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.primaryDark
                                        : AppColors.oliveDark,
                                  ),
                                ),
                                const Spacer(),
                                if (result.hijriDate != null)
                                  Text(
                                    result.hijriDate!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.onSurfaceVariantDark
                                          : AppColors.onSurfaceVariantLight,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Subtle corner ornaments
                          Positioned(
                            top: 0,
                            left: 0,
                            child: IslamicCornerOrnament(
                              size: 20,
                              opacity: isDark ? 0.10 : 0.15,
                              corner: CornerPosition.topLeft,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IslamicCornerOrnament(
                              size: 20,
                              opacity: isDark ? 0.10 : 0.15,
                              corner: CornerPosition.topRight,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ) ?? const SizedBox.shrink(),

                // Today's prayer tracker
                _PrayerTrackerCard(isDark: isDark),
                const SizedBox(height: 16),

                // Status card
                if (isPaused)
                  _StatusCard(
                    icon: Icons.pause_circle_outline,
                    message: context.tr('gating_paused'),
                    color: AppColors.warning,
                    isDark: isDark,
                  ),

                // Today's stats
                _StatsRow(
                  streak: prefs.streakCurrent,
                  isDark: isDark,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ManuscriptDivider(height: 24),
                ),

                // Gated apps section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr('gated_apps'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.appSelection),
                      child: Text(context.tr('manage')),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                blockedAppsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => Text('${context.tr('dash_error')}: $e'),
                  data: (apps) {
                    if (apps.isEmpty) {
                      return _EmptyAppsCard(isDark: isDark);
                    }
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: apps.map((app) {
                        return _AppChip(
                          name: app.displayName,
                          isDark: isDark,
                        );
                      }).toList(),
                    );
                  },
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: ManuscriptDivider(height: 24),
                ),

                // Quick actions
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(AppRoutes.gate),
                    icon: const Icon(Icons.menu_book_outlined),
                    label: Text(context.tr('read_now_voluntary')),
                  ),
                ),
              ],
            );
          },
        ),
      ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.message,
    required this.color,
    required this.isDark,
  });

  final IconData icon;
  final String message;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(
            message,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends ConsumerWidget {
  const _StatsRow({required this.streak, required this.isDark});

  final int streak;
  final bool isDark;

  String _formatReadingTime(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final minutes = seconds ~/ 60;
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final remainingMin = minutes % 60;
    return '${hours}h ${remainingMin}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayCount = ref.watch(todayGateCountProvider);
    final todayReading = ref.watch(todayReadingSecondsProvider);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: context.tr('today'),
            value: todayCount.when(
              data: (c) => '$c',
              loading: () => '—',
              error: (_, _) => '—',
            ),
            icon: Icons.auto_stories_outlined,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: context.tr('reading_time'),
            value: todayReading.when(
              data: (s) => s == 0 ? '—' : _formatReadingTime(s),
              loading: () => '—',
              error: (_, _) => '—',
            ),
            icon: Icons.schedule_outlined,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: context.tr('streak'),
            value: '$streak',
            icon: Icons.local_fire_department_outlined,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.isDark,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyAppsCard extends StatelessWidget {
  const _EmptyAppsCard({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.apps_outlined,
              size: 40,
              color: isDark
                  ? AppColors.onSurfaceVariantDark
                  : AppColors.onSurfaceVariantLight,
            ),
            const SizedBox(height: 12),
            Text(
              context.tr('no_apps_gated'),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              context.tr('choose_apps_hint'),
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
    );
  }
}

/// "Today's Prayers" tracker — five tappable prayer markers + count.
class _PrayerTrackerCard extends ConsumerWidget {
  const _PrayerTrackerCard({required this.isDark});
  final bool isDark;

  static const _icons = {
    'fajr': Icons.wb_twilight,
    'dhuhr': Icons.wb_sunny_outlined,
    'asr': Icons.wb_cloudy_outlined,
    'maghrib': Icons.brightness_4_outlined,
    'isha': Icons.nightlight_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayed = ref.watch(todayPrayerLogProvider).valueOrNull ?? <String>{};
    final repo = ref.read(prayerTrackerRepositoryProvider);
    final today = PrayerTrackerRepository.dateKey(DateTime.now());
    final primary = Theme.of(context).colorScheme.primary;
    final muted = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr('todays_prayers'),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${prayed.length}/5',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: PrayerTrackerRepository.prayers.map((p) {
                final isPrayed = prayed.contains(p);
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => repo.togglePrayed(today, p, !isPrayed),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPrayed ? primary : Colors.transparent,
                            border: Border.all(
                              color: isPrayed
                                  ? primary
                                  : muted.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            isPrayed ? Icons.check : _icons[p],
                            size: 19,
                            color: isPrayed ? Colors.white : muted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          context.tr(p),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: isPrayed
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isPrayed ? primary : null,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppChip extends StatelessWidget {
  const _AppChip({required this.name, required this.isDark});

  final String name;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.lock_outline, size: 18),
      label: Text(name),
      backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
