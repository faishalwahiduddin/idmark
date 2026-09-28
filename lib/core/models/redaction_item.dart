enum RedactionType {
  blackout('Sensor Hitam (Blackout)', 'Kotak hitam pekat permanen menutup data'),
  mosaic('Sensor Mosaik (Pixelate)', 'Efek pikselasi mengaburkan teks sensitif'),
  blur('Sensor Buram (Blur)', 'Efek buram meratakan detail data pribadi');

  final String label;
  final String description;
  const RedactionType(this.label, this.description);
}

enum RedactionPresetTarget {
  nik('Nomor NIK / ID', 0.25, 0.12, 0.45, 0.08),
  signature('Tanda Tangan', 0.65, 0.68, 0.28, 0.22),
  address('Alamat Lengkap', 0.25, 0.32, 0.48, 0.18),
  birthPlace('Tempat / Tgl Lahir', 0.25, 0.20, 0.40, 0.08),
  photo('Foto Wajah', 0.65, 0.15, 0.28, 0.45),
  custom('Area Kustom', 0.30, 0.40, 0.40, 0.15);

  final String label;
  final double defaultLeft;
  final double defaultTop;
  final double defaultWidth;
  final double defaultHeight;

  const RedactionPresetTarget(
    this.label,
    this.defaultLeft,
    this.defaultTop,
    this.defaultWidth,
    this.defaultHeight,
  );
}

class RedactionBox {
  final String id;
  final String label;
  final RedactionType type;
  final double left; // Normalized 0.0 - 1.0 relative to image width
  final double top; // Normalized 0.0 - 1.0 relative to image height
  final double width; // Normalized 0.0 - 1.0
  final double height; // Normalized 0.0 - 1.0

  const RedactionBox({
    required this.id,
    required this.label,
    this.type = RedactionType.blackout,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  /// Factory helper from preset target
  factory RedactionBox.fromPreset(RedactionPresetTarget target) {
    final uid = '${target.name}_${DateTime.now().millisecondsSinceEpoch}';
    return RedactionBox(
      id: uid,
      label: target.label,
      type: RedactionType.blackout,
      left: target.defaultLeft,
      top: target.defaultTop,
      width: target.defaultWidth,
      height: target.defaultHeight,
    );
  }

  /// Validation enforcing §VAL rule
  List<String> validate() {
    final errors = <String>[];
    if (label.trim().isEmpty) {
      errors.add('Label sensor tidak boleh kosong');
    }
    if (left < 0.0 || left > 1.0) {
      errors.add('Posisi X sensor harus berada dalam rentang 0.0 - 1.0');
    }
    if (top < 0.0 || top > 1.0) {
      errors.add('Posisi Y sensor harus berada dalam rentang 0.0 - 1.0');
    }
    if (width <= 0.0 || width > 1.0) {
      errors.add('Lebar sensor harus berada dalam rentang >0.0 - 1.0');
    }
    if (height <= 0.0 || height > 1.0) {
      errors.add('Tinggi sensor harus berada dalam rentang >0.0 - 1.0');
    }
    return errors;
  }

  RedactionBox copyWith({
    String? id,
    String? label,
    RedactionType? type,
    double? left,
    double? top,
    double? width,
    double? height,
  }) {
    final updated = RedactionBox(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      left: (left ?? this.left).clamp(0.0, 1.0 - (width ?? this.width)),
      top: (top ?? this.top).clamp(0.0, 1.0 - (height ?? this.height)),
      width: (width ?? this.width).clamp(0.05, 1.0),
      height: (height ?? this.height).clamp(0.03, 1.0),
    );
    final errors = updated.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError('Mutasi RedactionBox tidak valid: ${errors.join(', ')}');
    }
    return updated;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'type': type.name,
      'left': left,
      'top': top,
      'width': width,
      'height': height,
    };
  }

  factory RedactionBox.fromJson(Map<String, dynamic> json) {
    return RedactionBox(
      id: json['id'] as String? ?? 'box_${DateTime.now().millisecondsSinceEpoch}',
      label: json['label'] as String? ?? 'Sensor',
      type: RedactionType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => RedactionType.blackout,
      ),
      left: (json['left'] as num?)?.toDouble() ?? 0.1,
      top: (json['top'] as num?)?.toDouble() ?? 0.1,
      width: (json['width'] as num?)?.toDouble() ?? 0.3,
      height: (json['height'] as num?)?.toDouble() ?? 0.1,
    );
  }
}
