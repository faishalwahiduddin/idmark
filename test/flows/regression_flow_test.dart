import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/features/editor/editor_screen.dart';
import 'package:idmark/features/presets/presets_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import 'harness.dart';

Future<void> _pump(WidgetTester tester, Widget home) async {
  final storage = await freshStorage();
  // Test fonts (Ahem) are wider than real ones: RenderFlex overflow is noise here.
  final previous = FlutterError.onError;
  FlutterError.onError = (d) {
    if (!d.exceptionAsString().contains('overflowed')) previous?.call(d);
  };
  addTearDown(() => FlutterError.onError = previous);
  tester.view.physicalSize = const Size(430 * 3, 1600 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ProviderScope(
    overrides: [localStorageServiceProvider.overrideWithValue(storage)],
    child: MaterialApp(
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
  ));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('FLOW-WMK-01-T06 kolom Tujuan Watermark punya label aksesibilitas sebagai kolom teks', (tester) async {
    final handle = tester.ensureSemantics();
    await _pump(tester, const EditorScreen());
    expect(
      tester.getSemantics(find.byType(EditableText).first),
      isSemantics(label: 'Tujuan Watermark (Sesuai Kebutuhan)', isTextField: true),
    );
    handle.dispose();
  });

  testWidgets('FLOW-PRS-01-T05 tombol hapus pencarian mengosongkan kolom dan menampilkan lagi semua template', (tester) async {
    await _pump(tester, const PresetsScreen());
    final field = find.byType(TextField).first;
    await tester.enterText(field, 'bank');
    await tester.pumpAndSettle();
    expect(find.text('Menampilkan 18 template'), findsNothing);
    await tester.tap(find.byIcon(Icons.clear).first);
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(field).controller?.text ?? '', isEmpty);
    expect(find.text('bank'), findsNothing);
    expect(find.text('Menampilkan 18 template'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1)); // let StaggerFadeIn's entrance timers finish
  });
}
