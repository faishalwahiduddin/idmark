import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/constants/app_constants.dart';
import 'package:idmark/core/models/redaction_item.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/models/watermark_preset.dart';
import 'package:idmark/core/providers/app_providers.dart';

import 'harness.dart';

WatermarkPreset _preset(String id, String title) => WatermarkPreset(
      id: id,
      title: title,
      category: 'Kustom',
      samplePurpose: 'VERIFIKASI SEWA MOBIL',
      subtext: '',
      icon: Icons.bookmark_border,
      defaultPattern: WatermarkPattern.cornerStamp,
      defaultColor: WatermarkColorOption.purple,
      isCustom: true,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FLOW-RED-01-T02 kotak sensor di luar gambar atau berukuran nol ditolak validasi', () {
    const outside = RedactionBox(id: 'x', label: 'NIK', type: RedactionType.blackout, left: 1.2, top: 0.1, width: 0.3, height: 0.1);
    const empty = RedactionBox(id: 'y', label: ' ', type: RedactionType.blur, left: 0.1, top: 0.1, width: 0, height: 0.1);
    expect(outside.validate(), isNotEmpty);
    expect(empty.validate().length, 2);
  });

  test('FLOW-RED-01-T03 menggeser sensor ke tepi kanan dijepit agar tetap di dalam gambar', () {
    final box = RedactionBox.fromPreset(RedactionPresetTarget.signature);
    final moved = box.copyWith(left: 0.95);
    expect(moved.left + moved.width, lessThanOrEqualTo(1.0 + 1e-9));
    final tiny = box.copyWith(width: 0.0001);
    expect(tiny.width, 0.05);
  });

  test('FLOW-RED-01-T04 tambah dua sensor, hapus satu, lalu bersihkan; konfigurasi rusak di storage kembali ke bawaan', () async {
    final storage = await freshStorage();
    final c = containerWith(storage);
    addTearDown(c.dispose);
    final n = c.read(watermarkConfigProvider.notifier);
    const a = RedactionBox(id: 'a', label: 'NIK', type: RedactionType.blackout, left: 0.1, top: 0.1, width: 0.3, height: 0.1);
    const b = RedactionBox(id: 'b', label: 'TTD', type: RedactionType.mosaic, left: 0.6, top: 0.6, width: 0.3, height: 0.2);
    n.addRedaction(a);
    n.addRedaction(b);
    n.removeRedaction('a');
    expect(storage.loadConfig().redactions.map((r) => r.id), ['b']);
    n.clearRedactions();
    expect(storage.loadConfig().redactions, isEmpty);

    final corrupt = await freshStorage({
      AppConstants.keyRecentPurpose: jsonEncode({'purpose': 'VERIFIKASI', 'opacity': 5.0}),
    });
    expect(corrupt.loadConfig().opacity, WatermarkConfig.defaultConfig().opacity);
  });

  test('FLOW-PRS-01-T03 preset bawaan ber-id unik, mencakup kebutuhan lokal dan internasional, dan semuanya valid', () {
    final presets = WatermarkPreset.defaultPresets;
    expect(presets.map((p) => p.id).toSet().length, presets.length);
    expect(presets.map((p) => p.category), containsAll(['Perbankan', 'Internasional']));
    for (final p in presets) {
      expect(p.validate(), isEmpty, reason: p.id);
    }
  });

  test('FLOW-PRS-01-T04 preset kustom ber-id sama menggantikan yang lama di urutan teratas; menerapkannya mengubah cap', () async {
    final storage = await freshStorage();
    final c = containerWith(storage);
    addTearDown(c.dispose);
    final presets = c.read(customPresetsProvider.notifier);
    await presets.addPreset(_preset('custom_1', 'Rental Lama'));
    await presets.addPreset(_preset('custom_2', 'Kos'));
    await presets.addPreset(_preset('custom_1', 'Rental Baru'));
    final list = c.read(customPresetsProvider);
    expect(list.map((p) => p.title), ['Rental Baru', 'Kos']);
    expect(c.read(allPresetsProvider).first.title, 'Rental Baru');

    c.read(watermarkConfigProvider.notifier).applyPreset(list.first);
    final cfg = c.read(watermarkConfigProvider);
    expect(cfg.purpose, 'VERIFIKASI SEWA MOBIL');
    expect(cfg.pattern, WatermarkPattern.cornerStamp);
    expect(cfg.colorOption, WatermarkColorOption.purple);
  });
}
