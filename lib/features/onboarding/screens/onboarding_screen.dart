import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/gate_content_type.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/islamic_patterns.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Content preferences
  final Set<String> _selectedCategories = {'quran', 'dua'};
  String _quranMode = 'short_surah';
  bool _showTranslation = true;

  // Timer settings
  int _gateDurationSeconds = 300; // 5 min default
  int _unlockDurationSeconds = 600; // 10 min default

  static const _totalPages = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    final prefsRepo = ref.read(preferencesRepositoryProvider);

    // Save content preferences
    await prefsRepo.updateContentCategories(
      _selectedCategories.map(GateContentType.fromDbValue).toList(),
    );
    await prefsRepo.updateQuranMode(QuranMode.fromDbValue(_quranMode));
    await prefsRepo.updateShowTranslation(_showTranslation);

    // Save timer settings
    await prefsRepo.updateGateDuration(_gateDurationSeconds);
    await prefsRepo.updateUnlockDuration(_unlockDurationSeconds);

    // Mark onboarding complete
    await prefsRepo.completeOnboarding();

    if (mounted) {
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLastPage = _currentPage == _totalPages - 1;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _WelcomePage(isDark: isDark, onGetStarted: _nextPage),
                  _HowItWorksPage(isDark: isDark),
                  _ContentPreferencesPage(
                    isDark: isDark,
                    selectedCategories: _selectedCategories,
                    quranMode: _quranMode,
                    showTranslation: _showTranslation,
                    onToggleCategory: (cat) {
                      setState(() {
                        if (_selectedCategories.contains(cat)) {
                          if (_selectedCategories.length > 1) {
                            _selectedCategories.remove(cat);
                          }
                        } else {
                          _selectedCategories.add(cat);
                        }
                      });
                    },
                    onQuranModeChanged: (mode) {
                      setState(() => _quranMode = mode);
                    },
                    onTranslationChanged: (value) {
                      setState(() => _showTranslation = value);
                    },
                  ),
                  _TimerSetupPage(
                    isDark: isDark,
                    gateDuration: _gateDurationSeconds,
                    unlockDuration: _unlockDurationSeconds,
                    onGateDurationChanged: (v) =>
                        setState(() => _gateDurationSeconds = v),
                    onUnlockDurationChanged: (v) =>
                        setState(() => _unlockDurationSeconds = v),
                  ),
                  _ReadyPage(isDark: isDark),
                ],
              ),
            ),
            // Bottom navigation area
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_totalPages, (index) {
                      final isActive = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: isActive ? 22 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isActive
                              ? AppColors.olive
                              : (isDark
                                  ? AppColors.onSurfaceVariantDark
                                      .withValues(alpha: 0.25)
                                  : AppColors.onSurfaceVariantLight
                                      .withValues(alpha: 0.25)),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  // Main action button (hidden on welcome page which has its own)
                  if (_currentPage > 0)
                    _PrimaryButton(
                      label: isLastPage
                          ? context.tr('onb_start')
                          : context.tr('onb_next'),
                      onPressed: isLastPage ? _completeOnboarding : _nextPage,
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

// ── Shared: primary action button ───────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.olive,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ── Shared: page header (title + subtitle) ──────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.isDark,
    required this.title,
    required this.subtitle,
  });

  final bool isDark;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.2,
            color: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            height: 1.4,
            color: isDark
                ? AppColors.onSurfaceVariantDark
                : AppColors.onSurfaceVariantLight,
          ),
        ),
      ],
    );
  }
}

// ── Shared: section label (with optional helper text) ───────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.isDark,
    required this.label,
    this.description,
  });

  final bool isDark;
  final String label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description!,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: isDark
                  ? AppColors.onSurfaceVariantDark
                  : AppColors.onSurfaceVariantLight,
            ),
          ),
        ],
      ],
    );
  }
}

