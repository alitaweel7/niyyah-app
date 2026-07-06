import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/manuscript_decorations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(height: 1.6);
    final bulletStyle = bodyStyle?.copyWith(height: 1.8);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('priv_title'))),
      body: Stack(
        children: [
          const ParchmentBackground(),
          ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          ManuscriptHeader(
            height: 70,
            child: Text(
              context.tr('priv_heading'),
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.tr('priv_last_updated'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),

          // Intro
          _SectionCard(
            icon: Icons.favorite_outline,
            title: context.tr('priv_trust_title'),
            child: Text(
              context.tr('priv_p1'),
              style: bodyStyle,
            ),
          ),

          // What stays on device
          _SectionCard(
            icon: Icons.phone_android_outlined,
            title: context.tr('priv_device_title'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('priv_p2'),
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                _BulletItem(context.tr('priv_device_b1'), bulletStyle),
                _BulletItem(context.tr('priv_device_b2'), bulletStyle),
                _BulletItem(context.tr('priv_device_b3'), bulletStyle),
                _BulletItem(context.tr('priv_device_b4'), bulletStyle),
                _BulletItem(context.tr('priv_device_b5'), bulletStyle),
              ],
            ),
          ),

          // What we do NOT collect
          _SectionCard(
            icon: Icons.block_outlined,
            title: context.tr('priv_collect_title'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BulletItem(context.tr('priv_collect_b1'), bulletStyle),
                _BulletItem(context.tr('priv_collect_b2'), bulletStyle),
                _BulletItem(context.tr('priv_collect_b3'), bulletStyle),
                _BulletItem(context.tr('priv_collect_b4'), bulletStyle),
                _BulletItem(context.tr('priv_collect_b5'), bulletStyle),
                _BulletItem(context.tr('priv_collect_b6'), bulletStyle),
              ],
            ),
          ),

          // Permissions
          _SectionCard(
            icon: Icons.security_outlined,
            title: context.tr('priv_perms_title'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('priv_perms_intro'),
                  style: bodyStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  context.tr('priv_perms_android'),
                  style: bodyStyle?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                _BulletItem(context.tr('priv_perms_android_b1'), bulletStyle),
                _BulletItem(context.tr('priv_perms_android_b2'), bulletStyle),
                const SizedBox(height: 12),
                Text(
                  context.tr('priv_perms_ios'),
                  style: bodyStyle?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                _BulletItem(context.tr('priv_perms_ios_b1'), bulletStyle),
                const SizedBox(height: 12),
                Text(
                  context.tr('priv_perms_revoke'),
                  style: bodyStyle,
                ),
              ],
            ),
          ),

          // No ads
          _SectionCard(
            icon: Icons.money_off_outlined,
            title: context.tr('priv_noads_title'),
            child: Text(
              context.tr('priv_p3'),
              style: bodyStyle,
            ),
          ),

          // Quran data attribution
          _SectionCard(
            icon: Icons.auto_stories_outlined,
            title: context.tr('priv_qurandata_title'),
            child: Text(
              context.tr('priv_p4'),
              style: bodyStyle,
            ),
          ),

          // Future changes
          _SectionCard(
            icon: Icons.update_outlined,
            title: context.tr('priv_changes_title'),
            child: Text(
              context.tr('priv_p5'),
              style: bodyStyle,
            ),
          ),

          // Contact
          _SectionCard(
            icon: Icons.mail_outline,
            title: context.tr('priv_contact_title'),
            child: Text(
              context.tr('priv_p6'),
              style: bodyStyle,
            ),
          ),

          const SizedBox(height: 8),
          Text(
            AppConstants.tanzilAttribution,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
        ],
      ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem(this.text, this.style);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8, end: 10),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(text, style: style),
          ),
        ],
      ),
    );
  }
}
