import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/providers/app_providers.dart';
import '../../../l10n/app_localizations.dart';

/// Super-minimal gamifikasi: "N file watermark" dari audit log ekspor.
/// Murni turunan `auditLogsProvider` — tanpa provider baru, tanpa backend,
/// tanpa XP engine.
class DisciplineBadge extends ConsumerWidget {
  const DisciplineBadge({super.key});

  /// Canonical tier key for [count]. Localized at render time so the badge,
  /// the tooltip and the share text all follow the selected language.
  static String tierFor(int count) {
    if (count >= 50) return 'exemplary';
    if (count >= 10) return 'disciplined';
    if (count >= 1) return 'orderly';
    return 'starting';
  }

  static String tierLabel(String tier, AppLocalizations l10n) =>
      switch (tier) {
        'exemplary' => l10n.tierExemplary,
        'disciplined' => l10n.tierDisciplined,
        'orderly' => l10n.tierOrderly,
        _ => l10n.tierStarting,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logs = ref.watch(auditLogsProvider);
    final count = logs.length;
    final tier = tierFor(count);
    final tierName = l10n == null ? tier : tierLabel(tier, l10n);
    final shareText = l10n == null
        ? '$count file watermark • $tierName #IDMark'
        : l10n.disciplineShareText(count, tierName);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bannerSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              color: AppColors.accent,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n == null
                      ? '$count file watermark  •  $tierName'
                      : l10n.disciplineCount(count, tierName),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n?.disciplineDesc ??
                      'Setiap ekspor aman menambah disiplin proteksi dokumen.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFCBD5E1),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n?.shareDiscipline ?? 'Bagikan disiplin',
            icon: const Icon(Icons.share_outlined, size: 20),
            onPressed: () {
              SharePlus.instance.share(ShareParams(text: shareText));
            },
          ),
        ],
      ),
    );
  }
}
