import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/validators.dart';

enum WatermarkPattern {
  diagonalBand('Pita Melintang', 'Satu garis diagonal tebal melintang di tengah dokumen (Rekomendasi Kominfo)'),
  repeatedGrid('Pola Berulang (Grid)', 'Pola teks berulang di seluruh permukaan foto untuk proteksi maksimal'),
  bottomBar('Pita Bawah', 'Pita teks solid di bagian bawah dokumen'),
  cornerStamp('Cap Sudut', 'Cap verifikasi di sudut kanan bawah');

  final String label;
  final String description;
  const WatermarkPattern(this.label, this.description);
}

enum WatermarkColorOption {
  white('Putih Bersih', AppColors.watermarkWhite),
  dark('Hitam Pekat', AppColors.watermarkDark),
  red('Merah Resmi', AppColors.watermarkRed),
  blue('Biru Verifikasi', AppColors.watermarkBlue);

  final String label;
  final Color color;
  const WatermarkColorOption(this.label, this.color);
}

class WatermarkConfig {
  final String purpose;
  final DateTime transactionDate;
  final String customSubtext;
  final WatermarkPattern pattern;
  final WatermarkColorOption colorOption;
  final double opacity;
  final double fontSize;
  final double rotationAngle;
  final bool includeDate;
  final bool isUppercase;

  const WatermarkConfig({
    required this.purpose,
    required this.transactionDate,
    this.customSubtext = '',
    this.pattern = WatermarkPattern.diagonalBand,
    this.colorOption = WatermarkColorOption.red,
    this.opacity = 0.50,
    this.fontSize = 24.0,
    this.rotationAngle = -22.0,
    this.includeDate = true,
    this.isUppercase = true,
  });

  /// Factory default with standard Kominfo recommendation
  factory WatermarkConfig.defaultConfig() {
    return WatermarkConfig(
      purpose: 'VERIFIKASI PINJAMAN BANK ABC',
      transactionDate: DateTime.now(),
      customSubtext: '',
      pattern: WatermarkPattern.diagonalBand,
      colorOption: WatermarkColorOption.red,
      opacity: 0.50,
      fontSize: 24.0,
      rotationAngle: -22.0,
      includeDate: true,
      isUppercase: true,
    );
  }

  /// Validates state consistency before any mutation/saving (§VAL)
  List<String> validate() {
    final errors = <String>[];
    final pErr = AppValidators.validatePurpose(purpose);
    if (pErr != null) errors.add(pErr);

    final sErr = AppValidators.validateSubtext(customSubtext);
    if (sErr != null) errors.add(sErr);

    final oErr = AppValidators.validateOpacity(opacity);
    if (oErr != null) errors.add(oErr);

    final fErr = AppValidators.validateFontSize(fontSize);
    if (fErr != null) errors.add(fErr);

    final rErr = AppValidators.validateRotation(rotationAngle);
    if (rErr != null) errors.add(rErr);

    return errors;
  }

  /// Generates the combined text line for rendering
  String get renderedText {
    final cleanPurpose = isUppercase ? purpose.toUpperCase() : purpose;
    if (!includeDate) return cleanPurpose;
    final day = transactionDate.day.toString().padLeft(2, '0');
    final month = transactionDate.month.toString().padLeft(2, '0');
    final year = transactionDate.year.toString();
    final dateStr = '$day-$month-$year';
    return '$cleanPurpose (TGL: $dateStr)';
  }

  WatermarkConfig copyWith({
    String? purpose,
    DateTime? transactionDate,
    String? customSubtext,
    WatermarkPattern? pattern,
    WatermarkColorOption? colorOption,
    double? opacity,
    double? fontSize,
    double? rotationAngle,
    bool? includeDate,
    bool? isUppercase,
  }) {
    final updated = WatermarkConfig(
      purpose: purpose ?? this.purpose,
      transactionDate: transactionDate ?? this.transactionDate,
      customSubtext: customSubtext ?? this.customSubtext,
      pattern: pattern ?? this.pattern,
      colorOption: colorOption ?? this.colorOption,
      opacity: opacity ?? this.opacity,
      fontSize: fontSize ?? this.fontSize,
      rotationAngle: rotationAngle ?? this.rotationAngle,
      includeDate: includeDate ?? this.includeDate,
      isUppercase: isUppercase ?? this.isUppercase,
    );

    // Validate on mutation (§VAL)
    final errors = updated.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError('Mutasi WatermarkConfig tidak valid: ${errors.join(', ')}');
    }
    return updated;
  }

  Map<String, dynamic> toJson() {
    return {
      'purpose': purpose,
      'transactionDate': transactionDate.toIso8601String(),
      'customSubtext': customSubtext,
      'pattern': pattern.name,
      'colorOption': colorOption.name,
      'opacity': opacity,
      'fontSize': fontSize,
      'rotationAngle': rotationAngle,
      'includeDate': includeDate,
      'isUppercase': isUppercase,
    };
  }

  factory WatermarkConfig.fromJson(Map<String, dynamic> json) {
    return WatermarkConfig(
      purpose: json['purpose'] as String? ?? 'VERIFIKASI',
      transactionDate: json['transactionDate'] != null
          ? DateTime.tryParse(json['transactionDate'] as String) ?? DateTime.now()
          : DateTime.now(),
      customSubtext: json['customSubtext'] as String? ?? '',
      pattern: WatermarkPattern.values.firstWhere(
        (p) => p.name == json['pattern'],
        orElse: () => WatermarkPattern.diagonalBand,
      ),
      colorOption: WatermarkColorOption.values.firstWhere(
        (c) => c.name == json['colorOption'],
        orElse: () => WatermarkColorOption.red,
      ),
      opacity: (json['opacity'] as num?)?.toDouble() ?? 0.50,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 24.0,
      rotationAngle: (json['rotationAngle'] as num?)?.toDouble() ?? -22.0,
      includeDate: json['includeDate'] as bool? ?? true,
      isUppercase: json['isUppercase'] as bool? ?? true,
    );
  }
}
