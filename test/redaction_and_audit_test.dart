import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/audit_log_entry.dart';
import 'package:idmark/core/models/redaction_item.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/models/watermark_preset.dart';
import 'package:idmark/core/services/watermark_renderer_service.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:idmark/core/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('RedactionBox Model & §VAL Tests', () {
    test('Valid RedactionBox fromPreset passes validation', () {
      final box = RedactionBox.fromPreset(RedactionPresetTarget.nik);
      expect(box.validate(), isEmpty);
      expect(box.type, equals(RedactionType.blackout));
      expect(box.label, equals('Nomor NIK / ID'));
    });

    test('RedactionBox copyWith validates bounds (§VAL)', () {
      final box = RedactionBox.fromPreset(RedactionPresetTarget.signature);
      final updated = box.copyWith(
        type: RedactionType.mosaic,
        left: 0.1,
        top: 0.2,
      );
      expect(updated.validate(), isEmpty);
      expect(updated.type, equals(RedactionType.mosaic));
      expect(updated.left, equals(0.1));
    });

    test('RedactionBox serialization roundtrip preserves state', () {
      final box = RedactionBox(
        id: 'box_test_1',
        label: 'Sensor NIK',
        type: RedactionType.blur,
        left: 0.2,
        top: 0.3,
        width: 0.4,
        height: 0.1,
      );
      final json = box.toJson();
      final revived = RedactionBox.fromJson(json);

      expect(revived.id, equals(box.id));
      expect(revived.label, equals(box.label));
      expect(revived.type, equals(RedactionType.blur));
      expect(revived.left, closeTo(0.2, 0.001));
    });
  });

  group('AuditLogEntry Model & §VAL Tests', () {
    test('Valid AuditLogEntry passes validation', () {
      final entry = AuditLogEntry(
        id: 'audit_123',
        timestamp: DateTime.now(),
        purpose: 'VERIFIKASI BANK BNI',
        pattern: 'Pita Melintang',
        exportFormat: 'PNG',
        fileSizeBytes: 1024 * 500,
        sha256Hash: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
        redactionsCount: 2,
        metadataStripped: true,
        privacyScore: 95,
      );
      expect(entry.validate(), isEmpty);
    });

    test('AuditLogEntry rejects invalid privacy score (§VAL)', () {
      final entry = AuditLogEntry(
        id: 'audit_invalid',
        timestamp: DateTime.now(),
        purpose: 'TEST',
        pattern: 'Pita',
        exportFormat: 'PNG',
        fileSizeBytes: 100,
        sha256Hash: 'hash',
        redactionsCount: 0,
        metadataStripped: false,
        privacyScore: 120, // Invalid!
      );
      expect(entry.validate(), isNotEmpty);
      expect(entry.validate().first, contains('Skor privasi'));
    });

    test('AuditLogEntry serialization roundtrip preserves state', () {
      final now = DateTime.now();
      final entry = AuditLogEntry(
        id: 'audit_456',
        timestamp: now,
        purpose: 'VERIFIKASI PINJOL',
        pattern: 'Pola Berulang',
        exportFormat: 'PDF',
        fileSizeBytes: 2048,
        sha256Hash: 'abc123sha256',
        redactionsCount: 1,
        metadataStripped: true,
        privacyScore: 90,
      );
      final json = entry.toJson();
      final revived = AuditLogEntry.fromJson(json);

      expect(revived.id, equals(entry.id));
      expect(revived.purpose, equals(entry.purpose));
      expect(revived.exportFormat, equals('PDF'));
      expect(revived.privacyScore, equals(90));
    });
  });

  group('Privacy Scoring & WatermarkConfig Enhancements', () {
    test('High protection configuration yields Grade A+', () {
      final config = WatermarkConfig(
        purpose: 'VERIFIKASI REKENING BANK BCA',
        transactionDate: DateTime.now(),
        pattern: WatermarkPattern.repeatedGrid,
        includeDate: true,
        stripMetadata: true,
        redactions: [RedactionBox.fromPreset(RedactionPresetTarget.signature)],
      );

      expect(config.privacyScore, greaterThanOrEqualTo(90));
      expect(config.privacyGrade, equals('A+'));
      expect(config.privacyGradeDescription, contains('Proteksi Maksimal'));
    });

    test('WatermarkRendererService computes valid SHA-256', () {
      final dummyBytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hash = WatermarkRendererService.computeSha256(dummyBytes);
      expect(hash, isNotEmpty);
      expect(hash.length, equals(64)); // standard SHA-256 hex string length
    });
  });

  group('Custom Presets & LocalStorageService Tests', () {
    test('LocalStorageService manages custom presets and audit logs', () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.init();

      expect(storage.loadCustomPresets(), isEmpty);
      expect(storage.loadAuditLogs(), isEmpty);

      // Add custom preset
      final preset = WatermarkPreset(
        id: 'custom_test_1',
        title: 'Verifikasi Magang',
        category: 'Karir',
        samplePurpose: 'VERIFIKASI MAGANG PT MAJU JAYA',
        icon: WatermarkPreset.defaultPresets.first.icon,
        isCustom: true,
      );
      await storage.addCustomPreset(preset);

      final loadedPresets = storage.loadCustomPresets();
      expect(loadedPresets.length, equals(1));
      expect(loadedPresets.first.title, equals('Verifikasi Magang'));

      // Add audit log
      final audit = AuditLogEntry(
        id: 'audit_test_1',
        timestamp: DateTime.now(),
        purpose: 'TEST AUDIT',
        pattern: 'Diagonal',
        exportFormat: 'PNG',
        fileSizeBytes: 1000,
        sha256Hash: 'test_hash_123',
        redactionsCount: 0,
        metadataStripped: true,
        privacyScore: 85,
      );
      await storage.addAuditLog(audit);

      final loadedLogs = storage.loadAuditLogs();
      expect(loadedLogs.length, equals(1));
      expect(loadedLogs.first.purpose, equals('TEST AUDIT'));

      // Clean up
      await storage.deleteCustomPreset('custom_test_1');
      expect(storage.loadCustomPresets(), isEmpty);

      await storage.clearAuditLogs();
      expect(storage.loadAuditLogs(), isEmpty);
    });

    test('AppValidators validates quality and preset titles (§VAL)', () {
      expect(AppValidators.validateQuality(90), isNull);
      expect(AppValidators.validateQuality(5), isNotNull);
      expect(AppValidators.validateQuality(105), isNotNull);

      expect(AppValidators.validatePresetTitle('Valid Title'), isNull);
      expect(AppValidators.validatePresetTitle(''), isNotNull);
      expect(AppValidators.validatePresetTitle('ab'), isNotNull);

      expect(AppValidators.validatePresetCategory('Kategori'), isNull);
      expect(AppValidators.validatePresetCategory(''), isNotNull);
    });
  });
}