// ── Page 1: Welcome ─────────────────────────────────────────────────────────

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({required this.isDark, required this.onGetStarted});

  final bool isDark;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return ManuscriptPageFrame(
      showTopBorder: true,
      cornerSize: 64,
      padding: EdgeInsets.zero,
      child: Stack(
      children: [
        // Geometric background
        Positioned.fill(
          child: IslamicGeometricPattern(
            opacity: isDark ? 0.06 : 0.10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Rose accent + Illuminated header wrapping the app name "Niyyah"
              const RoseAccent(size: 36),
              const SizedBox(height: 12),
              ManuscriptHeader(
                height: 90,
                child: Text(
                  AppConstants.appName,
                  style: TextStyle(
                    fontFamily: AppTypography.arabicFontFamily,
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: AppColors.olive,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Tagline
              Text(
                context.tr('onb_welcome_tagline'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.onSurfaceVariantDark
                      : AppColors.onSurfaceVariantLight,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
              // Description
              Text(
                context.tr('onb_welcome_description'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: isDark
                      ? AppColors.translationTextDark
                      : AppColors.translationTextLight,
                ),
              ),
              const Spacer(flex: 2),
              // Get Started button
              _PrimaryButton(
                label: context.tr('onb_get_started'),
                onPressed: onGetStarted,
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ],
    ),
    );
  }
}

// ── Page 2: How It Works ────────────────────────────────────────────────────

class _HowItWorksPage extends StatelessWidget {
  const _HowItWorksPage({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ParchmentBackground(),
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          _PageHeader(
            isDark: isDark,
            title: context.tr('onb_how_title'),
            subtitle: context.tr('onb_how_subtitle'),
          ),
          const Spacer(flex: 1),
          const Center(child: RoseAccent(size: 24)),
          const SizedBox(height: 24),
          _StepTile(
            isDark: isDark,
            stepNumber: '1',
            icon: Icons.apps_rounded,
            title: context.tr('onb_step1_title'),
            description: context.tr('onb_step1_desc'),
          ),
          const SizedBox(height: 24),
          // Connector line
          _StepConnector(isDark: isDark),
          const SizedBox(height: 24),
          _StepTile(
            isDark: isDark,
            stepNumber: '2',
            icon: Icons.menu_book_rounded,
            title: context.tr('onb_step2_title'),
            description: context.tr('onb_step2_desc'),
          ),
          const SizedBox(height: 24),
          _StepConnector(isDark: isDark),
          const SizedBox(height: 24),
          _StepTile(
            isDark: isDark,
            stepNumber: '3',
            icon: Icons.lock_open_rounded,
            title: context.tr('onb_step3_title'),
            description: context.tr('onb_step3_desc'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.isDark,
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
  });

  final bool isDark;
  final String stepNumber;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step icon tile
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.olive.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.olive, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: isDark
                        ? AppColors.onSurfaceDark
                        : AppColors.onSurfaceLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: isDark
                        ? AppColors.translationTextDark
                        : AppColors.translationTextLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 22),
      child: Container(
        width: 2,
        height: 14,
        decoration: BoxDecoration(
          color: AppColors.olive.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

// ── Page 3: Content Preferences ─────────────────────────────────────────────

class _ContentPreferencesPage extends StatelessWidget {
  const _ContentPreferencesPage({
    required this.isDark,
    required this.selectedCategories,
    required this.quranMode,
    required this.showTranslation,
    required this.onToggleCategory,
    required this.onQuranModeChanged,
    required this.onTranslationChanged,
  });

  final bool isDark;
  final Set<String> selectedCategories;
  final String quranMode;
  final bool showTranslation;
  final void Function(String) onToggleCategory;
  final void Function(String) onQuranModeChanged;
  final void Function(bool) onTranslationChanged;

  @override
  Widget build(BuildContext context) {
    final quranSelected = selectedCategories.contains('quran');

    return Stack(
      children: [
        const ParchmentBackground(),
        SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            isDark: isDark,
            title: context.tr('onb_content_title'),
            subtitle: context.tr('onb_content_subtitle'),
          ),
          const SizedBox(height: 28),

          // Category checkboxes
          _ContentCheckbox(
            isDark: isDark,
            title: context.tr('onb_cat_quran'),
            subtitle: context.tr('onb_cat_quran_sub'),
            icon: Icons.auto_stories_rounded,
            isSelected: selectedCategories.contains('quran'),
            onChanged: () => onToggleCategory('quran'),
          ),
          const SizedBox(height: 12),
          _ContentCheckbox(
            isDark: isDark,
            title: context.tr('onb_cat_duas'),
            subtitle: context.tr('onb_cat_duas_sub'),
            icon: Icons.favorite_border_rounded,
            isSelected: selectedCategories.contains('dua'),
            onChanged: () => onToggleCategory('dua'),
          ),
          const SizedBox(height: 12),
          _ContentCheckbox(
            isDark: isDark,
            title: context.tr('onb_cat_teachings'),
            subtitle: context.tr('onb_cat_teachings_sub'),
            icon: Icons.lightbulb_outline_rounded,
            isSelected: selectedCategories.contains('islamic_teaching'),
            onChanged: () => onToggleCategory('islamic_teaching'),
          ),

          // Quran mode picker (shown when Quran is selected)
          if (quranSelected) ...[
            const SizedBox(height: 20),
            const Center(child: ManuscriptDivider(height: 20)),
            const SizedBox(height: 20),
            _SectionLabel(
              isDark: isDark,
              label: context.tr('onb_quran_mode_label'),
            ),
            const SizedBox(height: 12),
            _QuranModeChip(
              isDark: isDark,
              label: context.tr('onb_quran_short_surah'),
              subtitle: context.tr('onb_quran_short_surah_sub'),
              value: 'short_surah',
              groupValue: quranMode,
              onSelected: onQuranModeChanged,
            ),
            const SizedBox(height: 8),
            _QuranModeChip(
              isDark: isDark,
              label: context.tr('onb_quran_random_ayah'),
              subtitle: context.tr('onb_quran_random_ayah_sub'),
              value: 'random_ayah',
              groupValue: quranMode,
              onSelected: onQuranModeChanged,
            ),
            const SizedBox(height: 8),
            _QuranModeChip(
              isDark: isDark,
              label: context.tr('onb_quran_sequential'),
              subtitle: context.tr('onb_quran_sequential_sub'),
              value: 'sequential',
              groupValue: quranMode,
              onSelected: onQuranModeChanged,
            ),
          ],

          // Translation toggle
          const SizedBox(height: 28),
          _TranslationToggle(
            isDark: isDark,
            value: showTranslation,
            onChanged: onTranslationChanged,
          ),
        ],
      ),
    ),
      ],
    );
  }
}

class _ContentCheckbox extends StatelessWidget {
  const _ContentCheckbox({
    required this.isDark,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onChanged,
  });

  final bool isDark;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.olive.withValues(alpha: 0.08)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.olive.withValues(alpha: 0.4)
                : (isDark
                    ? AppColors.dividerDark
                    : AppColors.dividerLight),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.olive
                  : (isDark
                      ? AppColors.onSurfaceVariantDark
                      : AppColors.onSurfaceVariantLight),
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.onSurfaceDark
                          : AppColors.onSurfaceLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.olive : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? AppColors.olive
                      : (isDark
                          ? AppColors.onSurfaceVariantDark
                              .withValues(alpha: 0.4)
                          : AppColors.onSurfaceVariantLight
                              .withValues(alpha: 0.4)),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuranModeChip extends StatelessWidget {
  const _QuranModeChip({
    required this.isDark,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  final bool isDark;
  final String label;
  final String subtitle;
  final String value;
  final String groupValue;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.olive.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.olive.withValues(alpha: 0.4)
                : (isDark
                    ? AppColors.dividerDark
                    : AppColors.dividerLight),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.olive
                      : (isDark
                          ? AppColors.onSurfaceVariantDark
                              .withValues(alpha: 0.4)
                          : AppColors.onSurfaceVariantLight
                              .withValues(alpha: 0.4)),
                  width: 1.5,
                ),
                color: isSelected ? AppColors.olive : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.circle, size: 10, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      color: isDark
                          ? AppColors.onSurfaceDark
                          : AppColors.onSurfaceLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
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

class _TranslationToggle extends StatelessWidget {
  const _TranslationToggle({
    required this.isDark,
    required this.value,
    required this.onChanged,
  });

  final bool isDark;
  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.translate_rounded,
            color: isDark
                ? AppColors.onSurfaceVariantDark
                : AppColors.onSurfaceVariantLight,
            size: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('onb_show_translation'),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.onSurfaceDark
                        : AppColors.onSurfaceLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  context.tr('onb_show_translation_sub'),
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.olive,
            activeThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

// ── Page 4: Timer Setup ─────────────────────────────────────────────────────

class _TimerSetupPage extends StatelessWidget {
  const _TimerSetupPage({
    required this.isDark,
    required this.gateDuration,
    required this.unlockDuration,
    required this.onGateDurationChanged,
    required this.onUnlockDurationChanged,
  });

  final bool isDark;
  final int gateDuration;
  final int unlockDuration;
  final void Function(int) onGateDurationChanged;
  final void Function(int) onUnlockDurationChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ParchmentBackground(),
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          _PageHeader(
            isDark: isDark,
            title: context.tr('onb_timer_title'),
            subtitle: context.tr('onb_timer_subtitle'),
          ),
          const Spacer(flex: 1),

          // Gate duration section
          _SectionLabel(
            isDark: isDark,
            label: context.tr('onb_gate_duration_label'),
            description: context.tr('onb_gate_duration_desc'),
          ),
          const SizedBox(height: 14),
          Row(
            children: AppConstants.gateTimerPresets.map((seconds) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _DurationButton(
                    isDark: isDark,
                    label: '${seconds ~/ 60} ${context.tr('minutes')}',
                    isSelected: seconds == gateDuration,
                    onTap: () => onGateDurationChanged(seconds),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Center(child: ManuscriptDivider(height: 20)),
          const SizedBox(height: 20),

          // Unlock window section
          _SectionLabel(
            isDark: isDark,
            label: context.tr('onb_unlock_window_label'),
            description: context.tr('onb_unlock_window_desc'),
          ),
          const SizedBox(height: 14),
          Row(
            children: [300, 600, 900, 1200, 1800].map((seconds) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: _DurationButton(
                    isDark: isDark,
                    label: '${seconds ~/ 60}${context.tr('onb_min_short')}',
                    isSelected: seconds == unlockDuration,
                    onTap: () => onUnlockDurationChanged(seconds),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),
          // Explanation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.olive.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.olive.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: AppColors.olive.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.tr('onb_timer_explanation'),
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    ),
      ],
    );
  }
}

class _DurationButton extends StatelessWidget {
  const _DurationButton({
    required this.isDark,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.olive
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.olive
                : (isDark
                    ? AppColors.dividerDark
                    : AppColors.dividerLight),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark
                      ? AppColors.onSurfaceDark
                      : AppColors.onSurfaceLight),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Page 5: Ready ───────────────────────────────────────────────────────────

class _ReadyPage extends StatelessWidget {
  const _ReadyPage({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ManuscriptPageFrame(
      cornerSize: 56,
      padding: EdgeInsets.zero,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Celebratory mark — rose accent above an olive check medallion
          const RoseAccent(size: 28),
          const SizedBox(height: 16),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.olive.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.olive,
              size: 34,
            ),
          ),
          const SizedBox(height: 40),
          // Bismillah in Arabic
          Text(
            'بِسْمِ ٱللَّهِ',
            style: AppTypography.arabicHeading(isDark: isDark, fontSize: 36),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          Text(
            context.tr('onb_ready_title'),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: -0.2,
              color: isDark
                  ? AppColors.onSurfaceDark
                  : AppColors.onSurfaceLight,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            context.tr('onb_ready_description'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: isDark
                  ? AppColors.translationTextDark
                  : AppColors.translationTextLight,
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    ),
    );
  }
}
