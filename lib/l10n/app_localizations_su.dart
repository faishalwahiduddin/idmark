// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sundanese (`su`).
class AppLocalizationsSu extends AppLocalizations {
  AppLocalizationsSu([String locale = 'su']) : super(locale);

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
  String get tabSettings => 'Setélan';

  @override
  String get settings => 'Setélan';

  @override
  String get appearance => 'Pidangan';

  @override
  String get theme => 'Téma';

  @override
  String get themeLight => 'Caang';

  @override
  String get themeDark => 'Poék';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get selectTheme => 'Pilih Téma';

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
  String get about => 'Ngeunaan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpen';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Édit';

  @override
  String get reset => 'Reset';

  @override
  String get kominfoGuide => 'Panduan Kominfo';

  @override
  String get history => 'Riwayat Log';

  @override
  String get presets => 'Preset Pamaké';

  @override
  String get resetDefaults => 'Reset ka Bawaan';

  @override
  String get resetWarningTitle => 'Reset Setélan?';

  @override
  String get resetWarningBody =>
      'Setélan watermark bakal di-reset kana bawaan.';

  @override
  String get aboutApp => 'Ngeunaan Aplikasi';

  @override
  String get appVersion => 'Vérsi';

  @override
  String get appDomain => 'Domain';

  @override
  String get appCompliance => 'Standar Patuh';

  @override
  String get appProvider => 'Panyadia';

  @override
  String get clearHistory => 'Beresihkeun';

  @override
  String get historyCleared => 'Riwayat tos diberesihkeun.';

  @override
  String get preferencesReset => 'Setélan tos di-reset.';

  @override
  String get guideRules => '4 Aturan Pokok Watermark';

  @override
  String get guideRule1Title => 'Tulis Ngaran & Tujuan';

  @override
  String get guideRule1Desc =>
      'Ulah ukur nulis \"VÉRIFIKASI\". Tulis lengkep sangkan aman.';

  @override
  String get guideRule2Title => 'Lebetkeun Tanggal';

  @override
  String get guideRule2Desc => 'Tambahkeun tanggal pikeun ngawatesan waktosna.';

  @override
  String get guideRule3Title => 'Posisi Nyerong';

  @override
  String get guideRule3Desc => 'Simpen watermark nyerong luhureun téks.';

  @override
  String get guideRule4Title => 'Tutupan Tanda Tangan';

  @override
  String get guideRule4Desc => 'Tutupan tanda tangan anjeun sangkan aman.';

  @override
  String get warningRejectTitle => 'Waspada nu Nolak Watermark';

  @override
  String get warningRejectDesc =>
      'Kade lamun aya nu ménta KTP tanpa watermark.';

  @override
  String get verifiedOfficial => '★ DIVÉRIFIKASI RESMI ★';

  @override
  String get dateLabel => 'TGL';

  @override
  String get verifyIdentity => 'VÉRIFIKASI IDENTITAS';

  @override
  String get idmarkVerified => 'IDMARK VERIFIED';

  @override
  String get privacySettings => 'Privasi';

  @override
  String get autoStripExif => 'Hapus EXIF';

  @override
  String get autoStripExifDesc => 'Hapus data lokasi GPS';

  @override
  String historySubtitle(int count) {
    return 'Disimpen $count catetan';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count citakan disimpen';
  }
}
