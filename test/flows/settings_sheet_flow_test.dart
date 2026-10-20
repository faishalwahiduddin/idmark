import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/features/settings/settings_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import 'harness.dart';

void main() {
  testWidgets('FLOW-SET-01-T05 lembar Pilih Bahasa dan Zona Waktu terbuka tanpa galat render dan bisa memilih bahasa', (tester) async {
    final storage = await freshStorage();
    // Test fonts (Ahem) are wider than real ones, so RenderFlex overflow is noise
    // here; any other render/widget error (e.g. a missing Material) fails the case.
    final errors = <String>[];
    final previous = FlutterError.onError;
    FlutterError.onError = (d) {
      final msg = d.exceptionAsString();
      if (!msg.contains('overflowed')) errors.add(msg);
    };
    addTearDown(() => FlutterError.onError = previous);
    tester.view.physicalSize = const Size(430 * 3, 932 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(
      overrides: [localStorageServiceProvider.overrideWithValue(storage)],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          FallbackMaterialLocalizationsDelegate(),
          FallbackWidgetsLocalizationsDelegate(),
          FallbackCupertinoLocalizationsDelegate(),
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('id'),
        home: SettingsScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bahasa Aplikasi'));
    await tester.pumpAndSettle();
    expect(errors, isEmpty);
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();
    expect(storage.prefs.getString('locale'), 'en');

    await tester.tap(find.byKey(const ValueKey('timezone_picker')));
    await tester.pumpAndSettle();
    expect(errors, isEmpty);
    expect(find.byKey(const ValueKey('timezone_option_auto')), findsOneWidget);
  });
}
