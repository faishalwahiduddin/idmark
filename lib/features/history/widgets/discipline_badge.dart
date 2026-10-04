import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/providers/app_providers.dart';

/// Super-minimal gamifikasi: "N file watermark" dari audit log ekspor.
/// Murni turunan `auditLogsProvider` — tanpa provider baru, tanpa backend,
/// tanpa XP engine.
class DisciplineBadge extends ConsumerWidget {
  const DisciplineBadge({super.key});

  static String tierFor(int count) {
    if (count >= 50) return 'Teladan';
    if (count >= 10) return 'Disiplin';
    if (count >= 1) return 'Tertib';
    return 'Mulai';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(auditLogsProvider);
    final count = logs.length;

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
            child:
                const Icon(Icons.workspace_premium_outlined, color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count file watermark  •  ${tierFor(count)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Setiap ekspor aman menambah disiplin proteksi dokumen.',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Bagikan disiplin',
            icon: const Icon(Icons.share_outlined, size: 20),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(
                  text:
                      '$count file watermark • ${tierFor(count)} #IDMark',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
