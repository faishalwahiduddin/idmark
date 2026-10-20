import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/ui/press_scale.dart';
import 'package:idmark/core/ui/tap_target.dart';

void main() {
  // TapTarget(child: PressScale(...)) is the pattern for icon actions across the
  // app (settings rows, share/copy buttons). PressScale must not steal the tap.
  testWidgets('FLOW-SET-01-T06 tombol bersarang TapTarget + PressScale tetap memicu aksi saat diketuk', (tester) async {
    var taps = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: TapTarget(
            semanticLabel: 'Aksi uji',
            haptic: false,
            onTap: () => taps++,
            child: const PressScale(child: Icon(Icons.share_outlined)),
          ),
        ),
      ),
    ));
    await tester.tap(find.byIcon(Icons.share_outlined));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });
}
