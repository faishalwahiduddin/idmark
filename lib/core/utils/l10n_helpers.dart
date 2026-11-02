import '../../l10n/app_localizations.dart';
import '../models/redaction_item.dart';
import '../models/watermark_config.dart';

/// Returns localized language name for supported locale codes.
String languageName(String code, AppLocalizations l10n) {
  switch (code) {
    case 'id':
      return l10n.localeIndonesian;
    case 'en':
      return l10n.localeEnglish;
    case 'ar':
      return l10n.localeArabic;
    case 'jv':
      return l10n.localeJavanese;
    case 'su':
      return l10n.localeSundanese;
    case 'zh':
      return l10n.localeChinese;
    case 'ja':
      return l10n.localeJapanese;
    case 'es':
      return l10n.localeSpanish;
    default:
      return code;
  }
}

/// Maps stable validator error codes or fallback strings to localized messages.
String? mapValidationError(String? error, AppLocalizations l10n) {
  if (error == null) return null;
  switch (error) {
    case 'validationPurposeRequired':
      return l10n.validationPurposeRequired;
    case 'validationPurposeMinLength':
      return l10n.validationPurposeMinLength;
    case 'validationPurposeMaxLength':
      return l10n.validationPurposeMaxLength;
    case 'validationSubtextMaxLength':
      return l10n.validationSubtextMaxLength;
    case 'validationOpacityRange':
      return l10n.validationOpacityRange;
    case 'validationFontSizeRange':
      return l10n.validationFontSizeRange;
    case 'validationRotationRange':
      return l10n.validationRotationRange;
    case 'validationImageBytesEmpty':
      return l10n.validationImageBytesEmpty;
    case 'validationImageBytesTooLarge':
      return l10n.validationImageBytesTooLarge;
    case 'validationQualityRange':
      return l10n.validationQualityRange;
    case 'validationPresetTitleRequired':
      return l10n.validationPresetTitleRequired;
    case 'validationPresetTitleMinLength':
      return l10n.validationPresetTitleMinLength;
    case 'validationPresetTitleMaxLength':
      return l10n.validationPresetTitleMaxLength;
    case 'validationPresetCategoryRequired':
      return l10n.validationPresetCategoryRequired;
    case 'validationPresetCategoryMaxLength':
      return l10n.validationPresetCategoryMaxLength;
    // Models emit these Indonesian messages directly (§VAL); translate them
    // here so a validation snackbar always follows the selected language.
    case 'Label sensor tidak boleh kosong':
      return l10n.validationRedactionLabelRequired;
    case 'Posisi X sensor harus berada dalam rentang 0.0 - 1.0':
      return l10n.validationRedactionXRange;
    case 'Posisi Y sensor harus berada dalam rentang 0.0 - 1.0':
      return l10n.validationRedactionYRange;
    case 'Lebar sensor harus berada dalam rentang >0.0 - 1.0':
      return l10n.validationRedactionWidthRange;
    case 'Tinggi sensor harus berada dalam rentang >0.0 - 1.0':
      return l10n.validationRedactionHeightRange;
    case 'ID audit log tidak boleh kosong':
      return l10n.validationAuditIdRequired;
    case 'Tujuan audit log tidak boleh kosong':
      return l10n.validationAuditPurposeRequired;
    case 'Hash SHA-256 tidak boleh kosong':
      return l10n.validationAuditHashRequired;
    case 'Skor privasi harus berada antara 0 dan 100':
      return l10n.validationAuditScoreRange;
    default:
      return error;
  }
}

/// Localizes protection grade description for a [WatermarkConfig].
String protectionLevelDescription(WatermarkConfig config, AppLocalizations l10n) {
  return config.localizedPrivacyGradeDescription(l10n);
}

/// Localized labels for the watermark pattern enum.
extension WatermarkPatternL10n on WatermarkPattern {
  String labelOf(AppLocalizations? l10n) => l10n == null ? label : switch (this) {
    WatermarkPattern.diagonalBand => l10n.patternDiagonalBand,
    WatermarkPattern.repeatedGrid => l10n.patternRepeatedGrid,
    WatermarkPattern.bottomBar => l10n.patternBottomBar,
    WatermarkPattern.cornerStamp => l10n.patternCornerStamp,
    WatermarkPattern.securitySeal => l10n.patternSecuritySeal,
    WatermarkPattern.crossStamp => l10n.patternCrossStamp,
    WatermarkPattern.qrBadge => l10n.patternQrBadge,
  };

  String descriptionOf(AppLocalizations? l10n) => l10n == null ? description : switch (this) {
    WatermarkPattern.diagonalBand => l10n.patternDiagonalBandDesc,
    WatermarkPattern.repeatedGrid => l10n.patternRepeatedGridDesc,
    WatermarkPattern.bottomBar => l10n.patternBottomBarDesc,
    WatermarkPattern.cornerStamp => l10n.patternCornerStampDesc,
    WatermarkPattern.securitySeal => l10n.patternSecuritySealDesc,
    WatermarkPattern.crossStamp => l10n.patternCrossStampDesc,
    WatermarkPattern.qrBadge => l10n.patternQrBadgeDesc,
  };
}

