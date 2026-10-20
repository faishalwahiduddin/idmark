import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/constants/app_constants.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/services/watermark_renderer_service.dart';
import 'package:idmark/core/utils/app_timezone.dart';
import 'package:idmark/core/utils/validators.dart';

import 'harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('FLOW-WMK-01-T01 cap tujuan + tanggal dirender di perangkat dengan resolusi asli tetap utuh', (tester) async {
    await tester.runAsync(() async {
      final src = await blankImage(640, 400);
      final config = WatermarkConfig.defaultConfig();
      final png = await WatermarkRendererService.renderWatermark(sourceImage: src, config: config);
      final out = await decodePng(png);
      expect(out.width, 640);
      expect(out.height, 400);
      expect(WatermarkRendererService.computeSha256(png), hasLength(64));
      expect(config.renderedText, contains('(TGL: '));
    });
  });

  test('FLOW-WMK-01-T03 tujuan tepat 3 dan 80 karakter diterima, 81 karakter ditolak', () {
    expect(AppValidators.validatePurpose('a' * AppConstants.minPurposeLength), isNull);
    expect(AppValidators.validatePurpose('a' * AppConstants.maxPurposeLength), isNull);
    expect(AppValidators.validatePurpose('a' * (AppConstants.maxPurposeLength + 1)), 'validationPurposeMaxLength');
    expect(AppValidators.validatePurpose('   ab   '), 'validationPurposeMinLength');
  });

  test('FLOW-WMK-01-T04 tanggal cap mengikuti zona pilihan: instan yang sama bisa beda tanggal di Jakarta dan New York', () {
    final config = WatermarkConfig.defaultConfig().copyWith(transactionDate: DateTime.utc(2026, 10, 20, 20));
    final jakarta = AppTimeZone.locationOrFallback('Asia/Jakarta');
    final ny = AppTimeZone.locationOrFallback('America/New_York');
    expect(config.dateLabelIn(jakarta), '21-10-2026');
    expect(config.dateLabelIn(ny), '20-10-2026');
    expect(config.toJson()['transactionDate'], endsWith('Z'));
  });

  test('FLOW-WMK-02-T01 pola, warna, dan opasitas tersimpan dan dipakai lagi saat app dibuka ulang', () async {
    final storage = await freshStorage();
    final c = containerWith(storage);
    addTearDown(c.dispose);
    final n = c.read(watermarkConfigProvider.notifier);
    n.updatePattern(WatermarkPattern.repeatedGrid);
    n.updateColorOption(WatermarkColorOption.blue);
    n.updateOpacity(0.8);
    final reopened = containerWith(storage);
    addTearDown(reopened.dispose);
    final s = reopened.read(watermarkConfigProvider);
    expect(s.pattern, WatermarkPattern.repeatedGrid);
    expect(s.colorOption, WatermarkColorOption.blue);
    expect(s.opacity, 0.8);
  });

  test('FLOW-WMK-02-T02 opasitas di luar 10–100% ditolak dan konfigurasi tersimpan tidak berubah', () async {
    final storage = await freshStorage();
    final c = containerWith(storage);
    addTearDown(c.dispose);
    final n = c.read(watermarkConfigProvider.notifier);
    n.updateOpacity(0.6);
    expect(() => n.updateOpacity(1.5), throwsArgumentError);
    expect(() => n.updateOpacity(0.05), throwsArgumentError);
    expect(c.read(watermarkConfigProvider).opacity, 0.6);
    expect(storage.loadConfig().opacity, 0.6);
  });

  testWidgets('FLOW-WMK-02-T04 ketujuh pola cap dirender tanpa galat dan mempertahankan ukuran gambar', (tester) async {
    await tester.runAsync(() async {
      final src = await blankImage(300, 190);
      for (final p in WatermarkPattern.values) {
        final config = WatermarkConfig.defaultConfig().copyWith(pattern: p, opacity: 1.0, fontSize: 60.0);
        final out = await decodePng(await WatermarkRendererService.renderWatermark(sourceImage: src, config: config));
        expect([out.width, out.height], [300, 190], reason: p.name);
      }
    });
  });
}
