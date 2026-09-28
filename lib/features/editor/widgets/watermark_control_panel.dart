import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/redaction_item.dart';
import '../../../../core/models/watermark_config.dart';
import '../../../../core/utils/validators.dart';

class WatermarkControlPanel extends StatefulWidget {
  final WatermarkConfig config;
  final Function(String) onPurposeChanged;
  final Function(DateTime) onDateChanged;
  final Function(String) onSubtextChanged;
  final Function(WatermarkPattern) onPatternChanged;
  final Function(WatermarkColorOption) onColorChanged;
  final Function(double) onOpacityChanged;
  final Function(double) onFontSizeChanged;
  final Function(double) onRotationChanged;
  final Function(bool) onIncludeDateChanged;
  final Function(RedactionBox) onAddRedaction;
  final Function(String) onRemoveRedaction;
  final Function(RedactionBox) onUpdateRedaction;
  final Function(bool) onStripMetadataChanged;
  final Function(ExportFormat) onExportFormatChanged;
  final Function(int) onJpegQualityChanged;

  const WatermarkControlPanel({
    super.key,
    required this.config,
    required this.onPurposeChanged,
    required this.onDateChanged,
    required this.onSubtextChanged,
    required this.onPatternChanged,
    required this.onColorChanged,
    required this.onOpacityChanged,
    required this.onFontSizeChanged,
    required this.onRotationChanged,
    required this.onIncludeDateChanged,
    required this.onAddRedaction,
    required this.onRemoveRedaction,
    required this.onUpdateRedaction,
    required this.onStripMetadataChanged,
    required this.onExportFormatChanged,
    required this.onJpegQualityChanged,
  });

  @override
  State<WatermarkControlPanel> createState() => _WatermarkControlPanelState();
}

class _WatermarkControlPanelState extends State<WatermarkControlPanel> {
  late TextEditingController _purposeController;
  late TextEditingController _subtextController;
  String? _purposeError;

  @override
  void initState() {
    super.initState();
    _purposeController = TextEditingController(text: widget.config.purpose);
    _subtextController = TextEditingController(text: widget.config.customSubtext);
  }

