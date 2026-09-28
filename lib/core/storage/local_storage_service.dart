import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../models/audit_log_entry.dart';
import '../models/watermark_config.dart';
import '../models/watermark_preset.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  /// Loads stored watermark configuration or falls back to default
  WatermarkConfig loadConfig() {
    final raw = _prefs.getString(AppConstants.keyRecentPurpose);
    if (raw == null) {
      return WatermarkConfig.defaultConfig();
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final config = WatermarkConfig.fromJson(json);
      // Validate on load (§VAL)
      if (config.validate().isEmpty) {
        return config;
      }
    } catch (_) {
      // Fallback on corrupt storage
    }
    return WatermarkConfig.defaultConfig();
  }

  /// Saves watermark configuration with strict mutation validation (§VAL)
  Future<bool> saveConfig(WatermarkConfig config) async {
    final errors = config.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError('Gagal menyimpan config ke storage: ${errors.join(', ')}');
    }
    final jsonStr = jsonEncode(config.toJson());
    return _prefs.setString(AppConstants.keyRecentPurpose, jsonStr);
  }

  /// Clears stored preferences
  Future<bool> clearConfig() async {
    return _prefs.remove(AppConstants.keyRecentPurpose);
  }

  // --- Custom Presets Management ---

  List<WatermarkPreset> loadCustomPresets() {
    final raw = _prefs.getString(AppConstants.keyCustomPresets);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List;
      final presets = <WatermarkPreset>[];
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          final p = WatermarkPreset.fromJson(item);
          if (p.validate().isEmpty) {
            presets.add(p);
          }
        }
      }
      return presets;
    } catch (_) {
      return [];
    }
  }

  Future<bool> saveCustomPresets(List<WatermarkPreset> presets) async {
    for (final p in presets) {
      final errs = p.validate();
      if (errs.isNotEmpty) {
        throw ArgumentError('Preset tidak valid: ${errs.join(', ')}');
      }
    }
    final raw = jsonEncode(presets.map((p) => p.toJson()).toList());
    return _prefs.setString(AppConstants.keyCustomPresets, raw);
  }

  Future<void> addCustomPreset(WatermarkPreset preset) async {
    final list = loadCustomPresets();
    list.removeWhere((p) => p.id == preset.id);
    list.insert(0, preset);
    await saveCustomPresets(list);
  }

  Future<void> deleteCustomPreset(String id) async {
    final list = loadCustomPresets();
    list.removeWhere((p) => p.id == id);
    await saveCustomPresets(list);
  }

  // --- Audit History Management ---

  List<AuditLogEntry> loadAuditLogs() {
    final raw = _prefs.getString(AppConstants.keyAuditHistory);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List;
      final logs = <AuditLogEntry>[];
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          final log = AuditLogEntry.fromJson(item);
          if (log.validate().isEmpty) {
            logs.add(log);
          }
        }
      }
      return logs;
    } catch (_) {
      return [];
    }
  }

  Future<bool> saveAuditLogs(List<AuditLogEntry> logs) async {
    // Limit to latest 50 entries to conserve storage
    final capped = logs.take(50).toList();
    final raw = jsonEncode(capped.map((l) => l.toJson()).toList());
    return _prefs.setString(AppConstants.keyAuditHistory, raw);
  }

  Future<void> addAuditLog(AuditLogEntry entry) async {
    final list = loadAuditLogs();
    list.insert(0, entry);
    await saveAuditLogs(list);
  }

  Future<bool> clearAuditLogs() async {
    return _prefs.remove(AppConstants.keyAuditHistory);
  }

  // --- Privacy Settings ---

  bool getAutoStripExif() {
    return _prefs.getBool(AppConstants.keyAutoStripExif) ?? true;
  }

  Future<bool> setAutoStripExif(bool value) async {
    return _prefs.setBool(AppConstants.keyAutoStripExif, value);
  }
}
