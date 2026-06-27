import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class AppSelectionScreen extends ConsumerStatefulWidget {
  const AppSelectionScreen({super.key});

  @override
  ConsumerState<AppSelectionScreen> createState() => _AppSelectionScreenState();
}

class _AppSelectionScreenState extends ConsumerState<AppSelectionScreen>
    with WidgetsBindingObserver {
  final Set<String> _selectedPackages = {};
  bool _loaded = false;
  bool _permissionGranted = false;
  int _iosShieldedCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadExistingApps();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-check permission when user comes back from Settings
    if (state == AppLifecycleState.resumed && !_permissionGranted) {
      _recheckPermission();
    }
  }

  Future<void> _recheckPermission() async {
    try {
      final gateService = ref.read(appGateServiceProvider);
      final hasPerms = await gateService.hasPermissions();
      if (hasPerms && mounted) {
        setState(() => _permissionGranted = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('appsel_perm_granted'))),
        );
      }
    } catch (e) {
      debugPrint('Permission recheck failed: $e');
    }
  }

  Future<void> _loadExistingApps() async {
    try {
      final repo = ref.read(blockedAppRepositoryProvider);
      final apps = await repo.getActiveBlockedApps();

      // Check if Screen Time permission is already granted
      bool hasPerms = false;
      try {
        final gateService = ref.read(appGateServiceProvider);
        hasPerms = await gateService.hasPermissions();
      } catch (e) {
        debugPrint('Failed to check permissions: $e');
      }

      if (mounted) {
        setState(() {
          _selectedPackages.addAll(apps.map((a) => a.packageName));
          _permissionGranted = hasPerms;
          _loaded = true;
        });
      }
    } catch (e) {
      debugPrint('Failed to load existing apps: $e');
      if (mounted) {
        setState(() => _loaded = true);
      }
    }
  }

  /// Ensures Screen Time / Family Controls permission is granted.
  Future<bool> _ensurePermission() async {
    if (_permissionGranted) return true;

    try {
      final gateService = ref.read(appGateServiceProvider);
      final granted = await gateService.requestPermissions();

      if (granted) {
        setState(() => _permissionGranted = true);
        return true;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('appsel_perm_needed')),
              duration: const Duration(seconds: 6),
            ),
          );
        }
        return false;
      }
    } catch (e) {
      debugPrint('Permission request error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${context.tr('appsel_perm_error')}: $e')),
        );
      }
      return false;
    }
  }

  /// On iOS, open the native FamilyActivityPicker to select apps to shield.
  Future<void> _openIOSAppPicker() async {
    if (!await _ensurePermission()) return;

    try {
      final gateService = ref.read(appGateServiceProvider);
      final count = await gateService.showAppPicker();

      if (count > 0) {
        // Sync the count to the local database so dashboard reflects it
        await _syncIOSGatedApps(count);
      }

      setState(() {
        _iosShieldedCount = count;
      });

      if (mounted && count > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '$count ${count == 1 ? context.tr('appsel_app') : context.tr('appsel_apps')} ${context.tr('appsel_selected_for_gating')}'),
          ),
        );
      }
    } catch (e) {
      debugPrint('App picker error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${context.tr('appsel_picker_error')}: $e')),
        );
      }
    }
  }

  /// Sync iOS gated app count to the local database so the dashboard shows it.
  /// Since FamilyActivityPicker returns opaque tokens (no app names), we store
  /// a single placeholder entry with the count.
  Future<void> _syncIOSGatedApps(int count) async {
    final repo = ref.read(blockedAppRepositoryProvider);

    // Resolve localized label before any async gap (avoids context-after-await).
    final appWord =
        count == 1 ? context.tr('appsel_app') : context.tr('appsel_apps');
    final displayName =
        '$count $appWord ${context.tr('appsel_gated_via_screen_time')}';

    // Remove any existing iOS placeholder entries
    final existing = await repo.getAllBlockedApps();
    for (final app in existing.where((a) => a.platform == 'ios')) {
      await repo.removeBlockedApp(app.id);
    }

    // Add a single summary entry showing the total count
    await repo.addBlockedApp(
      packageName: 'ios_screen_time_gated',
      displayName: displayName,
    );
  }

  Map<String, String> get _availableApps {
    return Platform.isIOS
        ? AppConstants.defaultBlockableAppsIOS
        : AppConstants.defaultBlockableApps;
  }

  Future<void> _toggleApp(String packageName, String displayName) async {
    final repo = ref.read(blockedAppRepositoryProvider);

    if (_selectedPackages.contains(packageName)) {
      // Remove
      final existing = await repo.findByPackageName(packageName);
      if (existing != null) {
        await repo.removeBlockedApp(existing.id);
      }
      setState(() => _selectedPackages.remove(packageName));
    } else {
      // Request Screen Time permission before adding the first gated app
      if (!await _ensurePermission()) return;

      // Add
      await repo.addBlockedApp(
        packageName: packageName,
        displayName: displayName,
      );
      setState(() => _selectedPackages.add(packageName));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('appsel_title')),
      ),
      body: Stack(
        children: [
          const ParchmentBackground(),
          !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  context.tr('appsel_intro'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 20),
                // iOS: show button to open native FamilyActivityPicker
                if (Platform.isIOS) ...[
                  _IOSPickerCard(
                    isDark: isDark,
                    shieldedCount: _iosShieldedCount,
                    onTap: _openIOSAppPicker,
                  ),
                  const SizedBox(height: 20),
                  const Center(child: ManuscriptDivider(height: 18)),
                  const SizedBox(height: 12),
                  Text(
                    context.tr('appsel_ios_hint'),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.onSurfaceVariantDark
                              : AppColors.onSurfaceVariantLight,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
                // Android: show hardcoded list with toggles
                if (!Platform.isIOS) ...[
                  const SizedBox(height: 8),
                  const Center(child: ManuscriptDivider(height: 18)),
                  const SizedBox(height: 16),
                  ..._availableApps.entries.map((entry) {
                    final isSelected =
                        _selectedPackages.contains(entry.key);
                    return _AppTile(
                      packageName: entry.key,
                      displayName: entry.value,
                      isSelected: isSelected,
                      isDark: isDark,
                      onTap: () => _toggleApp(entry.key, entry.value),
                    );
                  }),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

/// Card button that opens the iOS FamilyActivityPicker.
class _IOSPickerCard extends StatelessWidget {
  const _IOSPickerCard({
    required this.isDark,
    required this.shieldedCount,
    required this.onTap,
  });

  final bool isDark;
  final int shieldedCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.apps_rounded, color: primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('appsel_card_title'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shieldedCount > 0
                          ? '$shieldedCount ${shieldedCount == 1 ? context.tr('appsel_app') : context.tr('appsel_apps')} ${context.tr('appsel_selected')}'
                          : context.tr('appsel_card_subtitle'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: mutedColor,
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: mutedColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppTile extends StatelessWidget {
  const _AppTile({
    required this.packageName,
    required this.displayName,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String packageName;
  final String displayName;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  IconData _iconForApp(String name) {
    switch (name.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'tiktok':
        return Icons.music_note_outlined;
      case 'x':
        return Icons.alternate_email;
      case 'snapchat':
        return Icons.chat_bubble_outline;
      case 'facebook':
        return Icons.facebook_outlined;
      case 'youtube':
        return Icons.play_circle_outline;
      default:
        return Icons.apps;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final mutedColor = isDark
        ? AppColors.onSurfaceVariantDark
        : AppColors.onSurfaceVariantLight;
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? primary.withValues(alpha: 0.12)
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _iconForApp(displayName),
                  size: 20,
                  color: isSelected ? primary : mutedColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  displayName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? primary : mutedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
