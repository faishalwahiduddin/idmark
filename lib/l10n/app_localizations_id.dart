// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Secure ID & Document Watermark';

  @override
  String get tabWatermark => 'Watermark';

  @override
  String get tabPreset => 'Preset';

  @override
  String get tabHistory => 'Riwayat';

  @override
  String get tabGuide => 'Panduan';

  @override
  String get tabSettings => 'Pengaturan';

  @override
  String get settings => 'Pengaturan';

  @override
  String get appearance => 'Tampilan';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get localeIndonesian => 'Bahasa Indonesia';

  @override
  String get localeEnglish => 'English';

  @override
  String get localeArabic => 'العربية';

  @override
  String get localeJavanese => 'Basa Jawa';

  @override
  String get localeSundanese => 'Basa Sunda';

  @override
  String get localeChinese => '中文';

  @override
  String get localeJapanese => '日本語';

  @override
  String get localeSpanish => 'Español';

  @override
  String get about => 'Tentang';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Edit';

  @override
  String get reset => 'Reset';

  @override
  String get kominfoGuide => 'Panduan Kominfo';

  @override
  String get history => 'Riwayat Audit Log';

  @override
  String get presets => 'Preset Kustom Pengguna';

  @override
  String get resetDefaults => 'Reset Pengaturan Bawaan';

  @override
  String get resetWarningTitle => 'Reset Preferensi?';

  @override
  String get resetWarningBody =>
      'Pengaturan watermark terakhir akan dikembalikan ke standar awal Kominfo.';

  @override
  String get aboutApp => 'Tentang Aplikasi';

  @override
  String get appVersion => 'Versi';

  @override
  String get appDomain => 'Domain';

  @override
  String get appCompliance => 'Standar Kepatuhan';

  @override
  String get appProvider => 'Penyedia';

  @override
  String get clearHistory => 'Bersihkan';

  @override
  String get historyCleared => 'Riwayat audit log dibersihkan.';

  @override
  String get preferencesReset =>
      'Preferensi berhasil direset ke rekomendasi Kominfo.';

  @override
  String get guideRules => '4 Aturan Pokok Watermark Kominfo';

  @override
  String get guideRule1Title => 'Tuliskan Nama Lembaga & Tujuan Spesifik';

  @override
  String get guideRule1Desc =>
      'Jangan hanya menulis \"VERIFIKASI\". Tuliskan lengkap seperti \"VERIFIKASI PINJAMAN PT BANK ABC\". Dengan begitu, pihak lain tidak dapat menggunakan foto tersebut di tempat lain.';

  @override
  String get guideRule2Title => 'Cantumkan Tanggal Transaksi Lengkap';

  @override
  String get guideRule2Desc =>
      'Tambahkan tanggal saat Anda mengirimkan dokumen (misal: 28-09-2026). Ini membatasi masa berlaku dokumen salinan sehingga tidak dapat didaur ulang di masa mendatang.';

  @override
  String get guideRule3Title => 'Posisikan Melintang di Atas Dokumen';

  @override
  String get guideRule3Desc =>
      'Letakkan watermark melintang di atas teks KTP secara semi-transparan. Jangan meletakkannya di area kosong di pinggir foto karena pelaku kejahatan bisa memotongnya (crop) dengan mudah.';

  @override
  String get guideRule4Title => 'Sensor Tanda Tangan & Digit Sensitif';

  @override
  String get guideRule4Desc =>
      'Tanda tangan basah adalah aset biometrik terpenting Anda. Jika verifikator hanya membutuhkan NIK dan nama, tutupi tanda tangan Anda untuk mencegah pemalsuan dokumen.';

  @override
  String get warningRejectTitle =>
      'Waspada: Pihak yang Menolak Foto Ber-Watermark';

  @override
  String get warningRejectDesc =>
      'Jika ada pihak atau aplikasi yang bersikeras meminta foto e-KTP polosan tanpa watermark padahal tujuan transaksi sudah jelas, Anda patut mencurigai niat pihak tersebut dan mempertimbangkan membatalkan transaksi.';

  @override
  String get verifiedOfficial => '★ RESMI DIVERIFIKASI ★';

  @override
  String get dateLabel => 'TGL';

  @override
  String get verifyIdentity => 'VERIFIKASI IDENTITAS';

  @override
  String get idmarkVerified => 'IDMARK VERIFIED';

  @override
  String get privacySettings => 'Pengaturan Privasi';

  @override
  String get autoStripExif => 'Otomatis hapus EXIF';

  @override
  String get autoStripExifDesc =>
      'Hapus metadata lokasi GPS dan kamera dari foto sebelum diekspor';

  @override
  String historySubtitle(int count) {
    return 'Tersimpan $count catatan ekspor on-device';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count template kustom tersimpan';
  }
}
