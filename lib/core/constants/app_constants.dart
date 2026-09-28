class AppConstants {
  static const String appName = 'KtpMark';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Watermark e-KTP & Identitas Aman';
  static const String appDomain = 'https://ktpmark.faishal.id';
  static const String fleetHome = 'https://faishal.id';
  
  // Storage Keys
  static const String keyRecentPurpose = 'ktpmark_recent_purpose';
  static const String keyDefaultOpacity = 'ktpmark_default_opacity';
  static const String keyDefaultPattern = 'ktpmark_default_pattern';
  static const String keyDefaultColor = 'ktpmark_default_color';
  static const String keySavedPresetId = 'ktpmark_saved_preset_id';

  // Limits & Validations
  static const int minPurposeLength = 3;
  static const int maxPurposeLength = 80;
  static const int maxSubtextLength = 100;
  static const int maxImageSizeBytes = 15 * 1024 * 1024; // 15MB
}
