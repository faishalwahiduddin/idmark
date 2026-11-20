import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/models/redaction_item.dart';
import '../../../core/theme/app_numeric.dart';
import '../../../core/ui/app_scroll.dart';
import '../../../core/utils/l10n_helpers.dart';
import '../../../l10n/app_localizations.dart';

/// "Redact" tab of the control panel. Boxes are moved and resized by
/// dragging them on the pinned preview; the sliders here are the accessible
/// fallback and show the same values the preview uses.
class RedactionTab extends StatelessWidget {
  final List<RedactionBox> redactions;
  final ValueChanged<RedactionBox> onAdd;
  final ValueChanged<String> onRemove;
  final ValueChanged<RedactionBox> onUpdate;

  const RedactionTab({
    super.key,
    required this.redactions,
    required this.onAdd,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    Widget addChip(String label, RedactionPresetTarget target, IconData icon) {
      return ActionChip(
        avatar: Icon(icon, size: 14, color: AppColors.primaryLight),
        label: Text(label),
        onPressed: () => onAdd(RedactionBox.fromPreset(target)),
      );
    }

    return ListView(
      physics: AppScroll.physics,
      children: [
        _Notice(
          icon: Icons.pan_tool_alt_outlined,
          text: l10n?.redactionDragHint ??
              'Seret kotak di foto untuk memindahkannya. Seret titik sudutnya untuk mengubah ukuran.',
        ),
        const SizedBox(height: 14),
        Text(
          l10n?.quickSensorLabel ?? 'Tambah Sensor Cepat:',
          style: text.labelMedium?.copyWith(color: AppColors.slate400, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            addChip(l10n?.sensorNik ?? 'Sensor NIK', RedactionPresetTarget.nik, Icons.add),
            addChip(l10n?.sensorSignature ?? 'Sensor Tanda Tangan', RedactionPresetTarget.signature, Icons.add),
            addChip(l10n?.sensorAddress ?? 'Sensor Alamat', RedactionPresetTarget.address, Icons.add),
            addChip(l10n?.sensorBirthDate ?? 'Sensor Tgl Lahir', RedactionPresetTarget.birthPlace, Icons.add),
            addChip(l10n?.customArea ?? 'Area Kustom', RedactionPresetTarget.custom, Icons.crop_square),
          ],
        ),
        const SizedBox(height: 16),
        if (redactions.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                const Icon(Icons.visibility_outlined, size: 36, color: AppColors.slate500),
                const SizedBox(height: 10),
                Text(
                  l10n?.noRedactionsYet ?? 'Belum ada area yang disensor.',
                  style: text.bodySmall?.copyWith(color: AppColors.slate400),
                ),
              ],
            ),
          )
        else
          for (final box in redactions)
            _RedactionCard(box: box, onRemove: onRemove, onUpdate: onUpdate),
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _Notice({required this.icon, required this.text, this.iconColor = AppColors.primaryLight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.slate300, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _RedactionCard extends StatelessWidget {
  final RedactionBox box;
  final ValueChanged<String> onRemove;
  final ValueChanged<RedactionBox> onUpdate;

  const _RedactionCard({required this.box, required this.onRemove, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    int pct(double v) => (v * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 4, 4, 12),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.crop, size: 16, color: AppColors.primaryLight),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  localizedRedactionLabel(box.label, l10n),
                  style: text.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.danger),
                tooltip: l10n?.deleteSensorTooltip ?? 'Hapus Sensor',
                onPressed: () => onRemove(box.id),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(
                  l10n?.sensorTypeLabel ?? 'Tipe Sensor: ',
                  style: text.bodySmall?.copyWith(color: AppColors.slate400),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<RedactionType>(
                    value: box.type,
                    isExpanded: true,
                    dropdownColor: AppColors.bgCard,
                    style: text.bodyMedium?.copyWith(color: Colors.white),
                    items: [
                      for (final type in RedactionType.values)
                        DropdownMenuItem(value: type, child: Text(type.labelOf(l10n))),
                    ],
                    onChanged: (val) {
                      if (val != null) onUpdate(box.copyWith(type: val));
                    },
                  ),
                ),
              ],
            ),
          ),
          if (box.type != RedactionType.blackout) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _Notice(
                icon: Icons.warning_amber_rounded,
                iconColor: AppColors.warning,
                text: l10n?.redactionWeakWarning ??
                    'Buram dan mosaik pada teks kecil seperti NIK kadang bisa dipulihkan. Gunakan Blackout untuk NIK.',
              ),
            ),
          ],
          const SizedBox(height: 4),
          // Full-width sliders over the whole 0–100% range, so the thumb
          // sits exactly where the label says.
          _PercentSlider(
            label: l10n?.positionX(pct(box.left)) ?? 'Posisi X (${pct(box.left)}%)',
            value: box.left,
            onChanged: (v) => onUpdate(box.copyWith(left: v.clamp(0.0, 1.0 - box.width))),
          ),
          _PercentSlider(
            label: l10n?.positionY(pct(box.top)) ?? 'Posisi Y (${pct(box.top)}%)',
            value: box.top,
            onChanged: (v) => onUpdate(box.copyWith(top: v.clamp(0.0, 1.0 - box.height))),
          ),
          _PercentSlider(
            label: l10n?.redactionWidth(pct(box.width)) ?? 'Lebar (${pct(box.width)}%)',
            value: box.width,
            min: 0.05,
            onChanged: (v) => onUpdate(box.copyWith(width: v.clamp(0.05, 1.0 - box.left))),
          ),
          _PercentSlider(
            label: l10n?.redactionHeight(pct(box.height)) ?? 'Tinggi (${pct(box.height)}%)',
            value: box.height,
            min: 0.03,
            onChanged: (v) => onUpdate(box.copyWith(height: v.clamp(0.03, 1.0 - box.top))),
          ),
        ],
      ),
    );
  }
}

class _PercentSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final ValueChanged<double> onChanged;

  const _PercentSlider({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.slate300,
                  fontFeatures: AppNumeric.tabularFeatures,
                ),
          ),
          Slider(
            value: value.clamp(min, 1.0),
            min: min,
            max: 1.0,
            semanticFormatterCallback: (_) => label,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
