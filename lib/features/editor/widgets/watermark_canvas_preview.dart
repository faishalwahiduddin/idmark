import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/ui/app_scroll.dart';
import '../../../../core/ui/press_scale.dart';
import '../../../../core/models/redaction_item.dart';
import '../../../../core/models/watermark_config.dart';
import '../../../../core/services/watermark_renderer_service.dart';
import '../../../../core/utils/app_timezone.dart';
import '../../../../core/utils/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_numeric.dart';

/// Parts of [WatermarkCanvasPreview]: the image stage, the toolbar below it
/// (quick redaction + change/delete photo), or both.
enum PreviewSection { all, stage, toolbar }

class WatermarkCanvasPreview extends StatefulWidget {
  final Uint8List? imageBytes;
  final WatermarkConfig config;
  final tz.Location? zone;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;
  final VoidCallback onClear;
  final Function(RedactionPresetTarget)? onAddQuickRedaction;

  /// Enables drag-to-move / drag-corner-to-resize of redaction boxes.
  final ValueChanged<RedactionBox>? onUpdateRedaction;

  /// Which part to build; the editor pins the stage and scrolls the toolbar.
  final PreviewSection section;

  /// Upper bound of the image stage height.
  final double maxPreviewHeight;

  const WatermarkCanvasPreview({
    super.key,
    required this.imageBytes,
    required this.config,
    this.zone,
    required this.onPickGallery,
    required this.onPickCamera,
    required this.onClear,
    this.onAddQuickRedaction,
    this.onUpdateRedaction,
    this.section = PreviewSection.all,
    this.maxPreviewHeight = 420,
  });

  @override
  State<WatermarkCanvasPreview> createState() => _WatermarkCanvasPreviewState();
}

class _WatermarkCanvasPreviewState extends State<WatermarkCanvasPreview> {
  bool _isComparingOriginal = false;
  final TransformationController _zoom = TransformationController();
  bool _zoomed = false;

  /// Width / height of the loaded image, once known.
  double? _aspect;
  ImageStream? _stream;
  ImageStreamListener? _listener;

  /// Redaction box being dragged (not yet committed to the config).
  RedactionBox? _liveBox;

  @override
  void initState() {
    super.initState();
    _zoom.addListener(_onZoomChanged);
    _resolveAspect();
  }

  void _resolveAspect() {
    _detachStream();
    final bytes = widget.imageBytes;
    if (bytes == null) {
      _aspect = null;
      return;
    }
    final stream = MemoryImage(bytes).resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((info, _) {
      final w = info.image.width, h = info.image.height;
      if (!mounted || w == 0 || h == 0) return;
      setState(() => _aspect = w / h);
    }, onError: (_, _) {});
    stream.addListener(listener);
    _stream = stream;
    _listener = listener;
  }

  void _detachStream() {
    final l = _listener;
    if (l != null) _stream?.removeListener(l);
    _stream = null;
    _listener = null;
  }

  void _onZoomChanged() {
    final z = _zoom.value.getMaxScaleOnAxis() > 1.001;
    if (z != _zoomed) setState(() => _zoomed = z);
  }

