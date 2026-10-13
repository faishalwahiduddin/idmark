import '../../l10n/app_localizations.dart';
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
    default:
      return error;
  }
}

/// Localizes protection grade description for a [WatermarkConfig].
String protectionLevelDescription(WatermarkConfig config, AppLocalizations l10n) {
  return config.localizedPrivacyGradeDescription(l10n);
}
