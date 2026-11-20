import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Where a saved document ended up, for the "saved to …" message.
enum SavedLocation { pictures, downloads }

/// A file written to shared storage.
class SavedDocument {
  final String path;
  final SavedLocation location;

  const SavedDocument(this.path, this.location);
}

/// Writes exported documents to the device's shared storage.
///
/// Android 11+ lets an app create its own files in the public `Pictures/`
/// and `Download/` folders by path, and the media scanner picks them up, so
/// they show in Gallery / Files under `IDMark`. Older Android, iOS and any
/// failure return `null`; the caller then falls back to the system share
/// sheet, which offers "Save image" / "Save to Files". Nothing leaves the
/// device either way.
class DocumentSaver {
  const DocumentSaver();

  static const String _androidRoot = '/storage/emulated/0';
  static const String folderName = 'IDMark';

  Future<SavedDocument?> save(
    Uint8List bytes,
    String filename, {
    required bool isImage,
  }) async {
    if (kIsWeb || !Platform.isAndroid) return null;
    final location = isImage ? SavedLocation.pictures : SavedLocation.downloads;
    final base = isImage ? 'Pictures' : 'Download';
    try {
      final dir = Directory('$_androidRoot/$base/$folderName');
      await dir.create(recursive: true);
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      return SavedDocument(file.path, location);
    } on FileSystemException catch (e) {
      debugPrint('DocumentSaver: shared storage write failed: ${e.message}');
      return null;
    }
  }
}

final documentSaverProvider = Provider<DocumentSaver>((ref) => const DocumentSaver());
