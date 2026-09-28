// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Javanese (`jv`).
class AppLocalizationsJv extends AppLocalizations {
  AppLocalizationsJv([String locale = 'jv']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Watermark KTP Aman';

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
  String get themeLight => 'Padhang';

  @override
  String get themeDark => 'Peteng';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get language => 'Basa';

  @override
  String get selectLanguage => 'Pilih Basa';

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
  String get about => 'Babagan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpen';

  @override
  String get delete => 'Busak';

  @override
  String get edit => 'Ubah';

  @override
  String get reset => 'Reset';

  @override
  String get kominfoGuide => 'Panduan Kominfo';

  @override
  String get history => 'Riwayat Log';

  @override
  String get presets => 'Preset Pangguna';

  @override
  String get resetDefaults => 'Reset menyang Gawan';

  @override
  String get resetWarningTitle => 'Reset Pengaturan?';

  @override
  String get resetWarningBody =>
      'Pengaturan watermark bakal dibalekake menyang gawan.';

  @override
  String get aboutApp => 'Babagan Aplikasi';

  @override
  String get appVersion => 'Versi';

  @override
  String get appDomain => 'Domain';

  @override
  String get appCompliance => 'Standar Kepatuhan';

  @override
  String get appProvider => 'Penyedia';

  @override
  String get clearHistory => 'Bersihake';

  @override
  String get historyCleared => 'Riwayat wis dibersihake.';

  @override
  String get preferencesReset => 'Pengaturan wis direset.';

  @override
  String get guideRules => '4 Aturan Pokok Watermark';

  @override
  String get guideRule1Title => 'Tulis Jeneng & Tujuan';

  @override
  String get guideRule1Desc =>
      'Aja mung nulis \"VERIFIKASI\". Tulis lengkap supaya ora disalahgunakake.';

  @override
  String get guideRule2Title => 'Lebokake Tanggal';

  @override
  String get guideRule2Desc => 'Tambahake tanggal kanggo matesi masa berlaku.';

  @override
  String get guideRule3Title => 'Posisi Miring';

  @override
  String get guideRule3Desc => 'Selehake watermark miring ing ndhuwur teks.';

  @override
  String get guideRule4Title => 'Tutup Tanda Tangan';

  @override
  String get guideRule4Desc =>
      'Tutup tanda tangan sampeyan kanggo nyegah pemalsuan.';

  @override
  String get warningRejectTitle => 'Ati-ati sing Nolak Watermark';

  @override
  String get warningRejectDesc =>
      'Curiga marang sing njaluk KTP tanpa watermark.';

  @override
  String get verifiedOfficial => '★ DIVERIFIKASI RESMI ★';

  @override
  String get dateLabel => 'TGL';

  @override
  String get verifyIdentity => 'VERIFIKASI IDENTITAS';

  @override
  String get idmarkVerified => 'IDMARK VERIFIED';

  @override
  String get privacySettings => 'Privasi';

  @override
  String get autoStripExif => 'Busak EXIF';

  @override
  String get autoStripExifDesc => 'Busak data lokasi GPS';

  @override
  String historySubtitle(int count) {
    return 'Kesimpen $count cathetan';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count template kesimpen';
  }
}
