import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/redaction_item.dart';
import '../models/watermark_config.dart';
import '../utils/app_timezone.dart';
import 'stamp_layout.dart';

class WatermarkRendererService {
  /// Decodes raw bytes to a [ui.Image]
  static Future<ui.Image> decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  /// Computes SHA-256 integrity checksum of byte data
  static String computeSha256(Uint8List bytes) {
    return sha256.convert(bytes).toString();
  }

  /// Renders both redactions (sensor) and watermark onto the source [ui.Image].
  ///
  /// Dates burned into pixels use [zone] (the selected display zone); when
  /// null the Jakarta fallback applies. Callers pass
  /// `ref.read(timezoneLocationProvider)`.
  static Future<Uint8List> renderWatermark({
    required ui.Image sourceImage,
    required WatermarkConfig config,
    tz.Location? zone,
  }) async {
    final loc = zone ?? AppTimeZone.locationOrFallback(kFallbackZoneName);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final width = sourceImage.width.toDouble();
    final height = sourceImage.height.toDouble();

    // 1. Draw base original image at native full resolution
    canvas.drawImage(sourceImage, Offset.zero, Paint());

    // 2. Render destructive redaction boxes (permanent on-canvas pixel covering)
    _renderRedactions(canvas, width, height, config.redactions);

    // 3–4. Watermark pattern (shared with the live preview).
    paintPattern(canvas, Size(width, height), config, loc);

    // 5. Finalize canvas recording and export to PNG bytes
    final picture = recorder.endRecording();
    final renderedImage = await picture.toImage(sourceImage.width, sourceImage.height);
    final byteData = await renderedImage.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Gagal mengonversi gambar ter-watermark ke PNG');
    }
    return byteData.buffer.asUint8List();
  }

  /// Renders like [renderWatermark] but encodes the image in [format]
  /// (PNG or JPEG). PDF callers wrap the PNG themselves.
  static Future<Uint8List> renderWatermarkAs({
    required ui.Image sourceImage,
    required WatermarkConfig config,
    required ExportFormat format,
    tz.Location? zone,
  }) async {
    final png = await renderWatermark(
      sourceImage: sourceImage,
      config: config,
      zone: zone,
    );
    if (format != ExportFormat.jpeg) return png;
    return encodeJpeg(png, quality: config.jpegQuality);
  }

  /// Re-encodes PNG [pngBytes] as a baseline JPEG at [quality] (1–100).
  /// The output carries no EXIF, like the PNG path.
  static Future<Uint8List> encodeJpeg(Uint8List pngBytes, {required int quality}) {
    return compute(_encodeJpegSync, (pngBytes, quality.clamp(1, 100)));
  }

  static Uint8List _encodeJpegSync((Uint8List, int) args) {
    final decoded = img.decodePng(args.$1);
    if (decoded == null) {
      throw Exception('Gagal mengonversi gambar ter-watermark ke JPEG');
    }
    return img.encodeJpg(decoded, quality: args.$2);
  }

  /// Destructive rendering of redaction boxes onto the canvas
  static void _renderRedactions(
    Canvas canvas,
    double width,
    double height,
    List<RedactionBox> redactions,
  ) {
    for (final box in redactions) {
      final rect = Rect.fromLTWH(
        box.left * width,
        box.top * height,
        box.width * width,
        box.height * height,
      );

      switch (box.type) {
        case RedactionType.blackout:
          final paint = Paint()
            ..color = Colors.black
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, paint);

          // Subtle label
          final textPainter = TextPainter(
            text: TextSpan(
              text: '[DISENSOR: ${box.label.toUpperCase()}]',
              style: TextStyle(
                color: const Color(0xFF94A3B8),
                fontSize: math.max(10.0, rect.height * 0.25).clamp(10.0, 18.0).toDouble(),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(maxWidth: rect.width - 8);
          textPainter.paint(
            canvas,
            Offset(
              rect.left + (rect.width - textPainter.width) / 2,
              rect.top + (rect.height - textPainter.height) / 2,
            ),
          );
          break;

        case RedactionType.mosaic:
          // Simulate pixelation with a dense checkered grid of opaque blocks
          final blockSize = math.max(6.0, rect.height / 5.0);
          final paint1 = Paint()..color = const Color(0xFF1E293B);
          final paint2 = Paint()..color = const Color(0xFF0F172A);
          final paint3 = Paint()..color = const Color(0xFF334155);

          int row = 0;
          for (double y = rect.top; y < rect.bottom; y += blockSize) {
            int col = 0;
            final bh = math.min(blockSize, rect.bottom - y);
            for (double x = rect.left; x < rect.right; x += blockSize) {
              final bw = math.min(blockSize, rect.right - x);
              final blockRect = Rect.fromLTWH(x, y, bw, bh);
              final p = (row + col) % 3 == 0 ? paint1 : ((row + col) % 3 == 1 ? paint2 : paint3);
              canvas.drawRect(blockRect, p);
              col++;
            }
            row++;
          }
          final borderPaint = Paint()
            ..color = const Color(0xFF64748B)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5;
          canvas.drawRect(rect, borderPaint);
          break;

        case RedactionType.blur:
          // Opaque frosted overlay with dark gradient
          final bgPaint = Paint()
            ..color = const Color(0xEE1E293B)
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, bgPaint);

          final borderPaint = Paint()
            ..color = const Color(0xFFEF4444)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0;
          canvas.drawRect(rect, borderPaint);
          break;
      }
    }
  }

  // --- Watermark Pattern Implementations ---

  /// Paints the selected watermark pattern onto [canvas] of [size].
  ///
  /// Used by both the export and the live preview, so what the user sees is
  /// what gets burned in. Every pattern is fitted with [StampFit] so the
  /// purpose and date always stay fully inside the image.
  static void paintPattern(
    Canvas canvas,
    Size size,
    WatermarkConfig config,
    tz.Location zone,
  ) {
    if (size.isEmpty) return;
    final width = size.width;
    final height = size.height;
    // Proportional scale relative to a 1080px reference image.
    final fontSize = config.fontSize * math.max(width, height) / 1080.0;
    switch (config.pattern) {
      case WatermarkPattern.diagonalBand:
        _renderDiagonalBand(canvas, width, height, config, fontSize, zone);
      case WatermarkPattern.repeatedGrid:
        _renderRepeatedGrid(canvas, width, height, config, fontSize, zone);
      case WatermarkPattern.bottomBar:
        _renderBottomBar(canvas, width, height, config, fontSize, zone);
      case WatermarkPattern.cornerStamp:
        _renderCornerStamp(canvas, width, height, config, fontSize, zone);
      case WatermarkPattern.securitySeal:
        _renderSecuritySeal(canvas, width, height, config, fontSize, zone);
      case WatermarkPattern.crossStamp:
        _renderCrossStamp(canvas, width, height, config, fontSize, zone);
      case WatermarkPattern.qrBadge:
        _renderQrBadge(canvas, width, height, config, fontSize, zone);
    }
  }

  /// Purpose as stamped (uppercased when configured).
  static String _purposeText(WatermarkConfig config) =>
      config.isUppercase ? config.purpose.toUpperCase() : config.purpose;

  /// `TGL: dd-MM-yyyy`, or null when the date is switched off.
  static String? _dateText(WatermarkConfig config, tz.Location zone) =>
      config.includeDate ? 'TGL: ${config.dateLabelIn(zone)}' : null;

  static Paint _bandFill(WatermarkConfig config, {double factor = 0.35}) =>
      Paint()
        ..color = (config.colorOption == WatermarkColorOption.white
                ? Colors.black
                : Colors.white)
            .withValues(alpha: (config.opacity * factor).clamp(0.05, 0.4))
        ..style = PaintingStyle.fill;

  static Paint _bandBorder(Color color, double fontSize) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = math.max(1.0, fontSize * 0.08);

  /// Lays out the diagonal band for [config] on a [size] image. Exposed so
  /// tests can assert the rotated band stays inside the image.
  static BandBlock layoutDiagonalBand(
    WatermarkConfig config,
    Size size,
    tz.Location zone,
  ) {
    final fontSize = config.fontSize * math.max(size.width, size.height) / 1080.0;
    return BandBlock.fit(
      purpose: _purposeText(config),
      dateText: _dateText(config, zone),
      subtext: config.customSubtext,
      color: config.colorOption.color.withValues(alpha: config.opacity),
      fontSize: fontSize,
      angleDeg: config.rotationAngle,
      area: size,
    );
  }

  static void _renderDiagonalBand(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    final color = config.colorOption.color.withValues(alpha: config.opacity);
    final block = layoutDiagonalBand(config, Size(width, height), zone);
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);
    block.paint(
      canvas,
      fill: _bandFill(config),
      border: _bandBorder(color, block.fontSize),
    );
    canvas.restore();
  }

  static void _renderRepeatedGrid(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    final color = config.colorOption.color
        .withValues(alpha: (config.opacity * 0.75).clamp(0.1, 0.9));
    final text = config.renderedTextIn(zone);

    TextPainter layoutAt(double f) => TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              color: color,
              fontSize: f,
              fontWeight: FontWeight.w700,
              letterSpacing: f * 0.05,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

    // Fit one tile so at least the centre copy is complete.
    var f = fontSize * 0.7;
    var tp = layoutAt(f);
    for (var i = 0; i < 6; i++) {
      final s = StampFit.scaleToFit(tp.size, config.rotationAngle, Size(width, height));
      if (s >= 1.0) break;
      f *= s * 0.995;
      tp = layoutAt(f);
    }

    final stepX = tp.width + (f * 4);
    final stepY = tp.height + (f * 3.5);

    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);

    // Tiles are anchored so one copy sits exactly on the centre; alternate
    // rows are offset by half a step.
    final diagonal = math.sqrt(width * width + height * height);
    final rows = (diagonal / stepY).ceil() + 1;
    final cols = (diagonal / stepX).ceil() + 1;
    for (var r = -rows; r <= rows; r++) {
      final rowShift = r.isOdd ? stepX / 2 : 0.0;
      for (var c = -cols; c <= cols; c++) {
        tp.paint(
          canvas,
          Offset(c * stepX + rowShift - tp.width / 2, r * stepY - tp.height / 2),
        );
      }
    }
    canvas.restore();
  }

  static void _renderBottomBar(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    final color = config.colorOption.color;
    final pad = fontSize;
    final textPainter = layoutShrinkToHeight(
      text: config.renderedTextIn(zone),
      style: TextStyle(
        color: color,
        fontSize: fontSize * 0.85,
        fontWeight: FontWeight.w800,
        letterSpacing: fontSize * 0.05,
      ),
      maxWidth: width - pad * 2,
      maxHeight: height * 0.4,
    );

    final barHeight = math.max(fontSize * 3.0, textPainter.height + pad);
    final barRect = Rect.fromLTWH(0, height - barHeight, width, barHeight);
    final barPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: 0.85);
    canvas.drawRect(barRect, barPaint);

    textPainter.paint(
      canvas,
      Offset((width - textPainter.width) / 2, height - (barHeight / 2) - (textPainter.height / 2)),
    );
  }

  static void _renderCornerStamp(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    final margin = math.min(fontSize, math.min(width, height) * StampFit.margin * 2);
    final stampWidth = math.min(fontSize * 10, width - margin * 2);
    final inner = fontSize * 0.4;
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    final textPainter = layoutShrinkToHeight(
      text: config.renderedTextIn(zone),
      style: TextStyle(
        color: color,
        fontSize: fontSize * 0.65,
        fontWeight: FontWeight.w800,
      ),
      maxWidth: stampWidth - inner * 2,
      maxHeight: height - margin * 2 - inner * 2,
    );
    final stampHeight = math.min(
      height - margin * 2,
      math.max(fontSize * 3.5, textPainter.height + inner * 2),
    );

    final stampRect = Rect.fromLTWH(
      width - stampWidth - margin,
      height - stampHeight - margin,
      stampWidth,
      stampHeight,
    );

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    final radius = Radius.circular(fontSize * 0.4);
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, radius), bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = fontSize * 0.1;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, radius), borderPaint);

    textPainter.paint(
      canvas,
      Offset(
        stampRect.left + (stampWidth - textPainter.width) / 2,
        stampRect.top + (stampHeight - textPainter.height) / 2,
      ),
    );
  }

  static void _renderSecuritySeal(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double baseFontSize,
    tz.Location zone,
  ) {
    // Shrink the whole seal when the image is smaller than the seal.
    final fit = math.min(
      1.0,
      math.min(width, height) * (1 - 2 * StampFit.margin) / (baseFontSize * 9.0),
    );
    final fontSize = baseFontSize * fit;
    final sealRadius = fontSize * 4.5;
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    canvas.save();
    canvas.translate(width / 2, height / 2);

    canvas.drawCircle(
      Offset.zero,
      sealRadius,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = fontSize * 0.12,
    );
    canvas.drawCircle(
      Offset.zero,
      sealRadius * 0.85,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = fontSize * 0.06,
    );
    canvas.drawCircle(Offset.zero, sealRadius, _bandFill(config));

    final headerPainter = layoutShrinkToHeight(
      text: '★ SALINAN TERBATAS ★',
      style: TextStyle(
        color: color,
        fontSize: fontSize * 0.45,
        fontWeight: FontWeight.w900,
        letterSpacing: fontSize * 0.05,
      ),
      maxWidth: sealRadius * 1.3,
      maxHeight: fontSize * 0.7,
    );
    headerPainter.paint(canvas, Offset(-headerPainter.width / 2, -sealRadius * 0.6));

    final purposePainter = layoutShrinkToHeight(
      text: config.purpose.toUpperCase(),
      style: TextStyle(
        color: color,
        fontSize: fontSize * 0.55,
        fontWeight: FontWeight.w900,
        letterSpacing: fontSize * 0.03,
      ),
      maxWidth: sealRadius * 1.5,
      maxHeight: sealRadius * 0.75,
    );
    purposePainter.paint(
      canvas,
      Offset(-purposePainter.width / 2, -purposePainter.height / 2),
    );

    final dateText = _dateText(config, zone);
    if (dateText != null) {
      final datePainter = layoutShrinkToHeight(
        text: dateText,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.45,
          fontWeight: FontWeight.w700,
        ),
        maxWidth: sealRadius * 1.3,
        maxHeight: fontSize * 0.7,
      );
      datePainter.paint(canvas, Offset(-datePainter.width / 2, sealRadius * 0.42));
    }

    canvas.restore();
  }

  static void _renderCrossStamp(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    final color = config.colorOption.color.withValues(alpha: config.opacity);
    final area = Size(width, height);
    final subtext = config.customSubtext.trim().isNotEmpty
        ? config.customSubtext.trim().toUpperCase()
        : 'HANYA UNTUK VERIFIKASI IDENTITAS';

    void band(double angle, String purpose, String? date, double f) {
      final block = BandBlock.fit(
        purpose: purpose,
        dateText: date,
        subtext: '',
        color: color,
        fontSize: f,
        angleDeg: angle,
        area: area,
      );
      canvas.save();
      canvas.translate(width / 2, height / 2);
      canvas.rotate((angle * math.pi) / 180.0);
      block.paint(
        canvas,
        fill: _bandFill(config, factor: 0.3),
        border: _bandBorder(color, block.fontSize),
      );
      canvas.restore();
    }

    band(-25.0, _purposeText(config), _dateText(config, zone), fontSize * 0.85);
    band(25.0, subtext, null, fontSize * 0.7);
  }

  static void _renderQrBadge(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double baseFontSize,
    tz.Location zone,
  ) {
    // Shrink the badge when it would not fit the image width.
    final fit = math.min(1.0, width * (1 - 2 * StampFit.margin) / (baseFontSize * 11.8));
    final fontSize = baseFontSize * fit;
    final badgeWidth = fontSize * 11;
    final badgeHeight = fontSize * 3.8;
    final badgeRect = Rect.fromLTWH(
      width - badgeWidth - (fontSize * 0.4),
      height - badgeHeight - (fontSize * 0.4),
      badgeWidth,
      badgeHeight,
    );

    final color = config.colorOption.color.withValues(alpha: config.opacity);
    final radius = Radius.circular(fontSize * 0.4);

    canvas.drawRRect(
      RRect.fromRectAndRadius(badgeRect, radius),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.95)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(badgeRect, radius),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = fontSize * 0.1,
    );

    // Simulated high-contrast QR matrix on the left.
    final qrBoxSize = badgeHeight - (fontSize * 0.6);
    final qrBoxRect = Rect.fromLTWH(
      badgeRect.left + (fontSize * 0.3),
      badgeRect.top + (fontSize * 0.3),
      qrBoxSize,
      qrBoxSize,
    );
    canvas.drawRect(qrBoxRect, Paint()..color = _qrInk);
    final pWhite = Paint()..color = Colors.white;
    final step = qrBoxSize / 5;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if ((i + j) % 2 == 1 || (i == 0 && j == 0) || (i == 4 && j == 4)) {
          canvas.drawRect(
            Rect.fromLTWH(qrBoxRect.left + (i * step), qrBoxRect.top + (j * step), step * 0.8, step * 0.8),
            pWhite,
          );
        }
      }
    }

    final rightLeft = qrBoxRect.right + (fontSize * 0.4);
    final maxRightWidth = badgeRect.right - rightLeft - (fontSize * 0.3);
    final top = badgeRect.top + (fontSize * 0.3);

    final topPainter = layoutShrinkToHeight(
      text: 'IDMARK',
      style: TextStyle(
        color: _qrHeader,
        fontSize: fontSize * 0.42,
        fontWeight: FontWeight.w900,
        letterSpacing: fontSize * 0.04,
      ),
      maxWidth: maxRightWidth,
      maxHeight: fontSize * 0.6,
      align: TextAlign.left,
    );
    topPainter.paint(canvas, Offset(rightLeft, top));

    final dateText = _dateText(config, zone);
    final dateBlock = dateText == null ? 0.0 : fontSize * 0.6;
    final purposeTop = top + topPainter.height + fontSize * 0.1;
    final purposePainter = layoutShrinkToHeight(
      text: config.purpose.toUpperCase(),
      style: TextStyle(
        color: color,
        fontSize: fontSize * 0.48,
        fontWeight: FontWeight.w800,
      ),
      maxWidth: maxRightWidth,
      maxHeight: badgeRect.bottom - fontSize * 0.25 - dateBlock - purposeTop,
      align: TextAlign.left,
    );
    purposePainter.paint(canvas, Offset(rightLeft, purposeTop));

    if (dateText != null) {
      final datePainter = layoutShrinkToHeight(
        text: dateText,
        style: TextStyle(
          color: _qrMeta,
          fontSize: fontSize * 0.38,
          fontWeight: FontWeight.w700,
        ),
        maxWidth: maxRightWidth,
        maxHeight: dateBlock,
        align: TextAlign.left,
      );
      datePainter.paint(
        canvas,
        Offset(rightLeft, badgeRect.bottom - fontSize * 0.25 - datePainter.height),
      );
    }
  }

  // Ink colours burned into the QR badge (always on its white card).
  static const Color _qrInk = Color(0xFF0F172A);
  static const Color _qrHeader = Color(0xFF0284C7);
  static const Color _qrMeta = Color(0xFF64748B);
}
