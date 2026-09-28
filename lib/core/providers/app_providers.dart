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

  void updatePurpose(String purpose) {
    state = state.copyWith(purpose: purpose);
    _persist();
  }

  void updateDate(DateTime date) {
    state = state.copyWith(transactionDate: date);
    _persist();
  }

  void updateSubtext(String subtext) {
    state = state.copyWith(customSubtext: subtext);
    _persist();
  }

  void updatePattern(WatermarkPattern pattern) {
    state = state.copyWith(pattern: pattern);
    _persist();
  }

  void updateColorOption(WatermarkColorOption colorOption) {
    state = state.copyWith(colorOption: colorOption);
    _persist();
  }

  void updateOpacity(double opacity) {
    state = state.copyWith(opacity: opacity);
    _persist();
  }

  void updateFontSize(double fontSize) {
    state = state.copyWith(fontSize: fontSize);
    _persist();
  }

  void updateRotation(double angle) {
    state = state.copyWith(rotationAngle: angle);
    _persist();
  }

  void updateIncludeDate(bool include) {
    state = state.copyWith(includeDate: include);
    _persist();
  }

  void updateUppercase(bool uppercase) {
    state = state.copyWith(isUppercase: uppercase);
    _persist();
  }

  void addRedaction(RedactionBox box) {
    final updatedList = List<RedactionBox>.from(state.redactions)..add(box);
    state = state.copyWith(redactions: updatedList);
    _persist();
  }

  void removeRedaction(String id) {
    final updatedList = state.redactions.where((b) => b.id != id).toList();
    state = state.copyWith(redactions: updatedList);
    _persist();
  }

  void clearRedactions() {
    state = state.copyWith(redactions: []);
    _persist();
  }

  void updateRedaction(RedactionBox updatedBox) {
    final updatedList = state.redactions.map((b) => b.id == updatedBox.id ? updatedBox : b).toList();
    state = state.copyWith(redactions: updatedList);
    _persist();
  }

  void updateExportFormat(ExportFormat format) {
    state = state.copyWith(exportFormat: format);
    _persist();
  }

  void updateJpegQuality(int quality) {
    state = state.copyWith(jpegQuality: quality);
    _persist();
  }

  void updateStripMetadata(bool strip) {
    state = state.copyWith(stripMetadata: strip);
    _persist();
  }

  void applyPreset(WatermarkPreset preset) {
    state = state.copyWith(
      purpose: preset.samplePurpose,
      customSubtext: preset.subtext,
      pattern: preset.defaultPattern,
      colorOption: preset.defaultColor,
    );
    _persist();
  }

  void resetToDefault() {
    state = WatermarkConfig.defaultConfig();
    _persist();
  }

  void _persist() {
    final storage = ref.read(localStorageServiceProvider);
    storage.saveConfig(state);
  }
}

final watermarkConfigProvider =
    NotifierProvider<WatermarkConfigNotifier, WatermarkConfig>(WatermarkConfigNotifier.new);

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
