// Per-app hook for the store screen harness (store_screens_test.dart).
// install-harness.sh never overwrites this file. Checklist: flutter_harness/README.md.
//
// Reproduce what main() does under --dart-define=STORE_DEMO=true, minus the
// platform plugins: seed storage, skip onboarding/consent, return the app root.
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/demo/store_demo.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/router/app_router.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:idmark/core/utils/app_timezone.dart';
import 'package:idmark/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// How long the splash screen needs before the router can be driven.
const kStoreSplash = Duration(seconds: 1);

/// Once per test process: plugin mocks (PackageInfo, path_provider, timezone).
Future<void> storeSetUpAll() async {
  AppTimeZone.initAppTimeZones();
  AppTimeZone.cachedDeviceZone = 'Asia/Jakarta';
  // Hashes and templates use fontFamily: 'monospace', which the test engine
  // draws as box glyphs. Alias it to a host monospace font.
  final loader = FontLoader('monospace')
    ..addFont(Future.value(
        ByteData.sublistView(File('/System/Library/Fonts/Monaco.ttf').readAsBytesSync())));
  await loader.load();
}

/// Builds the app root for [lang] (app language code, e.g. 'en') with demo
/// data seeded. Runs in real async, so file/plugin futures complete.
Future<Widget> storeBuildApp(String lang) async {
  SharedPreferences.setMockInitialValues({'locale': lang});
  final storage = await LocalStorageService.init();
  await seedStoreDemo(storage);
  return ProviderScope(
    overrides: [localStorageServiceProvider.overrideWithValue(storage)],
    child: const IdMarkApp(),
  );
}

/// Navigates to a raw-routes.json route (usually `appRouter.go(route)`).
Future<void> storeGo(WidgetTester tester, String route) async {
  appRouter.go(route);
}

/// raw-routes.json `actions` (taps/long-presses/swipes in device pixels) for
/// [slide]. Empty action: nothing to do. Implement with tester.tap/drag on
/// finders, not coordinates.
Future<void> storeAfterNavigate(
    WidgetTester tester, int slide, String action) async {
  if (action.isNotEmpty) {
    throw UnimplementedError(
        'store harness: slide $slide needs action "$action" - implement '
        'storeAfterNavigate in test/store_screens/app_config.dart');
  }
}
