import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/app_scroll.dart';
import '../../../../core/ui/press_scale.dart';
import '../../../../core/models/redaction_item.dart';
import '../../../../core/models/watermark_config.dart';
import '../../../../core/utils/app_timezone.dart';
import '../../../../core/utils/l10n_helpers.dart';
import '../../../../core/utils/validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_numeric.dart';
import 'redaction_tab.dart';
import '../../../core/ui/app_icon.dart';

class WatermarkControlPanel extends StatefulWidget {
  final WatermarkConfig config;
  final tz.Location? zone;
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
    this.zone,
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
  final FocusNode _purposeFocus = FocusNode();
  String? _purposeError;
  bool _expanded = true;

  /// True when moving from [from] to [to] reaches 0 deg or +/-45 deg, or
  /// crosses 0 deg. Never fires when the value did not change.
  static bool _crossesRotationDetent(double from, double to) {
    if (from == to) return false;
    if ((from < 0 && to >= 0) || (from > 0 && to <= 0)) return true;
    return to.abs() == 45.0;
  }

  /// Effective display zone: explicit zone, else Jakarta fallback.
  tz.Location get _loc =>
      widget.zone ?? AppTimeZone.locationOrFallback(kFallbackZoneName);

  @override
  void initState() {
    super.initState();
    _purposeController = TextEditingController(text: widget.config.purpose);
    _subtextController = TextEditingController(
      text: widget.config.customSubtext,
    );
    _purposeFocus.addListener(_selectPlaceholderOnFocus);
  }

