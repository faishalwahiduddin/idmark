import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idmark/core/models/audit_log_entry.dart';
import 'package:idmark/core/providers/app_providers.dart';
import 'package:idmark/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared setup for the §TRACE flow tests: fresh prefs and a container over them.
Future<LocalStorageService> freshStorage([Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  return LocalStorageService.init();
}

ProviderContainer containerWith(LocalStorageService storage) => ProviderContainer(
      overrides: [localStorageServiceProvider.overrideWithValue(storage)],
    );

/// A plain [w]×[h] source image, as if picked from the gallery.
Future<ui.Image> blankImage(int w, int h) {
  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder).drawRect(
    ui.Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
    ui.Paint()..color = const ui.Color(0xFFAACCEE),
  );
  return recorder.endRecording().toImage(w, h);
}

Future<ui.Image> decodePng(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes);
  return (await codec.getNextFrame()).image;
}

AuditLogEntry auditEntry(int i) => AuditLogEntry(
      id: 'audit_$i',
      timestamp: DateTime.utc(2026, 10, 1).add(Duration(minutes: i)),
      purpose: 'VERIFIKASI BANK $i',
      pattern: 'Pita Melintang',
      exportFormat: 'PNG',
      fileSizeBytes: 1000 + i,
      sha256Hash: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      redactionsCount: 0,
      metadataStripped: true,
      privacyScore: 80,
    );
