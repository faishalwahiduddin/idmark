import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idmark/core/constants/app_colors.dart';
import 'package:idmark/core/ui/app_icon.dart';

import '../support/real_fonts.dart';

/// Every SVG name referenced as `AppIcon('name'` in lib/.
Set<String> _usedNames() {
  final re = RegExp(r"AppIcon\(\s*'([a-z0-9_]+)'");
  final names = <String>{};
  for (final f in Directory('lib').listSync(recursive: true)) {
    if (f is File && f.path.endsWith('.dart')) {
      names.addAll(re.allMatches(f.readAsStringSync()).map((m) => m.group(1)!));
    }
  }
  return names;
}

List<String> _allNames() {
  final names = Directory('assets/icons')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.svg'))
      .map((f) => f.uri.pathSegments.last.replaceAll('.svg', ''))
      .toList()
    ..sort();
  return names;
}

void main() {
  test('every AppIcon used in lib/ exists with a 24x24 viewBox', () {
    final used = _usedNames();
    expect(used, isNotEmpty);
    for (final name in used) {
      final file = File('assets/icons/$name.svg');
      expect(file.existsSync(), isTrue, reason: '$name.svg missing');
      final src = file.readAsStringSync();
      expect(src, contains('viewBox="0 0 24 24"'), reason: name);
      expect(src, isNot(contains('<style')), reason: name);
      expect(src, isNot(contains('<text')), reason: name);
      expect(src, isNot(contains('<image')), reason: name);
      expect(src, isNot(contains('transform')), reason: name);
      expect(RegExp(r'<svg[^>]*\s(width|height)=').hasMatch(src), isFalse,
          reason: '$name has width/height on root');
    }
  });

  test('every SVG in assets/icons is used and parses at 24x24', () async {
    final used = _usedNames();
    for (final name in _allNames()) {
      expect(used, contains(name), reason: '$name.svg is bundled but unused');
      final src = File('assets/icons/$name.svg').readAsStringSync();
      final info = await vg.loadPicture(SvgStringLoader(src), null);
      expect(info.size, const Size(24, 24), reason: name);
      info.picture.dispose();
    }
  });

  testWidgets('icon preview sheet (light + dark)', (tester) async {
    await loadRealRoboto();
    final names = _allNames();
    tester.view.physicalSize = const Size(1240, 368);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    Widget cell(String name, Color tint, Color fg) => SizedBox(
          width: 148,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final s in const [24.0, 32.0, 48.0])
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: AppIcon(name, size: s, color: tint),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(name,
                style: TextStyle(fontFamily: 'Roboto', fontSize: 11, color: fg)),
          ]),
        );

    Widget panel(bool dark) {
      final bg = dark ? AppColors.bgDark : AppColors.lightBg;
      final fg = dark ? Colors.white : AppColors.lightTextPrimary;
      final muted = dark ? const Color(0xFF94A3B8) : AppColors.lightTextSecondary;
      final accent = dark ? AppColors.primaryLight : AppColors.primary;
      return Container(
        color: bg,
        padding: const EdgeInsets.all(12),
        child: Wrap(spacing: 4, runSpacing: 12, children: [
          for (final n in names)
            cell(
              n,
              n.startsWith('nav_') && !n.endsWith('_active') ? muted : accent,
              fg,
            ),
        ]),
      );
    }

    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: RepaintBoundary(
          child: Column(children: [panel(false), panel(true)]),
        ),
      ),
    ));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 500)));
    await tester.pumpAndSettle();
    expect(find.byType(SvgPicture), findsNWidgets(names.length * 3 * 2));
    await expectLater(
      find.byType(RepaintBoundary).first,
      matchesGoldenFile('goldens/icon_sheet.png'),
    );
  });
}
