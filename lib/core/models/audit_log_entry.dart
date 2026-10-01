import '../utils/app_timezone.dart';

class AuditLogEntry {
  final String id;
  final DateTime timestamp;
  final String purpose;
  final String pattern;
  final String exportFormat;
  final int fileSizeBytes;
  final String sha256Hash;
  final int redactionsCount;
  final bool metadataStripped;
  final int privacyScore;

  const AuditLogEntry({
    required this.id,
    required this.timestamp,
    required this.purpose,
    required this.pattern,
    required this.exportFormat,
    required this.fileSizeBytes,
    required this.sha256Hash,
    required this.redactionsCount,
    required this.metadataStripped,
    required this.privacyScore,
  });

  /// Enforces §VAL validation
  List<String> validate() {
    final errors = <String>[];
    if (id.trim().isEmpty) errors.add('ID audit log tidak boleh kosong');
    if (purpose.trim().isEmpty) errors.add('Tujuan audit log tidak boleh kosong');
    if (sha256Hash.trim().isEmpty) errors.add('Hash SHA-256 tidak boleh kosong');
    if (privacyScore < 0 || privacyScore > 100) {
      errors.add('Skor privasi harus berada antara 0 dan 100');
    }
    return errors;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // Storage contract (§TZ): always a UTC `Z` instant, never device-local.
      'timestamp': timestamp.toUtc().toIso8601String(),
      'purpose': purpose,
      'pattern': pattern,
      'exportFormat': exportFormat,
      'fileSizeBytes': fileSizeBytes,
      'sha256Hash': sha256Hash,
      'redactionsCount': redactionsCount,
      'metadataStripped': metadataStripped,
      'privacyScore': privacyScore,
    };
  }

  factory AuditLogEntry.fromJson(Map<String, dynamic> json) {
    return AuditLogEntry(
      id: json['id'] as String? ??
          'audit_${AppTimeZone.nowUtc().millisecondsSinceEpoch}',
      timestamp: json['timestamp'] != null
          ? AppTimeZone.parseUtc(json['timestamp']) ?? AppTimeZone.nowUtc()
          : AppTimeZone.nowUtc(),
      purpose: json['purpose'] as String? ?? 'VERIFIKASI',
      pattern: json['pattern'] as String? ?? 'diagonalBand',
      exportFormat: json['exportFormat'] as String? ?? 'PNG',
      fileSizeBytes: (json['fileSizeBytes'] as num?)?.toInt() ?? 0,
      sha256Hash: json['sha256Hash'] as String? ?? '',
      redactionsCount: (json['redactionsCount'] as num?)?.toInt() ?? 0,
      metadataStripped: json['metadataStripped'] as bool? ?? true,
      privacyScore: (json['privacyScore'] as num?)?.toInt() ?? 85,
    );
  }
}
