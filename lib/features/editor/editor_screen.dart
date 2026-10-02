import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/audit_log_entry.dart';
import '../../core/models/redaction_item.dart';
import '../../core/models/watermark_config.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/timezone_provider.dart';
import '../../core/services/pdf_export_service.dart';
import '../../core/services/watermark_renderer_service.dart';
import '../../core/utils/app_timezone.dart';
import '../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    final imageBytes = ref.read(selectedImageBytesProvider);
    if (imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n?.selectImageFirst ?? 'Pilih atau ambil foto KTP terlebih dahulu.'),
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
          content: Text(l10n?.checkConfigError(validationErrors.first) ?? 'Periksa konfigurasi: ${validationErrors.first}'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    ref.read(isProcessingProvider.notifier).setProcessing(true);
    try {
      final decoded = await WatermarkRendererService.decodeImage(imageBytes);
      final loc = ref.read(timezoneLocationProvider);
      final renderedBytes = await WatermarkRendererService.renderWatermark(
        sourceImage: decoded,
        config: config,
        zone: loc,
      );

      final sha256Hash = WatermarkRendererService.computeSha256(renderedBytes);

      Uint8List finalOutputBytes;
      String filename;
      String mimeType;
      final exportStamp = AppTimeZone.nowUtc().millisecondsSinceEpoch;

      if (config.exportFormat == ExportFormat.pdf) {
        finalOutputBytes = await PdfExportService.generatePdfDocument(
          imageBytes: renderedBytes,
          config: config,
          sha256Checksum: sha256Hash,
          zone: loc,
        );
        filename = 'idmark_$exportStamp.pdf';
        mimeType = 'application/pdf';
      } else {
        finalOutputBytes = renderedBytes;
        filename = 'idmark_$exportStamp.png';
        mimeType = 'image/png';
      }

      // Record to local-only audit log (storage contract §TZ: UTC instant).
      final auditEntry = AuditLogEntry(
        id: 'audit_$exportStamp',
        timestamp: AppTimeZone.nowUtc(),
        purpose: config.purpose,
        pattern: config.pattern.label,
        exportFormat: config.exportFormat == ExportFormat.pdf ? 'PDF' : 'PNG',
        fileSizeBytes: finalOutputBytes.lengthInBytes,
        sha256Hash: sha256Hash,
        redactionsCount: config.redactions.length,
        metadataStripped: config.stripMetadata,
        privacyScore: config.privacyScore,
      );
      await ref.read(auditLogsProvider.notifier).recordExport(auditEntry);

      if (!mounted) return;

      if (isShare) {
        final xFile = XFile.fromData(
          finalOutputBytes,
          name: filename,
          mimeType: mimeType,
        );
        await SharePlus.instance.share(
          ShareParams(
            files: [xFile],
            subject: l10n?.shareSubject(config.purpose) ?? 'Dokumen Identitas Ter-Watermark - ${config.purpose}',
            text: l10n?.shareText(config.purpose) ?? 'Dokumen identitas ter-watermark aman via IDMark (${config.purpose}) • 100% on-device',
          ),
        );
      } else {
        _showExportSuccessDialog(finalOutputBytes, sha256Hash, config);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.failedToExport(e.toString()) ?? 'Gagal mengekspor dokumen: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      ref.read(isProcessingProvider.notifier).setProcessing(false);
    }
  }

  void _showExportSuccessDialog(Uint8List bytes, String sha256Hash, WatermarkConfig config) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgSurface,
        title: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.accent, size: 24),
            const SizedBox(width: 10),
            Text(l10n?.watermarkDone ?? 'Watermark Selesai!', style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.watermarkDoneDesc ?? 'Dokumen e-KTP Anda telah berhasil diproteksi dengan watermark resolusi penuh dan sensor permanen secara 100% on-device.',
              style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.file_download_done, color: AppColors.primaryLight, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Format: ${config.exportFormat.name.toUpperCase()} • ${(bytes.lengthInBytes / 1024).toStringAsFixed(1)} KB',
                          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.border, height: 16),
                  Row(
                    children: [
                      const Text(
                        'SHA-256: ',
                        style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          sha256Hash.length > 20
                              ? '${sha256Hash.substring(0, 12)}...${sha256Hash.substring(sha256Hash.length - 8)}'
                              : sha256Hash,
                          style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF94A3B8)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: sha256Hash));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n?.hashCopied ?? 'Hash integritas disalin ke clipboard!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Icon(Icons.copy, size: 14, color: AppColors.primaryLight),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n?.close ?? 'Tutup', style: const TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _exportWatermarkedImage(isShare: true);
            },
            icon: const Icon(Icons.share, size: 16),
            label: Text(l10n?.share ?? 'Bagikan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedImage = ref.watch(selectedImageBytesProvider);
    final config = ref.watch(watermarkConfigProvider);
    final notifier = ref.read(watermarkConfigProvider.notifier);
    final isProcessing = ref.watch(isProcessingProvider);
    final loc = ref.watch(timezoneLocationProvider);

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
                Text('IDMark', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                Text(
                  'Secure ID Card & Privacy Shield',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt, size: 20),
            tooltip: l10n?.resetWatermarkTooltip ?? 'Reset Watermark',
            onPressed: () {
              notifier.resetToDefault();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n?.configResetKominfo ?? 'Konfigurasi dikembalikan ke standar rekomendasi Kominfo.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Kominfo & UU PDP Banner (solid surface: readable either theme)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.bannerSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.security, size: 18, color: AppColors.primaryLight),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n?.bannerUuPdp ?? 'Standar UU PDP: Bubuhkan watermark tujuan spesifik, tanggal, dan sensor data sensitif sebelum membagikan foto e-KTP.',
                          style: const TextStyle(fontSize: 12, color: Color(0xFFE2E8F0), height: 1.4),
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
                  zone: loc,
                  onPickGallery: () => _pickImage(ImageSource.gallery),
                  onPickCamera: () => _pickImage(ImageSource.camera),
                  onClear: () {
                    ref.read(selectedImageBytesProvider.notifier).setImage(null);
                  },
                  onAddQuickRedaction: (target) {
                    notifier.addRedaction(RedactionBox.fromPreset(target));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n?.sensorBoxAdded(target.label) ?? 'Kotak sensor "${target.label}" ditambahkan.'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Control Configuration Panel
                WatermarkControlPanel(
                  config: config,
                  zone: loc,
                  onPurposeChanged: notifier.updatePurpose,
                  onDateChanged: notifier.updateDate,
                  onSubtextChanged: notifier.updateSubtext,
                  onPatternChanged: notifier.updatePattern,
                  onColorChanged: notifier.updateColorOption,
                  onOpacityChanged: notifier.updateOpacity,
                  onFontSizeChanged: notifier.updateFontSize,
                  onRotationChanged: notifier.updateRotation,
                  onIncludeDateChanged: notifier.updateIncludeDate,
                  onAddRedaction: notifier.addRedaction,
                  onRemoveRedaction: notifier.removeRedaction,
                  onUpdateRedaction: notifier.updateRedaction,
                  onStripMetadataChanged: notifier.updateStripMetadata,
                  onExportFormatChanged: notifier.updateExportFormat,
                  onJpegQualityChanged: notifier.updateJpegQuality,
                ),
                const SizedBox(height: 20),

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
                            label: Text(
                              isProcessing
                                  ? (l10n?.processingOnDevice ?? 'Memproses Dokumen On-Device...')
                                  : (l10n?.saveDocument(config.exportFormat.name.toUpperCase()) ?? 'Simpan Dokumen (${config.exportFormat.name.toUpperCase()})'),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            onPressed: isProcessing ? null : () => _exportWatermarkedImage(isShare: true),
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: Text(l10n?.shareDirect ?? 'Bagikan Langsung'),
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
