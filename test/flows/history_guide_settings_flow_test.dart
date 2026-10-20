import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/constants/app_constants.dart';
import 'package:idmark/core/models/redaction_item.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/providers/locale_provider.dart';
import 'package:idmark/core/providers/theme_provider.dart';

import 'harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FLOW-HIS-01-T03 riwayat dibatasi 50 ekspor terbaru, urutan terbaru di atas', () async {
    final storage = await freshStorage();
    for (var i = 1; i <= 55; i++) {
      await storage.addAuditLog(auditEntry(i));
    }
    final logs = storage.loadAuditLogs();
    expect(logs.length, 50);
    expect(logs.first.id, 'audit_55');
    expect(logs.last.id, 'audit_6');
  });

  test('FLOW-HIS-01-T04 riwayat rusak di storage dibaca kosong; bersihkan riwayat mengosongkan daftar', () async {
    final broken = await freshStorage({AppConstants.keyAuditHistory: '[{rusak'});
    expect(broken.loadAuditLogs(), isEmpty);

    final storage = await freshStorage();
    final c = containerWith(storage);
    addTearDown(c.dispose);
    await c.read(auditLogsProvider.notifier).recordExport(auditEntry(1));
    expect(c.read(auditLogsProvider).length, 1);
    await c.read(auditLogsProvider.notifier).clearHistory();
    expect(c.read(auditLogsProvider), isEmpty);
    expect(storage.loadAuditLogs(), isEmpty);
  });

  test('FLOW-GDE-01-T02 cap tanpa tanggal, tanpa sanitasi EXIF, dengan tujuan pendek mendapat nilai privasi D', () {
    final weak = WatermarkConfig(
      purpose: 'KTP',
      transactionDate: DateTime.utc(2026, 1, 1),
      includeDate: false,
      stripMetadata: false,
    );
    expect(weak.privacyScore, 10);
    expect(weak.privacyGrade, 'D');
  });

  test('FLOW-GDE-01-T03 batas nilai: 80 poin = A, 90 poin = A+', () {
    final base = WatermarkConfig(purpose: 'VERIFIKASI BANK', transactionDate: DateTime.utc(2026, 1, 1));
    expect(base.privacyScore, 80);
    expect(base.privacyGrade, 'A');
    final grid = base.copyWith(pattern: WatermarkPattern.repeatedGrid);
    expect(grid.privacyScore, 85);
    final sensor = base.copyWith(redactions: [RedactionBox.fromPreset(RedactionPresetTarget.nik)]);
    expect(sensor.privacyScore, 95);
    expect(sensor.privacyGrade, 'A+');
  });

  test('FLOW-GDE-01-T04 semua perlindungan aktif sekaligus tetap dijepit maksimum 100', () {
    final all = WatermarkConfig(
      purpose: 'VERIFIKASI REKENING BANK',
      transactionDate: DateTime.utc(2026, 1, 1),
      pattern: WatermarkPattern.crossStamp,
      redactions: [RedactionBox.fromPreset(RedactionPresetTarget.signature)],
    );
    expect(all.privacyScore, 100);
  });

  test('FLOW-SET-01-T01 bahasa dan tema pilihan tersimpan lalu dipakai lagi saat app dibuka ulang', () async {
    final storage = await freshStorage();
    final c = containerWith(storage);
    addTearDown(c.dispose);
    await c.read(localeProvider.notifier).setLocale(const Locale('en'));
    await storage.saveThemeMode(ThemeMode.light);
    final reopened = containerWith(storage);
    addTearDown(reopened.dispose);
    expect(reopened.read(localeProvider), const Locale('en'));
    expect(reopened.read(themeModeProvider), ThemeMode.light);
  });

  test('FLOW-SET-01-T02 konfigurasi tersimpan yang melanggar §VAL (tujuan kosong) diabaikan, kembali ke bawaan', () async {
    final storage = await freshStorage({
      AppConstants.keyRecentPurpose: jsonEncode({'purpose': '', 'opacity': 0.5}),
    });
    expect(storage.loadConfig().purpose, WatermarkConfig.defaultConfig().purpose);
  });

  test('FLOW-SET-01-T03 instalasi baru: tema gelap, sanitasi EXIF aktif, ekspor PNG', () async {
    final storage = await freshStorage();
    expect(storage.getThemeMode(), ThemeMode.dark);
    expect(storage.getAutoStripExif(), isTrue);
    expect(storage.loadConfig().exportFormat, ExportFormat.png);
  });
}
