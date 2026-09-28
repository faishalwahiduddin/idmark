import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../models/watermark_config.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

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
}
