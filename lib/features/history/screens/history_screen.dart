import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/app_database.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  String _formatDuration(int? seconds) {
    if (seconds == null || seconds == 0) return '—';
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m == 0) return '${s}s';
    return '${m}m ${s}s';
  }

  /// A day-level grouping label (Today / Yesterday / d/m/y).
  String _dayLabel(BuildContext context, String isoString) {
    final dt = DateTime.tryParse(isoString);
    if (dt == null) return isoString;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    if (date == today) {
      return context.tr('hist_today');
    } else if (date == today.subtract(const Duration(days: 1))) {
      return context.tr('hist_yesterday');
    }
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  /// The time-of-day for a single session row (HH:mm).
  String _timeLabel(String isoString) {
    final dt = DateTime.tryParse(isoString);
    if (dt == null) return '';
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }

  String _contentTypeLabel(BuildContext context, String type) {
    return switch (type) {
      'quran' => context.tr('hist_type_quran'),
      'dua' => context.tr('hist_type_dua'),
      'prophet_story' => context.tr('hist_type_prophet_story'),
      'sahabah_story' => context.tr('hist_type_sahabah_story'),
      'islamic_history' => context.tr('hist_type_islamic_history'),
      'islamic_teaching' => context.tr('hist_type_islamic_teaching'),
      _ => type,
    };
  }

  IconData _contentTypeIcon(String type) {
    return switch (type) {
      'quran' => Icons.menu_book_outlined,
      'dua' => Icons.favorite_outline,
      _ => Icons.auto_stories_outlined,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sessionsAsync = ref.watch(recentSessionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('hist_title')),
      ),
      body: Stack(
        children: [
          const ParchmentBackground(),
          sessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${context.tr('hist_error')}: $e')),
        data: (sessions) {
          if (sessions.isEmpty) {
            return _EmptyState(isDark: isDark);
          }

          // Build a flat list of rows: date-group headers interleaved with
          // their sessions, preserving the provider's recency order.
          final rows = <_HistoryRow>[];
          String? currentDay;
          for (final session in sessions) {
            final day = _dayLabel(context, session.startedAt);
            if (day != currentDay) {
              currentDay = day;
              rows.add(_HistoryRow.header(day));
            }
            rows.add(_HistoryRow.session(session));
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            itemCount: rows.length + 1, // +1 for divider at top
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: ManuscriptDivider(height: 24),
                );
              }
              final row = rows[index - 1];
              if (row.isHeader) {
                return _DateHeader(label: row.headerLabel!, isDark: isDark);
              }
              return _SessionCard(
                session: row.session!,
                isDark: isDark,
                formatDuration: _formatDuration,
                timeLabel: _timeLabel,
                contentTypeLabel: _contentTypeLabel,
                contentTypeIcon: _contentTypeIcon,
              );
            },
          );
        },
      ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceVariantDark
                    : AppColors.surfaceVariantLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                size: 44,
                color: mutedColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.tr('hist_empty_title'),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.tr('hist_empty_subtitle'),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: mutedColor,
              ),
            ),
            const SizedBox(height: 24),
            const RoseAccent(size: 28),
          ],
        ),
      ),
    );
  }
}

/// A lightweight tagged union for rows in the history list:
/// either a date-group header or a session.
class _HistoryRow {
  const _HistoryRow.header(String label)
      : headerLabel = label,
        session = null;
  const _HistoryRow.session(GateSession this.session) : headerLabel = null;

  final String? headerLabel;
  final GateSession? session;

  bool get isHeader => headerLabel != null;
}

/// A small uppercase-feel date group header (Today / Yesterday / date).
class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.label, required this.isDark});

  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 12, 4, 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: isDark
                  ? AppColors.onSurfaceVariantDark
                  : AppColors.onSurfaceVariantLight,
            ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.session,
    required this.isDark,
    required this.formatDuration,
    required this.timeLabel,
    required this.contentTypeLabel,
    required this.contentTypeIcon,
  });

  final GateSession session;
  final bool isDark;
  final String Function(int?) formatDuration;
  final String Function(String) timeLabel;
  final String Function(BuildContext, String) contentTypeLabel;
  final IconData Function(String) contentTypeIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    final hasExtra = session.extraReadingSeconds > 0;
    final isCompleted = session.wasCompleted;
    final iconColor = isCompleted ? primary : mutedColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceVariantDark
                    : AppColors.surfaceVariantLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                contentTypeIcon(session.gateContentType),
                size: 20,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contentTypeLabel(context, session.gateContentType),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timeLabel(session.startedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatDuration(session.actualDurationSeconds),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (hasExtra) ...[
                  const SizedBox(height: 2),
                  Text(
                    '+${formatDuration(session.extraReadingSeconds)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
