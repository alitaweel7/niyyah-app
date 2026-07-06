import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class LearningScreen extends ConsumerWidget {
  const LearningScreen({super.key});

  String _formatTime(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final minutes = seconds ~/ 60;
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final remainingMin = minutes % 60;
    return '${hours}h ${remainingMin}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quranProgress = ref.watch(quranProgressProvider);
    final duasRead = ref.watch(duasReadCountProvider);
    final totalReading = ref.watch(totalReadingSecondsProvider);
    final prefsAsync = ref.watch(preferencesStreamProvider);
    final todayGates = ref.watch(todayGateCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('my_learning')),
      ),
      body: Stack(
        children: [
          const ParchmentBackground(),
          ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ManuscriptHeader(
            height: 60,
            child: Text(
              context.tr('quran_progress'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 16),

          // Hero progress ring — percent of the Quran read
          _QuranProgressHero(
            progress: quranProgress,
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Ayahs / Surahs read at a glance
          Row(
            children: [
              Expanded(
                child: _MiniStatCard(
                  label: context.tr('ayahs_read'),
                  value: quranProgress.when(
                    data: (p) => '${p.distinctAyahsRead}',
                    loading: () => '—',
                    error: (_, _) => '—',
                  ),
                  hint: '${context.tr('learn_of')} 6,236',
                  icon: Icons.menu_book_outlined,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MiniStatCard(
                  label: context.tr('surahs_completed'),
                  value: quranProgress.when(
                    data: (p) => '${p.completedSurahCount}',
                    loading: () => '—',
                    error: (_, _) => '—',
                  ),
                  hint: '${context.tr('learn_of')} 114',
                  icon: Icons.check_circle_outline,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Current reading position
          prefsAsync.when(
            data: (prefs) => _PositionCard(
              surahNumber: prefs.sequentialPositionSurah,
              ayahNumber: prefs.sequentialPositionAyah,
              isDark: isDark,
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 12),

          // Completed surahs list
          _CompletedSurahsList(isDark: isDark),

          const SizedBox(height: 16),
          const ManuscriptDivider(height: 24),
          const SizedBox(height: 16),

          ManuscriptHeader(
            height: 60,
            child: Text(
              context.tr('duas_learned'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          _ProgressCard(
            icon: Icons.favorite_outline,
            title: context.tr('duas_read'),
            value: duasRead.when(
              data: (v) => '$v',
              loading: () => '—',
              error: (_, _) => '—',
            ),
            subtitle: context.tr('keep_learning'),
            isDark: isDark,
          ),

          const SizedBox(height: 16),
          const ManuscriptDivider(height: 24),
          const SizedBox(height: 16),

          ManuscriptHeader(
            height: 60,
            child: Text(
              context.tr('summary'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MiniStatCard(
                  label: context.tr('total_reading_time'),
                  value: totalReading.when(
                    data: (s) => s == 0 ? '0m' : _formatTime(s),
                    loading: () => '—',
                    error: (_, _) => '—',
                  ),
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MiniStatCard(
                  label: context.tr('current_streak'),
                  value: prefsAsync.when(
                    data: (p) => '${p.streakCurrent} ${context.tr('learn_days')}',
                    loading: () => '—',
                    error: (_, _) => '—',
                  ),
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MiniStatCard(
                  label: context.tr('gates_today'),
                  value: todayGates.when(
                    data: (v) => '$v',
                    loading: () => '—',
                    error: (_, _) => '—',
                  ),
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 20),
          const Center(child: RoseAccent(size: 28)),
          const SizedBox(height: 12),
        ],
      ),
        ],
      ),
    );
  }
}

/// Premium hero card: a circular ring showing the percent of the Quran read,
/// with the percentage centered and a short caption below.
class _QuranProgressHero extends StatelessWidget {
  const _QuranProgressHero({
    required this.progress,
    required this.isDark,
  });

  final AsyncValue<QuranProgress> progress;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final mutedColor =
        isDark ? AppColors.onSurfaceVariantDark : AppColors.onSurfaceVariantLight;
    final trackColor =
        isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight;

    final percent = progress.maybeWhen(
      data: (p) => p.percent,
      orElse: () => 0.0,
    );
    final percentLabel = progress.when(
      data: (p) => '${(p.percent * 100).toStringAsFixed(1)}%',
      loading: () => '—',
      error: (_, _) => '—',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Progress ring
            SizedBox(
              width: 92,
              height: 92,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 92,
                    height: 92,
                    child: CircularProgressIndicator(
                      value: percent.clamp(0.0, 1.0),
                      strokeWidth: 7,
                      strokeCap: StrokeCap.round,
                      backgroundColor: trackColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primary),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        percentLabel,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Caption
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('ayahs_read'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    progress.when(
                      data: (p) =>
                          '${p.distinctAyahsRead} ${context.tr('learn_of')} 6,236',
                      loading: () => '${context.tr('learn_of')} 6,236',
                      error: (_, _) => '${context.tr('learn_of')} 6,236',
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.tr('of_total_quran'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.isDark,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _IconBadge(icon: icon, isDark: isDark),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A subtle, brand-tinted rounded square that houses a leading icon.
class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.isDark});

  final IconData icon;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceVariantDark
            : AppColors.surfaceVariantLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20, color: primary),
    );
  }
}

class _PositionCard extends StatelessWidget {
  const _PositionCard({
    required this.surahNumber,
    required this.ayahNumber,
    required this.isDark,
  });

  final int surahNumber;
  final int ayahNumber;
  final bool isDark;

  // Surah names for display
  static const _surahNames = [
    '', 'Al-Fatiha', 'Al-Baqarah', 'Ali Imran', 'An-Nisa', 'Al-Ma\'idah',
    'Al-An\'am', 'Al-A\'raf', 'Al-Anfal', 'At-Tawbah', 'Yunus',
    'Hud', 'Yusuf', 'Ar-Ra\'d', 'Ibrahim', 'Al-Hijr',
    'An-Nahl', 'Al-Isra', 'Al-Kahf', 'Maryam', 'Ta-Ha',
    'Al-Anbiya', 'Al-Hajj', 'Al-Mu\'minun', 'An-Nur', 'Al-Furqan',
    'Ash-Shu\'ara', 'An-Naml', 'Al-Qasas', 'Al-Ankabut', 'Ar-Rum',
    'Luqman', 'As-Sajdah', 'Al-Ahzab', 'Saba', 'Fatir',
    'Ya-Sin', 'As-Saffat', 'Sad', 'Az-Zumar', 'Ghafir',
    'Fussilat', 'Ash-Shura', 'Az-Zukhruf', 'Ad-Dukhan', 'Al-Jathiyah',
    'Al-Ahqaf', 'Muhammad', 'Al-Fath', 'Al-Hujurat', 'Qaf',
    'Adh-Dhariyat', 'At-Tur', 'An-Najm', 'Al-Qamar', 'Ar-Rahman',
    'Al-Waqi\'ah', 'Al-Hadid', 'Al-Mujadila', 'Al-Hashr', 'Al-Mumtahanah',
    'As-Saf', 'Al-Jumu\'ah', 'Al-Munafiqun', 'At-Taghabun', 'At-Talaq',
    'At-Tahrim', 'Al-Mulk', 'Al-Qalam', 'Al-Haqqah', 'Al-Ma\'arij',
    'Nuh', 'Al-Jinn', 'Al-Muzzammil', 'Al-Muddathir', 'Al-Qiyamah',
    'Al-Insan', 'Al-Mursalat', 'An-Naba', 'An-Nazi\'at', 'Abasa',
    'At-Takwir', 'Al-Infitar', 'Al-Mutaffifin', 'Al-Inshiqaq', 'Al-Buruj',
    'At-Tariq', 'Al-A\'la', 'Al-Ghashiyah', 'Al-Fajr', 'Al-Balad',
    'Ash-Shams', 'Al-Layl', 'Ad-Duha', 'Ash-Sharh', 'At-Tin',
    'Al-Alaq', 'Al-Qadr', 'Al-Bayyinah', 'Az-Zalzalah', 'Al-Adiyat',
    'Al-Qari\'ah', 'At-Takathur', 'Al-Asr', 'Al-Humazah', 'Al-Fil',
    'Quraysh', 'Al-Ma\'un', 'Al-Kawthar', 'Al-Kafirun', 'An-Nasr',
    'Al-Masad', 'Al-Ikhlas', 'Al-Falaq', 'An-Nas',
  ];

  @override
  Widget build(BuildContext context) {
    final name = surahNumber > 0 && surahNumber < _surahNames.length
        ? _surahNames[surahNumber]
        : '${context.tr('learn_surah')} $surahNumber';
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _IconBadge(icon: Icons.bookmark_outlined, isDark: isDark),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('currently_reading'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$name, ${context.tr('learn_ayah')} $ayahNumber',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDark
                    ? AppColors.onSurfaceVariantDark
                    : AppColors.onSurfaceVariantLight),
          ],
        ),
      ),
    );
  }
}

class _CompletedSurahsList extends ConsumerWidget {
  const _CompletedSurahsList({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(quranProgressProvider);

    return progressAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (progress) {
        final completed = progress.completedSurahNumbers;
        if (completed.isEmpty) return const SizedBox.shrink();

        final theme = Theme.of(context);
        final primary = theme.colorScheme.primary;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              context.tr('completed_surahs'),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: completed.map((surahNumber) {
                final name = surahNumber > 0 &&
                        surahNumber < _PositionCard._surahNames.length
                    ? _PositionCard._surahNames[surahNumber]
                    : '${context.tr('learn_surah')} $surahNumber';
                return Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 12, 6),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceVariantDark
                        : AppColors.surfaceVariantLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? AppColors.dividerDark
                          : AppColors.dividerLight,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          size: 16, color: primary),
                      const SizedBox(width: 6),
                      Text(
                        name,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.isDark,
    this.hint,
    this.icon,
  });

  final String label;
  final String value;
  final bool isDark;
  final String? hint;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: theme.colorScheme.primary),
              const SizedBox(height: 10),
            ],
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: mutedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hint != null) ...[
              const SizedBox(height: 2),
              Text(
                hint!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: mutedColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
