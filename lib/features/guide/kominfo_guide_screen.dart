import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class KominfoGuideScreen extends StatelessWidget {
  const KominfoGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Resmi Kominfo'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0369A1), Color(0xFF0C4A6E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified_outlined, color: Colors.white, size: 24),
                    SizedBox(width: 10),
                    Text(
                      'Lindungi KTP Anda',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Kementerian Kominfo mengimbau masyarakat untuk selalu memberikan watermark pada hasil scan atau foto e-KTP sebelum mengunggahnya ke internet.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFE0F2FE),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 4 Aturan Pokok Kominfo
          const Text(
            '4 Aturan Watermark Menurut Kominfo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          _buildGuideRule(
            number: '1',
            title: 'Tuliskan Nama Lembaga & Tujuan Spesifik',
            description:
                'Jangan hanya menulis "VERIFIKASI". Tuliskan lengkap seperti "VERIFIKASI PINJAMAN PT BANK ABC". Dengan begitu, pihak lain tidak dapat menggunakan foto tersebut di tempat lain.',
            icon: Icons.edit_note,
          ),
          _buildGuideRule(
            number: '2',
            title: 'Cantumkan Tanggal Transaksi Lengkap',
            description:
                'Tambahkan tanggal saat Anda mengirimkan dokumen (misal: 28-09-2026). Ini membatasi masa berlaku dokumen salinan sehingga tidak dapat didaur ulang di masa mendatang.',
            icon: Icons.calendar_today,
          ),
          _buildGuideRule(
            number: '3',
            title: 'Posisikan Melintang di Atas Dokumen',
            description:
                'Letakkan watermark melintang di atas teks KTP secara semi-transparan. Jangan meletakkannya di area kosong di pinggir foto karena pelaku kejahatan bisa memotongnya (crop) dengan mudah.',
            icon: Icons.crop_free,
          ),
          _buildGuideRule(
            number: '4',
            title: 'Sensor Tanda Tangan Jika Tidak Diminta',
            description:
                'Tanda tangan basah adalah salah satu aset biometrik terpenting Anda. Jika verifikator hanya membutuhkan NIK dan nama, tutupi tanda tangan Anda untuk mencegah pemalsuan dokumen.',
            icon: Icons.draw_outlined,
          ),

          const SizedBox(height: 16),
          // Legal Context Card
          Card(
            color: AppColors.bgSurface,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.gavel_outlined, size: 18, color: AppColors.accent),
                      SizedBox(width: 8),
                      Text(
                        'UU Perlindungan Data Pribadi (UU PDP No. 27/2022)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Anda sebagai subjek data pribadi berhak menentukan batasan tujuan penggunaan data identitas Anda. Lembaga yang meminta foto identitas wajib mematuhi batasan tersebut dan bertanggung jawab atas keamanan data.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGuideRule({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
