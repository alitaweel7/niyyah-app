import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/gate_content_type.dart';
import '../../../l10n/app_strings.dart';
import '../../../services/prayer_times_service.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('settings')),
      ),
      body: Stack(
        children: [
          const ParchmentBackground(),
          prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (prefs) {
          return ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            children: [
              // Gate Settings
              _SectionTitle(context.tr('gate_settings')),
              _SettingsTile(
                icon: Icons.timer_outlined,
                title: context.tr('gate_timer'),
                subtitle: '${prefs.gateDurationSeconds ~/ 60} ${context.tr('minutes')}',
                onTap: () => _showTimerPicker(context, ref, prefs.gateDurationSeconds),
              ),
              _SettingsTile(
                icon: Icons.lock_open_outlined,
                title: context.tr('unlock_window'),
                subtitle: '${prefs.unlockDurationSeconds ~/ 60} ${context.tr('minutes')}',
                onTap: () => _showUnlockDurationPicker(context, ref, prefs.unlockDurationSeconds),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // Content Settings
              _SectionTitle(context.tr('content')),
              _SettingsTile(
                icon: Icons.auto_stories_outlined,
                title: context.tr('gate_content'),
                subtitle: prefs.gateContentCategories
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .map(GateContentType.fromDbValue)
                    .map((t) => t.displayName)
                    .join(', '),
                onTap: () => _showContentCategoryPicker(context, ref, prefs.gateContentCategories),
              ),
              _SettingsTile(
                icon: Icons.book_outlined,
                title: context.tr('quran_mode'),
                subtitle: QuranMode.fromDbValue(prefs.quranMode).displayName,
                onTap: () => _showQuranModePicker(context, ref, prefs.quranMode),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.translate),
                title: Text(context.tr('show_translation')),
                value: prefs.showTranslation,
                onChanged: (value) async {
                  await ref
                      .read(preferencesRepositoryProvider)
                      .updateShowTranslation(value);
                },
              ),
              _SettingsTile(
                icon: Icons.language,
                title: context.tr('translation_language'),
                subtitle: _languageDisplayName(prefs.translationLanguage),
                onTap: () => _showLanguagePicker(context, ref, prefs.translationLanguage),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // App Management
              _SectionTitle(context.tr('apps')),
              _SettingsTile(
                icon: Icons.apps_outlined,
                title: context.tr('manage_gated_apps'),
                subtitle: context.tr('add_remove_apps'),
                onTap: () => context.push(AppRoutes.appSelection),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // Prayer Times
              _SectionTitle(context.tr('prayer_times')),
              _SettingsTile(
                icon: Icons.mosque_outlined,
                title: context.tr('calculation_method'),
                subtitle: _calcMethodLabel(context, prefs.prayerCalculationMethod),
                onTap: () => _showCalcMethodPicker(
                    context, ref, prefs.prayerCalculationMethod),
              ),
              _SettingsTile(
                icon: Icons.schedule_outlined,
                title: context.tr('asr_madhab'),
                subtitle: prefs.madhab == 'hanafi'
                    ? context.tr('asr_hanafi')
                    : context.tr('asr_shafi'),
                onTap: () => _showMadhabPicker(context, ref, prefs.madhab),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // Notifications
              _SectionTitle(context.tr('notifications')),
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: context.tr('notification_settings'),
                subtitle: context.tr('notif_subtitle'),
                onTap: () => context.push(AppRoutes.notificationSettings),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // Appearance
              _SectionTitle(context.tr('appearance')),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: context.tr('theme'),
                subtitle: context.tr('theme_${prefs.themeMode}'),
                onTap: () => _showThemePicker(context, ref, prefs.themeMode),
              ),
              _SettingsTile(
                icon: Icons.translate,
                title: context.tr('language'),
                subtitle:
                    AppStrings.supportedLanguages[prefs.localeCode] ?? 'English',
                onTap: () =>
                    _showAppLanguagePicker(context, ref, prefs.localeCode),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // Pause
              _SectionTitle(context.tr('pause')),
              _SettingsTile(
                icon: Icons.pause_circle_outline,
                title: context.tr('pause_gating'),
                subtitle: prefs.pauseUntilTimestamp != null
                    ? context.tr('paused')
                    : context.tr('not_paused'),
                onTap: () => _showPausePicker(context, ref),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ManuscriptDivider(height: 18),
              ),

              // About
              _SectionTitle(context.tr('about')),
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'Niyyah',
                subtitle: 'Version 1.0.0',
                onTap: () => context.push(AppRoutes.privacyPolicy),
              ),
              const SizedBox(height: 24),
              const Center(child: RoseAccent(size: 24)),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Text(
                  AppConstants.tanzilAttribution,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
        ],
      ),
    );
  }

  void _showTimerPicker(
      BuildContext context, WidgetRef ref, int currentSeconds) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Gate Timer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ...AppConstants.gateTimerPresets.map((seconds) {
                final minutes = seconds ~/ 60;
                final isSelected = seconds == currentSeconds;
                return ListTile(
                  title: Text('$minutes ${minutes == 1 ? 'minute' : 'minutes'}'),
                  trailing: isSelected
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () async {
                    await ref
                        .read(preferencesRepositoryProvider)
                        .updateGateDuration(seconds);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showThemePicker(
      BuildContext context, WidgetRef ref, String currentTheme) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Theme',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ...['system', 'light', 'dark'].map((mode) {
                final isSelected = mode == currentTheme;
                return ListTile(
                  title: Text(mode[0].toUpperCase() + mode.substring(1)),
                  trailing: isSelected
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () async {
                    await ref
                        .read(preferencesRepositoryProvider)
                        .updateThemeMode(mode);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showPausePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Pause Gating',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                title: const Text('1 hour'),
                onTap: () => _setPause(context, ref, const Duration(hours: 1)),
              ),
              ListTile(
                title: const Text('3 hours'),
                onTap: () => _setPause(context, ref, const Duration(hours: 3)),
              ),
              ListTile(
                title: const Text('Until tomorrow'),
                onTap: () => _setPause(context, ref, const Duration(hours: 12)),
              ),
              ListTile(
                title: const Text('Resume now'),
                onTap: () async {
                  await ref
                      .read(preferencesRepositoryProvider)
                      .setPauseUntil(null);
                  if (context.mounted) Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future<void> _setPause(
      BuildContext context, WidgetRef ref, Duration duration) async {
    final until = DateTime.now().add(duration).millisecondsSinceEpoch ~/ 1000;
    await ref.read(preferencesRepositoryProvider).setPauseUntil(until);
    if (context.mounted) Navigator.pop(context);
  }

  void _showUnlockDurationPicker(
      BuildContext context, WidgetRef ref, int currentSeconds) {
    final options = [300, 600, 900, 1200, 1800]; // 5, 10, 15, 20, 30 min
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Unlock Window',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ...options.map((seconds) {
                final minutes = seconds ~/ 60;
                final isSelected = seconds == currentSeconds;
                return ListTile(
                  title: Text('$minutes minutes'),
                  trailing: isSelected
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () async {
                    await ref
                        .read(preferencesRepositoryProvider)
                        .updateUnlockDuration(seconds);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showContentCategoryPicker(
      BuildContext context, WidgetRef ref, String currentCategories) {
    final selected = currentCategories
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toSet();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Gate Content',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: GateContentType.values.map((type) {
                            final isSelected =
                                selected.contains(type.dbValue);
                            final isLocked = type.isPremium;
                            return CheckboxListTile(
                              title: Text(type.displayName),
                              subtitle:
                                  isLocked ? const Text('Pro') : null,
                              value: isSelected,
                              onChanged: isLocked
                                  ? null
                                  : (value) {
                                      setSheetState(() {
                                        if (value == true) {
                                          selected.add(type.dbValue);
                                        } else {
                                          selected.remove(type.dbValue);
                                          if (selected.isEmpty) {
                                            selected.add(
                                                GateContentType.quran.dbValue);
                                          }
                                        }
                                      });
                                    },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(preferencesRepositoryProvider)
                                .updateContentCategories(
                                  selected
                                      .map(GateContentType.fromDbValue)
                                      .toList(),
                                );
                            if (context.mounted) Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showQuranModePicker(
      BuildContext context, WidgetRef ref, String currentMode) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Quran Mode',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ...QuranMode.values.map((mode) {
                final isSelected = mode.dbValue == currentMode;
                return ListTile(
                  title: Text(mode.displayName),
                  subtitle: Text(switch (mode) {
                    QuranMode.shortSurah => 'Random short Surah from Juz Amma',
                    QuranMode.randomAyah => 'Random Ayah from the entire Quran',
                    QuranMode.sequential =>
                      'Read through the Quran sequentially',
                  }),
                  trailing: isSelected
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () async {
                    await ref
                        .read(preferencesRepositoryProvider)
                        .updateQuranMode(mode);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  static const _languages = {
    'en': 'English',
    'ur': 'اردو (Urdu)',
    'tr': 'Türkçe (Turkish)',
    'fr': 'Français (French)',
    'id': 'Bahasa Indonesia',
    'bn': 'বাংলা (Bengali)',
    'ms': 'Bahasa Melayu',
    'de': 'Deutsch (German)',
    'es': 'Español (Spanish)',
  };

  String _languageDisplayName(String code) {
    return _languages[code] ?? 'English';
  }

  void _showLanguagePicker(
      BuildContext context, WidgetRef ref, String currentLang) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Translation Language',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _languages.entries.map((entry) {
                        final isSelected = entry.key == currentLang;
                        return ListTile(
                          title: Text(entry.value),
                          trailing: isSelected
                              ? Icon(Icons.check,
                                  color: Theme.of(context).colorScheme.primary)
                              : null,
                          onTap: () async {
                            await ref
                                .read(preferencesRepositoryProvider)
                                .updateTranslationLanguage(entry.key);
                            if (context.mounted) Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  String _calcMethodLabel(BuildContext context, String method) {
    if (method == 'auto') return context.tr('calc_method_auto');
    for (final m in PrayerCalculationMethod.values) {
      if (m.name == method) return PrayerTimesService.methodDisplayName(m);
    }
    return context.tr('calc_method_auto');
  }

  void _showAppLanguagePicker(
      BuildContext context, WidgetRef ref, String current) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(context.tr('language'),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              ...AppStrings.supportedLanguages.entries.map((e) {
                final isSelected = e.key == current;
                return ListTile(
                  title: Text(e.value),
                  trailing: isSelected
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () async {
                    await ref
                        .read(preferencesRepositoryProvider)
                        .updateLocale(e.key);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// Re-schedule prayer/adhkar notifications after a prayer-time setting changes
  /// so notification times reflect the new method/madhab immediately.
  Future<void> _rescheduleReminders(WidgetRef ref) async {
    try {
      await ref.read(islamicRemindersServiceProvider).scheduleAll();
    } catch (e) {
      debugPrint('Reschedule after prayer setting change failed: $e');
    }
  }

  void _showCalcMethodPicker(
      BuildContext context, WidgetRef ref, String current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Calculation Method',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: PrayerCalculationMethod.values.map((m) {
                        final isSelected = m.name == current;
                        return ListTile(
                          title:
                              Text(PrayerTimesService.methodDisplayName(m)),
                          trailing: isSelected
                              ? Icon(Icons.check,
                                  color: Theme.of(context).colorScheme.primary)
                              : null,
                          onTap: () async {
                            await ref
                                .read(preferencesRepositoryProvider)
                                .updatePrayerCalculationMethod(m.name);
                            await _rescheduleReminders(ref);
                            if (context.mounted) Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMadhabPicker(BuildContext context, WidgetRef ref, String current) {
    const options = [
      ('shafi', 'Shafi / Standard', 'Earlier Asr (used by most calendars)'),
      ('hanafi', 'Hanafi', 'Later Asr'),
    ];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Asr Time (Madhab)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              ...options.map((opt) {
                final isSelected = opt.$1 == current;
                return ListTile(
                  title: Text(opt.$2),
                  subtitle: Text(opt.$3),
                  trailing: isSelected
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () async {
                    await ref
                        .read(preferencesRepositoryProvider)
                        .updateMadhab(opt.$1);
                    await _rescheduleReminders(ref);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsetsDirectional.only(top: 2),
        child: Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: mutedColor),
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: 20, color: mutedColor),
      onTap: onTap,
    );
  }
}
