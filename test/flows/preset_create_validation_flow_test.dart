import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:idmark/features/presets/presets_screen.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

import 'harness.dart';

const _saveLabel = 'Simpan Preset';
const _categoryTooLong = 'Kategori maksimal 30 karakter';

Future<LocalStorageService> _openCreateDialog(WidgetTester tester) async {
  final previous = FlutterError.onError;
  FlutterError.onError = (d) {
    if (!d.exceptionAsString().contains('overflowed')) previous?.call(d);
  };
  addTearDown(() => FlutterError.onError = previous);
  // Test fonts (Ahem) are wider than real ones: give the dialog a tall surface.
  tester.view.physicalSize = const Size(430 * 3, 1600 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final storage = await freshStorage();
  await tester.pumpWidget(
    ProviderScope(
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
        home: const PresetsScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.add_circle_outline));
  await tester.pumpAndSettle();
  return storage;
}

/// Dialog text fields in layout order: 0 title, 1 category, 2 purpose, 3 subtext.
Finder _field(int index) => find
    .descendant(of: find.byType(AlertDialog), matching: find.byType(TextField))
    .at(index);

Finder _saveButton() => find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(ElevatedButton, _saveLabel),
    );

Future<void> _fillAndSave(WidgetTester tester) async {
  await tester.enterText(_field(0), 'Preset Uji');
  await tester.enterText(_field(2), 'VERIFIKASI REKENING BANK BCA');
  await tester.tap(_saveButton());
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'FLOW-PRS-01-T11 kategori preset 31 karakter ditolak: dialog tetap terbuka, galat tampil, tidak ada yang tersimpan',
    (tester) async {
      final storage = await _openCreateDialog(tester);
      await tester.enterText(_field(0), 'Preset Uji');
      await tester.enterText(_field(2), 'VERIFIKASI REKENING BANK BCA');
      // Set the controller directly to bypass the 30-char input limiter, the
      // same path a paste or restored draft would take.
      tester.widget<TextField>(_field(1)).controller!.text = 'A' * 31;
      await tester.pump();

      await tester.tap(_saveButton());
      await tester.pumpAndSettle();

      expect(find.text(_categoryTooLong), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(SnackBar), findsNothing);
      expect(storage.loadCustomPresets(), isEmpty);
    },
  );

  testWidgets(
    'FLOW-PRS-01-T12 kategori preset tepat 30 karakter tersimpan dan dialog ditutup',
    (tester) async {
      final storage = await _openCreateDialog(tester);
      await tester.enterText(_field(1), 'A' * 30);
      await _fillAndSave(tester);

      final saved = storage.loadCustomPresets();
      expect(saved, hasLength(1));
      expect(saved.single.category, 'A' * 30);
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
}
