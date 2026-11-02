import 'package:flutter/material.dart';

class FleetSlideItem {
  final String headline;
  final String subtext;
  final IconData? icon;
  final String? badgeText;

  const FleetSlideItem({
    required this.headline,
    required this.subtext,
    this.icon,
    this.badgeText,
  });
}

/// Brand colours and icons shared by the splash and onboarding screens.
///
/// Every user-visible string (app name, tagline, slides, buttons) comes from
/// `AppLocalizations` so it follows the selected language.
class FleetAppConfig {
  final Color primaryColor;
  final Color darkColor;
  final Color accentColor;
  final IconData fallbackIcon;

  /// Icons for the four onboarding slides, in slide order.
  final List<IconData> slideIcons;

  const FleetAppConfig({
    required this.primaryColor,
    required this.darkColor,
    required this.accentColor,
    required this.fallbackIcon,
    required this.slideIcons,
  });

  static const FleetAppConfig current = FleetAppConfig(
    primaryColor: Color(0xFF0F172A),
    darkColor: Color(0xFF020617),
    accentColor: Color(0xFF38BDF8),
    fallbackIcon: Icons.branding_watermark_rounded,
    slideIcons: [
      Icons.badge_rounded,
      Icons.lock_rounded,
      Icons.security_update_good_rounded,
      Icons.verified_rounded,
    ],
  );
}
