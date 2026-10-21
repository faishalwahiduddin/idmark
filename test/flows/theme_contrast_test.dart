import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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

import 'contrast_audit.dart';
import 'harness.dart';

bool _isIconGlyph(String line) {
  final text = line.split(' → ').first;
  return text.runes.every((r) => (r >= 0xE000 && r <= 0xF8FF) || r >= 0xF0000);
}

/// Renders [screen] in [theme] (one audit entry so the history screen has a card)
/// and returns every non-icon text below 4.5:1 (large text 3:1).
Future<List<String>> _audit(WidgetTester tester, Widget screen, ThemeData theme) async {
  // Test fonts (Ahem) are wider than real ones: RenderFlex overflow is noise here.
  final previous = FlutterError.onError;
  FlutterError.onError = (d) {
    if (!d.exceptionAsString().contains('overflowed')) previous?.call(d);
  };
  addTearDown(() => FlutterError.onError = previous);
  tester.view.physicalSize = const Size(1290, 2796);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final storage = await freshStorage({'locale': 'id'});
  await storage.addAuditLog(auditEntry(1));
  await tester.pumpWidget(ProviderScope(
    overrides: [localStorageServiceProvider.overrideWithValue(storage)],
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
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  return lowContrastTexts(tester, base: theme.scaffoldBackgroundColor).where((l) => !_isIconGlyph(l)).toList();
}

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);

  // Each screen's guards are edge cases of the flow that owns the screen:
  // @tc:FLOW-WMK-01-T07 @tc:FLOW-WMK-01-T08 @tc:FLOW-PRS-01-T06 @tc:FLOW-PRS-01-T07
  // @tc:FLOW-HIS-01-T05 @tc:FLOW-HIS-01-T06 @tc:FLOW-GDE-01-T06 @tc:FLOW-GDE-01-T07
  // @tc:FLOW-SET-01-T08 @tc:FLOW-SET-01-T10
  final screens = <(String, String, String, Widget)>[
    ('Watermark (editor)', 'FLOW-WMK-01-T07', 'FLOW-WMK-01-T08', const EditorScreen()),
    ('Preset', 'FLOW-PRS-01-T06', 'FLOW-PRS-01-T07', const PresetsScreen()),
    ('Riwayat', 'FLOW-HIS-01-T05', 'FLOW-HIS-01-T06', const HistoryScreen()),
    ('Panduan', 'FLOW-GDE-01-T06', 'FLOW-GDE-01-T07', const KominfoGuideScreen()),
    ('Pengaturan', 'FLOW-SET-01-T08', 'FLOW-SET-01-T10', const SettingsScreen()),
  ];
  for (final (name, darkTc, lightTc, screen) in screens) {
    testWidgets('$darkTc tema gelap: semua teks di layar $name kontras >= 4.5', (tester) async {
      expect(await _audit(tester, screen, AppTheme.darkTheme), isEmpty);
    });
    testWidgets('$lightTc tema terang: semua teks di layar $name kontras >= 4.5', (tester) async {
      expect(await _audit(tester, screen, AppTheme.lightTheme), isEmpty);
    });
  }
}
