import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../../core/services/watermark_renderer_service.dart';
import 'widgets/watermark_canvas_preview.dart';
import 'widgets/watermark_control_panel.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ref.read(imagePickerServiceProvider);
      final result = await picker.pickImage(source);
      if (result != null) {
        ref.read(selectedImageBytesProvider.notifier).setImage(result.bytes);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '').replaceAll('ArgumentError: ', '')),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  Future<void> _exportWatermarkedImage({bool isShare = false}) async {
    final imageBytes = ref.read(selectedImageBytesProvider);
    if (imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih atau ambil foto KTP terlebih dahulu.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final config = ref.read(watermarkConfigProvider);
    final validationErrors = config.validate();
    if (validationErrors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Periksa konfigurasi: ${validationErrors.first}'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    ref.read(isProcessingProvider.notifier).setProcessing(true);
    try {
      final decoded = await WatermarkRendererService.decodeImage(imageBytes);
      final renderedBytes = await WatermarkRendererService.renderWatermark(
        sourceImage: decoded,
        config: config,
      );

      if (!mounted) return;

      if (isShare) {
        final xFile = XFile.fromData(
          renderedBytes,
          name: 'ktp_watermark_${DateTime.now().millisecondsSinceEpoch}.png',
          mimeType: 'image/png',
        );
        await SharePlus.instance.share(
          ShareParams(
            files: [xFile],
            subject: 'Dokumen KTP Ber-Watermark',
            text: 'Dokumen e-KTP ter-watermark aman via KtpMark (${config.purpose})',
          ),
        );
      } else {
        // Download / Save flow
        _showExportSuccessDialog(renderedBytes);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengekspor gambar: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      ref.read(isProcessingProvider.notifier).setProcessing(false);
    }
  }

  void _showExportSuccessDialog(Uint8List bytes) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgSurface,
        title: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: AppColors.accent, size: 24),
            SizedBox(width: 10),
            Text('Watermark Selesai!', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dokumen e-KTP Anda telah berhasil dibubuhi watermark resolusi penuh secara 100% on-device.',
              style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.file_download_done, color: AppColors.primaryLight, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Ukuran output: ${(bytes.lengthInBytes / (1024 * 1024)).toStringAsFixed(2)} MB (PNG)',
                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _exportWatermarkedImage(isShare: true);
            },
            icon: const Icon(Icons.share, size: 16),
            label: const Text('Bagikan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(selectedImageBytesProvider);
    final config = ref.watch(watermarkConfigProvider);
    final notifier = ref.read(watermarkConfigProvider.notifier);
    final isProcessing = ref.watch(isProcessingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield_outlined, color: AppColors.primaryLight, size: 20),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('KtpMark', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                Text(
                  'Watermark e-KTP On-Device',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt, size: 20),
            tooltip: 'Reset Watermark',
            onPressed: () {
              notifier.resetToDefault();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Konfigurasi dikembalikan ke standar rekomendasi Kominfo.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Kominfo Security Tip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, size: 18, color: AppColors.primaryLight),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Saran Kominfo: Selalu beri watermark tujuan spesifik dan tanggal pada foto KTP agar tidak disalahgunakan untuk pinjol ilegal.',
                          style: TextStyle(fontSize: 12, color: Color(0xFFE2E8F0), height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Canvas Live Preview
                WatermarkCanvasPreview(
                  imageBytes: selectedImage,
                  config: config,
                  onPickGallery: () => _pickImage(ImageSource.gallery),
                  onPickCamera: () => _pickImage(ImageSource.camera),
                  onClear: () {
                    ref.read(selectedImageBytesProvider.notifier).setImage(null);
                  },
                ),
                const SizedBox(height: 20),

                // Control Configuration Panel
                WatermarkControlPanel(
                  config: config,
                  onPurposeChanged: notifier.updatePurpose,
                  onDateChanged: notifier.updateDate,
                  onSubtextChanged: notifier.updateSubtext,
                  onPatternChanged: notifier.updatePattern,
                  onColorChanged: notifier.updateColorOption,
                  onOpacityChanged: notifier.updateOpacity,
                  onFontSizeChanged: notifier.updateFontSize,
                  onRotationChanged: notifier.updateRotation,
                  onIncludeDateChanged: notifier.updateIncludeDate,
                ),
                const SizedBox(height: 24),

                // Export & Share Actions
                if (selectedImage != null)
                  Card(
                    color: AppColors.bgSurface,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            onPressed: isProcessing ? null : () => _exportWatermarkedImage(isShare: false),
                            icon: isProcessing
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Icon(Icons.download, size: 20),
                            label: Text(isProcessing ? 'Memproses Watermark...' : 'Simpan Dokumen Watermark'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            onPressed: isProcessing ? null : () => _exportWatermarkedImage(isShare: true),
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: const Text('Bagikan Langsung'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
