import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/validators.dart';
import 'redaction_item.dart';

enum WatermarkPattern {
  diagonalBand('Pita Melintang', 'Satu garis diagonal tebal melintang di tengah dokumen (Rekomendasi Kominfo)'),
  repeatedGrid('Pola Berulang (Grid)', 'Pola teks berulang di seluruh permukaan foto untuk proteksi maksimal'),
  bottomBar('Pita Bawah', 'Pita teks solid di bagian bawah dokumen'),
  cornerStamp('Cap Sudut', 'Cap verifikasi di sudut kanan bawah'),
  securitySeal('Segel Resmi Melingkar', 'Stempel segel melingkar ganda dengan border verifikasi'),
  crossStamp('Silang Ganda (X-Band)', 'Dua garis diagonal menyilang melindungi seluruh isi dokumen'),
  qrBadge('Lencana QR Verifikasi', 'Lencana verifikasi ber-QR code keabsahan tujuan dan tanggal');

  final String label;
  final String description;
  const WatermarkPattern(this.label, this.description);
}

enum WatermarkColorOption {
  white('Putih Bersih', AppColors.watermarkWhite),
  dark('Hitam Pekat', AppColors.watermarkDark),
  red('Merah Resmi', AppColors.watermarkRed),
  blue('Biru Verifikasi', AppColors.watermarkBlue),
  emerald('Hijau Aman', AppColors.watermarkEmerald),
  amber('Kuning Peringatan', AppColors.watermarkAmber),
  purple('Ungu Segel', AppColors.watermarkPurple);

  final String label;
  final Color color;
  const WatermarkColorOption(this.label, this.color);
}

enum ExportFormat {
  png('PNG (Resolusi Penuh)', 'Format lossless kualitas asli tanpa penurunan ketajaman'),
  jpeg('JPEG (Ukuran Ringan)', 'Format terkompresi hemat kuota untuk upload portal cepat'),
  pdf('Dokumen PDF (Siap Cetak)', 'Format berkas dokumen resmi standar kantor & perbankan');

  final String label;
  final String description;
  const ExportFormat(this.label, this.description);
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
  final List<RedactionBox> redactions;
  final bool stripMetadata;
  final ExportFormat exportFormat;
  final int jpegQuality;

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
    this.redactions = const [],
    this.stripMetadata = true,
    this.exportFormat = ExportFormat.png,
    this.jpegQuality = 90,
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
      redactions: const [],
      stripMetadata: true,
      exportFormat: ExportFormat.png,
      jpegQuality: 90,
    );
  }

  /// Calculates privacy compliance score (0-100) based on UU PDP standards
  int get privacyScore {
    int score = 0;
    if (purpose.trim().length >= 5) score += 30;
    if (includeDate) score += 20;
    if (stripMetadata) score += 20;
    if (redactions.isNotEmpty) score += 15;
    if (pattern == WatermarkPattern.repeatedGrid ||
        pattern == WatermarkPattern.crossStamp ||
        pattern == WatermarkPattern.securitySeal) {
      score += 15;
    } else {
      score += 10;
    }
    return score.clamp(0, 100);
  }

  String get privacyGrade {
    final s = privacyScore;
    if (s >= 90) return 'A+';
    if (s >= 80) return 'A';
    if (s >= 65) return 'B';
    if (s >= 50) return 'C';
    return 'D';
  }

  String get privacyGradeDescription {
    final s = privacyScore;
    if (s >= 90) return 'Proteksi Maksimal • Memenuhi rekomendasi Kominfo & UU PDP';
    if (s >= 80) return 'Proteksi Sangat Baik • Dokumen aman dibagikan';
    if (s >= 65) return 'Proteksi Cukup • Disarankan menambah tanggal dan sensor NIK';
    return 'Proteksi Lemah • Tambahkan tujuan spesifik dan tanggal';
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

    final qErr = AppValidators.validateQuality(jpegQuality);
    if (qErr != null) errors.add(qErr);

    for (final r in redactions) {
      errors.addAll(r.validate());
    }

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
    List<RedactionBox>? redactions,
    bool? stripMetadata,
    ExportFormat? exportFormat,
    int? jpegQuality,
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
      redactions: redactions ?? this.redactions,
      stripMetadata: stripMetadata ?? this.stripMetadata,
      exportFormat: exportFormat ?? this.exportFormat,
      jpegQuality: jpegQuality ?? this.jpegQuality,
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
      'redactions': redactions.map((r) => r.toJson()).toList(),
      'stripMetadata': stripMetadata,
      'exportFormat': exportFormat.name,
      'jpegQuality': jpegQuality,
    };
  }

  factory WatermarkConfig.fromJson(Map<String, dynamic> json) {
    final redactionsList = <RedactionBox>[];
    if (json['redactions'] is List) {
      for (final item in (json['redactions'] as List)) {
        if (item is Map<String, dynamic>) {
          redactionsList.add(RedactionBox.fromJson(item));
        }
      }
    }

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
      redactions: redactionsList,
      stripMetadata: json['stripMetadata'] as bool? ?? true,
      exportFormat: ExportFormat.values.firstWhere(
        (f) => f.name == json['exportFormat'],
        orElse: () => ExportFormat.png,
      ),
      jpegQuality: (json['jpegQuality'] as num?)?.toInt() ?? 90,
    );
  }
}
