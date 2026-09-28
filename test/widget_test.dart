import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:idmark/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('IdMarkApp smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final storageService = await LocalStorageService.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageServiceProvider.overrideWithValue(storageService),
        ],
        child: const IdMarkApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify app brand and header renders
    expect(find.text('IDMark'), findsOneWidget);
    expect(find.text('Unggah Foto e-KTP / Identitas'), findsOneWidget);
    expect(find.text('Buka Galeri'), findsOneWidget);
    expect(find.text('Konfigurasi Watermark'), findsOneWidget);
  });
}
