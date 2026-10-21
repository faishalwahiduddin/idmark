import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/core/models/watermark_preset.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/theme/app_theme.dart';
import 'package:idmark/core/utils/app_timezone.dart';
import 'package:idmark/features/editor/widgets/idmark_share_dialog.dart';
import 'package:idmark/features/presets/presets_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import 'contrast_audit.dart';
import 'harness.dart';

const _preset = WatermarkPreset(
  id: 'custom_1',
  title: 'Rental Uji',
  category: 'Kustom',
  samplePurpose: 'VERIFIKASI SEWA MOBIL',
  subtext: '',
  icon: Icons.bookmark_border,
  defaultPattern: WatermarkPattern.cornerStamp,
  defaultColor: WatermarkColorOption.purple,
  isCustom: true,
);

Future<ProviderContainer> _pump(
  WidgetTester tester,
  Widget home,
  ThemeData theme,
) async {
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
  await storage.addCustomPreset(_preset);
  final container = containerWith(storage);
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
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
        home: home,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

bool _isIconGlyph(String line) {
  final text = line.split(' → ').first;
  return text.runes.every((r) => (r >= 0xE000 && r <= 0xF8FF) || r >= 0xF0000);
}

List<String> _audit(WidgetTester tester, ThemeData theme) => lowContrastTexts(
  tester,
  base: theme.scaffoldBackgroundColor,
).where((l) => !_isIconGlyph(l)).toList();

/// Opens the create-preset dialog, audits it, closes it, opens the delete dialog and audits that.
Future<List<String>> _auditPresetDialogs(
  WidgetTester tester,
  ThemeData theme,
) async {
  await _pump(tester, const PresetsScreen(), theme);
  await tester.tap(find.byIcon(Icons.add_circle_outline));
  await tester.pumpAndSettle();
  final bad = [..._audit(tester, theme)];
  await tester.tap(find.byType(TextButton).last);
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.delete_outline));
  await tester.pumpAndSettle();
  bad.addAll(_audit(tester, theme));
  return bad;
}

Future<List<String>> _auditShare(WidgetTester tester, ThemeData theme) async {
  await _pump(
    tester,
    Scaffold(
      body: SingleChildScrollView(
        child: IdmarkShareDialog(
          config: WatermarkConfig.defaultConfig(),
          sha256Hash:
              'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
          dateLabel: '21-10-2026',
          fileSizeBytes: 123456,
        ),
      ),
    ),
    theme,
  );
  await tester.pump(const Duration(seconds: 1));
  return _audit(tester, theme);
}

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);

  testWidgets(
    'FLOW-PRS-01-T08 menghapus preset yang sedang dipakai lewat dialog konfirmasi: cap tetap, daftar berkurang, tanpa galat',
    (tester) async {
      final c = await _pump(tester, const PresetsScreen(), AppTheme.lightTheme);
      c.read(watermarkConfigProvider.notifier).applyPreset(_preset);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(c.read(customPresetsProvider), isEmpty);
      expect(c.read(watermarkConfigProvider).purpose, 'VERIFIKASI SEWA MOBIL');
    },
  );

  testWidgets(
    'FLOW-PRS-01-T09 tema gelap: dialog buat dan hapus preset kontras >= 4.5',
    (tester) async {
      expect(await _auditPresetDialogs(tester, AppTheme.darkTheme), isEmpty);
    },
  );
  testWidgets(
    'FLOW-PRS-01-T10 tema terang: dialog buat dan hapus preset kontras >= 4.5',
    (tester) async {
      expect(await _auditPresetDialogs(tester, AppTheme.lightTheme), isEmpty);
    },
  );
  testWidgets(
    'FLOW-WMK-01-T09 tema gelap: dialog bagikan hasil kontras >= 4.5',
    (tester) async {
      expect(await _auditShare(tester, AppTheme.darkTheme), isEmpty);
    },
  );
  testWidgets(
    'FLOW-WMK-01-T10 tema terang: dialog bagikan hasil kontras >= 4.5',
    (tester) async {
      expect(await _auditShare(tester, AppTheme.lightTheme), isEmpty);
    },
  );
}
