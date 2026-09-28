import 'package:flutter/material.dart';
import 'watermark_config.dart';

class WatermarkPreset {
  final String id;
  final String title;
  final String category;
  final String samplePurpose;
  final String subtext;
  final IconData icon;
  final WatermarkPattern defaultPattern;
  final WatermarkColorOption defaultColor;

  const WatermarkPreset({
    required this.id,
    required this.title,
    required this.category,
    required this.samplePurpose,
    this.subtext = 'HANYA UNTUK DOKUMEN INTERNAL',
    required this.icon,
    this.defaultPattern = WatermarkPattern.diagonalBand,
    this.defaultColor = WatermarkColorOption.red,
  });

  static const List<WatermarkPreset> defaultPresets = [
    WatermarkPreset(
      id: 'bank',
      title: 'Pembukaan Rekening Bank',
      category: 'Perbankan',
      samplePurpose: 'VERIFIKASI REKENING BANK [NAMA BANK]',
      icon: Icons.account_balance_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.red,
    ),
    WatermarkPreset(
      id: 'fintech',
      title: 'Pinjol / Fintech Resmi OJK',
      category: 'Finansial',
      samplePurpose: 'VERIFIKASI PINJAMAN RESMI [NAMA FINTECH]',
      icon: Icons.security_outlined,
      defaultPattern: WatermarkPattern.repeatedGrid,
      defaultColor: WatermarkColorOption.red,
    ),
    WatermarkPreset(
      id: 'job',
      title: 'Lamaran Pekerjaan',
      category: 'Karir',
      samplePurpose: 'VERIFIKASI REKRUTMEN PT [NAMA PERUSAHAAN]',
      icon: Icons.badge_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.blue,
    ),
    WatermarkPreset(
      id: 'rental',
      title: 'Sewa Mobil / Motor / Akomodasi',
      category: 'Rental & Wisata',
      samplePurpose: 'VERIFIKASI SEWA KENDARAAN [RENTAL XYZ]',
      icon: Icons.car_rental_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.dark,
    ),
    WatermarkPreset(
      id: 'telco',
      title: 'Registrasi Kartu SIM Prabayar',
      category: 'Telekomunikasi',
      samplePurpose: 'VERIFIKASI REGISTRASI SIM [PROVIDER]',
      icon: Icons.sim_card_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.blue,
    ),
    WatermarkPreset(
      id: 'kredit',
      title: 'Pengajuan Leasing / KPR / Multifinance',
      category: 'Multifinance',
      samplePurpose: 'VERIFIKASI PENGAJUAN KREDIT [LEASING ABC]',
      icon: Icons.home_work_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.red,
    ),
    WatermarkPreset(
      id: 'investment',
      title: 'Akun Sekuritas / Investasi',
      category: 'Investasi',
      samplePurpose: 'VERIFIKASI AKUN INVESTASI [SEKURITAS ABC]',
      icon: Icons.trending_up_outlined,
      defaultPattern: WatermarkPattern.repeatedGrid,
      defaultColor: WatermarkColorOption.blue,
    ),
    WatermarkPreset(
      id: 'ecommerce',
      title: 'Verifikasi Merchant Marketplace',
      category: 'E-Commerce',
      samplePurpose: 'VERIFIKASI TOKO [NAMA TOKO] MARKETPLACE',
      icon: Icons.storefront_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.dark,
    ),
  ];
}