  @override
  void didUpdateWidget(covariant WatermarkCanvasPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.imageBytes, widget.imageBytes)) {
      _zoom.value = Matrix4.identity();
      _aspect = null;
      _liveBox = null;
      _resolveAspect();
    }
  }

  @override
  void dispose() {
    _detachStream();
    _zoom.removeListener(_onZoomChanged);
    _zoom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageBytes == null) {
      return widget.section == PreviewSection.toolbar
          ? const SizedBox.shrink()
          : _buildUploadPrompt(context);
    }
    final children = <Widget>[
      if (widget.section != PreviewSection.toolbar) _buildStage(context),
      if (widget.section != PreviewSection.stage) ..._buildToolbar(context),
    ];
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: widget.section == PreviewSection.all ? null : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  /// Config as painted right now: the box being dragged uses its live
  /// position until the drag ends and is committed.
  WatermarkConfig get _paintedConfig {
    final live = _liveBox;
    if (live == null) return widget.config;
    return widget.config.copyWith(
      redactions: [
        for (final b in widget.config.redactions) b.id == live.id ? live : b,
      ],
    );
  }

  Widget _buildImageLayer() {
    final image = Image.memory(
      widget.imageBytes!,
      fit: _aspect == null ? BoxFit.contain : BoxFit.fill,
      width: double.infinity,
      gaplessPlayback: true,
    );
    final overlay = _isComparingOriginal
        ? const SizedBox.shrink()
        : CustomPaint(
            painter: _WatermarkOverlayPainter(
              config: _paintedConfig,
              zone: widget.zone,
            ),
          );
    if (_aspect == null) {
      return Stack(
        alignment: Alignment.center,
        children: [image, Positioned.fill(child: overlay)],
      );
    }
    // Known aspect: the painted area is exactly the image, so redaction
    // coordinates on screen match the exported pixels.
    return AspectRatio(
      aspectRatio: _aspect!,
      child: LayoutBuilder(
        builder: (context, box) {
          final size = Size(box.maxWidth, box.maxHeight);
          return Stack(
            fit: StackFit.expand,
            children: [
              image,
              overlay,
              if (!_isComparingOriginal && widget.onUpdateRedaction != null)
                for (final r in _paintedConfig.redactions) ..._redactionHandles(r, size),
            ],
          );
        },
      ),
    );
  }

  /// Drag target over a redaction box (move) plus a corner knob (resize).
  List<Widget> _redactionHandles(RedactionBox box, Size size) {
    final l10n = AppLocalizations.of(context);
    final rect = Rect.fromLTWH(
      box.left * size.width,
      box.top * size.height,
      box.width * size.width,
      box.height * size.height,
    );
    final active = _liveBox?.id == box.id;
    const knob = 44.0;
    return [
      Positioned.fromRect(
        rect: rect,
        child: Semantics(
          label: l10n?.redactionBoxSemantics(localizedRedactionLabel(box.label, l10n)) ??
              'Kotak sensor ${box.label}. Seret untuk memindahkan.',
          child: GestureDetector(
            key: ValueKey('redaction-drag-${box.id}'),
            behavior: HitTestBehavior.opaque,
            onPanStart: (_) => setState(() => _liveBox = box),
            onPanUpdate: (d) => _moveLive(box, d.delta, size),
            onPanEnd: (_) => _commitLive(),
            onPanCancel: _commitLive,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: active ? AppColors.primaryLight : AppColors.slate300,
                  width: active ? 2 : 1,
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: rect.right - knob / 2,
        top: rect.bottom - knob / 2,
        width: knob,
        height: knob,
        child: Semantics(
          label: l10n?.resizeRedaction ?? 'Ubah ukuran',
          child: GestureDetector(
            key: ValueKey('redaction-resize-${box.id}'),
            behavior: HitTestBehavior.opaque,
            onPanStart: (_) => setState(() => _liveBox = box),
            onPanUpdate: (d) => _resizeLive(box, d.delta, size),
            onPanEnd: (_) => _commitLive(),
            onPanCancel: _commitLive,
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bgDark, width: 2),
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  void _moveLive(RedactionBox base, Offset delta, Size size) {
    final cur = _liveBox ?? base;
    setState(() {
      _liveBox = cur.copyWith(
        left: cur.left + delta.dx / size.width,
        top: cur.top + delta.dy / size.height,
      );
    });
  }

  void _resizeLive(RedactionBox base, Offset delta, Size size) {
    final cur = _liveBox ?? base;
    setState(() {
      _liveBox = cur.copyWith(
        width: (cur.width + delta.dx / size.width).clamp(0.05, 1.0 - cur.left),
        height: (cur.height + delta.dy / size.height).clamp(0.03, 1.0 - cur.top),
      );
    });
  }

  void _commitLive() {
    final live = _liveBox;
    if (live == null) return;
    setState(() => _liveBox = null);
    widget.onUpdateRedaction?.call(live);
  }

  Widget _buildStage(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Live preview with the watermark overlay painter.
    return Container(
      constraints: BoxConstraints(maxHeight: widget.maxPreviewHeight),
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            transformationController: _zoom,
            minScale: 1,
            maxScale: 4,
            panEnabled: _zoomed && _liveBox == null,
            child: _buildImageLayer(),
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
                      fontFeatures: AppNumeric.tabularFeatures,
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
    );
  }

  List<Widget> _buildToolbar(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
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
                    l10n?.quickSensorShort ?? 'Sensor Cepat:',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.slate400),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: AppScroll.physics,
                      child: Row(
                        children: [
                          _buildQuickSensorChip(
                            l10n?.targetNik ?? 'NIK',
                            RedactionPresetTarget.nik,
                          ),
                          const SizedBox(width: 6),
                          _buildQuickSensorChip(
                            l10n?.targetSignature ?? 'Tanda Tangan',
                            RedactionPresetTarget.signature,
                          ),
                          const SizedBox(width: 6),
                          _buildQuickSensorChip(
                            l10n?.targetAddress ?? 'Alamat',
                            RedactionPresetTarget.address,
                          ),
                          const SizedBox(width: 6),
                          _buildQuickSensorChip(
                            l10n?.targetBirthPlace ?? 'Tgl Lahir',
                            RedactionPresetTarget.birthPlace,
                          ),
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
                    minimumSize: const Size(0, 44),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                // §A11Y: default IconButton is 48dp; compact dropped it to 40.
                IconButton(
                  onPressed: widget.onClear,
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                  tooltip: l10n?.deleteImage ?? 'Hapus Gambar',
                  constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                ),
              ],
            ),
          ),
    ];
  }


  Widget _buildQuickSensorChip(String label, RedactionPresetTarget target) {
    final isAlreadyAdded = widget.config.redactions.any((r) => r.label == target.label);
    return PressScale(
      onTap: () => widget.onAddQuickRedaction?.call(target),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isAlreadyAdded
              ? AppColors.primary.withValues(alpha: 0.25)
              : AppColors.bgSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isAlreadyAdded
                ? AppColors.primaryLight.withValues(alpha: 0.35)
                : AppColors.subtleBorder(context, alpha: 0.1),
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
    // Explicit brand-dark surface: prompt styling is authored for dark and
    // stays identical in either app theme.
    return Card(
      color: AppColors.bgCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: AppColors.subtleBorder(context, alpha: 0.1)),
      ),
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
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.uploadIdPhotoDesc ?? 'Pilih foto e-KTP, SIM, atau Paspor untuk menambahkan stempel tujuan, tanggal, dan sensor data vital.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.slate400,
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
                  Flexible(
                    child: Text(
                      l10n?.onDeviceBadge ?? '100% On-Device • Gambar tidak pernah dikirim ke server',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentText, // prompt card is brand-dark in both themes
                      ),
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
                PressScale(
                  scale: 0.97,
                  child: ElevatedButton.icon(
                    onPressed: widget.onPickGallery,
                    icon: const Icon(Icons.photo_library_outlined, size: 18),
                    label: Text(l10n?.openGallery ?? 'Buka Galeri'),
                  ),
                ),
                PressScale(
                  scale: 0.97,
                  child: OutlinedButton.icon(
                    onPressed: widget.onPickCamera,
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.primaryLight),
                    icon: const Icon(Icons.camera_alt_outlined, size: 18),
                    label: Text(l10n?.takePhoto ?? 'Ambil Foto'),
                  ),
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

    // 2. Watermark pattern: the exact export renderer, so the preview
    // matches the burned-in result (incl. the fit-to-image logic).
    WatermarkRendererService.paintPattern(canvas, size, config, _loc);
  }

  @override
  bool shouldRepaint(covariant _WatermarkOverlayPainter oldDelegate) {
    return oldDelegate.config != config || oldDelegate.zone != zone;
  }
}
