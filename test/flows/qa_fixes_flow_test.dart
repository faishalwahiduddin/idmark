import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/redaction_item.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/services/document_saver.dart';
import 'package:idmark/core/services/stamp_layout.dart';
import 'package:idmark/core/services/watermark_renderer_service.dart';
import 'package:idmark/core/theme/app_theme.dart';
import 'package:idmark/core/utils/app_timezone.dart';
import 'package:idmark/features/editor/editor_screen.dart';
import 'package:idmark/features/editor/widgets/watermark_canvas_preview.dart';
import 'package:idmark/features/history/history_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import '../support/real_fonts.dart';
import 'harness.dart';

const _longPurpose =
    'HANYA UNTUK VERIFIKASI BANK X CABANG JAKARTA SELATAN, PEMBUKAAN REKENING BARU';

void _phone(WidgetTester tester) {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

Widget _app(Widget home, {ProviderContainer? container}) {
  final app = MaterialApp(
    theme: AppTheme.darkTheme,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      FallbackMaterialLocalizationsDelegate(),
      FallbackWidgetsLocalizationsDelegate(),
      FallbackCupertinoLocalizationsDelegate(),
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('id'),
    home: home,
  );
  return container == null ? app : UncontrolledProviderScope(container: container, child: app);
}

Future<Uint8List> _cardPng() async {
  final img = await blankImage(900, 570);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}

/// Records saves instead of touching shared storage.
class _FakeSaver extends DocumentSaver {
  final saved = <(String, Uint8List)>[];

  @override
  Future<SavedDocument?> save(Uint8List bytes, String filename, {required bool isImage}) async {
    saved.add((filename, bytes));
    return SavedDocument('/storage/emulated/0/Pictures/IDMark/$filename', SavedLocation.pictures);
  }
}

void main() {
  setUpAll(() async {
    await loadRealRoboto();
    AppTimeZone.initAppTimeZones();
  });

  group('stamp fit (QA #1)', () {
    final zone = AppTimeZone.locationOrFallback(kFallbackZoneName);
    final base = WatermarkConfig.defaultConfig().copyWith(
      purpose: _longPurpose,
      customSubtext: 'HANYA UNTUK KELENGKAPAN BERKAS',
      fontSize: 42,
    );

    for (final size in const [Size(900, 570), Size(570, 900), Size(320, 200), Size(4000, 2520)]) {
      for (final angle in const [-45.0, -22.0, 0.0, 22.0, 45.0]) {
        test('long stamp at $angle° stays inside ${size.width.toInt()}x${size.height.toInt()}', () {
          final config = base.copyWith(rotationAngle: angle);
          final block = WatermarkRendererService.layoutDiagonalBand(config, size, zone);
          final bounds = StampFit.rotatedBounds(block.size, angle);
          expect(bounds.width, lessThanOrEqualTo(size.width), reason: 'band wider than image');
          expect(bounds.height, lessThanOrEqualTo(size.height), reason: 'band taller than image');
          // The date (anti-reuse proof) is part of the fitted text.
          final text = block.main.text!.toPlainText();
          expect(text, contains('TGL: ${config.dateLabelIn(zone)}'));
          expect(text.replaceAll('\n', ' '), contains('HANYA UNTUK VERIFIKASI'));
        });
      }
    }

    test('short stamp keeps the requested size on one line', () {
      final config = WatermarkConfig.defaultConfig().copyWith(purpose: 'BANK X');
      const size = Size(1080, 680);
      final block = WatermarkRendererService.layoutDiagonalBand(config, size, zone);
      expect(block.fontSize, closeTo(config.fontSize, 0.001));
      expect(block.main.computeLineMetrics(), hasLength(1));
    });

    testWidgets('every pattern renders a long stamp without error', (tester) async {
      await tester.runAsync(() async {
        final src = await blankImage(600, 380);
        for (final p in WatermarkPattern.values) {
          final bytes = await WatermarkRendererService.renderWatermark(
            sourceImage: src,
            config: base.copyWith(pattern: p, rotationAngle: 45),
            zone: zone,
          );
          expect(bytes, isNotEmpty, reason: p.name);
        }
      });
    });
  });

  group('placeholder (QA #4)', () {
    test('unfilled [NAMA BANK] is detected and never scores A+', () {
      final config = WatermarkConfig.defaultConfig().copyWith(
        purpose: 'VERIFIKASI REKENING BANK [NAMA BANK]',
        pattern: WatermarkPattern.repeatedGrid,
        redactions: [RedactionBox.fromPreset(RedactionPresetTarget.nik)],
      );
      expect(config.unfilledPlaceholders, ['[NAMA BANK]']);
      expect(config.hasSpecificPurpose, isFalse);
      expect(config.privacyGrade, isNot('A+'));
      final filled = config.copyWith(purpose: 'VERIFIKASI REKENING BANK MANDIRI');
      expect(filled.hasUnfilledPlaceholder, isFalse);
      expect(filled.privacyGrade, 'A+');
    });
  });

  group('state (QA #7, #8)', () {
    test('editor format override never rewrites the Settings default', () async {
      final container = containerWith(await freshStorage());
      addTearDown(container.dispose);
      expect(container.read(effectiveExportFormatProvider), ExportFormat.png);
      container.read(exportFormatOverrideProvider.notifier).set(ExportFormat.jpeg);
      expect(container.read(effectiveExportFormatProvider), ExportFormat.jpeg);
      expect(container.read(watermarkConfigProvider).exportFormat, ExportFormat.png);
    });

    test('a new photo resets the stamp date to today', () async {
      final container = containerWith(await freshStorage());
      addTearDown(container.dispose);
      final notifier = container.read(watermarkConfigProvider.notifier);
      await notifier.updateDate(DateTime.utc(2026, 10, 1));
      final today = DateTime.utc(2026, 11, 20, 4);
      await withClock(Clock.fixed(today), notifier.resetDateToToday);
      expect(container.read(watermarkConfigProvider).transactionDate, today);
    });
  });

  testWidgets('QA #4 #5 #6 #7: export blocks placeholders, saves JPEG, logs JPEG, keeps default PNG',
      (tester) async {
    _phone(tester);
    final saver = _FakeSaver();
    final storage = await freshStorage({'locale': 'id'});
    final container = ProviderContainer(overrides: [
      localStorageServiceProvider.overrideWithValue(storage),
      documentSaverProvider.overrideWithValue(saver),
    ]);
    addTearDown(container.dispose);
    final png = (await tester.runAsync(_cardPng))!;
    container.read(selectedImageBytesProvider.notifier).setImage(png);
    await container.read(watermarkConfigProvider.notifier).updatePurpose('VERIFIKASI REKENING BANK [NAMA BANK]');

    await tester.pumpWidget(_app(const EditorScreen(), container: container));
    await tester.pumpAndSettle();
    final l10n = AppLocalizations.of(tester.element(find.byType(EditorScreen)))!;

    // The purpose field flags the placeholder inline.
    expect(find.text(l10n.placeholderUnfilled('[NAMA BANK]')), findsOneWidget);

    final save = find.text(l10n.saveDocument('PNG'));
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pump();
    expect(find.text(l10n.placeholderUnfilled('[NAMA BANK]')), findsNWidgets(2), reason: 'field + snackbar');
    expect(saver.saved, isEmpty);
    expect(container.read(auditLogsProvider), isEmpty);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    // Fill it in and pick JPEG for this export in the Format tab.
    await container.read(watermarkConfigProvider.notifier).updatePurpose('VERIFIKASI REKENING BANK MANDIRI');
    final formatTab = find.descendant(of: find.byType(TabBar), matching: find.text(l10n.tabFormatShort));
    await tester.ensureVisible(formatTab);
    await tester.tap(formatTab);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.formatJpeg));
    await tester.pumpAndSettle();

    final saveJpeg = find.text(l10n.saveDocument('JPEG'));
    await tester.ensureVisible(saveJpeg);
    await tester.tap(saveJpeg);
    for (var i = 0; i < 100 && saver.saved.isEmpty; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    await tester.pumpAndSettle();

    expect(saver.saved, hasLength(1));
    final (name, bytes) = saver.saved.single;
    expect(name, endsWith('.jpg'));
    expect(bytes.sublist(0, 2), [0xFF, 0xD8], reason: 'real JPEG bytes');
    expect(container.read(auditLogsProvider).single.exportFormat, 'JPEG');
    expect(container.read(watermarkConfigProvider).exportFormat, ExportFormat.png,
        reason: 'Settings default untouched');
    expect(find.text(l10n.savedToGallery), findsOneWidget);
    // Share reuses the same bytes: closing the dialog adds no second entry.
    await tester.tap(find.text(l10n.close));
    await tester.pumpAndSettle();
    expect(container.read(auditLogsProvider), hasLength(1));
  });

  testWidgets('QA #14: delete one history entry, then undo', (tester) async {
    _phone(tester);
    final storage = await freshStorage({'locale': 'id'});
    await storage.addAuditLog(auditEntry(1));
    await storage.addAuditLog(auditEntry(2));
    final container = containerWith(storage);
    addTearDown(container.dispose);
    await tester.pumpWidget(_app(const HistoryScreen(), container: container));
    await tester.pumpAndSettle();
    final l10n = AppLocalizations.of(tester.element(find.byType(HistoryScreen)))!;

    expect(find.text('VERIFIKASI BANK 2'), findsOneWidget);
    await tester.tap(find.byTooltip(l10n.deleteEntry).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.deleteEntry));
    await tester.pumpAndSettle();
    expect(find.text('VERIFIKASI BANK 2'), findsNothing);
    expect(find.text('VERIFIKASI BANK 1'), findsOneWidget);
    expect(storage.loadAuditLogs().map((e) => e.id), ['audit_1']);

    await tester.tap(find.text(l10n.undo));
    await tester.pumpAndSettle();
    expect(storage.loadAuditLogs().map((e) => e.id), ['audit_2', 'audit_1']);

    // Swipe left removes too.
    await tester.drag(find.text('VERIFIKASI BANK 1'), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(storage.loadAuditLogs().map((e) => e.id), ['audit_2']);
  });

  testWidgets('QA #2: drag a redaction box on the preview, then resize it', (tester) async {
    _phone(tester);
    final png = (await tester.runAsync(_cardPng))!;
    final box = RedactionBox.fromPreset(RedactionPresetTarget.nik);
    final updates = <RedactionBox>[];
    var config = WatermarkConfig.defaultConfig().copyWith(redactions: [box]);
    await tester.pumpWidget(_app(StatefulBuilder(
      builder: (context, setState) => Scaffold(
        body: WatermarkCanvasPreview(
          imageBytes: png,
          config: config,
          onPickGallery: () {},
          onPickCamera: () {},
          onClear: () {},
          onUpdateRedaction: (b) {
            updates.add(b);
            setState(() => config = config.copyWith(redactions: [b]));
          },
        ),
      ),
    )));
    await tester.runAsync(() => precacheImage(MemoryImage(png), tester.element(find.byType(WatermarkCanvasPreview))));
    await tester.pumpAndSettle();

    final drag = find.byKey(ValueKey('redaction-drag-${box.id}'));
    expect(drag, findsOneWidget);
    await tester.timedDrag(drag, const Offset(60, 30), const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(updates, hasLength(1));
    expect(updates.last.left, greaterThan(box.left));
    expect(updates.last.top, greaterThan(box.top));
    expect(updates.last.width, closeTo(box.width, 1e-9));

    final resize = find.byKey(ValueKey('redaction-resize-${box.id}'));
    await tester.timedDrag(resize, const Offset(40, 20), const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(updates, hasLength(2));
    expect(updates.last.width, greaterThan(box.width));
    expect(updates.last.height, greaterThan(box.height));
  });

  testWidgets('QA #3 #16: pinned preview + 4 tabs lay out at 1.6x text', (tester) async {
    _phone(tester);
    final storage = await freshStorage({'locale': 'id'});
    final container = containerWith(storage);
    addTearDown(container.dispose);
    final png = (await tester.runAsync(_cardPng))!;
    container.read(selectedImageBytesProvider.notifier).setImage(png);
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(_app(const EditorScreen(), container: container));
    expect(MediaQuery.textScalerOf(tester.element(find.byType(EditorScreen))).scale(10), 16);
    await tester.runAsync(() => precacheImage(MemoryImage(png), tester.element(find.byType(EditorScreen))));
    await tester.pumpAndSettle();
    final stage = find.byType(InteractiveViewer);
    final top = tester.getTopLeft(stage).dy;
    // Scrolling the controls leaves the preview where it is.
    await tester.drag(find.byType(TabBar), const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(stage).dy, top);
    expect(tester.takeException(), isNull);
  });
}
