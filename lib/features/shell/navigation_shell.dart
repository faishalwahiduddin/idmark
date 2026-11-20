import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/ui/app_icon.dart';
import '../../core/ui/glass_bar.dart';
import '../../l10n/app_localizations.dart';

class NavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShell({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navSurface = isDark ? AppColors.bgSurface : Colors.white;

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: GlassBar(
        borderSide: BarBorderSide.top,
        color: navSurface,
        opacity: isDark ? 0.82 : 0.76,
        blurSigma: 20,
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: [
            NavigationDestination(
              icon: const AppIcon('nav_watermark'),
              selectedIcon: const AppIcon('nav_watermark_active', color: AppColors.primaryLight),
              label: l10n?.tabWatermark ?? 'Watermark',
            ),
            NavigationDestination(
              icon: const AppIcon('nav_preset'),
              selectedIcon: const AppIcon('nav_preset_active', color: AppColors.primaryLight),
              label: l10n?.tabPreset ?? 'Preset',
            ),
            NavigationDestination(
              icon: const AppIcon('nav_history'),
              selectedIcon: const AppIcon('nav_history_active', color: AppColors.primaryLight),
              label: l10n?.tabHistory ?? 'Riwayat',
            ),
            NavigationDestination(
              icon: const AppIcon('nav_guide'),
              selectedIcon: const AppIcon('nav_guide_active', color: AppColors.primaryLight),
              label: l10n?.tabGuide ?? 'Panduan',
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings, color: AppColors.primaryLight),
              label: l10n?.tabSettings ?? 'Pengaturan',
            ),
          ],
        ),
      ),
    );
  }
}