/// Localized labels for the watermark colour enum.
extension WatermarkColorOptionL10n on WatermarkColorOption {
  String labelOf(AppLocalizations? l10n) => l10n == null ? label : switch (this) {
    WatermarkColorOption.white => l10n.colorWhite,
    WatermarkColorOption.dark => l10n.colorDark,
    WatermarkColorOption.red => l10n.colorRed,
    WatermarkColorOption.blue => l10n.colorBlue,
    WatermarkColorOption.emerald => l10n.colorEmerald,
    WatermarkColorOption.amber => l10n.colorAmber,
    WatermarkColorOption.purple => l10n.colorPurple,
  };
}

/// Localized labels for the export format enum.
extension ExportFormatL10n on ExportFormat {
  String labelOf(AppLocalizations? l10n) => l10n == null ? label : switch (this) {
    ExportFormat.png => l10n.formatPng,
    ExportFormat.jpeg => l10n.formatJpeg,
    ExportFormat.pdf => l10n.formatPdf,
  };

  String descriptionOf(AppLocalizations? l10n) => l10n == null ? description : switch (this) {
    ExportFormat.png => l10n.formatPngDesc,
    ExportFormat.jpeg => l10n.formatJpegDesc,
    ExportFormat.pdf => l10n.formatPdfDesc,
  };
}

/// Localized labels for the redaction type enum.
extension RedactionTypeL10n on RedactionType {
  String labelOf(AppLocalizations? l10n) => l10n == null ? label : switch (this) {
    RedactionType.blackout => l10n.redactBlackout,
    RedactionType.mosaic => l10n.redactMosaic,
    RedactionType.blur => l10n.redactBlur,
  };

  String descriptionOf(AppLocalizations? l10n) => l10n == null ? description : switch (this) {
    RedactionType.blackout => l10n.redactBlackoutDesc,
    RedactionType.mosaic => l10n.redactMosaicDesc,
    RedactionType.blur => l10n.redactBlurDesc,
  };
}

/// Localized labels for the redaction preset target enum.
extension RedactionPresetTargetL10n on RedactionPresetTarget {
  String labelOf(AppLocalizations? l10n) => l10n == null ? label : switch (this) {
    RedactionPresetTarget.nik => l10n.targetNik,
    RedactionPresetTarget.signature => l10n.targetSignature,
    RedactionPresetTarget.address => l10n.targetAddress,
    RedactionPresetTarget.birthPlace => l10n.targetBirthPlace,
    RedactionPresetTarget.photo => l10n.targetPhoto,
    RedactionPresetTarget.custom => l10n.customArea,
  };
}

/// Localized display label for a preset category.
///
/// Category values stay canonical (Indonesian) in storage so filtering keeps
/// working; only the label rendered in the UI is translated.
String presetCategoryLabel(String category, AppLocalizations l10n) =>
    switch (category) {
      'Semua' => l10n.allTemplates,
      'Preset Saya' => l10n.myPresets,
      'Perbankan' => l10n.catBanking,
      'Finansial & Pinjol' => l10n.catFinance,
      'Karir & HR' => l10n.catCareer,
      'Rental & Wisata' => l10n.catRental,
      'Telekomunikasi' => l10n.catTelecom,
      'Multifinance' => l10n.catMultifinance,
      'Investasi' => l10n.catInvestment,
      'Layanan Publik' => l10n.catPublicService,
      'Internasional' => l10n.catInternational,
      'E-Commerce' => l10n.catEcommerce,
      _ => category,
    };

/// Localized title for a built-in preset; custom presets keep their own name.
String presetTitleLabel(String id, String fallback, AppLocalizations l10n) =>
    switch (id) {
      'bank' => l10n.presetBank,
      'bank_update' => l10n.presetBankUpdate,
      'fintech' => l10n.presetFintech,
      'paylater' => l10n.presetPaylater,
      'job' => l10n.presetJob,
      'hr_onboarding' => l10n.presetHrOnboarding,
      'rental' => l10n.presetRental,
      'hotel_stay' => l10n.presetHotel,
      'telco' => l10n.presetTelco,
      'sim_replace' => l10n.presetSimReplace,
      'kredit' => l10n.presetKredit,
      'kpr' => l10n.presetKpr,
      'investment' => l10n.presetInvestment,
      'crypto' => l10n.presetCrypto,
      'ecommerce' => l10n.presetEcommerce,
      'bpjs' => l10n.presetBpjs,
      'gov_kelurahan' => l10n.presetGovKelurahan,
      'global_kyc' => l10n.presetGlobalKyc,
      _ => fallback,
    };
