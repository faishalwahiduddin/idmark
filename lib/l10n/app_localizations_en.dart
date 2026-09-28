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

  @override
  String get selectImageFirst =>
      'Please select or take an ID card photo first.';

  @override
  String checkConfigError(String error) {
    return 'Check configuration: $error';
  }

  @override
  String get watermarkDone => 'Watermark Completed!';

  @override
  String get watermarkDoneDesc =>
      'Your ID document has been successfully protected with full resolution watermark and permanent redaction 100% on-device.';

  @override
  String get hashCopied => 'Integrity hash copied to clipboard!';

  @override
  String get close => 'Close';

  @override
  String get share => 'Share';

  @override
  String get resetWatermarkTooltip => 'Reset Watermark';

  @override
  String get configResetKominfo =>
      'Configuration reset to Kominfo recommended standards.';

  @override
  String get bannerUuPdp =>
      'PDP Law Standard: Add specific purpose watermark, date, and redact sensitive data before sharing ID card photos.';

  @override
  String sensorBoxAdded(String label) {
    return 'Sensor box \"$label\" added.';
  }

  @override
  String get processingOnDevice => 'Processing Document On-Device...';

  @override
  String saveDocument(String format) {
    return 'Save Document ($format)';
  }

  @override
  String get shareDirect => 'Share Directly';

  @override
  String failedToExport(String error) {
    return 'Failed to export document: $error';
  }

  @override
  String shareSubject(String purpose) {
    return 'Watermarked Identity Document - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'Secure watermarked identity document via IDMark ($purpose) • 100% on-device';
  }

  @override
  String get watermarkConfigTitle => 'Watermark Configuration';

  @override
  String get sensorMaskTab => 'Redact / Mask';

  @override
  String get privacyExifTab => 'Privacy & EXIF';

  @override
  String get exportFormatTab => 'Export Format';

  @override
  String get watermarkPurposeLabel => 'Watermark Purpose (As Needed)';

  @override
  String get watermarkPurposeHint => 'e.g.: BANK ABC LOAN VERIFICATION';

  @override
  String get transactionDate => 'Transaction Date';

  @override
  String get includeDateChip => 'Include Date';

  @override
  String get subtextLabel => 'Additional Notes / Subtext (Optional)';

  @override
  String get subtextHint => 'e.g.: FOR INTERNAL FILE COMPLETION ONLY';

  @override
  String get patternLabel => 'Watermark Stamp Pattern (7 Styles)';

  @override
  String get colorLabel => 'Watermark Stamp Color';

  @override
  String get opacityLevel => 'Opacity Level (Transparency)';

  @override
  String get watermarkFontSize => 'Watermark Font Size';

  @override
  String get rotationAngle => 'Rotation Angle';

  @override
  String get redactionIntro =>
      'Cover vital data such as signatures or ID number digits irrelevant to the transaction to minimize identity theft risks.';

  @override
  String get quickSensorLabel => 'Quick Redaction Add:';

  @override
  String get sensorNik => 'Redact ID No.';

  @override
  String get sensorSignature => 'Redact Signature';

  @override
  String get sensorAddress => 'Redact Address';

  @override
  String get sensorBirthDate => 'Redact Birth Date';

  @override
  String get customArea => 'Custom Area';

  @override
  String get noRedactionsYet => 'No redacted areas yet.';

  @override
  String get deleteSensorTooltip => 'Delete Redaction';

  @override
  String get sensorTypeLabel => 'Redaction Type:';

  @override
  String positionX(int percent) {
    return 'Position X ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'Position Y ($percent%)';
  }

  @override
  String get privacyComplianceIndex => 'Document Privacy Compliance Index';

  @override
  String get complianceChecklistTitle =>
      'PDP Law No. 27/2022 Compliance Checklist:';

  @override
  String get checkPurposeTitle => 'Specific Purpose of Use';

  @override
  String get checkPurposeDesc =>
      'Limits copy usage so it cannot be diverted to other transactions';

  @override
  String get checkDateTitle => 'Transaction Date Included';

  @override
  String get checkDateDesc =>
      'Limits document expiration so it cannot be misused in the future';

  @override
  String get checkExifTitle => 'Sanitize EXIF & GPS Metadata';

  @override
  String get checkExifDesc =>
      'Removes geographic home coordinate locations from photo files';

  @override
  String get checkSensorTitle => 'Redact Vital Parts (ID No. / Signature)';

  @override
  String get checkSensorDesc =>
      'Hides information not strictly required by the recipient';

  @override
  String get autoSanitizeExifTitle => 'Automatic EXIF Metadata Sanitization';

  @override
  String get autoSanitizeExifDesc =>
      'Automatically strips camera metadata tags, phone model, and GPS coordinates during export';

  @override
  String get chooseExportFormat => 'Choose Output Document Format:';

  @override
  String get jpegCompressionQuality => 'JPEG Compression Quality';

  @override
  String protectionGrade(String grade, int score) {
    return 'Protection $grade ($score%)';
  }

  @override
  String get viewingOriginal => 'Viewing Original';

  @override
  String get holdToCompare => 'Hold: Compare';

  @override
  String activeWatermarkWithCount(int count) {
    return 'Active Watermark ($count redactions)';
  }

  @override
  String get activeWatermarkPreview => 'Active Watermark Preview';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get deleteImage => 'Delete Image';

  @override
  String get uploadIdPhoto => 'Upload ID Card / Identity Photo';

  @override
  String get uploadIdPhotoDesc =>
      'Select an ID card, driver\'s license, or passport photo to add purpose stamp, date, and vital data redaction.';

  @override
  String get onDeviceBadge =>
      '100% On-Device • Images are never sent to a server';

  @override
  String get openGallery => 'Open Gallery';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get historyAndAuditLog => 'History & Audit Log';

  @override
  String get clearAllHistoryTooltip => 'Clear All History';

  @override
  String get localPrivacyAuditLog => 'Local Privacy Audit Log';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return 'Total $count documents have been safely stamped 100% on-device. This log is stored only on your device.';
  }

  @override
  String get searchHistoryHint => 'Search document purpose history...';

  @override
  String get noWatermarkedDocsYet => 'No Watermarked Documents Yet';

  @override
  String get noWatermarkedDocsDesc =>
      'Documents that you have watermarked and exported will have their audit logs recorded here.';

  @override
  String get noHistoryFound => 'No history found matching your search.';

  @override
  String scoreLabel(int score) {
    return 'Score $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count Sensitive Redactions';
  }

  @override
  String get exifSanitized => 'EXIF Sanitized';

  @override
  String get sha256Copied => 'SHA-256 hash copied to clipboard!';

  @override
  String get clearHistoryConfirmTitle => 'Clear All History?';

  @override
  String get clearHistoryConfirmBody =>
      'The audit log list on your device will be permanently cleared.';

  @override
  String get historyClearedSuccess => 'History successfully cleared.';

  @override
  String get templatePresetHub => 'Templates & Presets Hub';

  @override
  String get createPresetTooltip => 'Create New Preset';

  @override
  String get officialTemplateCatalog => 'Official Watermark Template Catalog';

  @override
  String get officialTemplateDesc =>
      'Choose banking or job application templates, or create personal custom presets saved on your device.';

  @override
  String get searchTemplateHint =>
      'Search templates (bank, loan, hr, mortgage, rental)...';

  @override
  String showingTemplatesCount(int count) {
    return 'Showing $count templates';
  }

  @override
  String get createCustom => 'Create Custom';

  @override
  String get noTemplatesFound => 'No templates found matching the filter.';

  @override
  String get customBadge => 'Custom';

  @override
  String get deleteCustomPresetTooltip => 'Delete Custom Preset';

  @override
  String get activeBadge => 'Active';

  @override
  String patternInfo(String pattern) {
    return 'Pattern: $pattern';
  }

  @override
  String get usePreset => 'Use Preset';

  @override
  String presetApplied(String title) {
    return 'Preset \"$title\" successfully applied!';
  }

  @override
  String get createNewCustomPreset => 'Create New Custom Preset';

  @override
  String get presetName => 'Preset Name';

  @override
  String get presetNameHint => 'e.g.: Scholarship Verification';

  @override
  String get category => 'Category';

  @override
  String get categoryHint => 'e.g.: Education / Custom';

  @override
  String get purposeTemplateText => 'Purpose Template Text';

  @override
  String get purposeTemplateHint => 'e.g.: SCHOLARSHIP APPLICATION 2026';

  @override
  String get additionalSubtext => 'Additional Subtext';

  @override
  String get subtextTemplateHint => 'Internal notes';

  @override
  String get stampPattern => 'Stamp Pattern';

  @override
  String get savePreset => 'Save Preset';

  @override
  String customPresetSaved(String title) {
    return 'Custom preset \"$title\" saved!';
  }

  @override
  String get deletePresetConfirmTitle => 'Delete Preset?';

  @override
  String deletePresetConfirmBody(String title) {
    return 'Preset \"$title\" will be removed from your local template list.';
  }

  @override
  String get presetDeletedSuccess => 'Preset successfully deleted.';

  @override
  String get protectDigitalId => 'Protect Your Digital Identity';

  @override
  String get protectDigitalIdDesc =>
      'Ministry of Communication and PDP Law No. 27/2022 require caution when sharing ID card photos to avoid unauthorized loan collaterals or fictitious account openings.';

  @override
  String get safeSharingChecklist => 'Safe Checklist Before Sending ID Card';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 Completed';
  }

  @override
  String get checkItem1 =>
      'Institution/recipient name clearly written on watermark';

  @override
  String get checkItem2 => 'Latest transaction date included on the stamp';

  @override
  String get checkItem3 =>
      'Watermark crosses over text data so it cannot be cropped';

  @override
  String get checkItem4 =>
      'Signature redacted if verifier does not request a signature specimen';

  @override
  String get checkItem5 =>
      'EXIF metadata and GPS coordinates removed from image';

  @override
  String get zeroServerTitle => 'Absolute Privacy (Zero Server Upload)';

  @override
  String get zeroServerDesc =>
      'IDMark runs 100% in your browser or local device. ID card photos are never sent, stored, or processed on any external server.';

  @override
  String get dataSecuritySanitation => 'Data Sanitation & Security';

  @override
  String get autoExifSubtitle =>
      'Removes GPS coordinate metadata tags and camera model from exported photos';

  @override
  String get defaultExportFormat => 'Default Export Format';

  @override
  String get localDeviceStorage => 'Local Device Storage';

  @override
  String get resetDefaultsDesc =>
      'Reset templates and text settings to factory defaults';

  @override
  String get appLabel => 'Application';
}
