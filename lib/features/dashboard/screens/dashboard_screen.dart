import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesStreamProvider);
    final blockedAppsAsync = ref.watch(blockedAppsStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aya Unlock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_outline),
            tooltip: 'Open gate now',
            onPressed: () => context.push(AppRoutes.gate),
          ),
        ],
      ),
      body: SafeArea(
        child: prefsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (prefs) {
            final isPaused = prefs.pauseUntilTimestamp != null &&
                DateTime.now().millisecondsSinceEpoch <
                    (prefs.pauseUntilTimestamp! * 1000);

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Status card
                if (isPaused)
                  _StatusCard(
                    icon: Icons.pause_circle_outline,
                    message: 'Gating paused',
                    color: AppColors.warning,
                    isDark: isDark,
                  ),

                // Today's stats
                _StatsRow(
                  streak: prefs.streakCurrent,
                  isDark: isDark,
                ),

                const SizedBox(height: 24),

                // Gated apps section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gated Apps',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.appSelection),
                      child: const Text('Manage'),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                blockedAppsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => Text('Error: $e'),
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

                const SizedBox(height: 32),

                // Quick actions
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(AppRoutes.gate),
                    icon: const Icon(Icons.menu_book_outlined),
                    label: const Text('Read now (voluntary)'),
                  ),
                ),
              ],
            );
          },
        ),
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

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.streak, required this.isDark});

  final int streak;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Today',
            value: '—',
            icon: Icons.auto_stories_outlined,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Reading time',
            value: '—',
            icon: Icons.schedule_outlined,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Streak',
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
              'No apps gated yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose apps to gate behind a reading moment',
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
