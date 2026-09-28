import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

/// Presets Catalog Provider
final presetsCatalogProvider = Provider<List<WatermarkPreset>>((ref) {
  return WatermarkPreset.defaultPresets;
});

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
