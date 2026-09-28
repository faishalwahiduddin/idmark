import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/audit_log_entry.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:idmark/features/guide/kominfo_guide_screen.dart';
import 'package:idmark/features/history/history_screen.dart';
import 'package:idmark/features/presets/presets_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('HistoryScreen renders empty state and populated logs correctly', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.init();

    final container = ProviderContainer(
      overrides: [
        localStorageServiceProvider.overrideWithValue(storage),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: HistoryScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Riwayat & Audit Log'), findsOneWidget);
    expect(find.text('Belum Ada Dokumen Ter-Watermark'), findsOneWidget);

    // Now populate an audit log entry via the Riverpod notifier
    final entry = AuditLogEntry(
      id: 'test_entry',
      timestamp: DateTime(2026, 9, 28, 14, 30),
      purpose: 'VERIFIKASI PINJAMAN PT ABC',
      pattern: 'Pita Melintang',
      exportFormat: 'PNG',
      fileSizeBytes: 2048,
      sha256Hash: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      redactionsCount: 1,
      metadataStripped: true,
      privacyScore: 92,
    );
    await container.read(auditLogsProvider.notifier).recordExport(entry);

    await tester.pumpAndSettle();

    expect(find.text('VERIFIKASI PINJAMAN PT ABC'), findsOneWidget);
    expect(find.textContaining('Skor 92%'), findsOneWidget);
    expect(find.textContaining('1 Sensor Sensitif'), findsOneWidget);
  });

  testWidgets('PresetsScreen renders search bar, category chips, and presets catalog', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageServiceProvider.overrideWithValue(storage),
        ],
        child: const MaterialApp(home: PresetsScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Template & Preset Hub'), findsOneWidget);
    expect(find.text('Semua'), findsOneWidget);
    expect(find.widgetWithText(FilterChip, 'Perbankan'), findsOneWidget);
    expect(find.text('Pembukaan Rekening Bank'), findsOneWidget);
  });

  testWidgets('KominfoGuideScreen renders interactive checklist and rules', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: KominfoGuideScreen()),
    );

    await tester.pumpAndSettle();

    expect(find.text('Panduan Resmi Kominfo & UU PDP'), findsOneWidget);
    expect(find.text('Checklist Aman Sebelum Kirim e-KTP'), findsOneWidget);
    expect(find.text('0 / 5 Selesai'), findsOneWidget);

    // Tap first checklist item
    await tester.tap(find.text('Nama instansi/penerima tertulis jelas pada watermark'));
    await tester.pumpAndSettle();

    expect(find.text('1 / 5 Selesai'), findsOneWidget);
  });
}
