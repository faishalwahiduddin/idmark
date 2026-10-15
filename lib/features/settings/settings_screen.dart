import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../core/ui/app_scroll.dart';
import '../../core/ui/press_scale.dart';
import '../../core/constants/app_constants.dart';
import '../../core/models/watermark_config.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/timezone_provider.dart';
import '../../core/utils/app_timezone.dart';
import '../../core/utils/l10n_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../../../core/ui/spring_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const List<String> _supportedLocales = [
    'id',
    'en',
    'ar',
    'jv',
    'su',
    'zh',
    'ja',
    'es',
  ];

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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacyAndSettings),
      ),
      body: ListView(
        physics: AppScroll.physics,
        padding: AppScroll.pagePadding(context),
        children: [
          // Security Architecture Card (solid surface: readable either theme)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.bannerSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.12)),
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
          Text(
            'Tampilan & Bahasa',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.muted(context),
              letterSpacing: -0.3,
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
                      Expanded(
                        child: Text(
                          'Mode Tema',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.title(context)),
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
                  const Divider(height: 24),
                  PressScale(
                    scale: 0.98,
                    onTap: () => _showLanguageModal(context, ref, currentLocale, l10n),
                    child: IgnorePointer(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.translate, color: AppColors.primaryLight, size: 20),
                        title: Text(l10n.appLanguage, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.title(context))),
                        subtitle: Text(
                          languageName(langCode, l10n),
                          style: TextStyle(fontSize: 12, color: AppColors.muted(context)),
                        ),
                        trailing: Icon(Icons.chevron_right, color: AppColors.muted(context)),
                      ),
                    ),
                  ),
                  const Divider(height: 24),
                  Semantics(
                    button: true,
                    label: l10n.timezone,
                    child: PressScale(
                      scale: 0.98,
                      onTap: () => _showTimezoneModal(context, ref),
                      child: IgnorePointer(
                        child: ListTile(
                          key: const ValueKey('timezone_picker'),
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.schedule, color: AppColors.primaryLight, size: 20),
                          title: Text(l10n.timezone,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.title(context))),
                          subtitle: Text(
                            _currentTimezoneLabel(ref, l10n),
                            style: TextStyle(fontSize: 12, color: AppColors.muted(context)),
                          ),
                          trailing: Icon(Icons.chevron_right, color: AppColors.muted(context)),
                        ),
                      ),
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.muted(context),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.cleaning_services_outlined, color: AppColors.primaryLight),
                  title: Text(l10n.autoSanitizeExifTitle, style: TextStyle(fontSize: 14, color: AppColors.title(context))),
                  subtitle: Text(
                    l10n.autoExifSubtitle,
                    style: TextStyle(fontSize: 12, color: AppColors.muted(context)),
                  ),
                  value: autoStrip,
                  activeThumbColor: AppColors.accent,
                  onChanged: (val) async {
                    await storage.setAutoStripExif(val);
                    ref.read(watermarkConfigProvider.notifier).updateStripMetadata(val);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.file_present_outlined, color: AppColors.primaryLight),
                  title: Text(l10n.defaultExportFormat, style: TextStyle(fontSize: 14, color: AppColors.title(context))),
                  subtitle: Text(
                    config.exportFormat.label,
                    style: TextStyle(fontSize: 12, color: AppColors.muted(context)),
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.muted(context),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.history_edu, color: AppColors.primaryLight),
                  title: Text(l10n.history, style: TextStyle(fontSize: 14, color: AppColors.title(context))),
                  subtitle: Text(
                    l10n.historySubtitle(auditLogs.length),
                    style: TextStyle(fontSize: 12, color: AppColors.muted(context)),
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
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.bookmark_border, color: AppColors.primaryLight),
                  title: Text(l10n.presets, style: TextStyle(fontSize: 14, color: AppColors.title(context))),
                  subtitle: Text(
                    l10n.presetsSubtitle(customPresets.length),
                    style: TextStyle(fontSize: 12, color: AppColors.muted(context)),
                  ),
                ),
                const Divider(height: 1),
                PressScale(
                  scale: 0.98,
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n.resetWarningTitle, style: TextStyle(color: AppColors.title(context))),
                        content: Text(
                          l10n.resetWarningBody,
                          style: TextStyle(color: AppColors.body(context)),
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
                  child: IgnorePointer(
                    child: ListTile(
                      leading: const Icon(Icons.delete_sweep_outlined, color: AppColors.danger),
                      title: Text(l10n.resetDefaults, style: TextStyle(fontSize: 14, color: AppColors.title(context))),
                      subtitle: Text(l10n.resetDefaultsDesc,
                          style: TextStyle(fontSize: 12, color: AppColors.muted(context))),
                      trailing: Icon(Icons.chevron_right, color: AppColors.muted(context)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tentang Aplikasi & Lisensi
          Text(
            l10n.aboutApp,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.muted(context),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutRow(context, l10n.appLabel, AppConstants.appName),
                  const Divider(height: 24),
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      final version = snapshot.hasData
                          ? '${snapshot.data!.version}+${snapshot.data!.buildNumber}'
                          : '...';
                      return _buildAboutRow(context, l10n.appVersion, version);
                    },
                  ),
                  const Divider(height: 24),
                  _buildAboutRow(context, l10n.appDomain, 'idmark.faishal.id'),
                  const Divider(height: 24),
                  _buildAboutRow(context, 'Identitas', 'id.faishal.idmark'),
                  const Divider(height: 24),
                  _buildAboutRow(context, l10n.appCompliance, 'UU No. 27/2022 (PDP) & Kominfo'),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.licenseUsageTitle,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.title(context)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          l10n.licenseUsageBadgeText,
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
                    l10n.licenseUsageNotice,
                    style: TextStyle(fontSize: 12, color: AppColors.muted(context), height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
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
    showSpringSheet(
      context: context,
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
                  physics: AppScroll.physics,
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

  void _showLanguageModal(BuildContext context, WidgetRef ref, Locale currentLocale, AppLocalizations l10n) {
    showSpringSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.selectLanguage,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  physics: AppScroll.physics,
                  children: _supportedLocales.map((code) {
                    final isSelected = code == currentLocale.languageCode;
                    return PressScale(
                      scale: 0.98,
                      onTap: () {
                        ref.read(localeProvider.notifier).setLocale(Locale(code));
                        Navigator.pop(ctx);
                      },
                      child: IgnorePointer(
                        child: ListTile(
                          title: Text(languageName(code, l10n)),
                          trailing: isSelected ? const Icon(Icons.check, color: AppColors.accent) : null,
                        ),
                      ),
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

  Widget _buildAboutRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.muted(context))),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.title(context))),
        ),
      ],
    );
  }
}
