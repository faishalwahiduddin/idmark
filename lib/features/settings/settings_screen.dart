import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/models/watermark_config.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/timezone_provider.dart';
import '../../core/utils/app_timezone.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const Map<String, ({String name, String nativeName})> _languages = {
    'id': (name: 'Indonesian', nativeName: 'Bahasa Indonesia'),
    'en': (name: 'English', nativeName: 'English'),
    'ar': (name: 'Arabic', nativeName: 'العربية'),
    'jv': (name: 'Javanese', nativeName: 'Basa Jawa'),
    'su': (name: 'Sundanese', nativeName: 'Basa Sunda'),
    'zh': (name: 'Chinese', nativeName: '中文 (简体)'),
    'ja': (name: 'Japanese', nativeName: '日本語'),
    'es': (name: 'Spanish', nativeName: 'Español'),
  };

  static const Map<String, ({String title, String desc, String badge})> _licenseTexts = {
    'id': (
      title: 'Lisensi Penggunaan',
      desc: 'Bebas digunakan untuk keperluan personal dan non-profit.',
      badge: 'Personal & Non-Profit',
    ),
    'en': (
      title: 'Usage License',
      desc: 'Free to use for personal and non-profit use.',
      badge: 'Personal & Non-Profit',
    ),
    'ar': (
      title: 'ترخيص الاستخدام',
      desc: 'مجاني للاستخدام الشخصي وغير الربحي.',
      badge: 'شخصي وغير ربحي',
    ),
    'jv': (
      title: 'Lisensi Panganggo',
      desc: 'Bebas dienggo kanggo kaperluan pribadi lan non-profit.',
      badge: 'Pribadi & Non-Profit',
    ),
    'su': (
      title: 'Lisensi Pamakean',
      desc: 'Bebas dianggo pikeun kaperluan pribadi jeung non-profit.',
      badge: 'Pribadi & Non-Profit',
    ),
    'zh': (
      title: '使用许可',
      desc: '个人及非营利性用途免费使用。',
      badge: '个人与非营利',
    ),
    'ja': (
      title: '利用規約・ライセンス',
      desc: '個人および非営利目的での利用は無料です。',
      badge: '個人・非営利',
    ),
    'es': (
      title: 'Licencia de Uso',
      desc: 'Gratis para uso personal y sin fines de lucro.',
      badge: 'Personal y Sin Fines de Lucro',
    ),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final storage = ref.watch(localStorageServiceProvider);
    final autoStrip = storage.getAutoStripExif();
    final config = ref.watch(watermarkConfigProvider);
    final auditLogs = ref.watch(auditLogsProvider);
    final customPresets = ref.watch(customPresetsProvider);
    final currentLocale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final langCode = currentLocale.languageCode;
    final license = _licenseTexts[langCode] ?? _licenseTexts['en']!;

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

          // Tampilan & Bahasa
          const Text(
            'Tampilan & Bahasa',
            style: TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.palette_outlined, color: AppColors.primaryLight, size: 20),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Mode Tema',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                      SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment(
                            value: ThemeMode.system,
                            icon: Icon(Icons.brightness_auto, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.light,
                            icon: Icon(Icons.light_mode, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            icon: Icon(Icons.dark_mode, size: 16),
                          ),
                        ],
                        selected: {themeMode},
                        onSelectionChanged: (selected) {
                          ref.read(themeModeProvider.notifier).setThemeMode(selected.first);
                        },
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.border, height: 24),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.translate, color: AppColors.primaryLight, size: 20),
                    title: Text(l10n.appLanguage, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                    subtitle: Text(
                      '${_languages[langCode]?.nativeName ?? langCode} (${_languages[langCode]?.name ?? langCode})',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
                    onTap: () => _showLanguageModal(context, ref, currentLocale),
                  ),
                  const Divider(color: AppColors.border, height: 24),
                  Semantics(
                    button: true,
                    label: l10n.timezone,
                    child: ListTile(
                      key: const ValueKey('timezone_picker'),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.schedule, color: AppColors.primaryLight, size: 20),
                      title: Text(l10n.timezone,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                      subtitle: Text(
                        _currentTimezoneLabel(ref, l10n),
                        style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
                      onTap: () => _showTimezoneModal(context, ref),
                    ),
                  ),
                ],
              ),
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

          // Tentang Aplikasi & Lisensi
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutRow(l10n.appLabel, AppConstants.appName),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appVersion, '${AppConstants.appVersion}+1'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appDomain, 'idmark.faishal.id'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Identitas', 'id.faishal.idmark'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.appCompliance, 'UU No. 27/2022 (PDP) & Kominfo'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Ekosistem', 'Security & Privacy Fleet'),
                  const Divider(color: AppColors.border, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        license.title,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          license.badge,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    license.desc,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _currentTimezoneLabel(WidgetRef ref, AppLocalizations l10n) {
    final now = AppTimeZone.nowUtc();
    final manual = ref.watch(timezoneProvider);
    if (manual != null) {
      return '$manual (${AppTimeZone.zoneShortLabel(manual, now)})';
    }
    final device = ref.watch(timezoneNameProvider);
    return '${l10n.timezoneAuto} · $device '
        '(${AppTimeZone.offsetLabel(device, now)})';
  }

  void _showTimezoneModal(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final now = AppTimeZone.nowUtc();
    final current = ref.read(timezoneProvider);
    final device = ref.read(timezoneNameProvider);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.timezone,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      key: const ValueKey('timezone_option_auto'),
                      title: Text(l10n.timezoneAuto),
                      subtitle: Text(
                        '$device (${AppTimeZone.offsetLabel(device, now)})',
                      ),
                      trailing: current == null
                          ? const Icon(Icons.check, color: AppColors.accent)
                          : null,
                      onTap: () {
                        ref.read(timezoneProvider.notifier).resetToAuto();
                        Navigator.pop(ctx);
                      },
                    ),
                    for (final zone in kCuratedZones)
                      ListTile(
                        key: ValueKey('timezone_option_${zone.iana}'),
                        title: Text(
                          zone.shortLabel == null
                              ? '${zone.iana} (${AppTimeZone.offsetLabel(zone.iana, now)})'
                              : '${zone.iana} (${zone.shortLabel}, '
                                  '${AppTimeZone.offsetLabel(zone.iana, now)})',
                        ),
                        trailing: zone.iana == current
                            ? const Icon(Icons.check, color: AppColors.accent)
                            : null,
                        onTap: () {
                          // §VAL: setZone validates via tz.getLocation and
                          // throws ArgumentError on unknown names — the picker
                          // only offers curated zones, so this never throws.
                          ref.read(timezoneProvider.notifier).setZone(zone.iana);
                          Navigator.pop(ctx);
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageModal(BuildContext context, WidgetRef ref, Locale currentLocale) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Pilih Bahasa / Select Language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  children: _languages.entries.map((entry) {
                    final isSelected = entry.key == currentLocale.languageCode;
                    return ListTile(
                      title: Text(entry.value.nativeName),
                      subtitle: Text(entry.value.name),
                      trailing: isSelected ? const Icon(Icons.check, color: AppColors.accent) : null,
                      onTap: () {
                        ref.read(localeProvider.notifier).setLocale(Locale(entry.key));
                        Navigator.pop(ctx);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
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
