import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';

class AppSelectionScreen extends ConsumerStatefulWidget {
  const AppSelectionScreen({super.key});

  @override
  ConsumerState<AppSelectionScreen> createState() => _AppSelectionScreenState();
}

class _AppSelectionScreenState extends ConsumerState<AppSelectionScreen> {
  final Set<String> _selectedPackages = {};
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadExistingApps();
  }

  Future<void> _loadExistingApps() async {
    final repo = ref.read(blockedAppRepositoryProvider);
    final apps = await repo.getActiveBlockedApps();
    setState(() {
      _selectedPackages.addAll(apps.map((a) => a.packageName));
      _loaded = true;
    });
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
      // Check free tier limit
      final activeCount = await repo.getActiveCount();
      if (activeCount >= AppConstants.freeMaxBlockedApps) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Free tier allows up to 3 apps. Upgrade to Pro for unlimited.'),
            ),
          );
        }
        return;
      }
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
        title: const Text('Select Apps to Gate'),
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Choose which apps you\'d like to gate behind a reading moment.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Free: up to ${AppConstants.freeMaxBlockedApps} apps · Pro: unlimited',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                      ),
                ),
                const SizedBox(height: 20),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          _iconForApp(displayName),
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : (isDark
                  ? AppColors.onSurfaceVariantDark
                  : AppColors.onSurfaceVariantLight),
        ),
        title: Text(displayName),
        trailing: isSelected
            ? Icon(Icons.check_circle,
                color: Theme.of(context).colorScheme.primary)
            : Icon(Icons.circle_outlined,
                color: isDark
                    ? AppColors.onSurfaceVariantDark
                    : AppColors.onSurfaceVariantLight),
        onTap: onTap,
      ),
    );
  }
}
