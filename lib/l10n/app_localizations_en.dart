// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Secure ID & Document Watermark';

  @override
  String get tabWatermark => 'Watermark';

  @override
  String get tabPreset => 'Preset';

  @override
  String get tabHistory => 'History';

  @override
  String get tabGuide => 'Guide';

  @override
  String get tabSettings => 'Settings';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

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
  String get about => 'About';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get reset => 'Reset';

  @override
  String get kominfoGuide => 'Kominfo Guide';

  @override
  String get history => 'Audit Log History';

  @override
  String get presets => 'Custom User Presets';

  @override
  String get resetDefaults => 'Reset to Defaults';

  @override
  String get resetWarningTitle => 'Reset Preferences?';

  @override
  String get resetWarningBody =>
      'Your watermark settings will be restored to Kominfo defaults.';

  @override
  String get aboutApp => 'About App';

  @override
  String get appVersion => 'Version';

  @override
  String get appDomain => 'Domain';

  @override
  String get appCompliance => 'Compliance Standard';

  @override
  String get appProvider => 'Provider';

  @override
  String get clearHistory => 'Clear';

  @override
  String get historyCleared => 'Audit log history cleared.';

  @override
  String get preferencesReset =>
      'Preferences successfully reset to Kominfo recommendations.';

  @override
  String get guideRules => '4 Main Rules of Kominfo Watermark';

  @override
  String get guideRule1Title => 'Write Agency Name & Specific Purpose';

  @override
  String get guideRule1Desc =>
      'Don\'t just write \"VERIFICATION\". Write completely like \"PT BANK ABC LOAN VERIFICATION\". This prevents others from using the photo elsewhere.';

  @override
  String get guideRule2Title => 'Include Complete Transaction Date';

  @override
  String get guideRule2Desc =>
      'Add the date you send the document (e.g., 28-09-2026). This limits the validity period of the copied document so it cannot be recycled in the future.';

  @override
  String get guideRule3Title => 'Position Diagonally Across the Document';

  @override
  String get guideRule3Desc =>
      'Place the watermark diagonally across the ID text semi-transparently. Do not place it in an empty area at the edge of the photo as criminals can easily crop it.';

  @override
  String get guideRule4Title => 'Censor Signatures & Sensitive Digits';

  @override
  String get guideRule4Desc =>
      'A wet signature is your most important biometric asset. If the verifier only needs your NIK and name, cover your signature to prevent document forgery.';

  @override
  String get warningRejectTitle =>
      'Beware: Parties Rejecting Watermarked Photos';

  @override
  String get warningRejectDesc =>
      'If any party or application insists on requesting a plain e-KTP photo without a watermark even when the transaction purpose is clear, you should suspect their intentions and consider canceling the transaction.';

  @override
  String get verifiedOfficial => '★ OFFICIALLY VERIFIED ★';

  @override
  String get dateLabel => 'DATE';

  @override
  String get verifyIdentity => 'IDENTITY VERIFICATION';

  @override
  String get idmarkVerified => 'IDMARK VERIFIED';

  @override
  String get privacySettings => 'Privacy Settings';

  @override
  String get autoStripExif => 'Auto strip EXIF';

  @override
  String get autoStripExifDesc =>
      'Remove GPS and camera metadata from photos before export';

  @override
  String historySubtitle(int count) {
    return '$count on-device export records saved';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count custom templates saved';
  }
}
