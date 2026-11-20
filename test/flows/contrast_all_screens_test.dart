import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/audit_log_entry.dart';
import 'package:idmark/core/models/redaction_item.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/theme/app_theme.dart';
import 'package:idmark/core/utils/app_timezone.dart';
import 'package:idmark/features/editor/editor_screen.dart';
import 'package:idmark/features/guide/kominfo_guide_screen.dart';
import 'package:idmark/features/history/history_screen.dart';
import 'package:idmark/features/presets/presets_screen.dart';
import 'package:idmark/features/settings/settings_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import '../support/contrast_audit.dart';
import '../support/real_fonts.dart';
import 'harness.dart';

/// A 900x570 ID-card-sized PNG, as if picked from the gallery.
Future<Uint8List> _cardPng() async {
  final img = await blankImage(900, 570);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}

AuditLogEntry _lowScoreEntry() => AuditLogEntry(
      id: 'audit_low',
      timestamp: DateTime.utc(2026, 10, 2),
      purpose: 'VERIFIKASI SEWA',
      pattern: 'Cap Sudut',
      exportFormat: 'JPEG',
      fileSizeBytes: 97000,
      sha256Hash: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      redactionsCount: 2,
      metadataStripped: false,
      privacyScore: 50,
    );

/// Pumps [screen] at phone size with real fonts in [theme], with demo data:
/// two history entries (one low score) and, when [withImage], a loaded
/// photo plus one mosaic redaction (shows the weak-redaction warning).
Future<ProviderContainer> _pump(
  WidgetTester tester,
  Widget screen,
  ThemeData theme, {
  bool withImage = false,
}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final storage = await freshStorage({'locale': 'id'});
  await storage.addAuditLog(_lowScoreEntry());
  await storage.addAuditLog(auditEntry(1));
  final container = containerWith(storage);
  addTearDown(container.dispose);
  if (withImage) {
    final png = (await tester.runAsync(_cardPng))!;
    container.read(selectedImageBytesProvider.notifier).setImage(png);
    final box = RedactionBox.fromPreset(RedactionPresetTarget.nik).copyWith(type: RedactionType.mosaic);
    await container.read(watermarkConfigProvider.notifier).addRedaction(box);
  }
  await tester.pumpWidget(UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        FallbackMaterialLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('id'),
      home: screen,
    ),
  ));
  if (withImage) {
    final bytes = container.read(selectedImageBytesProvider)!;
    await tester.runAsync(() => precacheImage(MemoryImage(bytes), tester.element(find.byType(EditorScreen))));
  }
  await tester.pumpAndSettle();
  return container;
}

List<String> _low(WidgetTester tester, ThemeData theme) =>
    lowContrastTexts(tester, base: theme.scaffoldBackgroundColor);

void main() {
  setUpAll(() async {
    await loadRealRoboto();
    AppTimeZone.initAppTimeZones();
  });

  // @tc:FLOW-WMK-01-T07 @tc:FLOW-WMK-01-T08 @tc:FLOW-PRS-01-T06 @tc:FLOW-PRS-01-T07
  // @tc:FLOW-HIS-01-T05 @tc:FLOW-HIS-01-T06 @tc:FLOW-GDE-01-T06 @tc:FLOW-GDE-01-T07
  // @tc:FLOW-SET-01-T08 @tc:FLOW-SET-01-T10
  final screens = <(String, Widget)>[
    ('Watermark (kosong)', const EditorScreen()),
    ('Preset', const PresetsScreen()),
    ('Riwayat', const HistoryScreen()),
    ('Panduan', const KominfoGuideScreen()),
    ('Pengaturan', const SettingsScreen()),
  ];
  final themes = <(String, ThemeData)>[
    ('gelap', AppTheme.darkTheme),
    ('terang', AppTheme.lightTheme),
  ];

  for (final (themeName, theme) in themes) {
    for (final (name, screen) in screens) {
      testWidgets('tema $themeName: layar $name tanpa teks kontras rendah', (tester) async {
        await _pump(tester, screen, theme);
        expect(_low(tester, theme), isEmpty);
      });
    }

    testWidgets('tema $themeName: editor dengan foto, semua tab panel', (tester) async {
      await _pump(tester, const EditorScreen(), theme, withImage: true);
      expect(_low(tester, theme), isEmpty, reason: 'tab Watermark');
      for (final tab in ['Sensor', 'Privasi', 'Format']) {
        final finder = find.descendant(of: find.byType(TabBar), matching: find.text(tab));
        await tester.ensureVisible(finder);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(_low(tester, theme), isEmpty, reason: 'tab $tab');
      }
    });
  }
}
