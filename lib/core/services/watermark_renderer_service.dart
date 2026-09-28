import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/watermark_config.dart';

class WatermarkRendererService {
  /// Decodes raw bytes to a [ui.Image]
  static Future<ui.Image> decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  /// Renders the watermark onto the source [ui.Image] and returns PNG bytes
  static Future<Uint8List> renderWatermark({
    required ui.Image sourceImage,
    required WatermarkConfig config,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final width = sourceImage.width.toDouble();
    final height = sourceImage.height.toDouble();

    // 1. Draw base original image at native full resolution
    canvas.drawImage(sourceImage, Offset.zero, Paint());

    // 2. Compute proportional scaling factor relative to standard 1080p
    final scale = math.max(width, height) / 1080.0;
    final baseFontSize = config.fontSize * scale;

    // 3. Render selected pattern
    switch (config.pattern) {
      case WatermarkPattern.diagonalBand:
        _renderDiagonalBand(canvas, width, height, config, baseFontSize);
        break;
      case WatermarkPattern.repeatedGrid:
        _renderRepeatedGrid(canvas, width, height, config, baseFontSize);
        break;
      case WatermarkPattern.bottomBar:
        _renderBottomBar(canvas, width, height, config, baseFontSize);
        break;
      case WatermarkPattern.cornerStamp:
        _renderCornerStamp(canvas, width, height, config, baseFontSize);
        break;
    }

    // 4. Finalize canvas recording and export to PNG
    final picture = recorder.endRecording();
    final renderedImage = await picture.toImage(sourceImage.width, sourceImage.height);
    final byteData = await renderedImage.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Gagal mengonversi gambar ter-watermark ke PNG');
    }
    return byteData.buffer.asUint8List();
  }

  static void _renderDiagonalBand(
    Canvas canvas,
    double width,
    double height,
    WatermarkConfig config,
    double fontSize,
  ) {
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);

    final text = config.renderedText;
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    // Measure text
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

    // Draw background ribbon highlight
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

    // Draw ribbon box with border
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.3)), bandPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.5, fontSize * 0.08);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.3)), borderPaint);

    // Draw primary watermark text
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    // Draw subtext if provided
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
  ) {
    canvas.save();
    final text = config.renderedText;
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

    // Rotate the whole canvas
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
  ) {
    final barHeight = fontSize * 3.0;
    final barRect = Rect.fromLTWH(0, height - barHeight, width, barHeight);

    final barPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: 0.85);
    canvas.drawRect(barRect, barPaint);

    final color = config.colorOption.color;
    final text = config.renderedText;

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

    final text = config.renderedText;
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
}
