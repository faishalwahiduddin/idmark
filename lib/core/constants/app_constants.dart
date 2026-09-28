class AppConstants {
  static const String appName = 'IDMark';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Secure ID Card & Document Watermark';
  static const String appDomain = 'https://idmark.faishal.id';
  static const String fleetHome = 'https://faishal.id';
  
  // Storage Keys
  static const String keyRecentPurpose = 'idmark_recent_purpose';
  static const String keyDefaultOpacity = 'idmark_default_opacity';
  static const String keyDefaultPattern = 'idmark_default_pattern';
  static const String keyDefaultColor = 'idmark_default_color';
  static const String keySavedPresetId = 'idmark_saved_preset_id';
  static const String keyCustomPresets = 'idmark_custom_presets';
  static const String keyAuditHistory = 'idmark_audit_history';
  static const String keyAutoStripExif = 'idmark_auto_strip_exif';
  static const String keyPreferredExportFormat = 'idmark_preferred_export_format';

  // Limits & Validations
  static const int minPurposeLength = 3;
  static const int maxPurposeLength = 80;
  static const int maxSubtextLength = 100;
  static const int maxImageSizeBytes = 15 * 1024 * 1024; // 15MB
}
