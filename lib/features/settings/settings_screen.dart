import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/models/watermark_config.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final storage = ref.watch(localStorageServiceProvider);
    final autoStrip = storage.getAutoStripExif();
    final config = ref.watch(watermarkConfigProvider);
    final auditLogs = ref.watch(auditLogsProvider);
    final customPresets = ref.watch(customPresetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacyAndSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Security Architecture Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shield_outlined, color: AppColors.accent, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      l10n.zeroServerTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.zeroServerDesc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE2E8F0),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sanitasi & Keamanan Data
          Text(
            l10n.dataSecuritySanitation,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.cleaning_services_outlined, color: AppColors.primaryLight),
                  title: Text(l10n.autoSanitizeExifTitle, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  subtitle: Text(
                    l10n.autoExifSubtitle,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                  value: autoStrip,
                  activeThumbColor: AppColors.accent,
                  onChanged: (val) async {
                    await storage.setAutoStripExif(val);
                    ref.read(watermarkConfigProvider.notifier).updateStripMetadata(val);
                  },
                ),
                const Divider(color: AppColors.border, height: 1),
                ListTile(
                  leading: const Icon(Icons.file_present_outlined, color: AppColors.primaryLight),
                  title: Text(l10n.defaultExportFormat, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  subtitle: Text(
                    config.exportFormat.label,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                  trailing: DropdownButton<ExportFormat>(
                    value: config.exportFormat,
                    dropdownColor: AppColors.bgSurface,
                    underline: const SizedBox(),
                    items: ExportFormat.values.map((f) {
                      return DropdownMenuItem(
                        value: f,
                        child: Text(f.name.toUpperCase(), style: const TextStyle(fontSize: 12, color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(watermarkConfigProvider.notifier).updateExportFormat(val);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Penyimpanan Lokal
          Text(
            l10n.localDeviceStorage,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.history_edu, color: AppColors.primaryLight),
                  title: Text(l10n.history, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  subtitle: Text(
                    l10n.historySubtitle(auditLogs.length),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                  trailing: TextButton(
                    onPressed: auditLogs.isEmpty
                        ? null
                        : () async {
                            await ref.read(auditLogsProvider.notifier).clearHistory();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.historyCleared)),
                              );
                            }
                          },
                    child: Text(l10n.clearHistory, style: const TextStyle(color: AppColors.danger, fontSize: 12)),
                  ),
                ),
                const Divider(color: AppColors.border, height: 1),
                ListTile(
                  leading: const Icon(Icons.bookmark_border, color: AppColors.primaryLight),
                  title: Text(l10n.presets, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  subtitle: Text(
                    l10n.presetsSubtitle(customPresets.length),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                ),
                const Divider(color: AppColors.border, height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_sweep_outlined, color: AppColors.danger),
                  title: Text(l10n.resetDefaults, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  subtitle: Text(l10n.resetDefaultsDesc,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                  trailing: const Icon(Icons.chevron_right, color: Color(0xFF64748B)),
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: AppColors.bgSurface,
                        title: Text(l10n.resetWarningTitle, style: const TextStyle(color: Colors.white)),
                        content: Text(
                          l10n.resetWarningBody,
                          style: const TextStyle(color: Color(0xFF94A3B8)),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(l10n.cancel),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                            child: Text(l10n.reset),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await storage.clearConfig();
                      ref.read(watermarkConfigProvider.notifier).resetToDefault();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.preferencesReset)),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tentang Aplikasi
          Text(
            l10n.aboutApp,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAboutRow(l10n.appLabel, AppConstants.appName),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appVersion, '${AppConstants.appVersion}+1'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appDomain, 'idmark.faishal.id'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appCompliance, 'UU No. 27/2022 (PDP) & Kominfo'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appProvider, 'Armada faishal.id'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAboutRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}
