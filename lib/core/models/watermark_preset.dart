import 'package:flutter/material.dart';
import '../utils/validators.dart';
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
  final bool isCustom;

  const WatermarkPreset({
    required this.id,
    required this.title,
    required this.category,
    required this.samplePurpose,
    this.subtext = 'HANYA UNTUK DOKUMEN INTERNAL',
    required this.icon,
    this.defaultPattern = WatermarkPattern.diagonalBand,
    this.defaultColor = WatermarkColorOption.red,
    this.isCustom = false,
  });

  /// Enforces §VAL validation
  List<String> validate() {
    final errors = <String>[];
    final tErr = AppValidators.validatePresetTitle(title);
    if (tErr != null) errors.add(tErr);

    final cErr = AppValidators.validatePresetCategory(category);
    if (cErr != null) errors.add(cErr);

    final pErr = AppValidators.validatePurpose(samplePurpose);
    if (pErr != null) errors.add(pErr);

    return errors;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'samplePurpose': samplePurpose,
      'subtext': subtext,
      'iconCode': icon.codePoint,
      'defaultPattern': defaultPattern.name,
      'defaultColor': defaultColor.name,
      'isCustom': isCustom,
    };
  }

  factory WatermarkPreset.fromJson(Map<String, dynamic> json) {
    return WatermarkPreset(
      id: json['id'] as String? ?? 'preset_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Preset Kustom',
      category: json['category'] as String? ?? 'Kustom',
      samplePurpose: json['samplePurpose'] as String? ?? 'VERIFIKASI DOKUMEN',
      subtext: json['subtext'] as String? ?? 'HANYA UNTUK DOKUMEN INTERNAL',
      icon: Icons.shield_outlined,
      defaultPattern: WatermarkPattern.values.firstWhere(
        (p) => p.name == json['defaultPattern'],
        orElse: () => WatermarkPattern.diagonalBand,
      ),
      defaultColor: WatermarkColorOption.values.firstWhere(
        (c) => c.name == json['defaultColor'],
        orElse: () => WatermarkColorOption.red,
      ),
      isCustom: json['isCustom'] as bool? ?? true,
    );
  }

  static const List<WatermarkPreset> defaultPresets = [
    // 1. Perbankan
    WatermarkPreset(
      id: 'bank',
      title: 'Pembukaan Rekening Bank',
      category: 'Perbankan',
      samplePurpose: 'VERIFIKASI REKENING BANK [NAMA BANK]',
      subtext: 'KHUSUS PEMBUKAAN REKENING BARU',
      icon: Icons.account_balance_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.red,
    ),
    WatermarkPreset(
      id: 'bank_update',
      title: 'Pengkinian Data Nasabah Bank',
      category: 'Perbankan',
      samplePurpose: 'PENGKINIAN DATA NASABAH BANK [NAMA BANK]',
      subtext: 'DOKUMEN VERIFIKASI INTERNAL CABANG',
      icon: Icons.manage_accounts_outlined,
      defaultPattern: WatermarkPattern.securitySeal,
      defaultColor: WatermarkColorOption.blue,
    ),

    // 2. Fintech & Pinjol
    WatermarkPreset(
      id: 'fintech',
      title: 'Pinjol / Fintech Resmi OJK',
      category: 'Finansial & Pinjol',
      samplePurpose: 'VERIFIKASI PINJAMAN RESMI [NAMA FINTECH]',
      subtext: 'DILARANG UNTUK APLIKASI LAIN',
      icon: Icons.security_outlined,
      defaultPattern: WatermarkPattern.repeatedGrid,
      defaultColor: WatermarkColorOption.red,
    ),
    WatermarkPreset(
      id: 'paylater',
      title: 'Aktivasi Paylater / Kartu Kredit',
      category: 'Finansial & Pinjol',
      samplePurpose: 'VERIFIKASI LIMIT PAYLATER [NAMA PROVIDER]',
      subtext: 'HANYA UNTUK SATU KALI PENGAJUAN',
      icon: Icons.credit_card_outlined,
      defaultPattern: WatermarkPattern.crossStamp,
      defaultColor: WatermarkColorOption.red,
    ),

    // 3. Karir & HR
    WatermarkPreset(
      id: 'job',
      title: 'Lamaran Pekerjaan',
      category: 'Karir & HR',
      samplePurpose: 'VERIFIKASI REKRUTMEN PT [NAMA PERUSAHAAN]',
      subtext: 'ARSIP TIM REKRUTMEN HRD',
      icon: Icons.badge_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.blue,
    ),
    WatermarkPreset(
      id: 'hr_onboarding',
      title: 'Onboarding Karyawan Baru',
      category: 'Karir & HR',
      samplePurpose: 'BERKAS ONBOARDING KARYAWAN PT [NAMA PT]',
      subtext: 'DOKUMEN KONTRAK KERJA INTERNAL',
      icon: Icons.assignment_ind_outlined,
      defaultPattern: WatermarkPattern.bottomBar,
      defaultColor: WatermarkColorOption.emerald,
    ),

    // 4. Rental & Wisata
    WatermarkPreset(
      id: 'rental',
      title: 'Sewa Mobil / Motor / Rental',
      category: 'Rental & Wisata',
      samplePurpose: 'VERIFIKASI SEWA KENDARAAN [RENTAL XYZ]',
      subtext: 'JAMINAN SEWA BERLAKU S.D. TANGGAL KEMBALI',
      icon: Icons.car_rental_outlined,
      defaultPattern: WatermarkPattern.crossStamp,
      defaultColor: WatermarkColorOption.dark,
    ),
    WatermarkPreset(
      id: 'hotel_stay',
      title: 'Check-In Hotel / Villa / Kost',
      category: 'Rental & Wisata',
      samplePurpose: 'VERIFIKASI RESERVASI MENGINAP [NAMA HOTEL]',
      subtext: 'HANYA UNTUK BUKTI IDENTITAS TAMU',
      icon: Icons.hotel_outlined,
      defaultPattern: WatermarkPattern.cornerStamp,
      defaultColor: WatermarkColorOption.blue,
    ),

    // 5. Telekomunikasi
    WatermarkPreset(
      id: 'telco',
      title: 'Registrasi Kartu SIM Prabayar',
      category: 'Telekomunikasi',
      samplePurpose: 'VERIFIKASI REGISTRASI SIM [PROVIDER]',
      subtext: 'SESUAI ATURAN KOMINFO REPUBLIK INDONESIA',
      icon: Icons.sim_card_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.blue,
    ),
    WatermarkPreset(
      id: 'sim_replace',
      title: 'Ganti Kartu SIM Hilang / Rusak',
      category: 'Telekomunikasi',
      samplePurpose: 'PENGGANTIAN KARTU SIM GERAI [PROVIDER]',
      subtext: 'VALIDASI IDENTITAS PEMILIK NOMOR',
      icon: Icons.phonelink_setup_outlined,
      defaultPattern: WatermarkPattern.repeatedGrid,
      defaultColor: WatermarkColorOption.amber,
    ),

    // 6. Multifinance & Properti
    WatermarkPreset(
      id: 'kredit',
      title: 'Pengajuan Leasing / Multifinance',
      category: 'Multifinance',
      samplePurpose: 'VERIFIKASI PENGAJUAN KREDIT [LEASING ABC]',
      subtext: 'KHUSUS BERKAS SURVEY KREDIT',
      icon: Icons.directions_car_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.red,
    ),
    WatermarkPreset(
      id: 'kpr',
      title: 'Pengajuan KPR / Properti',
      category: 'Multifinance',
      samplePurpose: 'VERIFIKASI BERKAS PENGAJUAN KPR [DEVELOPER/BANK]',
      subtext: 'DOKUMEN KELENGKAPAN APLIKASI KREDIT RUMAH',
      icon: Icons.home_work_outlined,
      defaultPattern: WatermarkPattern.securitySeal,
      defaultColor: WatermarkColorOption.purple,
    ),

    // 7. Investasi & Aset Kripto
    WatermarkPreset(
      id: 'investment',
      title: 'Akun Sekuritas Saham IDX',
      category: 'Investasi',
      samplePurpose: 'VERIFIKASI AKUN INVESTASI [SEKURITAS ABC]',
      subtext: 'KYC PEMBUKAAN REKENING DANA NASABAH (RDN)',
      icon: Icons.trending_up_outlined,
      defaultPattern: WatermarkPattern.repeatedGrid,
      defaultColor: WatermarkColorOption.emerald,
    ),
    WatermarkPreset(
      id: 'crypto',
      title: 'Verifikasi Akun Kripto Bappebti',
      category: 'Investasi',
      samplePurpose: 'VERIFIKASI KYC EXCHANGE KRIPTO [NAMA PLATFORM]',
      subtext: 'VALIDASI IDENTITAS RESMI BAPPEBTI',
      icon: Icons.currency_bitcoin_outlined,
      defaultPattern: WatermarkPattern.qrBadge,
      defaultColor: WatermarkColorOption.blue,
    ),

    // 8. E-Commerce
    WatermarkPreset(
      id: 'ecommerce',
      title: 'Verifikasi Merchant Marketplace',
      category: 'E-Commerce',
      samplePurpose: 'VERIFIKASI TOKO [NAMA TOKO] MARKETPLACE',
      subtext: 'VERIFIKASI PENJUAL RESMI',
      icon: Icons.storefront_outlined,
      defaultPattern: WatermarkPattern.diagonalBand,
      defaultColor: WatermarkColorOption.dark,
    ),

    // 9. Layanan Publik
    WatermarkPreset(
      id: 'bpjs',
      title: 'Klaim JHT / Saldo BPJS',
      category: 'Layanan Publik',
      samplePurpose: 'VERIFIKASI KLAIM MANFAAT BPJS KETENAGAKERJAAN',
      subtext: 'PENGAJUAN KLAIM RESMI PESERTA',
      icon: Icons.health_and_safety_outlined,
      defaultPattern: WatermarkPattern.securitySeal,
      defaultColor: WatermarkColorOption.emerald,
    ),
    WatermarkPreset(
      id: 'gov_kelurahan',
      title: 'Administrasi Kependudukan / Kelurahan',
      category: 'Layanan Publik',
      samplePurpose: 'PENGURUSAN SURAT KETERANGAN KELURAHAN [NAMA DAERAH]',
      subtext: 'ARSIP PELAYANAN WARGA NEGARA',
      icon: Icons.account_balance,
      defaultPattern: WatermarkPattern.bottomBar,
      defaultColor: WatermarkColorOption.dark,
    ),

    // 10. Global / Internasional
    WatermarkPreset(
      id: 'global_kyc',
      title: 'International KYC Verification',
      category: 'Internasional',
      samplePurpose: 'FOR KYC COMPLIANCE VERIFICATION ONLY [INSTITUTION]',
      subtext: 'NOT VALID FOR ANY OTHER TRANSACTION',
      icon: Icons.public_outlined,
      defaultPattern: WatermarkPattern.crossStamp,
      defaultColor: WatermarkColorOption.red,
    ),
  ];
}
