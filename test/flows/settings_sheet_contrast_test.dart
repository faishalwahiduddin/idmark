import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/theme/app_theme.dart';
import 'package:idmark/core/utils/app_timezone.dart';
import 'package:idmark/features/settings/settings_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import 'harness.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  return (la > lb ? la + 0.05 : lb + 0.05) / (la > lb ? lb + 0.05 : la + 0.05);
}

/// Contrast of [text] against the nearest opaque Material behind it.
double _contrastOf(WidgetTester tester, Finder text) {
  final bg = tester
      .widgetList<Material>(find.ancestor(of: text, matching: find.byType(Material)))
      .map((m) => m.color)
      .firstWhere((c) => c != null && c.a > 0)!;
  final fg = tester.renderObject<RenderParagraph>(text).text.style!.color!;
  return _contrast(fg, bg);
}

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);

  for (final (name, theme) in [('gelap', AppTheme.darkTheme), ('terang', AppTheme.lightTheme)]) {
    testWidgets('FLOW-SET-01-T07 di tema $name pilihan di lembar Bahasa dan Zona Waktu terbaca (kontras >= 4.5)', (tester) async {
      // Test fonts (Ahem) are wider than real ones: RenderFlex overflow is noise here.
      final previous = FlutterError.onError;
      FlutterError.onError = (d) {
        if (!d.exceptionAsString().contains('overflowed')) previous?.call(d);
      };
      addTearDown(() => FlutterError.onError = previous);
      tester.view.physicalSize = const Size(3000, 2796);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final storage = await freshStorage({'locale': 'id'});
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
          home: const SettingsScreen(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Bahasa Aplikasi'));
      await tester.pumpAndSettle();
      final english = find.text('English').last;
      expect(_contrastOf(tester, english), greaterThanOrEqualTo(4.5));
      await tester.tap(english);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('timezone_picker')));
      await tester.pumpAndSettle();
      final auto = find.descendant(
        of: find.byKey(const ValueKey('timezone_option_auto')),
        matching: find.byType(RichText),
      ).first;
      final bg = tester
          .widgetList<Material>(find.ancestor(of: auto, matching: find.byType(Material)))
          .map((m) => m.color)
          .firstWhere((c) => c != null && c.a > 0)!;
      final fg = tester.renderObject<RenderParagraph>(auto).text.style!.color!;
      expect(_contrast(fg, bg), greaterThanOrEqualTo(4.5), reason: 'fg $fg on bg $bg');
    });
  }
}
