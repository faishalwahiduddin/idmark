import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/app_providers.dart';
import 'core/providers/locale_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/timezone_provider.dart';
import 'core/router/app_router.dart';
import 'core/storage/local_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_timezone.dart';
import 'l10n/app_localizations.dart';
import 'l10n/fallback_framework_delegates.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize offline storage service
  final storageService = await LocalStorageService.init();

  // Timezone database first: every displayed time below is projected through
  // it. Then the device zone, so the "Auto" mode already knows where the
  // phone is before first paint.
  AppTimeZone.initAppTimeZones();
  AppTimeZone.cachedDeviceZone = await AppTimeZone.getDeviceZoneName();

  runApp(
    ProviderScope(
      overrides: [
        localStorageServiceProvider.overrideWithValue(storageService),
      ],
      child: const IdMarkApp(),
    ),
  );
}

class IdMarkApp extends ConsumerStatefulWidget {
  const IdMarkApp({super.key});

  @override
  ConsumerState<IdMarkApp> createState() => _IdMarkAppState();
}

class _IdMarkAppState extends ConsumerState<IdMarkApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // After travel (or a manual clock change) the device zone may differ.
    // Refresh it on return to foreground — but ONLY on Auto: a manual zone
    // is an explicit choice that must survive a device move.
    if (state == AppLifecycleState.resumed &&
        ref.read(timezoneProvider) == null) {
      ref.read(deviceZoneProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'IDMark — Secure ID & Document Watermark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        FallbackMaterialLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: supportedLocales,
      locale: locale,
    );
  }
}
