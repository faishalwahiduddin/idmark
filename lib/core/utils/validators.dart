import '../constants/app_constants.dart';

/// Centralized validator for UI form fields and data mutations.
/// Enforces §VAL rule across frontend and storage boundaries.
class AppValidators {
  /// Validates watermark purpose text.
  static String? validatePurpose(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tujuan watermark tidak boleh kosong';
    }
    final trimmed = value.trim();
    if (trimmed.length < AppConstants.minPurposeLength) {
      return 'Tujuan minimal ${AppConstants.minPurposeLength} karakter';
    }
    if (trimmed.length > AppConstants.maxPurposeLength) {
      return 'Tujuan maksimal ${AppConstants.maxPurposeLength} karakter';
    }
    return null;
  }

  /// Validates optional watermark subtext.
  static String? validateSubtext(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Subtext is optional
    }
    if (value.trim().length > AppConstants.maxSubtextLength) {
      return 'Catatan tambahan maksimal ${AppConstants.maxSubtextLength} karakter';
    }
    return null;
  }

  /// Validates opacity value (must be between 0.1 and 1.0).
  static String? validateOpacity(double opacity) {
    if (opacity < 0.1 || opacity > 1.0) {
      return 'Opasitas harus berada di antara 10% dan 100%';
    }
    return null;
  }

  /// Validates font size scaling factor (10.0 to 60.0).
  static String? validateFontSize(double fontSize) {
    if (fontSize < 10.0 || fontSize > 60.0) {
      return 'Ukuran teks harus antara 10 dan 60 pt';
    }
    return null;
  }

  /// Validates rotation angle (-90 to +90 degrees).
  static String? validateRotation(double angle) {
    if (angle < -90.0 || angle > 90.0) {
      return 'Sudut rotasi harus antara -90° dan +90°';
    }
    return null;
  }

  /// Validates uploaded image byte size.
  static String? validateImageBytes(int sizeInBytes) {
    if (sizeInBytes <= 0) {
      return 'File gambar kosong atau korup';
    }
    if (sizeInBytes > AppConstants.maxImageSizeBytes) {
      final mb = (AppConstants.maxImageSizeBytes / (1024 * 1024)).toStringAsFixed(0);
      return 'Ukuran gambar melebihi batas maksimal ($mb MB)';
    }
    return null;
  }

  /// Validates export JPEG quality factor (10 to 100).
  static String? validateQuality(int quality) {
    if (quality < 10 || quality > 100) {
      return 'Kualitas gambar harus antara 10% dan 100%';
    }
    return null;
  }

  /// Validates custom preset title.
  static String? validatePresetTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama preset tidak boleh kosong';
    }
    if (value.trim().length < 3) {
      return 'Nama preset minimal 3 karakter';
    }
    if (value.trim().length > 50) {
      return 'Nama preset maksimal 50 karakter';
    }
    return null;
  }

  /// Validates custom preset category.
  static String? validatePresetCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kategori preset tidak boleh kosong';
    }
    if (value.trim().length > 30) {
      return 'Kategori maksimal 30 karakter';
    }
    return null;
  }
}
