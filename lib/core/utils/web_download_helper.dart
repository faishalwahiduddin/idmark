import 'dart:typed_data';

import 'web_download_helper_stub.dart'
    if (dart.library.js_interop) 'web_download_helper_web.dart';

void downloadFileWeb(Uint8List bytes, String filename, {String mimeType = 'image/png'}) {
  downloadFileWebImpl(bytes, filename, mimeType: mimeType);
}
