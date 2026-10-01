import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/redaction_item.dart';
import '../../../../core/models/watermark_config.dart';
import '../../../../core/utils/app_timezone.dart';
import '../../../../l10n/app_localizations.dart';

class WatermarkCanvasPreview extends StatefulWidget {
  final Uint8List? imageBytes;
  final WatermarkConfig config;
  final tz.Location? zone;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;
  final VoidCallback onClear;
  final Function(RedactionPresetTarget)? onAddQuickRedaction;

  const WatermarkCanvasPreview({
    super.key,
    required this.imageBytes,
    required this.config,
    this.zone,
    required this.onPickGallery,
    required this.onPickCamera,
    required this.onClear,
    this.onAddQuickRedaction,
  });

  @override
  State<WatermarkCanvasPreview> createState() => _WatermarkCanvasPreviewState();
}

class _WatermarkCanvasPreviewState extends State<WatermarkCanvasPreview> {
  bool _isComparingOriginal = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (widget.imageBytes == null) {
      return _buildUploadPrompt(context);
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Live Preview Container with Watermark Overlay Painter
          Container(
            constraints: const BoxConstraints(maxHeight: 420),
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.memory(
                  widget.imageBytes!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
                if (!_isComparingOriginal)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _WatermarkOverlayPainter(
                        config: widget.config,
                        zone: widget.zone,
                      ),
                    ),
                  ),

                // Top Floating Privacy Meter Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.bgSurface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.config.privacyScore >= 80 ? AppColors.accent : AppColors.warning,
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.config.privacyScore >= 80 ? Icons.security : Icons.shield_outlined,
                          size: 14,
                          color: widget.config.privacyScore >= 80 ? AppColors.accent : AppColors.warning,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n?.protectionGrade(widget.config.privacyGrade, widget.config.privacyScore) ??
                              'Proteksi ${widget.config.privacyGrade} (${widget.config.privacyScore}%)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: widget.config.privacyScore >= 80 ? AppColors.accent : AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top Left Hold-To-Compare Button
                Positioned(
                  top: 12,
                  left: 12,
                  child: GestureDetector(
                    onTapDown: (_) => setState(() => _isComparingOriginal = true),
                    onTapUp: (_) => setState(() => _isComparingOriginal = false),
                    onTapCancel: () => setState(() => _isComparingOriginal = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _isComparingOriginal
                            ? AppColors.primary
                            : AppColors.bgSurface.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isComparingOriginal ? Icons.visibility : Icons.visibility_outlined,
                            size: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _isComparingOriginal
                                ? (l10n?.viewingOriginal ?? 'Melihat Asli')
                                : (l10n?.holdToCompare ?? 'Tahan: Bandingkan'),
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quick Redaction Bar (If callback provided)
          if (widget.onAddQuickRedaction != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: AppColors.bgDark,
              child: Row(
                children: [
                  const Icon(Icons.remove_red_eye_outlined, size: 14, color: AppColors.primaryLight),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.quickSensorLabel ?? 'Sensor Cepat:',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildQuickSensorChip('NIK', RedactionPresetTarget.nik),
                          const SizedBox(width: 6),
                          _buildQuickSensorChip('Tanda Tangan', RedactionPresetTarget.signature),
                          const SizedBox(width: 6),
                          _buildQuickSensorChip('Alamat', RedactionPresetTarget.address),
                          const SizedBox(width: 6),
                          _buildQuickSensorChip('Tgl Lahir', RedactionPresetTarget.birthPlace),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Action Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppColors.bgCard,
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, size: 16, color: AppColors.accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.config.redactions.isNotEmpty
                        ? (l10n?.activeWatermarkWithCount(widget.config.redactions.length) ??
                            'Watermark Aktif (${widget.config.redactions.length} sensor)')
                        : (l10n?.activeWatermarkPreview ?? 'Pratinjau Watermark Aktif'),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: widget.onPickGallery,
                  icon: const Icon(Icons.sync, size: 16),
                  label: Text(l10n?.changePhoto ?? 'Ganti Foto', style: const TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryLight,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                IconButton(
                  onPressed: widget.onClear,
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                  tooltip: l10n?.deleteImage ?? 'Hapus Gambar',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSensorChip(String label, RedactionPresetTarget target) {
    final isAlreadyAdded = widget.config.redactions.any((r) => r.label.contains(label));
    return InkWell(
      onTap: () => widget.onAddQuickRedaction?.call(target),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isAlreadyAdded
              ? AppColors.primary.withValues(alpha: 0.25)
              : AppColors.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isAlreadyAdded ? AppColors.primaryLight : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isAlreadyAdded ? Icons.check : Icons.add,
              size: 11,
              color: isAlreadyAdded ? AppColors.primaryLight : const Color(0xFFCBD5E1),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isAlreadyAdded ? AppColors.primaryLight : const Color(0xFFCBD5E1),
                fontWeight: isAlreadyAdded ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadPrompt(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
            Text(
              l10n?.uploadIdPhoto ?? 'Unggah Foto e-KTP / Identitas',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.uploadIdPhotoDesc ?? 'Pilih foto e-KTP, SIM, atau Paspor untuk menambahkan stempel tujuan, tanggal, dan sensor data vital.',
              textAlign: TextAlign.center,
              style: const TextStyle(
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shield_outlined, size: 14, color: AppColors.accent),
                  const SizedBox(width: 6),
                  Text(
                    l10n?.onDeviceBadge ?? '100% On-Device • Gambar tidak pernah dikirim ke server',
                    style: const TextStyle(
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
                  onPressed: widget.onPickGallery,
                  icon: const Icon(Icons.photo_library_outlined, size: 18),
                  label: Text(l10n?.openGallery ?? 'Buka Galeri'),
                ),
                OutlinedButton.icon(
                  onPressed: widget.onPickCamera,
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: Text(l10n?.takePhoto ?? 'Ambil Foto'),
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
  final tz.Location? zone;

  _WatermarkOverlayPainter({required this.config, this.zone});

  /// Effective display zone: explicit zone, else Jakarta fallback.
  tz.Location get _loc =>
      zone ?? AppTimeZone.locationOrFallback(kFallbackZoneName);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final width = size.width;
    final height = size.height;

    // 1. Draw Redaction Overlays
    for (final box in config.redactions) {
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
          final borderPaint = Paint()
            ..color = Colors.white70
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0;
          canvas.drawRect(rect, borderPaint);

          final textPainter = TextPainter(
            text: TextSpan(
              text: '[DISENSOR: ${box.label.toUpperCase()}]',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(maxWidth: rect.width - 4);
          textPainter.paint(
            canvas,
            Offset(
              rect.left + (rect.width - textPainter.width) / 2,
              rect.top + (rect.height - textPainter.height) / 2,
            ),
          );
          break;

        case RedactionType.mosaic:
          final blockSize = math.max(4.0, rect.height / 4.0);
          final p1 = Paint()..color = const Color(0xFF1E293B);
          final p2 = Paint()..color = const Color(0xFF0F172A);
          int row = 0;
          for (double y = rect.top; y < rect.bottom; y += blockSize) {
            int col = 0;
            final bh = math.min(blockSize, rect.bottom - y);
            for (double x = rect.left; x < rect.right; x += blockSize) {
              final bw = math.min(blockSize, rect.right - x);
              canvas.drawRect(Rect.fromLTWH(x, y, bw, bh), (row + col) % 2 == 0 ? p1 : p2);
              col++;
            }
            row++;
          }
          final borderPaint = Paint()
            ..color = const Color(0xFF64748B)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0;
          canvas.drawRect(rect, borderPaint);
          break;

        case RedactionType.blur:
          final paint = Paint()
            ..color = const Color(0xEE1E293B)
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, paint);
          final borderPaint = Paint()
            ..color = const Color(0xFFEF4444)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5;
          canvas.drawRect(rect, borderPaint);
          break;
      }
    }

    // 2. Draw Watermark Pattern
    final scale = math.max(width, height) / 450.0;
    final fontSize = (config.fontSize * 0.55) * scale;
    final text = config.renderedTextIn(_loc);
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
      case WatermarkPattern.securitySeal:
        _drawSecuritySeal(canvas, width, height, color, fontSize);
        break;
      case WatermarkPattern.crossStamp:
        _drawCrossStamp(canvas, width, height, text, color, fontSize);
        break;
      case WatermarkPattern.qrBadge:
        _drawQrBadge(canvas, width, height, color, fontSize);
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
    const margin = 12.0;

    final stampRect = Rect.fromLTWH(
      width - stampWidth - margin,
      height - stampHeight - margin,
      stampWidth,
      stampHeight,
    );

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, const Radius.circular(6)), bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(RRect.fromRectAndRadius(stampRect, const Radius.circular(6)), borderPaint);

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

  void _drawSecuritySeal(
    Canvas canvas,
    double width,
    double height,
    Color color,
    double fontSize,
  ) {
    canvas.save();
    canvas.translate(width / 2, height / 2);

    final radius = fontSize * 4.0;
    final outerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(Offset.zero, radius, outerPaint);

    final innerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(Offset.zero, radius * 0.85, innerPaint);

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: (config.opacity * 0.35).clamp(0.05, 0.35))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, radius, bgPaint);

    final headerPainter = TextPainter(
      text: TextSpan(
        text: '★ RESMI DIVERIFIKASI ★',
        style: TextStyle(color: color, fontSize: fontSize * 0.45, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    headerPainter.layout();
    headerPainter.paint(canvas, Offset(-headerPainter.width / 2, -radius * 0.55));

    final textPainter = TextPainter(
      text: TextSpan(
        text: config.purpose.toUpperCase(),
        style: TextStyle(color: color, fontSize: fontSize * 0.55, fontWeight: FontWeight.w900),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(maxWidth: radius * 1.5);
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

    if (config.includeDate) {
      final datePainter = TextPainter(
        text: TextSpan(
          text: 'TGL: ${config.dateLabelIn(_loc)}',
          style: TextStyle(color: color, fontSize: fontSize * 0.45, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      );
      datePainter.layout();
      datePainter.paint(canvas, Offset(-datePainter.width / 2, radius * 0.45));
    }

    canvas.restore();
  }

  void _drawCrossStamp(
    Canvas canvas,
    double width,
    double height,
    String text,
    Color color,
    double fontSize,
  ) {
    // 1st diagonal band (-25 deg)
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((-25.0 * math.pi) / 180.0);

    final painter1 = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize * 0.8, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    );
    painter1.layout();

    final rect1 = Rect.fromCenter(
      center: Offset.zero,
      width: painter1.width + 30,
      height: painter1.height + 14,
    );
    final bg1 = Paint()
      ..color = Colors.white.withValues(alpha: (config.opacity * 0.35).clamp(0.05, 0.35))
      ..style = PaintingStyle.fill;
    final stroke1 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, const Radius.circular(4)), bg1);
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, const Radius.circular(4)), stroke1);
    painter1.paint(canvas, Offset(-painter1.width / 2, -painter1.height / 2));
    canvas.restore();

    // 2nd diagonal band (+25 deg)
    canvas.save();
    canvas.translate(width / 2, height / 2);
    canvas.rotate((25.0 * math.pi) / 180.0);

    final subtext = config.customSubtext.trim().isNotEmpty
        ? config.customSubtext.trim()
        : 'VERIFIKASI IDENTITAS';
    final painter2 = TextPainter(
      text: TextSpan(
        text: subtext.toUpperCase(),
        style: TextStyle(color: color, fontSize: fontSize * 0.7, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    );
    painter2.layout();

    final rect2 = Rect.fromCenter(
      center: Offset.zero,
      width: painter2.width + 30,
      height: painter2.height + 14,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(rect2, const Radius.circular(4)), bg1);
    canvas.drawRRect(RRect.fromRectAndRadius(rect2, const Radius.circular(4)), stroke1);
    painter2.paint(canvas, Offset(-painter2.width / 2, -painter2.height / 2));
    canvas.restore();
  }

  void _drawQrBadge(
    Canvas canvas,
    double width,
    double height,
    Color color,
    double fontSize,
  ) {
    final badgeWidth = fontSize * 9.5;
    final badgeHeight = fontSize * 3.4;
    const margin = 12.0;
    final badgeRect = Rect.fromLTWH(
      width - badgeWidth - margin,
      height - badgeHeight - margin,
      badgeWidth,
      badgeHeight,
    );

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(badgeRect, const Radius.circular(6)), bgPaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(RRect.fromRectAndRadius(badgeRect, const Radius.circular(6)), borderPaint);

    // QR Box
    final qrBoxSize = badgeHeight - 12;
    final qrBoxRect = Rect.fromLTWH(badgeRect.left + 6, badgeRect.top + 6, qrBoxSize, qrBoxSize);
    canvas.drawRect(qrBoxRect, Paint()..color = const Color(0xFF0F172A));

    // Simulated QR dots
    final step = qrBoxSize / 4;
    final pWhite = Paint()..color = Colors.white;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if ((i + j) % 2 == 1) {
          canvas.drawRect(Rect.fromLTWH(qrBoxRect.left + (i * step), qrBoxRect.top + (j * step), step * 0.8, step * 0.8), pWhite);
        }
      }
    }

    final rightX = qrBoxRect.right + 8;
    final titlePainter = TextPainter(
      text: const TextSpan(
        text: 'IDMARK VERIFIED',
        style: TextStyle(color: Color(0xFF0284C7), fontSize: 9, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout();
    titlePainter.paint(canvas, Offset(rightX, badgeRect.top + 6));

    final purposePainter = TextPainter(
      text: TextSpan(
        text: config.purpose.toUpperCase(),
        style: TextStyle(color: color, fontSize: fontSize * 0.45, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    );
    purposePainter.layout(maxWidth: badgeRect.right - rightX - 6);
    purposePainter.paint(canvas, Offset(rightX, badgeRect.top + 18));
  }

  @override
  bool shouldRepaint(covariant _WatermarkOverlayPainter oldDelegate) {
    return oldDelegate.config != config || oldDelegate.zone != zone;
  }
}
