import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/audit_log_entry.dart';
import '../models/redaction_item.dart';
import '../models/watermark_config.dart';
import '../models/watermark_preset.dart';
import '../services/image_picker_service.dart';
import '../services/watermark_renderer_service.dart';
import '../storage/local_storage_service.dart';
import '../utils/app_timezone.dart';

/// Local Storage Service Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localStorageServiceProvider must be overridden in ProviderScope');
});

/// Image Picker Service Provider
final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return ImagePickerService();
});

/// Default Presets Catalog Provider
final defaultPresetsCatalogProvider = Provider<List<WatermarkPreset>>((ref) {
  return WatermarkPreset.defaultPresets;
});

/// Custom User Presets Notifier
class CustomPresetsNotifier extends Notifier<List<WatermarkPreset>> {
  @override
  List<WatermarkPreset> build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.loadCustomPresets();
  }

  Future<void> addPreset(WatermarkPreset preset) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.addCustomPreset(preset);
    state = storage.loadCustomPresets();
  }

  Future<void> deletePreset(String id) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.deleteCustomPreset(id);
    state = storage.loadCustomPresets();
  }
}

final customPresetsProvider =
    NotifierProvider<CustomPresetsNotifier, List<WatermarkPreset>>(CustomPresetsNotifier.new);

/// Combined Presets Provider (Built-in + Custom)
final allPresetsProvider = Provider<List<WatermarkPreset>>((ref) {
  final defaults = ref.watch(defaultPresetsCatalogProvider);
  final customs = ref.watch(customPresetsProvider);
  return [...customs, ...defaults];
});

/// Audit Log History Notifier
class AuditLogsNotifier extends Notifier<List<AuditLogEntry>> {
  @override
  List<AuditLogEntry> build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.loadAuditLogs();
  }

  Future<void> recordExport(AuditLogEntry entry) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.addAuditLog(entry);
    state = storage.loadAuditLogs();
  }

  /// Removes one entry; returns it (with its index) so the UI can undo.
  Future<(AuditLogEntry, int)?> deleteEntry(String id) async {
    final index = state.indexWhere((e) => e.id == id);
    if (index < 0) return null;
    final removed = state[index];
    final storage = ref.read(localStorageServiceProvider);
    final next = [...state]..removeAt(index);
    await storage.saveAuditLogs(next);
    state = storage.loadAuditLogs();
    return (removed, index);
  }

  /// Puts back an entry removed by [deleteEntry] at its old position.
  Future<void> restoreEntry(AuditLogEntry entry, int index) async {
    if (state.any((e) => e.id == entry.id)) return;
    final storage = ref.read(localStorageServiceProvider);
    final next = [...state]..insert(index.clamp(0, state.length), entry);
    await storage.saveAuditLogs(next);
    state = storage.loadAuditLogs();
  }

  Future<void> clearHistory() async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.clearAuditLogs();
    state = [];
  }
}

final auditLogsProvider =
    NotifierProvider<AuditLogsNotifier, List<AuditLogEntry>>(AuditLogsNotifier.new);

