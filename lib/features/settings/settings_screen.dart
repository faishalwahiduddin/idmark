import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privasi & Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Security Architecture Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.shield_outlined, color: AppColors.accent, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'Privasi Mutlak (Zero Server Upload)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'IDMark berjalan 100% di peramban atau perangkat lokal Anda. Foto identitas e-KTP tidak pernah dikirim, disimpan, atau diproses di peladen (server) eksternal manapun.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE2E8F0),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Pengaturan Bagian
          const Text(
            'Preferensi Lokal',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_sweep_outlined, color: AppColors.danger),
              title: const Text('Hapus Preferensi Tersimpan', style: TextStyle(fontSize: 14, color: Colors.white)),
              subtitle: const Text('Mengembalikan template dan pengaturan teks ke bawaan pabrik', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF64748B)),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.bgSurface,
                    title: const Text('Reset Preferensi?', style: TextStyle(color: Colors.white)),
                    content: const Text(
                      'Pengaturan watermark terakhir akan dikembalikan ke standar awal.',
                      style: TextStyle(color: Color(0xFF94A3B8)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Batal'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final storage = ref.read(localStorageServiceProvider);
                  await storage.clearConfig();
                  ref.read(watermarkConfigProvider.notifier).resetToDefault();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preferensi berhasil direset.')),
                    );
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 24),

          // Tentang Aplikasi
          const Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAboutRow('Aplikasi', AppConstants.appName),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Versi', '${AppConstants.appVersion}+1'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Domain', 'idmark.faishal.id'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Penyedia', 'Armada faishal.id'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAboutRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}
