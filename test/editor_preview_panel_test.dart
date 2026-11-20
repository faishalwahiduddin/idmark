import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/models/watermark_config.dart';
import 'package:idmark/features/editor/widgets/watermark_canvas_preview.dart';
import 'package:idmark/features/editor/widgets/watermark_control_panel.dart';
import 'package:idmark/l10n/app_localizations.dart';
import 'package:idmark/l10n/fallback_framework_delegates.dart';

// 1x1 transparent PNG.
final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
);

Widget _app(Widget child) => MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        FallbackMaterialLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('id'),
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );

void _phone(WidgetTester tester) {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

void main() {
  _pageScrollTests();
  testWidgets('preview: pinch viewer present and hold-to-compare still toggles', (tester) async {
    _phone(tester);
    await tester.pumpWidget(_app(WatermarkCanvasPreview(
      imageBytes: _png,
      config: WatermarkConfig.defaultConfig(),
      onPickGallery: () {},
      onPickCamera: () {},
      onClear: () {},
    )));
    await tester.runAsync(() => precacheImage(MemoryImage(_png), tester.element(find.byType(WatermarkCanvasPreview))));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsOneWidget);
    final l10n = AppLocalizations.of(tester.element(find.byType(WatermarkCanvasPreview)))!;
    expect(find.text(l10n.holdToCompare), findsOneWidget);
    final g = await tester.startGesture(tester.getCenter(find.text(l10n.holdToCompare)));
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text(l10n.viewingOriginal), findsOneWidget);
    await g.up();
    await tester.pump();
    expect(find.text(l10n.holdToCompare), findsOneWidget);
  });

  testWidgets('panel: header toggle collapses and expands at phone size, target >= 44', (tester) async {
    _phone(tester);
    await tester.pumpWidget(_app(WatermarkControlPanel(
      config: WatermarkConfig.defaultConfig(),
      onPurposeChanged: (_) {},
      onDateChanged: (_) {},
      onSubtextChanged: (_) {},
      onPatternChanged: (_) {},
      onColorChanged: (_) {},
      onOpacityChanged: (_) {},
      onFontSizeChanged: (_) {},
      onRotationChanged: (_) {},
      onIncludeDateChanged: (_) {},
      onAddRedaction: (_) {},
      onRemoveRedaction: (_) {},
      onUpdateRedaction: (_) {},
      onStripMetadataChanged: (_) {},
      onExportFormatChanged: (_) {},
      onJpegQualityChanged: (_) {},
    )));
    expect(find.byType(TabBar), findsOneWidget);
    final toggle = find.byIcon(Icons.keyboard_arrow_up);
    expect(tester.getSize(find.ancestor(of: toggle, matching: find.byType(SizedBox)).first).shortestSide, greaterThanOrEqualTo(44));
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(find.byType(TabBar), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pumpAndSettle();
    expect(find.byType(TabBar), findsOneWidget);
  });
}

void _pageScrollTests() {
  testWidgets('preview: vertical drag on the unzoomed preview scrolls the page', (tester) async {
    _phone(tester);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        FallbackMaterialLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('id'),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            WatermarkCanvasPreview(
              imageBytes: _png,
              config: WatermarkConfig.defaultConfig(),
              onPickGallery: () {},
              onPickCamera: () {},
              onClear: () {},
            ),
            const SizedBox(height: 2000),
          ]),
        ),
      ),
    ));
    await tester.runAsync(() => precacheImage(MemoryImage(_png), tester.element(find.byType(WatermarkCanvasPreview))));
    await tester.pumpAndSettle();
    final viewer = find.byType(InteractiveViewer);
    final g = await tester.startGesture(tester.getCenter(viewer));
    for (var i = 0; i < 20; i++) {
      await g.moveBy(const Offset(0, -10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await g.up();
    await tester.pumpAndSettle();
    final pos = tester.state<ScrollableState>(find.byType(Scrollable).first).position;
    expect(pos.pixels, greaterThan(100), reason: 'page should scroll when the drag starts on the unzoomed preview');
  });
}
