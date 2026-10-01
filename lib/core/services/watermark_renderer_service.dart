import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/redaction_item.dart';
import '../models/watermark_config.dart';
import '../utils/app_timezone.dart';

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

    // 3. Compute proportional scaling factor relative to standard 1080p
    final scale = math.max(width, height) / 1080.0;
    final baseFontSize = config.fontSize * scale;

    // 4. Render selected watermark pattern
    switch (config.pattern) {
      case WatermarkPattern.diagonalBand:
        _renderDiagonalBand(canvas, width, height, config, baseFontSize, loc);
        break;
      case WatermarkPattern.repeatedGrid:
        _renderRepeatedGrid(canvas, width, height, config, baseFontSize, loc);
        break;
      case WatermarkPattern.bottomBar:
        _renderBottomBar(canvas, width, height, config, baseFontSize, loc);
        break;
      case WatermarkPattern.cornerStamp:
        _renderCornerStamp(canvas, width, height, config, baseFontSize, loc);
        break;
      case WatermarkPattern.securitySeal:
        _renderSecuritySeal(canvas, width, height, config, baseFontSize, loc);
        break;
      case WatermarkPattern.crossStamp:
        _renderCrossStamp(canvas, width, height, config, baseFontSize, loc);
        break;
      case WatermarkPattern.qrBadge:
        _renderQrBadge(canvas, width, height, config, baseFontSize, loc);
        break;
    }

    // 5. Finalize canvas recording and export to PNG bytes
    final picture = recorder.endRecording();
    final renderedImage = await picture.toImage(sourceImage.width, sourceImage.height);
    final byteData = await renderedImage.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Gagal mengonversi gambar ter-watermark ke PNG');
    }
    return byteData.buffer.asUint8List();
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

  static void _renderDiagonalBand(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);

    final text = config.renderedTextIn(zone);
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final bandPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: (config.opacity * 0.35).clamp(0.05, 0.4))
      ..style = PaintingStyle.fill;

    final padX = fontSize * 1.5;
    final padY = fontSize * 0.6;
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: textPainter.width + (padX * 2),
      height: textPainter.height + (padY * 2),
    );

    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.3)), bandPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.5, fontSize * 0.08);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.3)), borderPaint);

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    if (config.customSubtext.trim().isNotEmpty) {
      final subPainter = TextPainter(
        text: TextSpan(
          text: config.customSubtext.trim(),
          style: TextStyle(
            color: color,
            fontSize: fontSize * 0.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      subPainter.layout();
      subPainter.paint(
        canvas,
        Offset(-subPainter.width / 2, (textPainter.height / 2) + (fontSize * 0.1)),
      );
    }

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
    canvas.save();
    final text = config.renderedTextIn(zone);
    final color = config.colorOption.color.withValues(alpha: (config.opacity * 0.75).clamp(0.1, 0.9));

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.7,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final stepX = textPainter.width + (fontSize * 3);
    final stepY = textPainter.height + (fontSize * 2.5);

    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);
    canvas.translate(-width / 2, -height / 2);

    final diagonal = math.sqrt(width * width + height * height);
    for (double y = -diagonal; y < diagonal * 2; y += stepY) {
      for (double x = -diagonal; x < diagonal * 2; x += stepX) {
        textPainter.paint(canvas, Offset(x, y));
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
    final barHeight = fontSize * 3.0;
    final barRect = Rect.fromLTWH(0, height - barHeight, width, barHeight);

    final barPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: 0.85);
    canvas.drawRect(barRect, barPaint);

    final color = config.colorOption.color;
    final text = config.renderedTextIn(zone);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.85,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: width - (fontSize * 2));
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
    final stampWidth = fontSize * 10;
    final stampHeight = fontSize * 3.5;
    final margin = fontSize * 1.0;

    final stampRect = Rect.fromLTWH(
      width - stampWidth - margin,
      height - stampHeight - margin,
      stampWidth,
      stampHeight,
    );

    final color = config.colorOption.color.withValues(alpha: config.opacity);

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, Radius.circular(fontSize * 0.4)), bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = fontSize * 0.1;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, Radius.circular(fontSize * 0.4)), borderPaint);

    final text = config.renderedTextIn(zone);
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.65,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: stampWidth - (fontSize * 0.8));
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
    double fontSize,
    tz.Location zone,
  ) {
    canvas.save();
    canvas.translate(width / 2, height / 2);

    final sealRadius = fontSize * 4.5;
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    // Outer circle
    final outerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = fontSize * 0.12;
    canvas.drawCircle(Offset.zero, sealRadius, outerPaint);

    // Inner dashed circle
    final innerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = fontSize * 0.06;
    canvas.drawCircle(Offset.zero, sealRadius * 0.85, innerPaint);

    // Background fill
    final bgPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: (config.opacity * 0.35).clamp(0.05, 0.4))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, sealRadius, bgPaint);

    // Seal header text
    final headerPainter = TextPainter(
      text: TextSpan(
        text: '★ RESMI DIVERIFIKASI ★',
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.45,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    headerPainter.layout();
    headerPainter.paint(canvas, Offset(-headerPainter.width / 2, -sealRadius * 0.55));

    // Center Purpose Text
    final purposePainter = TextPainter(
      text: TextSpan(
        text: config.purpose.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.55,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    purposePainter.layout(maxWidth: sealRadius * 1.6);
    purposePainter.paint(
      canvas,
      Offset(-purposePainter.width / 2, -purposePainter.height / 2),
    );

    // Bottom Date text
    if (config.includeDate) {
      final datePainter = TextPainter(
        text: TextSpan(
          text: 'TGL: ${config.dateLabelIn(zone)}',
          style: TextStyle(
            color: color,
            fontSize: fontSize * 0.45,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      datePainter.layout();
      datePainter.paint(canvas, Offset(-datePainter.width / 2, sealRadius * 0.45));
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
    // Render first diagonal ribbon (-25 deg)
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((-25.0 * math.pi) / 180.0);

    final text = config.renderedTextIn(zone);
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.85,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final bandPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: (config.opacity * 0.3).clamp(0.05, 0.35))
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.5, fontSize * 0.08);

    final rect1 = Rect.fromCenter(
      center: Offset.zero,
      width: textPainter.width + (fontSize * 2),
      height: textPainter.height + (fontSize * 0.8),
    );
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, Radius.circular(fontSize * 0.2)), bandPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, Radius.circular(fontSize * 0.2)), borderPaint);
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();

    // Render second crossing diagonal ribbon (+25 deg)
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((25.0 * math.pi) / 180.0);

    final subtext = config.customSubtext.trim().isNotEmpty
        ? config.customSubtext.trim()
        : 'HANYA UNTUK VERIFIKASI IDENTITAS';
    final textPainter2 = TextPainter(
      text: TextSpan(
        text: subtext.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.7,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout();

    final rect2 = Rect.fromCenter(
      center: Offset.zero,
      width: textPainter2.width + (fontSize * 2),
      height: textPainter2.height + (fontSize * 0.8),
    );
    canvas.drawRRect(RRect.fromRectAndRadius(rect2, Radius.circular(fontSize * 0.2)), bandPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect2, Radius.circular(fontSize * 0.2)), borderPaint);
    textPainter2.paint(canvas, Offset(-textPainter2.width / 2, -textPainter2.height / 2));
    canvas.restore();
  }

  static void _renderQrBadge(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
    tz.Location zone,
  ) {
    final badgeWidth = fontSize * 11;
    final badgeHeight = fontSize * 3.8;
    final badgeRect = Rect.fromLTWH(
      width - badgeWidth - (fontSize * 0.8),
      height - badgeHeight - (fontSize * 0.8),
      badgeWidth,
      badgeHeight,
    );

    final color = config.colorOption.color.withValues(alpha: config.opacity);

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(badgeRect, Radius.circular(fontSize * 0.4)), bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = fontSize * 0.1;
    canvas.drawRRect(RRect.fromRectAndRadius(badgeRect, Radius.circular(fontSize * 0.4)), borderPaint);

    // Draw Simulated High-Contrast QR Matrix Icon Box on the left
    final qrBoxSize = badgeHeight - (fontSize * 0.6);
    final qrBoxRect = Rect.fromLTWH(
      badgeRect.left + (fontSize * 0.3),
      badgeRect.top + (fontSize * 0.3),
      qrBoxSize,
      qrBoxSize,
    );
    final qrPaint = Paint()..color = const Color(0xFF0F172A);
    canvas.drawRect(qrBoxRect, qrPaint);

    // Draw QR pattern blocks
    final pWhite = Paint()..color = Colors.white;
    final step = qrBoxSize / 5;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if ((i + j) % 2 == 1 || (i == 0 && j == 0) || (i == 4 && j == 4)) {
          canvas.drawRect(Rect.fromLTWH(qrBoxRect.left + (i * step), qrBoxRect.top + (j * step), step * 0.8, step * 0.8), pWhite);
        }
      }
    }

    // Right text column
    final rightLeft = qrBoxRect.right + (fontSize * 0.4);
    final maxRightWidth = badgeRect.right - rightLeft - (fontSize * 0.3);

    final topPainter = TextPainter(
      text: const TextSpan(
        text: 'IDMARK VERIFIED',
        style: TextStyle(
          color: Color(0xFF0284C7),
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    topPainter.layout();
    topPainter.paint(canvas, Offset(rightLeft, badgeRect.top + (fontSize * 0.3)));

    final purposePainter = TextPainter(
      text: TextSpan(
        text: config.purpose.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.48,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    purposePainter.layout(maxWidth: maxRightWidth);
    purposePainter.paint(canvas, Offset(rightLeft, badgeRect.top + (fontSize * 0.9)));

    if (config.includeDate) {
      final datePainter = TextPainter(
        text: TextSpan(
          text: 'TGL: ${config.dateLabelIn(zone)}',
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      datePainter.layout();
      datePainter.paint(canvas, Offset(rightLeft, badgeRect.top + (fontSize * 2.5)));
    }
  }
}
