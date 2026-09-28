import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
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
            const SizedBox(height: 18),

            // 1. Purpose Input (with §VAL validator)
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
            const SizedBox(height: 16),

            // 2. Transaction Date Picker
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                              const Text(
                                'Tanggal Transaksi',
                                style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                              ),
                              Text(
                                '${widget.config.transactionDate.day.toString().padLeft(2, '0')}-${widget.config.transactionDate.month.toString().padLeft(2, '0')}-${widget.config.transactionDate.year}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text('Cantumkan Tgl'),
                  selected: widget.config.includeDate,
                  onSelected: widget.onIncludeDateChanged,
                  selectedColor: AppColors.primary.withValues(alpha: 0.3),
                  checkmarkColor: AppColors.primaryLight,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Gaya Pola Watermark
            const Text(
              'Gaya Pola Watermark',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WatermarkPattern.values.map((p) {
                final isSelected = widget.config.pattern == p;
                return ChoiceChip(
                  label: Text(p.label),
                  selected: isSelected,
                  onSelected: (_) => widget.onPatternChanged(p),
                  selectedColor: AppColors.primary.withValues(alpha: 0.25),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    color: isSelected ? AppColors.primaryLight : const Color(0xFF94A3B8),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // 4. Warna Cap
            const Text(
              'Warna Watermark',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WatermarkColorOption.values.map((c) {
                final isSelected = widget.config.colorOption == c;
                return ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: c.color,
                    radius: 7,
                  ),
                  label: Text(c.label),
                  selected: isSelected,
                  onSelected: (_) => widget.onColorChanged(c),
                  selectedColor: c.color.withValues(alpha: 0.2),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // 5. Opacity Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tingkat Transparansi (Opasitas)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
                ),
                Text(
                  '${(widget.config.opacity * 100).toInt()}%',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryLight),
                ),
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

            // 6. Font Size Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ukuran Teks Cap',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
                ),
                Text(
                  '${widget.config.fontSize.toInt()} pt',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryLight),
                ),
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

            // 7. Rotation Slider (for diagonal/grid)
            if (widget.config.pattern == WatermarkPattern.diagonalBand ||
                widget.config.pattern == WatermarkPattern.repeatedGrid) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kemiringan Sudut',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1)),
                  ),
                  Text(
                    '${widget.config.rotationAngle.toInt()}°',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryLight),
                  ),
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
        ),
      ),
    );
  }
}
