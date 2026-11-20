import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../core/ui/app_scroll.dart';
import '../../core/ui/press_scale.dart';
import '../../core/ui/tap_target.dart';
import '../../core/models/audit_log_entry.dart';
import '../../core/models/redaction_item.dart';
import '../../core/models/watermark_config.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/timezone_provider.dart';
import '../../core/services/document_saver.dart';
import '../../core/services/pdf_export_service.dart';
import '../../core/services/watermark_renderer_service.dart';
import '../../core/utils/app_timezone.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import '../../core/utils/l10n_helpers.dart';
import '../../core/utils/web_download_helper.dart';
import 'widgets/idmark_share_dialog.dart';
import 'widgets/watermark_canvas_preview.dart';
import 'widgets/watermark_control_panel.dart';
import '../../core/theme/app_numeric.dart';
import '../../core/ui/app_icon.dart';

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
        // A new photo is a new copy: stamp today's date, not a stale one.
        await ref.read(watermarkConfigProvider.notifier).resetDateToToday();
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

  /// Renders the current config into the effective export format, records
  /// the audit entry (with the real format) and returns the file.
  Future<_ExportedFile?> _renderExport() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final imageBytes = ref.read(selectedImageBytesProvider);
    if (imageBytes == null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n?.selectImageFirst ?? 'Pilih atau ambil foto KTP terlebih dahulu.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return null;
    }

    final config = ref.read(watermarkConfigProvider);
    final validationErrors = config.validate();
    if (validationErrors.isNotEmpty) {
      final firstErr = l10n != null ? mapValidationError(validationErrors.first, l10n) : validationErrors.first;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n?.checkConfigError(firstErr ?? validationErrors.first) ?? 'Periksa konfigurasi: $firstErr'),
          backgroundColor: AppColors.danger,
        ),
      );
      return null;
    }

    // A preset placeholder such as [NAMA BANK] must never be burned in.
    final placeholders = config.unfilledPlaceholders;
    if (placeholders.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            l10n?.placeholderUnfilled(placeholders.first) ??
                'Ganti ${placeholders.first} dengan nama sebenarnya sebelum mengekspor.',
          ),
          backgroundColor: AppColors.danger,
        ),
      );
      return null;
    }

    final format = ref.read(effectiveExportFormatProvider);
    ref.read(isProcessingProvider.notifier).setProcessing(true);
    try {
      final decoded = await WatermarkRendererService.decodeImage(imageBytes);
      final loc = ref.read(timezoneLocationProvider);
      final exportStamp = AppTimeZone.nowUtc().millisecondsSinceEpoch;

      final Uint8List bytes;
      final String sha256Hash;
      if (format == ExportFormat.pdf) {
        final png = await WatermarkRendererService.renderWatermark(
          sourceImage: decoded,
          config: config,
          zone: loc,
        );
        sha256Hash = WatermarkRendererService.computeSha256(png);
        bytes = await PdfExportService.generatePdfDocument(
          imageBytes: png,
          config: config,
          sha256Checksum: sha256Hash,
          zone: loc,
          l10n: l10n,
        );
      } else {
        bytes = await WatermarkRendererService.renderWatermarkAs(
          sourceImage: decoded,
          config: config,
          format: format,
          zone: loc,
        );
        sha256Hash = WatermarkRendererService.computeSha256(bytes);
      }
      final file = _ExportedFile(
        bytes: bytes,
        sha256: sha256Hash,
        format: format,
        filename: 'idmark_$exportStamp.${_extensionOf(format)}',
        config: config,
      );

      // Record to local-only audit log (storage contract §TZ: UTC instant).
      await ref.read(auditLogsProvider.notifier).recordExport(
            AuditLogEntry(
              id: 'audit_$exportStamp',
              timestamp: AppTimeZone.nowUtc(),
              purpose: config.purpose,
              pattern: l10n == null ? config.pattern.label : config.pattern.labelOf(l10n),
              exportFormat: format.name.toUpperCase(),
              fileSizeBytes: bytes.lengthInBytes,
              sha256Hash: sha256Hash,
              redactionsCount: config.redactions.length,
              metadataStripped: config.stripMetadata,
              privacyScore: config.privacyScore,
            ),
          );
      return file;
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n?.failedToExport(e.toString()) ?? 'Gagal mengekspor dokumen: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
      return null;
    } finally {
      ref.read(isProcessingProvider.notifier).setProcessing(false);
    }
  }

  static String _extensionOf(ExportFormat f) => switch (f) {
        ExportFormat.png => 'png',
        ExportFormat.jpeg => 'jpg',
        ExportFormat.pdf => 'pdf',
      };

  static String _mimeOf(ExportFormat f) => switch (f) {
        ExportFormat.png => 'image/png',
        ExportFormat.jpeg => 'image/jpeg',
        ExportFormat.pdf => 'application/pdf',
      };

  /// "Save Document": writes the file to shared storage where the platform
  /// allows it (Android: Pictures/IDMark or Download/IDMark), downloads it
  /// on the web, and otherwise opens the share sheet so the user can pick
  /// "Save image" / "Save to Files". Never a silent no-op.
  Future<void> _saveDocument() async {
    final l10n = AppLocalizations.of(context);
    final file = await _renderExport();
    if (file == null || !mounted) return;

    String? savedLabel;
    if (kIsWeb) {
      downloadFileWeb(file.bytes, file.filename, mimeType: _mimeOf(file.format));
      savedLabel = l10n?.downloadSuccess(file.filename) ?? 'Dokumen ter-watermark berhasil diunduh (${file.filename})!';
    } else {
      final saved = await ref.read(documentSaverProvider).save(
            file.bytes,
            file.filename,
            isImage: file.format != ExportFormat.pdf,
          );
      if (!mounted) return;
      if (saved != null) {
        savedLabel = saved.location == SavedLocation.pictures
            ? (l10n?.savedToGallery ?? 'Tersimpan di Galeri › Pictures/IDMark')
            : (l10n?.savedToDownloads ?? 'Tersimpan di File › Download/IDMark');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n?.saveViaShareHint ??
                  'Untuk menyimpan salinan, pilih "Simpan gambar" atau "Simpan ke File" di lembar berbagi.',
            ),
            duration: const Duration(seconds: 4),
          ),
        );
        await _shareFile(file);
        if (!mounted) return;
      }
    }
    _showExportSuccessDialog(file, savedLabel);
  }

  /// "Share Directly": render once and open the share sheet.
  Future<void> _shareDirect() async {
    final file = await _renderExport();
    if (file == null || !mounted) return;
    await _shareFile(file);
  }

  Future<void> _shareFile(_ExportedFile file) async {
    final l10n = AppLocalizations.of(context);
    final purpose = file.config.purpose;
    if (kIsWeb) {
      downloadFileWeb(file.bytes, file.filename, mimeType: _mimeOf(file.format));
      return;
    }
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(file.bytes, name: file.filename, mimeType: _mimeOf(file.format))],
        subject: l10n?.shareSubject(purpose) ?? 'Dokumen Identitas Ter-Watermark - $purpose',
        text: l10n?.shareText(purpose) ?? 'Dokumen identitas ter-watermark aman via IDMark ($purpose) • 100% on-device',
      ),
    );
  }

  void _showExportSuccessDialog(_ExportedFile file, String? savedLabel) {
    final l10n = AppLocalizations.of(context);
    final hash = file.sha256;
    final config = file.config;
    final loc = ref.read(timezoneLocationProvider);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgSurface,
        title: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.accent, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Text(l10n?.watermarkDone ?? 'Watermark Selesai!', style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n?.watermarkDoneDesc ?? 'Dokumen e-KTP Anda telah berhasil diproteksi dengan watermark resolusi penuh dan sensor permanen secara 100% on-device.',
                style: const TextStyle(color: AppColors.slate300, fontSize: 13, height: 1.4),
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
                        const AppIcon('export_file', color: AppColors.primaryLight, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${l10n?.exportFormatTab ?? 'Format Ekspor'}: '
                            '${file.format.name.toUpperCase()} • '
                            '${(file.bytes.lengthInBytes / 1024).toStringAsFixed(1)} KB',
                            style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold, fontFeatures: AppNumeric.tabularFeatures),
                          ),
                        ),
                      ],
                    ),
                    if (savedLabel != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.folder_outlined, color: AppColors.primaryLight, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              savedLabel,
                              style: Theme.of(ctx).textTheme.bodySmall?.copyWith(color: AppColors.slate300),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const Divider(color: AppColors.border, height: 16),
                    Row(
                      children: [
                        const AppIcon('hash_fingerprint', size: 14, color: AppColors.slate400),
                        const SizedBox(width: 6),
                        const Text(
                          'SHA-256: ',
                          style: TextStyle(fontSize: 10, color: AppColors.slate400, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            hash.length > 20 ? '${hash.substring(0, 12)}...${hash.substring(hash.length - 8)}' : hash,
                            style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.slate400),
                          ),
                        ),
                        // §A11Y: 14dp glyph needs an explicit 44dp hit area.
                        TapTarget(
                          minSize: 44,
                          semanticLabel: l10n?.hashCopied ?? 'Hash integritas disalin ke clipboard!',
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: hash));
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
              const SizedBox(height: 20),
              // Stacked full-width actions: primary first, in thumb reach.
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  unawaited(_shareFile(file));
                },
                icon: Icon(kIsWeb ? Icons.download : Icons.share, size: 18),
                label: Text(kIsWeb ? (l10n?.download ?? 'Unduh') : (l10n?.share ?? 'Bagikan')),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  IdmarkShareDialog.show(
                    context: context,
                    config: config,
                    sha256Hash: hash,
                    // The stamp date itself, as burned into the document.
                    dateLabel: config.dateLabelIn(loc),
                    fileSizeBytes: file.bytes.lengthInBytes,
                  );
                },
                icon: const AppIcon('shield_check', size: 18),
                label: Text(l10n?.protectionProof ?? 'Bukti Proteksi'),
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                child: Text(l10n?.close ?? 'Tutup', style: const TextStyle(color: AppColors.slate400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedImage = ref.watch(selectedImageBytesProvider);
    final notifier = ref.read(watermarkConfigProvider.notifier);

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.shield_outlined, color: AppColors.primaryLight, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.appTitle ?? 'IDMark',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.4),
                  ),
                  Text(
                    l10n?.appSubtitle ?? 'Secure ID Card & Privacy Shield',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: AppColors.muted(context), fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt, size: 20),
            tooltip: l10n?.resetWatermarkTooltip ?? 'Reset Watermark',
            onPressed: () {
              unawaited(notifier.resetToDefault());
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
      body: LayoutBuilder(
        builder: (context, box) {
          if (selectedImage == null) {
            return SingleChildScrollView(
              physics: AppScroll.physics,
              padding: AppScroll.pagePadding(context),
              child: _constrained(Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBanner(context),
                  const SizedBox(height: 16),
                  _buildPreview(PreviewSection.all),
                  const SizedBox(height: 20),
                  _buildControlPanel(),
                  const SizedBox(height: 8),
                ],
              )),
            );
          }
          // Photo loaded: the preview stays pinned on top so every change
          // (typing, colour, redaction drag) is visible while editing.
          final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
          final stageMax = (box.maxHeight * (keyboardOpen ? 0.3 : 0.4)).clamp(140.0, 420.0);
          final pad = AppScroll.pagePadding(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(pad.left, 8, pad.right, 8),
                child: _constrained(_buildPreview(PreviewSection.stage, maxHeight: stageMax)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AppScroll.physics,
                  padding: EdgeInsets.fromLTRB(pad.left, 0, pad.right, pad.bottom),
                  child: _constrained(Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPreview(PreviewSection.toolbar),
                      const SizedBox(height: 12),
                      _buildBanner(context),
                      const SizedBox(height: 16),
                      _buildControlPanel(),
                      const SizedBox(height: 20),
                      _buildExportActions(),
                      const SizedBox(height: 8),
                    ],
                  )),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _constrained(Widget child) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: child,
        ),
      );

  Widget _buildBanner(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Solid surface: readable in either theme.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bannerSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          const AppIcon('id_card', size: 18, color: AppColors.primaryLight),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n?.bannerUuPdp ??
                  'Sebelum membagikan foto KTP: cantumkan tujuan spesifik dan tanggal, lalu tutup data yang tidak dibutuhkan penerima.',
              style: const TextStyle(fontSize: 12, color: AppColors.slate300, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(PreviewSection section, {double maxHeight = 420}) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(watermarkConfigProvider.notifier);
    return WatermarkCanvasPreview(
      imageBytes: ref.watch(selectedImageBytesProvider),
      config: ref.watch(watermarkConfigProvider),
      zone: ref.watch(timezoneLocationProvider),
      section: section,
      maxPreviewHeight: maxHeight,
      onPickGallery: () => _pickImage(ImageSource.gallery),
      onPickCamera: () => _pickImage(ImageSource.camera),
      onClear: () => ref.read(selectedImageBytesProvider.notifier).setImage(null),
      onUpdateRedaction: notifier.updateRedaction,
      onAddQuickRedaction: (target) {
        unawaited(notifier.addRedaction(RedactionBox.fromPreset(target)));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n == null
                  ? 'Kotak sensor "${target.label}" ditambahkan.'
                  : l10n.sensorBoxAdded(target.labelOf(l10n)),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  Widget _buildControlPanel() {
    final notifier = ref.read(watermarkConfigProvider.notifier);
    final config = ref.watch(watermarkConfigProvider);
    final format = ref.watch(effectiveExportFormatProvider);
    return WatermarkControlPanel(
      // The panel shows the format of THIS export; the saved default
      // (Settings) only changes from Settings.
      config: format == config.exportFormat ? config : config.copyWith(exportFormat: format),
      zone: ref.watch(timezoneLocationProvider),
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
      onExportFormatChanged: (f) => ref.read(exportFormatOverrideProvider.notifier).set(f),
      onJpegQualityChanged: notifier.updateJpegQuality,
    );
  }

  Widget _buildExportActions() {
    final l10n = AppLocalizations.of(context);
    final isProcessing = ref.watch(isProcessingProvider);
    final formatName = ref.watch(effectiveExportFormatProvider).name.toUpperCase();
    // Theme card surface so the outlined button keeps its themed contrast.
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PressScale(
              scale: 0.97,
              child: ElevatedButton.icon(
                onPressed: isProcessing ? null : _saveDocument,
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
                      : (l10n?.saveDocument(formatName) ?? 'Simpan Dokumen ($formatName)'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            PressScale(
              scale: 0.97,
              child: OutlinedButton.icon(
                onPressed: isProcessing ? null : _shareDirect,
                icon: const Icon(Icons.share_outlined, size: 18),
                label: Text(l10n?.shareDirect ?? 'Bagikan Langsung'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One rendered export, kept so "Share" in the success dialog reuses the
/// same bytes instead of rendering (and logging) a second time.
class _ExportedFile {
  final Uint8List bytes;
  final String sha256;
  final ExportFormat format;
  final String filename;
  final WatermarkConfig config;

  const _ExportedFile({
    required this.bytes,
    required this.sha256,
    required this.format,
    required this.filename,
    required this.config,
  });
}
