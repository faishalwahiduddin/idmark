import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/utils/validators.dart';

void main() {
  group('AppValidators §VAL Unit Tests', () {
    test('validatePurpose rejects empty and invalid length', () {
      expect(AppValidators.validatePurpose(null), isNotNull);
      expect(AppValidators.validatePurpose(''), isNotNull);
      expect(AppValidators.validatePurpose('  '), isNotNull);
      expect(AppValidators.validatePurpose('AB'), isNotNull); // < 3
      expect(AppValidators.validatePurpose('VERIFIKASI REKENING BANK BCA'), isNull);
    });

    test('validateOpacity enforces 0.1 to 1.0 range', () {
      expect(AppValidators.validateOpacity(0.05), isNotNull);
      expect(AppValidators.validateOpacity(1.05), isNotNull);
      expect(AppValidators.validateOpacity(0.50), isNull);
    });

    test('validateFontSize enforces 10 to 60 pt', () {
      expect(AppValidators.validateFontSize(5.0), isNotNull);
      expect(AppValidators.validateFontSize(75.0), isNotNull);
      expect(AppValidators.validateFontSize(24.0), isNull);
    });

    test('validateRotation enforces -90 to +90 degrees', () {
      expect(AppValidators.validateRotation(-100.0), isNotNull);
      expect(AppValidators.validateRotation(95.0), isNotNull);
      expect(AppValidators.validateRotation(-22.0), isNull);
    });

    test('validateImageBytes rejects empty or oversized bytes', () {
      expect(AppValidators.validateImageBytes(0), isNotNull);
      expect(AppValidators.validateImageBytes(-10), isNotNull);
      expect(AppValidators.validateImageBytes(20 * 1024 * 1024), isNotNull); // > 15MB
      expect(AppValidators.validateImageBytes(2 * 1024 * 1024), isNull);
    });
  });

  group('WatermarkConfig Mutation & §VAL Tests', () {
    test('Default config is valid', () {
      final config = WatermarkConfig.defaultConfig();
      expect(config.validate(), isEmpty);
    });

    test('Invalid mutation throws ArgumentError', () {
      final config = WatermarkConfig.defaultConfig();
      expect(
        () => config.copyWith(purpose: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Serialization round-trip preserves state', () {
      final original = WatermarkConfig.defaultConfig();
      final json = original.toJson();
      final restored = WatermarkConfig.fromJson(json);

      expect(restored.purpose, original.purpose);
      expect(restored.pattern, original.pattern);
      expect(restored.colorOption, original.colorOption);
      expect(restored.opacity, original.opacity);
    });
  });
}
