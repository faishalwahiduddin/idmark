import 'package:flutter/material.dart';

class AppColors {
  // Brand Primary (Cyber Blue / Indonesian Shield)
  static const Color primary = Color(0xFF0284C7); // Sky 600
  static const Color primaryDark = Color(0xFF0369A1); // Sky 700
  static const Color primaryLight = Color(0xFF38BDF8); // Sky 400
  
  // Secondary / Accent
  static const Color secondary = Color(0xFF0F172A); // Slate 900
  static const Color accent = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color danger = Color(0xFFEF4444); // Red 500

  // Background & Surfaces
  static const Color bgDark = Color(0xFF090D16);
  static const Color bgSurface = Color(0xFF111827);
  static const Color bgCard = Color(0xFF1F2937);
  static const Color border = Color(0xFF374151);

  // Light Mode Fallback
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // --- Brightness-aware text (reads on both brand-dark and light) ---
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// Headings: white on dark, slate-900 on light.
  static Color title(BuildContext context) =>
      _isDark(context) ? Colors.white : lightTextPrimary;

  /// Body copy on cards and banners.
  static Color body(BuildContext context) => _isDark(context)
      ? const Color(0xFFE2E8F0)
      : const Color(0xFF334155);

  /// Secondary / muted labels and section headers.
  static Color muted(BuildContext context) => _isDark(context)
      ? const Color(0xFF94A3B8)
      : const Color(0xFF64748B);

  /// Solid dark banner surface: keeps pale brand text readable in
  /// EITHER theme (used for all info banners instead of alpha washes).
  static const Color bannerSurface = bgSurface;

  // Watermark Color Palette Presets
  static const Color watermarkRed = Color(0xFFDC2626);
  static const Color watermarkBlue = Color(0xFF2563EB);
  static const Color watermarkDark = Color(0xFF1E293B);
  static const Color watermarkWhite = Color(0xFFF8FAFC);
  static const Color watermarkEmerald = Color(0xFF059669);
  static const Color watermarkAmber = Color(0xFFD97706);
  static const Color watermarkPurple = Color(0xFF7C3AED);
}
