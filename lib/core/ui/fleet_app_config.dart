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

class FleetAppConfig {
  final String appName;
  final String tagline;
  final Color primaryColor;
  final Color darkColor;
  final Color accentColor;
  final IconData fallbackIcon;
  final String skipLabel;
  final String nextLabel;
  final String getStartedLabel;
  final String defaultBadgeText;
  final String privacyHeadline;
  final String privacyDetail;
  final List<FleetSlideItem> slides;

  const FleetAppConfig({
    required this.appName,
    required this.tagline,
    required this.primaryColor,
    required this.darkColor,
    required this.accentColor,
    required this.fallbackIcon,
    this.skipLabel = 'Lewati',
    this.nextLabel = 'Lanjut',
    this.getStartedLabel = 'Mulai Sekarang',
    this.defaultBadgeText = '100% Offline & Cepat',
    this.privacyHeadline = 'Privasi & Offline Terjamin',
    this.privacyDetail =
        'Semua data tersimpan aman di perangkat Anda tanpa pelacak.',
    required this.slides,
  });

  static final FleetAppConfig current = FleetAppConfig(
    appName: 'IdmarkGo',
    tagline: 'Beri cap watermark teks pada foto KTP, SIM & dokumen penting.',
    primaryColor: const Color(0xFF0F172A),
    darkColor: const Color(0xFF020617),
    accentColor: const Color(0xFF38BDF8),
    fallbackIcon: Icons.branding_watermark_rounded,
    slides: const [
    FleetSlideItem(
      headline: 'Stempel identitas',
      subtext: 'Tujuan & tanggal di dokumen',
      icon: Icons.badge_rounded,
      badgeText: '100% Offline & Privat',
    ),
    FleetSlideItem(
      headline: 'Preset',
      subtext: 'Template siap pakai',
      icon: Icons.lock_rounded,
      badgeText: 'Ringan & Responsif',
    ),
    FleetSlideItem(
      headline: 'Riwayat',
      subtext: 'Hasil stempel tersimpan',
      icon: Icons.security_update_good_rounded,
      badgeText: 'Tanpa Iklan & Tanpa Akun',
    ),
    FleetSlideItem(
      headline: 'On-device',
      subtext: 'Tanpa unggah ke cloud',
      icon: Icons.verified_rounded,
      badgeText: 'Data Tersimpan di Perangkat',
    ),
    ],
  );
}
