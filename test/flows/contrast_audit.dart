import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// WCAG contrast ratio between two opaque colours.
double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  final hi = la > lb ? la : lb, lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

/// Backgrounds actually painted behind [node]: colored boxes/materials up the
/// render tree are alpha-composited until an opaque one (else [base]).
/// A gradient counts as opaque and yields one background per color stop.
List<Color> _backgroundsOf(RenderObject node, Color base) {
  final layers = <Color>[];
  var bases = <Color>[base];
  for (RenderObject? p = node.parent; p != null; p = p.parent) {
    Color? c;
    if (p is RenderDecoratedBox && p.position == DecorationPosition.background) {
      final d = p.decoration;
      final gradient = d is BoxDecoration ? d.gradient : d is ShapeDecoration ? d.gradient : null;
      if (gradient != null) {
        bases = gradient.colors.where((g) => g.a > 0).toList();
        break;
      }
      c = d is BoxDecoration ? d.color : d is ShapeDecoration ? d.color : null;
    } else if (p.runtimeType.toString() == '_RenderColoredBox') {
      // ColoredBox's render object is private; read its colour dynamically.
      c = (p as dynamic).color as Color?;
    } else if (p is RenderPhysicalModel) {
      c = p.color;
    } else if (p is RenderPhysicalShape) {
      c = p.color;
    }
    if (c != null && c.a > 0) {
      if (c.a >= 0.999) {
        bases = [c];
        break;
      }
      layers.add(c);
    }
  }
  return [for (final b in bases) layers.reversed.fold<Color>(b, (bg, c) => Color.alphaBlend(c, bg))];
}

bool _isIconGlyph(String t) => t.runes.every((r) => (r >= 0xE000 && r <= 0xF8FF) || r >= 0xF0000);

/// WCAG "large text": >= 24 px, or >= 18.66 px bold.
bool _isLarge(TextStyle? s) {
  final size = s?.fontSize ?? 14;
  final bold = (s?.fontWeight ?? FontWeight.normal).value >= FontWeight.w700.value;
  return size >= 24 || (bold && size >= 18.66);
}

/// Visible, non-icon text whose contrast against its painted background is
/// below WCAG AA: 4.5:1, or 3:1 for large text.
List<String> lowContrastTexts(WidgetTester tester, {required Color base}) {
  final out = <String>[];
  for (final e in find.byType(RichText).evaluate()) {
    final r = e.renderObject;
    if (r is! RenderParagraph || !r.attached || !r.hasSize || r.size.isEmpty) continue;
    final text = r.text.toPlainText().trim();
    if (text.isEmpty || _isIconGlyph(text)) continue;
    final style = r.text.style;
    final fg = style?.color;
    if (fg == null || fg.a < 0.5) continue; // decorative / disabled text
    final min = _isLarge(style) ? 3.0 : 4.5;
    var worst = double.infinity;
    final chip = e.findAncestorWidgetOfExactType<RawChip>();
    // RawChip paints its own fill (invisible to the render-tree walk).
    final chipTheme = chip == null ? null : Theme.of(e).chipTheme;
    final chipBg = chip == null
        ? null
        : (chip.selected == true
            ? (chip.selectedColor ?? chipTheme?.selectedColor)
            : (chip.backgroundColor ?? chipTheme?.backgroundColor));
    // InputDecorator paints its own fill (invisible to the render-tree walk).
    final field = e.findAncestorWidgetOfExactType<InputDecorator>();
    final fieldFill = field != null && field.decoration.filled == true ? field.decoration.fillColor : null;
    final backgrounds = fieldFill != null && fieldFill.a >= 0.999 ? [fieldFill] : _backgroundsOf(r, base);
    for (final bg in chipBg == null ? backgrounds : [for (final b in backgrounds) Color.alphaBlend(chipBg, b)]) {
      final c = contrastRatio(Color.alphaBlend(fg, bg), bg);
      if (c < worst) worst = c;
    }
    if (worst < min) out.add('"${text.length > 40 ? text.substring(0, 40) : text}" ${worst.toStringAsFixed(2)} < $min');
  }
  return out;
}