  /// Focusing a purpose that still holds a preset placeholder such as
  /// `[NAMA BANK]` selects it, so typing replaces it directly.
  void _selectPlaceholderOnFocus() {
    if (!_purposeFocus.hasFocus) return;
    final m = WatermarkConfig.placeholderPattern.firstMatch(_purposeController.text);
    if (m == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _purposeController.selection = TextSelection(baseOffset: m.start, extentOffset: m.end);
    });
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
    _purposeFocus.dispose();
    _purposeController.dispose();
    _subtextController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    // Show the picker on the zone wall-clock day: the stored instant is UTC,
    // so project it first — otherwise the picker opens a day off east of UTC.
    final z = AppTimeZone.toZoned(widget.config.transactionDate, _loc);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(z.year, z.month, z.day),
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
    final l10n = AppLocalizations.of(context);
    // Explicit brand-dark surface: panel styling is authored for dark and
    // stays identical in either app theme (same as preset/history cards).
    return Theme(
      data: AppTheme.darkTheme,
      child: Card(
        color: AppColors.bgCard,
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Semantics(
                button: true,
                expanded: _expanded,
                label: l10n?.watermarkConfigTitle ?? 'Konfigurasi Watermark',
                excludeSemantics: true,
                child: InkWell(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 56),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.tune,
                            size: 20,
                            color: AppColors.primaryLight,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n?.watermarkConfigTitle ?? 'Konfigurasi Watermark',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: Icon(
                              _expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColors.slate300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: _expanded
                    ? Column(
                        children: [
              // Top Tab Navigation (panel surface is always brand-dark)
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.border, width: 1),
                  ),
                ),
                // Four short labels fit without scrolling, so no tab hides
                // off-screen on first view.
                child: TabBar(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  indicatorColor: AppColors.primaryLight,
                  labelColor: AppColors.primaryLight,
                  unselectedLabelColor: AppColors.slate400,
                  tabs: [
                    Tab(
                      icon: const AppIcon('stamp_seal', size: 18),
                      text: l10n?.tabWatermark ?? 'Watermark',
                    ),
                    Tab(
                      icon: Badge(
                        isLabelVisible: widget.config.redactions.isNotEmpty,
                        label: Text('${widget.config.redactions.length}'),
                        child: const AppIcon('redact_box', size: 18),
                      ),
                      text: l10n?.tabRedactShort ?? 'Sensor',
                    ),
                    Tab(
                      icon: const AppIcon('shield_check', size: 18),
                      text: l10n?.tabPrivacyShort ?? 'Privasi',
                    ),
                    Tab(
                      icon: const AppIcon('export_file', size: 18),
                      text: l10n?.tabFormatShort ?? 'Format',
                    ),
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
                      RedactionTab(
                        redactions: widget.config.redactions,
                        onAdd: widget.onAddRedaction,
                        onRemove: widget.onRemoveRedaction,
                        onUpdate: widget.onUpdateRedaction,
                      ),
                      _buildPrivacyTab(context),
                      _buildExportTab(context),
                    ],
                  ),
                ),
              ),
                        ],
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- TAB 1: WATERMARK ---
  Widget _buildWatermarkTab(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      physics: AppScroll.physics,
      children: [
        // 1. Purpose Input
        Text(
          l10n?.watermarkPurposeLabel ?? 'Tujuan Watermark (Sesuai Kebutuhan)',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.slate300,
          ),
        ),
        const SizedBox(height: 6),
        // Accessible name for screen readers and getByLabel; the heading above is a separate node.
        MergeSemantics(
          child: Semantics(
            label:
                l10n?.watermarkPurposeLabel ??
                'Tujuan Watermark (Sesuai Kebutuhan)',
            child: TextFormField(
              controller: _purposeController,
              focusNode: _purposeFocus,
              decoration: InputDecoration(
                hintText:
                    l10n?.watermarkPurposeHint ??
                    'Misal: VERIFIKASI PINJAMAN BANK ABC',
                errorText: _purposeError ?? _placeholderError(l10n),
                errorMaxLines: 3,
                prefixIcon: const Icon(Icons.shield_outlined, size: 18),
                suffixIcon: _purposeController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () {
                          _purposeController.clear();
                          setState(() {
                            _purposeError = l10n != null
                                ? mapValidationError(
                                    AppValidators.validatePurpose(''),
                                    l10n,
                                  )
                                : AppValidators.validatePurpose('');
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (val) {
                final rawErr = AppValidators.validatePurpose(val);
                final err = l10n != null
                    ? mapValidationError(rawErr, l10n)
                    : rawErr;
                setState(() => _purposeError = err);
                if (rawErr == null) {
                  widget.onPurposeChanged(val);
                }
              },
            ),
          ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.primaryLight,
                      ),
                      const SizedBox(width: 10),
                      Flexible(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n?.transactionDate ?? 'Tanggal Transaksi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.slate400,
                            ),
                          ),
                          Text(
                            widget.config.dateLabelIn(_loc),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            PressScale(
              onTap: () =>
                  widget.onIncludeDateChanged(!widget.config.includeDate),
              child: IgnorePointer(
                child: FilterChip(
                  label: Text(l10n?.includeDateChip ?? 'Cantumkan Tgl'),
                  selected: widget.config.includeDate,
                  onSelected: (_) {},
                  selectedColor: AppColors.primary.withValues(alpha: 0.3),
                  checkmarkColor: AppColors.primaryLight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // 3. Subtext Input (Optional)
        Text(
          l10n?.subtextLabel ?? 'Catatan Tambahan / Subtext (Opsional)',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.slate400,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _subtextController,
          decoration: InputDecoration(
            hintText:
                l10n?.subtextHint ??
                'Misal: HANYA UNTUK KELENGKAPAN BERKAS INTERNAL',
            prefixIcon: const Icon(Icons.notes, size: 18),
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
        Text(
          l10n?.patternLabel ?? 'Pola Stempel Watermark (7 Gaya)',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.slate300,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: WatermarkPattern.values.map((p) {
            final isSelected = widget.config.pattern == p;
            return ChoiceChip(
              label: Text(p.labelOf(l10n)),
              selected: isSelected,
              onSelected: (_) => widget.onPatternChanged(p),
              selectedColor: AppColors.primary.withValues(alpha: 0.25),
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                color: isSelected
                    ? AppColors.primaryLight
                    : AppColors.slate400,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // 5. Color Selector
        Text(
          l10n?.colorLabel ?? 'Warna Cap Watermark',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.slate300,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: WatermarkColorOption.values.map((c) {
            final isSelected = widget.config.colorOption == c;
            return ChoiceChip(
              avatar: CircleAvatar(backgroundColor: c.color, radius: 6),
              label: Text(c.labelOf(l10n)),
              selected: isSelected,
              onSelected: (_) => widget.onColorChanged(c),
              selectedColor: c.color.withValues(alpha: 0.25),
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                color: isSelected ? Colors.white : AppColors.slate400,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // 6. Opacity & Font Size Sliders
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n?.opacityLevel ?? 'Tingkat Opasitas (Transparansi)',
              style: const TextStyle(fontSize: 12, color: AppColors.slate300),
            ),
            Text(
              '${(widget.config.opacity * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryLight,
                fontFeatures: AppNumeric.tabularFeatures,
              ),
            ),
          ],
        ),
        Slider(
          value: widget.config.opacity,
          min: 0.15,
          max: 0.90,
          divisions: 15,
          activeColor: AppColors.primary,
          onChanged: (v) {
            if (v != widget.config.opacity) HapticFeedback.selectionClick();
            widget.onOpacityChanged(v);
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n?.watermarkFontSize ?? 'Ukuran Teks Watermark',
              style: const TextStyle(fontSize: 12, color: AppColors.slate300),
            ),
            Text(
              '${widget.config.fontSize.toInt()} pt',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryLight,
                fontFeatures: AppNumeric.tabularFeatures,
              ),
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

        if (widget.config.pattern == WatermarkPattern.diagonalBand ||
            widget.config.pattern == WatermarkPattern.repeatedGrid) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.rotationAngle ?? 'Kemiringan Sudut',
                style: const TextStyle(fontSize: 12, color: AppColors.slate300),
              ),
              Text(
                '${widget.config.rotationAngle.toInt()}°',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryLight,
                  fontFeatures: AppNumeric.tabularFeatures,
                ),
              ),
            ],
          ),
          Slider(
            value: widget.config.rotationAngle,
            min: -45.0,
            max: 45.0,
            divisions: 18,
            activeColor: AppColors.primary,
            onChanged: (v) {
              if (_crossesRotationDetent(widget.config.rotationAngle, v)) {
                HapticFeedback.selectionClick();
              }
              widget.onRotationChanged(v);
            },
          ),
        ],
      ],
    );
  }

  /// Inline error while the purpose still holds a preset placeholder.
  String? _placeholderError(AppLocalizations? l10n) {
    final m = WatermarkConfig.placeholderPattern.firstMatch(_purposeController.text);
    if (m == null) return null;
    final ph = m.group(0)!;
    return l10n?.placeholderUnfilled(ph) ??
        'Ganti $ph dengan nama sebenarnya sebelum mengekspor.';
  }

  // --- TAB 3: PRIVASI & EXIF ---
  Widget _buildPrivacyTab(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final score = widget.config.privacyScore;
    final checks = [
      widget.config.hasSpecificPurpose,
      widget.config.includeDate,
      widget.config.stripMetadata,
      widget.config.redactions.isNotEmpty,
    ];
    final done = checks.where((c) => c).length;

    return ListView(
      physics: AppScroll.physics,
      children: [
        // Protection checklist summary: plain count + bar, no letter grade
        // (the app is not a certification; see notLegalAdvice).
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n?.privacyComplianceIndex ?? 'Checklist Perlindungan',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    '$done/${checks.length}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFeatures: AppNumeric.tabularFeatures,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.config.localizedPrivacyGradeDescription(l10n),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.slate400,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: done / checks.length,
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
        Text(
          l10n?.complianceChecklistTitle ??
              'Checklist Kepatuhan UU PDP No. 27/2022:',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.slate300,
          ),
        ),
        const SizedBox(height: 10),
        _buildChecklistItem(
          l10n?.checkPurposeTitle ?? 'Tujuan Penggunaan Spesifik',
          checks[0],
          l10n?.checkPurposeDesc ??
              'Membatasi agar salinan tidak bisa dialihkan ke transaksi lain',
        ),
        _buildChecklistItem(
          l10n?.checkDateTitle ?? 'Tanggal Transaksi Dicantumkan',
          widget.config.includeDate,
          l10n?.checkDateDesc ??
              'Membatasi masa kedaluwarsa dokumen agar tidak disalahgunakan di masa depan',
        ),
        _buildChecklistItem(
          l10n?.checkExifTitle ?? 'Sanitasi Metadata EXIF & GPS',
          widget.config.stripMetadata,
          l10n?.checkExifDesc ??
              'Menghilangkan lokasi geografis koordinat rumah dari file foto',
        ),
        _buildChecklistItem(
          l10n?.checkSensorTitle ?? 'Sensor Bagian Vital (NIK / Tanda Tangan)',
          widget.config.redactions.isNotEmpty,
          l10n?.checkSensorDesc ??
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
          // Own Material so the tile's ink is not hidden by the box fill.
          child: Material(
            type: MaterialType.transparency,
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const AppIcon('exif_strip', color: AppColors.primaryLight),
              title: Text(
                l10n?.autoSanitizeExifTitle ?? 'Sanitasi Metadata EXIF Otomatis',
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              subtitle: Text(
                l10n?.autoSanitizeExifDesc ??
                    'Menghapus tag metadata kamera, model HP, dan koordinat GPS secara otomatis saat ekspor',
                style: const TextStyle(fontSize: 11, color: AppColors.slate400),
              ),
              value: widget.config.stripMetadata,
              activeThumbColor: AppColors.accent,
              onChanged: widget.onStripMetadataChanged,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n?.notLegalAdvice ??
              'Panduan keamanan saja, bukan nasihat hukum dan bukan sertifikasi resmi.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.slate400),
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
            color: isChecked ? AppColors.accent : AppColors.slate500,
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
                    color: isChecked ? Colors.white : AppColors.slate400,
                  ),
                ),
                Text(
                  reason,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.slate400,
                  ),
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
    final l10n = AppLocalizations.of(context);
    return ListView(
      physics: AppScroll.physics,
      children: [
        Text(
          l10n?.chooseExportFormat ?? 'Pilih Format Dokumen Keluaran:',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n?.exportFormatSessionNote ??
              'Berlaku untuk ekspor ini. Format bawaan diatur di Pengaturan.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.slate400),
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
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryLight
                        : AppColors.border,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      format == ExportFormat.png
                          ? Icons.image_outlined
                          : (format == ExportFormat.jpeg
                                ? Icons.compress
                                : Icons.picture_as_pdf_outlined),
                      color: isSelected
                          ? AppColors.primaryLight
                          : AppColors.slate400,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            format.labelOf(l10n),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.slate300,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            format.descriptionOf(l10n),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.slate400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected
                          ? AppColors.primaryLight
                          : AppColors.slate500,
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
              Text(
                l10n?.jpegCompressionQuality ?? 'Kualitas Kompresi JPEG',
                style: const TextStyle(fontSize: 12, color: AppColors.slate300),
              ),
              Text(
                '${widget.config.jpegQuality}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryLight,
                  fontFeatures: AppNumeric.tabularFeatures,
                ),
              ),
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
