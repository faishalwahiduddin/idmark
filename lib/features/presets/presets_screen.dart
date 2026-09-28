import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/watermark_config.dart';
import '../../core/models/watermark_preset.dart';
import '../../core/providers/app_providers.dart';
import '../../core/utils/validators.dart';

class PresetsScreen extends ConsumerStatefulWidget {
  const PresetsScreen({super.key});

  @override
  ConsumerState<PresetsScreen> createState() => _PresetsScreenState();
}

class _PresetsScreenState extends ConsumerState<PresetsScreen> {
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'Preset Saya',
    'Perbankan',
    'Finansial & Pinjol',
    'Karir & HR',
    'Rental & Wisata',
    'Telekomunikasi',
    'Multifinance',
    'Investasi',
    'Layanan Publik',
    'Internasional',
  ];

  @override
  Widget build(BuildContext context) {
    final allPresets = ref.watch(allPresetsProvider);
    final activeConfig = ref.watch(watermarkConfigProvider);

    final filteredPresets = allPresets.where((p) {
      final matchesSearch = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.samplePurpose.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.category.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory = _selectedCategory == 'Semua' ||
          (_selectedCategory == 'Preset Saya' && p.isCustom) ||
          p.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Template & Preset Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 22, color: AppColors.primaryLight),
            tooltip: 'Buat Preset Baru',
            onPressed: () => _showCreatePresetDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bookmarks_outlined, color: AppColors.primaryLight, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Katalog Template Watermark Resmi',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Pilih template standar perbankan, lamaran kerja, atau buat preset kustom pribadi yang tersimpan di perangkat Anda.',
                        style: const TextStyle(fontSize: 12, color: Color(0xFFE2E8F0), height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari template (bank, pinjol, hrd, kpr, rental)...',
              prefixIcon: const Icon(Icons.search, size: 18),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 16),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              filled: true,
              fillColor: AppColors.bgSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 12),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppColors.primary.withValues(alpha: 0.25),
                    checkmarkColor: AppColors.primaryLight,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                      color: isSelected ? AppColors.primaryLight : const Color(0xFF94A3B8),
                    ),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Presets Count Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Menampilkan ${filteredPresets.length} template',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
              TextButton.icon(
                onPressed: () => _showCreatePresetDialog(context),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Buat Kustom', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Presets List
          if (filteredPresets.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Tidak ditemukan template yang cocok dengan filter.',
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                ),
              ),
            )
          else
            ...filteredPresets.map((preset) => _buildPresetCard(context, preset, activeConfig)),
        ],
      ),
    );
  }

  Widget _buildPresetCard(BuildContext context, WatermarkPreset preset, WatermarkConfig activeConfig) {
    final isCurrent = activeConfig.purpose == preset.samplePurpose;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        color: isCurrent ? AppColors.primary.withValues(alpha: 0.15) : AppColors.bgCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isCurrent ? AppColors.primaryLight : AppColors.border,
            width: isCurrent ? 1.5 : 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.bgSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(preset.icon, size: 20, color: AppColors.primaryLight),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                preset.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (preset.isCustom) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Kustom',
                                  style: TextStyle(fontSize: 10, color: AppColors.primaryLight, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          preset.category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (preset.isCustom)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                      tooltip: 'Hapus Preset Kustom',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _confirmDeletePreset(context, preset),
                    ),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Aktif',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  preset.samplePurpose,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: Color(0xFFE2E8F0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pola: ${preset.defaultPattern.label}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(watermarkConfigProvider.notifier).applyPreset(preset);
                      context.go('/');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Preset "${preset.title}" berhasil diterapkan!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check, size: 14),
                    label: const Text('Gunakan Preset'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreatePresetDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final catCtrl = TextEditingController(text: 'Kustom');
    final purposeCtrl = TextEditingController();
    final subtextCtrl = TextEditingController(text: 'HANYA UNTUK DOKUMEN INTERNAL');
    WatermarkPattern selectedPattern = WatermarkPattern.diagonalBand;
    WatermarkColorOption selectedColor = WatermarkColorOption.red;

    String? titleErr;
    String? purposeErr;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.bgSurface,
          title: const Row(
            children: [
              Icon(Icons.add_box_outlined, color: AppColors.primaryLight, size: 22),
              SizedBox(width: 8),
              Text('Buat Preset Kustom Baru', style: TextStyle(color: Colors.white, fontSize: 17)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nama Preset', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    hintText: 'Misal: Verifikasi Beasiswa Kemendikbud',
                    errorText: titleErr,
                  ),
                ),
                const SizedBox(height: 12),

                const Text('Kategori', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                TextField(
                  controller: catCtrl,
                  decoration: const InputDecoration(hintText: 'Misal: Pendidikan / Kustom'),
                ),
                const SizedBox(height: 12),

                const Text('Teks Template Tujuan', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                TextField(
                  controller: purposeCtrl,
                  decoration: InputDecoration(
                    hintText: 'Misal: PENGAJUAN BEASISWA 2026',
                    errorText: purposeErr,
                  ),
                ),
                const SizedBox(height: 12),

                const Text('Subtext Tambahan', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                TextField(
                  controller: subtextCtrl,
                  decoration: const InputDecoration(hintText: 'Catatan internal'),
                ),
                const SizedBox(height: 12),

                const Text('Pola Stempel', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                DropdownButton<WatermarkPattern>(
                  value: selectedPattern,
                  dropdownColor: AppColors.bgCard,
                  isExpanded: true,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  items: WatermarkPattern.values.map((p) {
                    return DropdownMenuItem(value: p, child: Text(p.label));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedPattern = val);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal', style: TextStyle(color: Color(0xFF94A3B8))),
            ),
            ElevatedButton(
              onPressed: () {
                final tErr = AppValidators.validatePresetTitle(titleCtrl.text);
                final pErr = AppValidators.validatePurpose(purposeCtrl.text);

                setDialogState(() {
                  titleErr = tErr;
                  purposeErr = pErr;
                });

                if (tErr == null && pErr == null) {
                  final newPreset = WatermarkPreset(
                    id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                    title: titleCtrl.text.trim(),
                    category: catCtrl.text.trim().isEmpty ? 'Kustom' : catCtrl.text.trim(),
                    samplePurpose: purposeCtrl.text.trim().toUpperCase(),
                    subtext: subtextCtrl.text.trim(),
                    icon: Icons.bookmark_border,
                    defaultPattern: selectedPattern,
                    defaultColor: selectedColor,
                    isCustom: true,
                  );

                  ref.read(customPresetsProvider.notifier).addPreset(newPreset);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preset kustom "${newPreset.title}" disimpan!')),
                  );
                }
              },
              child: const Text('Simpan Preset'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeletePreset(BuildContext context, WatermarkPreset preset) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgSurface,
        title: const Text('Hapus Preset?', style: TextStyle(color: Colors.white)),
        content: Text(
          'Preset "${preset.title}" akan dihapus dari daftar template lokal Anda.',
          style: const TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(customPresetsProvider.notifier).deletePreset(preset.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preset berhasil dihapus.')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