/// Watermark Configuration Notifier
class WatermarkConfigNotifier extends Notifier<WatermarkConfig> {
  @override
  WatermarkConfig build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.loadConfig();
  }

  Future<void> updatePurpose(String purpose) async {
    state = state.copyWith(purpose: purpose);
    await _persist();
  }

  Future<void> updateDate(DateTime date) async {
    state = state.copyWith(transactionDate: date);
    await _persist();
  }

  Future<void> updateSubtext(String subtext) async {
    state = state.copyWith(customSubtext: subtext);
    await _persist();
  }

  Future<void> updatePattern(WatermarkPattern pattern) async {
    state = state.copyWith(pattern: pattern);
    await _persist();
  }

  Future<void> updateColorOption(WatermarkColorOption colorOption) async {
    state = state.copyWith(colorOption: colorOption);
    await _persist();
  }

  Future<void> updateOpacity(double opacity) async {
    state = state.copyWith(opacity: opacity);
    await _persist();
  }

  Future<void> updateFontSize(double fontSize) async {
    state = state.copyWith(fontSize: fontSize);
    await _persist();
  }

  Future<void> updateRotation(double angle) async {
    state = state.copyWith(rotationAngle: angle);
    await _persist();
  }

  Future<void> updateIncludeDate(bool include) async {
    state = state.copyWith(includeDate: include);
    await _persist();
  }

  Future<void> updateUppercase(bool uppercase) async {
    state = state.copyWith(isUppercase: uppercase);
    await _persist();
  }

  Future<void> addRedaction(RedactionBox box) async {
    final updatedList = List<RedactionBox>.from(state.redactions)..add(box);
    state = state.copyWith(redactions: updatedList);
    await _persist();
  }

  Future<void> removeRedaction(String id) async {
    final updatedList = state.redactions.where((b) => b.id != id).toList();
    state = state.copyWith(redactions: updatedList);
    await _persist();
  }

  Future<void> clearRedactions() async {
    state = state.copyWith(redactions: []);
    await _persist();
  }

  Future<void> updateRedaction(RedactionBox updatedBox) async {
    final updatedList = state.redactions.map((b) => b.id == updatedBox.id ? updatedBox : b).toList();
    state = state.copyWith(redactions: updatedList);
    await _persist();
  }

  Future<void> updateExportFormat(ExportFormat format) async {
    state = state.copyWith(exportFormat: format);
    await _persist();
  }

  Future<void> updateJpegQuality(int quality) async {
    state = state.copyWith(jpegQuality: quality);
    await _persist();
  }

  Future<void> updateStripMetadata(bool strip) async {
    state = state.copyWith(stripMetadata: strip);
    await _persist();
  }

  Future<void> applyPreset(WatermarkPreset preset) async {
    state = state.copyWith(
      purpose: preset.samplePurpose,
      customSubtext: preset.subtext,
      pattern: preset.defaultPattern,
      colorOption: preset.defaultColor,
    );
    await _persist();
  }

  /// Stamps today's date: called when a new photo is loaded so a stale
  /// date from an earlier session never ends up on a new copy.
  Future<void> resetDateToToday() async {
    state = state.copyWith(transactionDate: AppTimeZone.nowUtc());
    await _persist();
  }

  Future<void> resetToDefault() async {
    state = WatermarkConfig.defaultConfig();
    await _persist();
  }

  Future<void> _persist() {
    final storage = ref.read(localStorageServiceProvider);
    return storage.saveConfig(state);
  }
}

final watermarkConfigProvider =
    NotifierProvider<WatermarkConfigNotifier, WatermarkConfig>(WatermarkConfigNotifier.new);

/// Export format chosen in the editor for the current session. `null` means
/// "use the default from Settings" ([WatermarkConfig.exportFormat]); picking
/// a format in the editor never rewrites that default.
class ExportFormatOverrideNotifier extends Notifier<ExportFormat?> {
  @override
  ExportFormat? build() => null;

  void set(ExportFormat? format) => state = format;
}

final exportFormatOverrideProvider =
    NotifierProvider<ExportFormatOverrideNotifier, ExportFormat?>(
  ExportFormatOverrideNotifier.new,
);

/// Format the next export will use: editor override, else the default.
final effectiveExportFormatProvider = Provider<ExportFormat>((ref) {
  return ref.watch(exportFormatOverrideProvider) ??
      ref.watch(watermarkConfigProvider).exportFormat;
});

/// Selected Image Bytes Notifier
class SelectedImageBytesNotifier extends Notifier<Uint8List?> {
  @override
  Uint8List? build() => null;

  void setImage(Uint8List? bytes) {
    state = bytes;
  }
}

final selectedImageBytesProvider =
    NotifierProvider<SelectedImageBytesNotifier, Uint8List?>(SelectedImageBytesNotifier.new);

/// Decoded Source Image Provider
final decodedImageProvider = FutureProvider<ui.Image?>((ref) async {
  final bytes = ref.watch(selectedImageBytesProvider);
  if (bytes == null) return null;
  return WatermarkRendererService.decodeImage(bytes);
});

/// Exporting / Rendering busy indicator Notifier
class IsProcessingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setProcessing(bool processing) {
    state = processing;
  }
}

final isProcessingProvider =
    NotifierProvider<IsProcessingNotifier, bool>(IsProcessingNotifier.new);
