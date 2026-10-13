import '../constants/app_constants.dart';

/// Centralized validator for UI form fields and data mutations.
/// Enforces §VAL rule across frontend and storage boundaries.
/// Returns stable error codes that are mapped to localized strings via l10n_helpers.
class AppValidators {
  /// Validates watermark purpose text.
  static String? validatePurpose(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validationPurposeRequired';
    }
    final trimmed = value.trim();
    if (trimmed.length < AppConstants.minPurposeLength) {
      return 'validationPurposeMinLength';
    }
    if (trimmed.length > AppConstants.maxPurposeLength) {
      return 'validationPurposeMaxLength';
    }
    return null;
  }

  /// Validates optional watermark subtext.
  static String? validateSubtext(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Subtext is optional
    }
    if (value.trim().length > AppConstants.maxSubtextLength) {
      return 'validationSubtextMaxLength';
    }
    return null;
  }

  /// Validates opacity value (must be between 0.1 and 1.0).
  static String? validateOpacity(double opacity) {
    if (opacity < 0.1 || opacity > 1.0) {
      return 'validationOpacityRange';
    }
    return null;
  }

  /// Validates font size scaling factor (10.0 to 60.0).
  static String? validateFontSize(double fontSize) {
    if (fontSize < 10.0 || fontSize > 60.0) {
      return 'validationFontSizeRange';
    }
    return null;
  }

  /// Validates rotation angle (-90 to +90 degrees).
  static String? validateRotation(double angle) {
    if (angle < -90.0 || angle > 90.0) {
      return 'validationRotationRange';
    }
    return null;
  }

  /// Validates uploaded image byte size.
  static String? validateImageBytes(int sizeInBytes) {
    if (sizeInBytes <= 0) {
      return 'validationImageBytesEmpty';
    }
    if (sizeInBytes > AppConstants.maxImageSizeBytes) {
      return 'validationImageBytesTooLarge';
    }
    return null;
  }

  /// Validates export JPEG quality factor (10 to 100).
  static String? validateQuality(int quality) {
    if (quality < 10 || quality > 100) {
      return 'validationQualityRange';
    }
    return null;
  }

  /// Validates custom preset title.
  static String? validatePresetTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validationPresetTitleRequired';
    }
    if (value.trim().length < 3) {
      return 'validationPresetTitleMinLength';
    }
    if (value.trim().length > 50) {
      return 'validationPresetTitleMaxLength';
    }
    return null;
  }

  /// Validates custom preset category.
  static String? validatePresetCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validationPresetCategoryRequired';
    }
    if (value.trim().length > 30) {
      return 'validationPresetCategoryMaxLength';
    }
    return null;
  }
}
