import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

import 'harness.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  return (la > lb ? la + 0.05 : lb + 0.05) / (la > lb ? lb + 0.05 : la + 0.05);
}

/// Background painted behind [element]: nearest Material / ColoredBox / BoxDecoration
/// colour, alpha-blended over the next one down. Null when a gradient or image
/// is in the way (cannot be judged from one colour).
Color? _backgroundOf(Element element) {
  final layers = <Color>[];
  var stop = false;
  element.visitAncestorElements((a) {
    final w = a.widget;
    Color? c;
    if (w is Material && w.type != MaterialType.transparency) c = w.color;
    if (w is ColoredBox) c = w.color;
    if (w is DecoratedBox || w is Container) {
      final d = w is DecoratedBox ? w.decoration : (w as Container).decoration;
      if (d is BoxDecoration) {
        if (d.gradient != null || d.image != null) {
          stop = layers.isEmpty;
          return false;
        }
        c = d.color;
      }
    }
    if (c != null && c.a > 0) {
      layers.add(c);
      if (c.a >= 1) return false;
    }
    return true;
  });
  if (stop || layers.isEmpty) return null;
  var bg = layers.last.withValues(alpha: 1);
  for (final c in layers.reversed.skip(1)) {
    bg = Color.alphaBlend(c, bg);
  }
  return bg;
}

/// Every visible text on screen with contrast below 4.5 (WCAG AA), as "text: ratio".
List<String> lowContrastTexts(WidgetTester tester) {
  final bad = <String>[];
  final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
  for (final element in find.byType(RichText).evaluate()) {
    final ro = element.renderObject as RenderParagraph?;
    if (ro == null || !ro.attached || !ro.hasSize || ro.size.isEmpty) continue;
    final origin = ro.localToGlobal(Offset.zero);
    if (origin.dy > screen.height || origin.dx > screen.width) continue;
    final text = ro.text.toPlainText().trim();
    final fg = ro.text.style?.color;
    if (text.isEmpty || fg == null || fg.a < 0.5) continue;
    // Icon glyphs (private-use code points) are not text.
    final isIcon = text.runes.every((r) => r >= 0xE000 && r <= 0xF8FF || r >= 0xF0000);
    if (isIcon) continue;
    final bg = _backgroundOf(element);
    if (bg == null) continue;
    final ratio = _contrast(Color.alphaBlend(fg, bg), bg);
    if (ratio < 4.5) {
      final label = text.length > 40 ? text.substring(0, 40) : text;
      bad.add('$label: ${ratio.toStringAsFixed(2)}');
    }
  }
  return bad;
}

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);

  // Each screen's guard is an edge case of the flow that owns the screen.
  testWidgets(
    'FLOW-WMK-01-T07 tema gelap: semua teks di layar Watermark (editor) kontras >= 4.5',
    (t) => _audit(t, const EditorScreen()),
  );
  testWidgets(
    'FLOW-PRS-01-T06 tema gelap: semua teks di layar Preset kontras >= 4.5',
    (t) => _audit(t, const PresetsScreen()),
  );
  testWidgets(
    'FLOW-HIS-01-T05 tema gelap: semua teks di layar Riwayat kontras >= 4.5',
    (t) => _audit(t, const HistoryScreen()),
  );
  testWidgets(
    'FLOW-GDE-01-T06 tema gelap: semua teks di layar Panduan kontras >= 4.5',
    (t) => _audit(t, const KominfoGuideScreen()),
  );
  testWidgets(
    'FLOW-SET-01-T08 tema gelap: semua teks di layar Pengaturan kontras >= 4.5',
    (t) => _audit(t, const SettingsScreen()),
  );
}

Future<void> _audit(WidgetTester tester, Widget screen) async {
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
  await tester.pumpWidget(
    ProviderScope(
      overrides: [localStorageServiceProvider.overrideWithValue(storage)],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
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
    ),
  );
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  expect(lowContrastTexts(tester), isEmpty);
}