  @override
  void didUpdateWidget(covariant WatermarkControlPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.purpose != widget.config.purpose &&
        _purposeController.text != widget.config.purpose) {
      _purposeController.text = widget.config.purpose;
    }
    if (oldWidget.config.customSubtext != widget.config.customSubtext &&
        _subtextController.text != widget.config.customSubtext) {
      _subtextController.text = widget.config.customSubtext;
    }
  }

  @override
  void dispose() {
    _purposeController.dispose();
    _subtextController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.config.transactionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.bgCard,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  Icon(Icons.tune, size: 20, color: AppColors.primaryLight),
                  SizedBox(width: 8),
                  Text(
                    'Konfigurasi Watermark',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Top Tab Navigation
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
              ),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.primaryLight,
                labelColor: AppColors.primaryLight,
                unselectedLabelColor: const Color(0xFF94A3B8),
                tabs: [
                  const Tab(icon: Icon(Icons.shield_outlined, size: 18), text: 'Watermark'),
                  Tab(
                    icon: Badge(
                      isLabelVisible: widget.config.redactions.isNotEmpty,
                      label: Text('${widget.config.redactions.length}'),
                      child: const Icon(Icons.visibility_off_outlined, size: 18),
                    ),
                    text: 'Sensor / Mask',
                  ),
                  const Tab(icon: Icon(Icons.verified_outlined, size: 18), text: 'Privasi & EXIF'),
                  const Tab(icon: Icon(Icons.file_download_outlined, size: 18), text: 'Format Ekspor'),
                ],
              ),
            ),

            // Tab Views
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                height: 520,
                child: TabBarView(
                  children: [
                    _buildWatermarkTab(context),
                    _buildRedactionTab(context),
                    _buildPrivacyTab(context),
                    _buildExportTab(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: WATERMARK ---
  Widget _buildWatermarkTab(BuildContext context) {
    return ListView(
      children: [
        // 1. Purpose Input
        const Text(
          'Tujuan Watermark (Sesuai Kebutuhan)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _purposeController,
          decoration: InputDecoration(
            hintText: 'Misal: VERIFIKASI PINJAMAN BANK ABC',
            errorText: _purposeError,
            prefixIcon: const Icon(Icons.shield_outlined, size: 18),
            suffixIcon: _purposeController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 16),
                    onPressed: () {
                      _purposeController.clear();
                      setState(() {
                        _purposeError = AppValidators.validatePurpose('');
                      });
                    },
                  )
                : null,
          ),
          onChanged: (val) {
            final err = AppValidators.validatePurpose(val);
            setState(() => _purposeError = err);
            if (err == null) {
              widget.onPurposeChanged(val);
            }
          },
        ),
        const SizedBox(height: 14),

        // 2. Transaction Date
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _selectDate(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: AppColors.primaryLight),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tanggal Transaksi', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                          Text(
                            '${widget.config.transactionDate.day.toString().padLeft(2, '0')}-${widget.config.transactionDate.month.toString().padLeft(2, '0')}-${widget.config.transactionDate.year}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            FilterChip(
              label: const Text('Cantumkan Tgl'),
              selected: widget.config.includeDate,
              onSelected: widget.onIncludeDateChanged,
              selectedColor: AppColors.primary.withValues(alpha: 0.3),
              checkmarkColor: AppColors.primaryLight,
            ),
          ],
        ),
        const SizedBox(height: 14),

        // 3. Subtext Input (Optional)
        const Text(
          'Catatan Tambahan / Subtext (Opsional)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _subtextController,
          decoration: const InputDecoration(
            hintText: 'Misal: HANYA UNTUK KELENGKAPAN BERKAS INTERNAL',
            prefixIcon: Icon(Icons.notes, size: 18),
          ),
          onChanged: (val) {
            final err = AppValidators.validateSubtext(val);
            if (err == null) {
              widget.onSubtextChanged(val);
            }
          },
        ),
        const SizedBox(height: 16),

        // 4. Pattern Selector
        const Text(
          'Pola Stempel Watermark (7 Gaya)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: WatermarkPattern.values.map((p) {
            final isSelected = widget.config.pattern == p;
            return ChoiceChip(
              label: Text(p.label),
              selected: isSelected,
              onSelected: (_) => widget.onPatternChanged(p),
              selectedColor: AppColors.primary.withValues(alpha: 0.25),
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                color: isSelected ? AppColors.primaryLight : const Color(0xFF94A3B8),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // 5. Color Selector
        const Text(
          'Warna Cap Watermark',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: WatermarkColorOption.values.map((c) {
            final isSelected = widget.config.colorOption == c;
            return ChoiceChip(
              avatar: CircleAvatar(backgroundColor: c.color, radius: 6),
              label: Text(c.label),
              selected: isSelected,
              onSelected: (_) => widget.onColorChanged(c),
              selectedColor: c.color.withValues(alpha: 0.25),
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // 6. Opacity & Font Size Sliders
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tingkat Opasitas (Transparansi)', style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
            Text('${(widget.config.opacity * 100).toInt()}%',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryLight)),
          ],
        ),
        Slider(
          value: widget.config.opacity,
          min: 0.15,
          max: 0.90,
          divisions: 15,
          activeColor: AppColors.primary,
          onChanged: widget.onOpacityChanged,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ukuran Teks Watermark', style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
            Text('${widget.config.fontSize.toInt()} pt',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryLight)),
          ],
        ),
        Slider(
          value: widget.config.fontSize,
          min: 16.0,
          max: 42.0,
          divisions: 13,
          activeColor: AppColors.primary,
          onChanged: widget.onFontSizeChanged,
        ),

        if (widget.config.pattern == WatermarkPattern.diagonalBand ||
            widget.config.pattern == WatermarkPattern.repeatedGrid) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Kemiringan Sudut', style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
              Text('${widget.config.rotationAngle.toInt()}°',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryLight)),
            ],
          ),
          Slider(
            value: widget.config.rotationAngle,
            min: -45.0,
            max: 45.0,
            divisions: 18,
            activeColor: AppColors.primary,
            onChanged: widget.onRotationChanged,
          ),
        ],
      ],
    );
  }

  // --- TAB 2: SENSOR / REDAKSI ---
  Widget _buildRedactionTab(BuildContext context) {
    return ListView(
      children: [
        // Intro Notice
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: const Row(
            children: [
              Icon(Icons.privacy_tip_outlined, size: 18, color: AppColors.primaryLight),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Tutup bagian data vital seperti tanda tangan atau digit NIK yang tidak relevan dengan transaksi untuk meminimalkan risiko pencurian identitas.',
                  style: TextStyle(fontSize: 11, color: Color(0xFFCBD5E1), height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Quick Preset Add Buttons
        const Text(
          'Tambah Sensor Cepat:',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(
              avatar: const Icon(Icons.add, size: 14, color: AppColors.primaryLight),
              label: const Text('Sensor NIK'),
              onPressed: () => widget.onAddRedaction(RedactionBox.fromPreset(RedactionPresetTarget.nik)),
            ),
            ActionChip(
              avatar: const Icon(Icons.add, size: 14, color: AppColors.primaryLight),
              label: const Text('Sensor Tanda Tangan'),
              onPressed: () => widget.onAddRedaction(RedactionBox.fromPreset(RedactionPresetTarget.signature)),
            ),
            ActionChip(
              avatar: const Icon(Icons.add, size: 14, color: AppColors.primaryLight),
              label: const Text('Sensor Alamat'),
              onPressed: () => widget.onAddRedaction(RedactionBox.fromPreset(RedactionPresetTarget.address)),
            ),
            ActionChip(
              avatar: const Icon(Icons.add, size: 14, color: AppColors.primaryLight),
              label: const Text('Sensor Tgl Lahir'),
              onPressed: () => widget.onAddRedaction(RedactionBox.fromPreset(RedactionPresetTarget.birthPlace)),
            ),
            ActionChip(
              avatar: const Icon(Icons.crop_square, size: 14, color: AppColors.accent),
              label: const Text('Area Kustom'),
              onPressed: () => widget.onAddRedaction(RedactionBox.fromPreset(RedactionPresetTarget.custom)),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Active Redactions List
        if (widget.config.redactions.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Icon(Icons.visibility_outlined, size: 36, color: Colors.grey.shade600),
                  const SizedBox(height: 10),
                  const Text(
                    'Belum ada area yang disensor.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          )
        else
          ...widget.config.redactions.map((box) => _buildRedactionItemCard(box)),
      ],
    );
  }

  Widget _buildRedactionItemCard(RedactionBox box) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.crop, size: 16, color: AppColors.primaryLight),
                  const SizedBox(width: 8),
                  Text(
                    box.label,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                tooltip: 'Hapus Sensor',
                visualDensity: VisualDensity.compact,
                onPressed: () => widget.onRemoveRedaction(box.id),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Tipe Masking Selector
          Row(
            children: [
              const Text('Tipe Sensor: ', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              const SizedBox(width: 8),
              DropdownButton<RedactionType>(
                value: box.type,
                dropdownColor: AppColors.bgCard,
                isDense: true,
                style: const TextStyle(fontSize: 12, color: Colors.white),
                items: RedactionType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.label),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    widget.onUpdateRedaction(box.copyWith(type: val));
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Position Sliders (X & Y)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Posisi X (${(box.left * 100).toInt()}%)',
                        style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    Slider(
                      value: box.left,
                      min: 0.0,
                      max: 1.0 - box.width,
                      activeColor: AppColors.primary,
                      onChanged: (val) => widget.onUpdateRedaction(box.copyWith(left: val)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Posisi Y (${(box.top * 100).toInt()}%)',
                        style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    Slider(
                      value: box.top,
                      min: 0.0,
                      max: 1.0 - box.height,
                      activeColor: AppColors.primary,
                      onChanged: (val) => widget.onUpdateRedaction(box.copyWith(top: val)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- TAB 3: PRIVASI & EXIF ---
  Widget _buildPrivacyTab(BuildContext context) {
    final score = widget.config.privacyScore;
    final grade = widget.config.privacyGrade;

    return ListView(
      children: [
        // Privacy Scorecard Gauge
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: score >= 80 ? AppColors.accent : AppColors.warning,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Indeks Kepatuhan Privasi Dokumen',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.config.privacyGradeDescription,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: score >= 80
                          ? AppColors.accent.withValues(alpha: 0.2)
                          : AppColors.warning.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      grade,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: score >= 80 ? AppColors.accent : AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: score / 100.0,
                  minHeight: 8,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    score >= 80 ? AppColors.accent : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Compliance Checklist
        const Text(
          'Checklist Kepatuhan UU PDP No. 27/2022:',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFCBD5E1)),
        ),
        const SizedBox(height: 10),
        _buildChecklistItem(
          'Tujuan Penggunaan Spesifik',
          widget.config.purpose.trim().length >= 5,
          'Membatasi agar salinan tidak bisa dialihkan ke transaksi lain',
        ),
        _buildChecklistItem(
          'Tanggal Transaksi Dicantumkan',
          widget.config.includeDate,
          'Membatasi masa kedaluwarsa dokumen agar tidak disalahgunakan di masa depan',
        ),
        _buildChecklistItem(
          'Sanitasi Metadata EXIF & GPS',
          widget.config.stripMetadata,
          'Menghilangkan lokasi geografis koordinat rumah dari file foto',
        ),
        _buildChecklistItem(
          'Sensor Bagian Vital (NIK / Tanda Tangan)',
          widget.config.redactions.isNotEmpty,
          'Menyembunyikan informasi yang tidak diwajibkan oleh penerima',
        ),
        const SizedBox(height: 16),

        // EXIF Stripper Switch
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Sanitasi Metadata EXIF Otomatis', style: TextStyle(fontSize: 13, color: Colors.white)),
            subtitle: const Text(
              'Menghapus tag metadata kamera, model HP, dan koordinat GPS secara otomatis saat ekspor',
              style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            ),
            value: widget.config.stripMetadata,
            activeThumbColor: AppColors.accent,
            onChanged: widget.onStripMetadataChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistItem(String title, bool isChecked, String reason) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isChecked ? AppColors.accent : const Color(0xFF64748B),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isChecked ? Colors.white : const Color(0xFF94A3B8),
                  ),
                ),
                Text(
                  reason,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 4: FORMAT EKSPOR ---
  Widget _buildExportTab(BuildContext context) {
    return ListView(
      children: [
        const Text(
          'Pilih Format Dokumen Keluaran:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 12),
        ...ExportFormat.values.map((format) {
          final isSelected = widget.config.exportFormat == format;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => widget.onExportFormatChanged(format),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryLight : AppColors.border,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      format == ExportFormat.png
                          ? Icons.image_outlined
                          : (format == ExportFormat.jpeg ? Icons.compress : Icons.picture_as_pdf_outlined),
                      color: isSelected ? AppColors.primaryLight : const Color(0xFF94A3B8),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            format.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            format.description,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? AppColors.primaryLight : const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 16),

        if (widget.config.exportFormat == ExportFormat.jpeg) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Kualitas Kompresi JPEG', style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
              Text('${widget.config.jpegQuality}%',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryLight)),
            ],
          ),
          Slider(
            value: widget.config.jpegQuality.toDouble(),
            min: 50.0,
            max: 100.0,
            divisions: 10,
            activeColor: AppColors.primary,
            onChanged: (val) => widget.onJpegQualityChanged(val.toInt()),
          ),
        ],
      ],
    );
  }
}
