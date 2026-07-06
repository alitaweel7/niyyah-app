import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

/// Simple notification settings: a small, sensible set of daily reminders.
/// The scheduler sends at most 2 per day (3 on Fridays), rotating and in the
/// app's language.
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  Future<void> _reschedule(WidgetRef ref) async {
    try {
      await ref.read(islamicRemindersServiceProvider).scheduleAll();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesStreamProvider);
    final repo = ref.read(preferencesRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('noti_title'))),
      body: Stack(
        children: [
          const ParchmentBackground(),
          prefsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (prefs) {
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
                    child: Text(
                      context.tr('noti_intro'),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.wb_sunny_outlined),
                    title: Text(context.tr('noti_morning')),
                    subtitle: Text(context.tr('noti_morning_sub')),
                    value: prefs.notifyMorningAdhkar,
                    onChanged: (v) async {
                      await repo.updateNotifyMorningAdhkar(v);
                      await _reschedule(ref);
                    },
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.nights_stay_outlined),
                    title: Text(context.tr('noti_evening')),
                    subtitle: Text(context.tr('noti_evening_sub')),
                    value: prefs.notifyEveningAdhkar,
                    onChanged: (v) async {
                      await repo.updateNotifyEveningAdhkar(v);
                      await _reschedule(ref);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ManuscriptDivider(height: 20),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.menu_book_outlined),
                    title: Text(context.tr('noti_friday_kahf')),
                    subtitle: Text(context.tr('noti_friday_kahf_short')),
                    value: prefs.notifyFridayKahf,
                    onChanged: (v) async {
                      await repo.updateNotifyFridayKahf(v);
                      await _reschedule(ref);
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await ref
                            .read(islamicRemindersServiceProvider)
                            .sendSample();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(context.tr('noti_sample_sent'))),
                          );
                        }
                      },
                      icon: const Icon(Icons.notifications_active_outlined),
                      label: Text(context.tr('noti_send_sample')),
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
}
