import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Geometry helpers that keep every watermark stamp fully inside the image.
///
/// The date on a stamp is the anti-reuse proof, so a stamp that runs off the
/// edge defeats its purpose. All fit maths lives here so the export renderer
/// and the live preview (which calls the same renderer) cannot drift apart.
class StampFit {
  StampFit._();

  /// Fraction of each image side kept free around a stamp.
  static const double margin = 0.03;

  /// Axis-aligned bounds of a [content] box rotated by [angleDeg].
  static Size rotatedBounds(Size content, double angleDeg) {
    final a = angleDeg * math.pi / 180.0;
    final c = math.cos(a).abs();
    final s = math.sin(a).abs();
    return Size(
      content.width * c + content.height * s,
      content.width * s + content.height * c,
    );
  }

  /// Scale (<= 1) that makes [content], rotated by [angleDeg] around the
  /// centre of [area], fit inside [area] minus [margin] on every side.
  static double scaleToFit(Size content, double angleDeg, Size area) {
    if (content.isEmpty || area.isEmpty) return 1.0;
    final b = rotatedBounds(content, angleDeg);
    final availW = area.width * (1 - 2 * margin);
    final availH = area.height * (1 - 2 * margin);
    return math.min(1.0, math.min(availW / b.width, availH / b.height));
  }

  /// True when [content] rotated by [angleDeg] and centred in [area] stays
  /// inside it (with a 0.5px tolerance for rounding).
  static bool fitsCentered(Size content, double angleDeg, Size area) {
    final b = rotatedBounds(content, angleDeg);
    return b.width <= area.width + 0.5 && b.height <= area.height + 0.5;
  }
}

/// A banded stamp block: main text (one or more lines) plus an optional
/// subtext line, wrapped in a padded rounded band. Drawn centred on the
/// canvas origin, so callers translate + rotate first.
class BandBlock {
  final TextPainter main;
  final TextPainter? sub;
  final double fontSize;

  BandBlock._(this.main, this.sub, this.fontSize);

  double get padX => fontSize * 1.2;
  double get padY => fontSize * 0.5;
  double get _gap => sub == null ? 0 : fontSize * 0.15;

  Size get size {
    final w = math.max(main.width, sub?.width ?? 0);
    final h = main.height + _gap + (sub?.height ?? 0);
    return Size(w + padX * 2, h + padY * 2);
  }

  /// Lays out [text] (and [subtext]) for a band of [fontSize] and returns the
  /// block. [maxLineWidth] wraps long text onto more lines.
  static BandBlock layout({
    required String text,
    required String subtext,
    required Color color,
    required double fontSize,
    double subtextFactor = 0.5,
    double? maxLineWidth,
  }) {
    final main = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: fontSize * 0.06,
          height: 1.15,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxLineWidth ?? double.infinity);

    TextPainter? sub;
    if (subtext.trim().isNotEmpty) {
      sub = TextPainter(
        text: TextSpan(
          text: subtext.trim(),
          style: TextStyle(
            color: color,
            fontSize: fontSize * subtextFactor,
            fontWeight: FontWeight.w600,
            letterSpacing: fontSize * 0.03,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxLineWidth ?? double.infinity);
    }
    return BandBlock._(main, sub, fontSize);
  }

  /// Picks the line layout that keeps the stamp largest, then shrinks the
  /// font until the rotated band fits inside [area]. Candidates: one line,
  /// purpose / date on two lines, and the purpose wrapped onto 2–3 lines.
  static BandBlock fit({
    required String purpose,
    required String? dateText,
    required String subtext,
    required Color color,
    required double fontSize,
    required double angleDeg,
    required Size area,
    double subtextFactor = 0.5,
  }) {
    final oneLine = dateText == null ? purpose : '$purpose ($dateText)';
    final twoLine = dateText == null ? purpose : '$purpose\n$dateText';

    BandBlock build(String t, double f, double? wrap) => layout(
          text: t,
          subtext: subtext,
          color: color,
          fontSize: f,
          subtextFactor: subtextFactor,
          maxLineWidth: wrap,
        );

    // Candidate layouts at the requested size: (text, wrap width factor).
    final probe = build(purpose, fontSize, null);
    final candidates = <(String, double?)>[
      (oneLine, null),
      if (dateText != null) (twoLine, null),
      (twoLine, probe.main.width / 2 * 1.08),
      (twoLine, probe.main.width / 3 * 1.08),
    ];

    var best = build(oneLine, fontSize, null);
    double? bestWrap;
    var bestScale = StampFit.scaleToFit(best.size, angleDeg, area);
    var bestText = oneLine;
    for (final (t, wrap) in candidates.skip(1)) {
      if (bestScale >= 1.0) break;
      final b = build(t, fontSize, wrap);
      final s = StampFit.scaleToFit(b.size, angleDeg, area);
      // Prefer fewer lines unless the wrap keeps the stamp clearly larger.
      if (s > bestScale * 1.05) {
        best = b;
        bestScale = s;
        bestWrap = wrap;
        bestText = t;
      }
    }
    if (bestScale >= 1.0) return best;

    // Shrink: text width is not perfectly linear in font size (glyph
    // metrics, line breaks), so re-check a few times.
    var f = fontSize;
    var scale = bestScale;
    for (var i = 0; i < 6 && scale < 1.0; i++) {
      final next = f * scale * 0.995;
      best = build(
        bestText,
        next,
        bestWrap == null ? null : bestWrap * next / fontSize,
      );
      f = next;
      scale = StampFit.scaleToFit(best.size, angleDeg, area);
    }
    return best;
  }

  /// Paints the band (fill + border) and the text centred on the origin.
  void paint(Canvas canvas, {required Paint fill, required Paint border}) {
    final s = size;
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: s.width,
      height: s.height,
    );
    final rr = RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.3));
    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, border);
    final top = -s.height / 2 + padY;
    main.paint(canvas, Offset(-main.width / 2, top));
    sub?.paint(canvas, Offset(-sub!.width / 2, top + main.height + _gap));
  }
}

/// Lays out [text] with [style] wrapped at [maxWidth], shrinking the font
/// until it is no taller than [maxHeight]. Used by the boxed stamps
/// (corner stamp, seal, QR badge, bottom bar).
TextPainter layoutShrinkToHeight({
  required String text,
  required TextStyle style,
  required double maxWidth,
  required double maxHeight,
  TextAlign align = TextAlign.center,
}) {
  var size = style.fontSize ?? 14;
  late TextPainter p;
  for (var i = 0; i < 8; i++) {
    p = TextPainter(
      text: TextSpan(text: text, style: style.copyWith(fontSize: size)),
      textAlign: align,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: math.max(1, maxWidth));
    if (p.height <= maxHeight) break;
    size *= math.max(0.5, math.sqrt(maxHeight / p.height));
  }
  return p;
}
