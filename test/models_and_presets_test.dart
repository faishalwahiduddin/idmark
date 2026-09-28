import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/models/watermark_preset.dart';

void main() {
  group('WatermarkPreset Catalog Tests', () {
    test('Default presets catalog is populated with valid items', () {
      final presets = WatermarkPreset.defaultPresets;
      expect(presets, isNotEmpty);
      expect(presets.length, greaterThanOrEqualTo(5));

      for (final p in presets) {
        expect(p.id, isNotEmpty);
        expect(p.title, isNotEmpty);
        expect(p.category, isNotEmpty);
        expect(p.samplePurpose, isNotEmpty);
      }
    });

    test('renderedText generates uppercase formatted text with date', () {
      final testDate = DateTime(2026, 9, 28);
      final config = WatermarkConfig(
        purpose: 'verifikasi bank abc',
        transactionDate: testDate,
        includeDate: true,
        isUppercase: true,
      );

      expect(config.renderedText, 'VERIFIKASI BANK ABC (TGL: 28-09-2026)');
    });

    test('renderedText without date only renders purpose', () {
      final config = WatermarkConfig(
        purpose: 'VERIFIKASI KREDIT',
        transactionDate: DateTime.now(),
        includeDate: false,
      );

      expect(config.renderedText, 'VERIFIKASI KREDIT');
    });
  });
}
