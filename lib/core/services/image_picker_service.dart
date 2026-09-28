import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../utils/validators.dart';

class PickedImageResult {
  final Uint8List bytes;
  final String fileName;

  const PickedImageResult({
    required this.bytes,
    required this.fileName,
  });
}

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<PickedImageResult?> pickImage(ImageSource source) async {
    final xFile = await _picker.pickImage(
      source: source,
      maxWidth: 4096,
      maxHeight: 4096,
      imageQuality: 95,
    );

    if (xFile == null) return null;

    final bytes = await xFile.readAsBytes();

    // Enforce §VAL validation on uploaded input
    final validationError = AppValidators.validateImageBytes(bytes.lengthInBytes);
    if (validationError != null) {
      throw ArgumentError(validationError);
    }

    return PickedImageResult(
      bytes: bytes,
      fileName: xFile.name,
    );
  }
}
