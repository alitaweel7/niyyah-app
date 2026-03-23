import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (prefs) {
          return ListView(
            children: [
              // Gate Settings
              _SectionTitle('Gate Settings'),
              _SettingsTile(
                icon: Icons.timer_outlined,
                title: 'Gate timer',
                subtitle: '${prefs.gateDurationSeconds ~/ 60} minutes',
                onTap: () => _showTimerPicker(context, ref, prefs.gateDurationSeconds),
              ),
              _SettingsTile(
                icon: Icons.lock_open_outlined,
                title: 'Unlock window',
                subtitle: '${prefs.unlockDurationSeconds ~/ 60} minutes',
                onTap: () {
                  // TODO: Show unlock duration picker
                },
              ),

              const Divider(),

              // Content Settings
              _SectionTitle('Content'),
              _SettingsTile(
                icon: Icons.auto_stories_outlined,
                title: 'Gate content',
                subtitle: prefs.gateContentCategories,
                onTap: () {
                  // TODO: Show content category picker
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.translate),
                title: const Text('Show translation'),
                value: prefs.showTranslation,
                onChanged: (value) async {
                  await ref
                      .read(preferencesRepositoryProvider)
                      .updateShowTranslation(value);
                },
              ),

              const Divider(),

              // App Management
              _SectionTitle('Apps'),
              _SettingsTile(
                icon: Icons.apps_outlined,
                title: 'Manage gated apps',
                subtitle: 'Add or remove apps',
                onTap: () => context.push(AppRoutes.appSelection),
              ),

              const Divider(),

              // Appearance
              _SectionTitle('Appearance'),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: prefs.themeMode,
                onTap: () => _showThemePicker(context, ref, prefs.themeMode),
              ),

              const Divider(),

              // Pause
              _SectionTitle('Pause'),
              _SettingsTile(
                icon: Icons.pause_circle_outline,
                title: 'Pause gating',
                subtitle: prefs.pauseUntilTimestamp != null
                    ? 'Paused'
                    : 'Not paused',
                onTap: () => _showPausePicker(context, ref),
              ),

              const Divider(),

              // About
              _SectionTitle('About'),
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'Aya Unlock',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  // TODO: Show about screen with attribution
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  AppConstants.tanzilAttribution,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
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
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
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
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
