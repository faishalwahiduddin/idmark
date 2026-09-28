import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/watermark_config.dart';

class WatermarkCanvasPreview extends StatelessWidget {
  final Uint8List? imageBytes;
  final WatermarkConfig config;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;
  final VoidCallback onClear;

  const WatermarkCanvasPreview({
    super.key,
    required this.imageBytes,
    required this.config,
    required this.onPickGallery,
    required this.onPickCamera,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (imageBytes == null) {
      return _buildUploadPrompt(context);
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Live Preview Container with Watermark Overlay Painter
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.memory(
                  imageBytes!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _WatermarkOverlayPainter(config: config),
                  ),
                ),
              ],
            ),
          ),
          // Action Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.bgCard,
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, size: 16, color: AppColors.accent),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Pratinjau Watermark Aktif',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onPickGallery,
                  icon: const Icon(Icons.sync, size: 16),
                  label: const Text('Ganti Foto', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryLight,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                  tooltip: 'Hapus Gambar',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadPrompt(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
              ),
              child: const Icon(
                Icons.document_scanner_outlined,
                size: 36,
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Unggah Foto e-KTP / Identitas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih foto e-KTP, SIM, atau Paspor yang akan diberi watermark tujuan dan tanggal.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF94A3B8),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shield_outlined, size: 14, color: AppColors.accent),
                  SizedBox(width: 6),
                  Text(
                    '100% On-Device • Gambar tidak dikirim ke server',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onPickGallery,
                  icon: const Icon(Icons.photo_library_outlined, size: 18),
                  label: const Text('Buka Galeri'),
                ),
                OutlinedButton.icon(
                  onPressed: onPickCamera,
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: const Text('Ambil Foto'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WatermarkOverlayPainter extends CustomPainter {
  final WatermarkConfig config;

  _WatermarkOverlayPainter({required this.config});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final width = size.width;
    final height = size.height;
    final scale = math.max(width, height) / 450.0;
    final fontSize = (config.fontSize * 0.55) * scale;
    final text = config.renderedText;
    final color = config.colorOption.color.withValues(alpha: config.opacity);

    switch (config.pattern) {
      case WatermarkPattern.diagonalBand:
        _drawDiagonal(canvas, width, height, text, color, fontSize);
        break;
      case WatermarkPattern.repeatedGrid:
        _drawGrid(canvas, width, height, text, color, fontSize);
        break;
      case WatermarkPattern.bottomBar:
        _drawBottomBar(canvas, width, height, text, color, fontSize);
        break;
      case WatermarkPattern.cornerStamp:
        _drawCornerStamp(canvas, width, height, text, color, fontSize);
        break;
    }
  }

  void _drawDiagonal(
    Canvas canvas,
    double width,
    double height,
    String text,
    Color color,
    double fontSize,
  ) {
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);

    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();

    final padX = fontSize * 1.2;
    final padY = fontSize * 0.4;
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: painter.width + (padX * 2),
      height: painter.height + (padY * 2),
    );

    final bandPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: (config.opacity * 0.4).clamp(0.05, 0.4))
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.25)), bandPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.0, fontSize * 0.08);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(fontSize * 0.25)), borderPaint);

    painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));

    if (config.customSubtext.trim().isNotEmpty) {
      final subPainter = TextPainter(
        text: TextSpan(
          text: config.customSubtext.trim(),
          style: TextStyle(
            color: color,
            fontSize: fontSize * 0.55,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      subPainter.layout();
      subPainter.paint(canvas, Offset(-subPainter.width / 2, (painter.height / 2) + 2));
    }

    canvas.restore();
  }

  void _drawGrid(
    Canvas canvas,
    double width,
    double height,
    String text,
    Color color,
    double fontSize,
  ) {
    canvas.save();
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.65,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();

    canvas.translate(width / 2, height / 2);
    canvas.rotate((config.rotationAngle * math.pi) / 180.0);
    canvas.translate(-width / 2, -height / 2);

    final stepX = painter.width + 40;
    final stepY = painter.height + 30;
    final diagonal = math.sqrt(width * width + height * height);

    for (double y = -diagonal; y < diagonal * 2; y += stepY) {
      for (double x = -diagonal; x < diagonal * 2; x += stepX) {
        painter.paint(canvas, Offset(x, y));
      }
    }
    canvas.restore();
  }

  void _drawBottomBar(
    Canvas canvas,
    double width,
    double height,
    String text,
    Color color,
    double fontSize,
  ) {
    final barHeight = fontSize * 2.8;
    final barRect = Rect.fromLTWH(0, height - barHeight, width, barHeight);

    final barPaint = Paint()
      ..color = (config.colorOption == WatermarkColorOption.white ? Colors.black : Colors.white)
          .withValues(alpha: 0.85);
    canvas.drawRect(barRect, barPaint);

    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: config.colorOption.color,
          fontSize: fontSize * 0.8,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout(maxWidth: width - 20);
    painter.paint(canvas, Offset((width - painter.width) / 2, height - (barHeight / 2) - (painter.height / 2)));
  }

  void _drawCornerStamp(
    Canvas canvas,
    double width,
    double height,
    String text,
    Color color,
    double fontSize,
  ) {
    final stampWidth = fontSize * 9;
    final stampHeight = fontSize * 3.2;
    final margin = 12.0;

    final stampRect = Rect.fromLTWH(
      width - stampWidth - margin,
      height - stampHeight - margin,
      stampWidth,
      stampHeight,
    );

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, Radius.circular(6)), bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, Radius.circular(6)), borderPaint);

    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize * 0.6,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout(maxWidth: stampWidth - 10);
    painter.paint(
      canvas,
      Offset(
        stampRect.left + (stampWidth - painter.width) / 2,
        stampRect.top + (stampHeight - painter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _WatermarkOverlayPainter oldDelegate) {
    return oldDelegate.config != config;
  }
}
