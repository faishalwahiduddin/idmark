import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class KominfoGuideScreen extends StatefulWidget {
  const KominfoGuideScreen({super.key});

  @override
  State<KominfoGuideScreen> createState() => _KominfoGuideScreenState();
}

class _KominfoGuideScreenState extends State<KominfoGuideScreen> {
  final Map<int, bool> _checklistStates = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
  };

  @override
  Widget build(BuildContext context) {
    final checkedCount = _checklistStates.values.where((v) => v).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Resmi Kominfo & UU PDP'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      'Lindungi Identitas Digital Anda',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Kementerian Kominfo dan UU No. 27/2022 (PDP) mewajibkan masyarakat berhati-hati saat membagikan foto e-KTP agar tidak dijadikan jaminan pinjaman online bodong atau pembukaan rekening fiktif.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE0F2FE),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Interactive Safe-Sharing Checklist
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Checklist Aman Sebelum Kirim e-KTP',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: checkedCount == 5
                            ? AppColors.accent.withValues(alpha: 0.2)
                            : AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$checkedCount / 5 Selesai',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: checkedCount == 5 ? AppColors.accent : AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildChecklistItem(0, 'Nama instansi/penerima tertulis jelas pada watermark'),
                _buildChecklistItem(1, 'Tanggal transaksi terkini dicantumkan pada cap'),
                _buildChecklistItem(2, 'Watermark melintang di atas data teks agar tidak bisa dicrop'),
                _buildChecklistItem(3, 'Tanda tangan disensor jika verifikator tidak meminta spesimen tanda tangan'),
                _buildChecklistItem(4, 'Metadata EXIF dan koordinat GPS telah dihapus dari gambar'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 4 Aturan Pokok Kominfo
          const Text(
            '4 Aturan Pokok Watermark Kominfo',
            style: TextStyle(
              fontSize: 15,
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
            title: 'Sensor Tanda Tangan & Digit Sensitif',
            description:
                'Tanda tangan basah adalah aset biometrik terpenting Anda. Jika verifikator hanya membutuhkan NIK dan nama, tutupi tanda tangan Anda untuk mencegah pemalsuan dokumen.',
            icon: Icons.draw_outlined,
          ),
          const SizedBox(height: 16),

          // Peringatan jika Penerima Menolak Watermark
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.danger.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waspada: Pihak yang Menolak Foto Ber-Watermark',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Jika ada pihak atau aplikasi yang bersikeras meminta foto e-KTP polosan tanpa watermark padahal tujuan transaksi sudah jelas, Anda patut mencurigai niat pihak tersebut dan mempertimbangkan membatalkan transaksi.',
                        style: TextStyle(fontSize: 11, color: Color(0xFFFCA5A5), height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(int index, String text) {
    final isChecked = _checklistStates[index] ?? false;
    return InkWell(
      onTap: () {
        setState(() {
          _checklistStates[index] = !isChecked;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
              color: isChecked ? AppColors.accent : const Color(0xFF64748B),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: isChecked ? Colors.white : const Color(0xFF94A3B8),
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
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
