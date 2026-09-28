// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Secure ID & Document Watermark';

  @override
  String get tabWatermark => 'Watermark';

  @override
  String get tabPreset => 'Preset';

  @override
  String get tabHistory => 'Riwayat';

  @override
  String get tabGuide => 'Panduan';

  @override
  String get tabSettings => 'Pengaturan';

  @override
  String get settings => 'Pengaturan';

  @override
  String get appearance => 'Tampilan';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get localeIndonesian => 'Bahasa Indonesia';

  @override
  String get localeEnglish => 'English';

  @override
  String get localeArabic => 'العربية';

  @override
  String get localeJavanese => 'Basa Jawa';

  @override
  String get localeSundanese => 'Basa Sunda';

  @override
  String get localeChinese => '中文';

  @override
  String get localeJapanese => '日本語';

  @override
  String get localeSpanish => 'Español';

  @override
  String get about => 'Tentang';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Edit';

  @override
  String get reset => 'Reset';

  @override
  String get kominfoGuide => 'Panduan Kominfo';

  @override
  String get history => 'Riwayat Audit Log';

  @override
  String get presets => 'Preset Kustom Pengguna';

  @override
  String get resetDefaults => 'Reset Pengaturan Bawaan';

  @override
  String get resetWarningTitle => 'Reset Preferensi?';

  @override
  String get resetWarningBody =>
      'Pengaturan watermark terakhir akan dikembalikan ke standar awal Kominfo.';

  @override
  String get aboutApp => 'Tentang Aplikasi';

  @override
  String get appVersion => 'Versi';

  @override
  String get appDomain => 'Domain';

  @override
  String get appCompliance => 'Standar Kepatuhan';

  @override
  String get appProvider => 'Penyedia';

  @override
  String get clearHistory => 'Bersihkan';

  @override
  String get historyCleared => 'Riwayat audit log dibersihkan.';

  @override
  String get preferencesReset =>
      'Preferensi berhasil direset ke rekomendasi Kominfo.';

  @override
  String get guideRules => '4 Aturan Pokok Watermark Kominfo';

  @override
  String get guideRule1Title => 'Tuliskan Nama Lembaga & Tujuan Spesifik';

  @override
  String get guideRule1Desc =>
      'Jangan hanya menulis \"VERIFIKASI\". Tuliskan lengkap seperti \"VERIFIKASI PINJAMAN PT BANK ABC\". Dengan begitu, pihak lain tidak dapat menggunakan foto tersebut di tempat lain.';

  @override
  String get guideRule2Title => 'Cantumkan Tanggal Transaksi Lengkap';

  @override
  String get guideRule2Desc =>
      'Tambahkan tanggal saat Anda mengirimkan dokumen (misal: 28-09-2026). Ini membatasi masa berlaku dokumen salinan sehingga tidak dapat didaur ulang di masa mendatang.';

  @override
  String get guideRule3Title => 'Posisikan Melintang di Atas Dokumen';

  @override
  String get guideRule3Desc =>
      'Letakkan watermark melintang di atas teks KTP secara semi-transparan. Jangan meletakkannya di area kosong di pinggir foto karena pelaku kejahatan bisa memotongnya (crop) dengan mudah.';

  @override
  String get guideRule4Title => 'Sensor Tanda Tangan & Digit Sensitif';

  @override
  String get guideRule4Desc =>
      'Tanda tangan basah adalah aset biometrik terpenting Anda. Jika verifikator hanya membutuhkan NIK dan nama, tutupi tanda tangan Anda untuk mencegah pemalsuan dokumen.';

  @override
  String get warningRejectTitle =>
      'Waspada: Pihak yang Menolak Foto Ber-Watermark';

  @override
  String get warningRejectDesc =>
      'Jika ada pihak atau aplikasi yang bersikeras meminta foto e-KTP polosan tanpa watermark padahal tujuan transaksi sudah jelas, Anda patut mencurigai niat pihak tersebut dan mempertimbangkan membatalkan transaksi.';

  @override
  String get verifiedOfficial => '★ RESMI DIVERIFIKASI ★';

  @override
  String get dateLabel => 'TGL';

  @override
  String get verifyIdentity => 'VERIFIKASI IDENTITAS';

  @override
  String get idmarkVerified => 'IDMARK VERIFIED';

  @override
  String get privacySettings => 'Pengaturan Privasi';

  @override
  String get autoStripExif => 'Otomatis hapus EXIF';

  @override
  String get autoStripExifDesc =>
      'Hapus metadata lokasi GPS dan kamera dari foto sebelum diekspor';

  @override
  String historySubtitle(int count) {
    return 'Tersimpan $count catatan ekspor on-device';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count template kustom tersimpan';
  }

  @override
  String get selectImageFirst => 'Pilih atau ambil foto KTP terlebih dahulu.';

  @override
  String checkConfigError(String error) {
    return 'Periksa konfigurasi: $error';
  }

  @override
  String get watermarkDone => 'Watermark Selesai!';

  @override
  String get watermarkDoneDesc =>
      'Dokumen e-KTP Anda telah berhasil diproteksi dengan watermark resolusi penuh dan sensor permanen secara 100% on-device.';

  @override
  String get hashCopied => 'Hash integritas disalin ke clipboard!';

  @override
  String get close => 'Tutup';

  @override
  String get share => 'Bagikan';

  @override
  String get resetWatermarkTooltip => 'Reset Watermark';

  @override
  String get configResetKominfo =>
      'Konfigurasi dikembalikan ke standar rekomendasi Kominfo.';

  @override
  String get bannerUuPdp =>
      'Standar UU PDP: Bubuhkan watermark tujuan spesifik, tanggal, dan sensor data sensitif sebelum membagikan foto e-KTP.';

  @override
  String sensorBoxAdded(String label) {
    return 'Kotak sensor \"$label\" ditambahkan.';
  }

  @override
  String get processingOnDevice => 'Memproses Dokumen On-Device...';

  @override
  String saveDocument(String format) {
    return 'Simpan Dokumen ($format)';
  }

  @override
  String get shareDirect => 'Bagikan Langsung';

  @override
  String failedToExport(String error) {
    return 'Gagal mengekspor dokumen: $error';
  }

  @override
  String shareSubject(String purpose) {
    return 'Dokumen Identitas Ter-Watermark - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'Dokumen identitas ter-watermark aman via IDMark ($purpose) • 100% on-device';
  }

  @override
  String get watermarkConfigTitle => 'Konfigurasi Watermark';

  @override
  String get sensorMaskTab => 'Sensor / Mask';

  @override
  String get privacyExifTab => 'Privasi & EXIF';

  @override
  String get exportFormatTab => 'Format Ekspor';

  @override
  String get watermarkPurposeLabel => 'Tujuan Watermark (Sesuai Kebutuhan)';

  @override
  String get watermarkPurposeHint => 'Misal: VERIFIKASI PINJAMAN BANK ABC';

  @override
  String get transactionDate => 'Tanggal Transaksi';

  @override
  String get includeDateChip => 'Cantumkan Tgl';

  @override
  String get subtextLabel => 'Catatan Tambahan / Subtext (Opsional)';

  @override
  String get subtextHint => 'Misal: HANYA UNTUK KELENGKAPAN BERKAS INTERNAL';

  @override
  String get patternLabel => 'Pola Stempel Watermark (7 Gaya)';

  @override
  String get colorLabel => 'Warna Cap Watermark';

  @override
  String get opacityLevel => 'Tingkat Opasitas (Transparansi)';

  @override
  String get watermarkFontSize => 'Ukuran Teks Watermark';

  @override
  String get rotationAngle => 'Kemiringan Sudut';

  @override
  String get redactionIntro =>
      'Tutup bagian data vital seperti tanda tangan atau digit NIK yang tidak relevan dengan transaksi untuk meminimalkan risiko pencurian identitas.';

  @override
  String get quickSensorLabel => 'Tambah Sensor Cepat:';

  @override
  String get sensorNik => 'Sensor NIK';

  @override
  String get sensorSignature => 'Sensor Tanda Tangan';

  @override
  String get sensorAddress => 'Sensor Alamat';

  @override
  String get sensorBirthDate => 'Sensor Tgl Lahir';

  @override
  String get customArea => 'Area Kustom';

  @override
  String get noRedactionsYet => 'Belum ada area yang disensor.';

  @override
  String get deleteSensorTooltip => 'Hapus Sensor';

  @override
  String get sensorTypeLabel => 'Tipe Sensor:';

  @override
  String positionX(int percent) {
    return 'Posisi X ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'Posisi Y ($percent%)';
  }

  @override
  String get privacyComplianceIndex => 'Indeks Kepatuhan Privasi Dokumen';

  @override
  String get complianceChecklistTitle =>
      'Checklist Kepatuhan UU PDP No. 27/2022:';

  @override
  String get checkPurposeTitle => 'Tujuan Penggunaan Spesifik';

  @override
  String get checkPurposeDesc =>
      'Membatasi agar salinan tidak bisa dialihkan ke transaksi lain';

  @override
  String get checkDateTitle => 'Tanggal Transaksi Dicantumkan';

  @override
  String get checkDateDesc =>
      'Membatasi masa kedaluwarsa dokumen agar tidak disalahgunakan di masa depan';

  @override
  String get checkExifTitle => 'Sanitasi Metadata EXIF & GPS';

  @override
  String get checkExifDesc =>
      'Menghilangkan lokasi geografis koordinat rumah dari file foto';

  @override
  String get checkSensorTitle => 'Sensor Bagian Vital (NIK / Tanda Tangan)';

  @override
  String get checkSensorDesc =>
      'Menyembunyikan informasi yang tidak diwajibkan oleh penerima';

  @override
  String get autoSanitizeExifTitle => 'Sanitasi Metadata EXIF Otomatis';

  @override
  String get autoSanitizeExifDesc =>
      'Menghapus tag metadata kamera, model HP, dan koordinat GPS secara otomatis saat ekspor';

  @override
  String get chooseExportFormat => 'Pilih Format Dokumen Keluaran:';

  @override
  String get jpegCompressionQuality => 'Kualitas Kompresi JPEG';

  @override
  String protectionGrade(String grade, int score) {
    return 'Proteksi $grade ($score%)';
  }

  @override
  String get viewingOriginal => 'Melihat Asli';

  @override
  String get holdToCompare => 'Tahan: Bandingkan';

  @override
  String activeWatermarkWithCount(int count) {
    return 'Watermark Aktif ($count sensor)';
  }

  @override
  String get activeWatermarkPreview => 'Pratinjau Watermark Aktif';

  @override
  String get changePhoto => 'Ganti Foto';

  @override
  String get deleteImage => 'Hapus Gambar';

  @override
  String get uploadIdPhoto => 'Unggah Foto e-KTP / Identitas';

  @override
  String get uploadIdPhotoDesc =>
      'Pilih foto e-KTP, SIM, atau Paspor untuk menambahkan stempel tujuan, tanggal, dan sensor data vital.';

  @override
  String get onDeviceBadge =>
      '100% On-Device • Gambar tidak pernah dikirim ke server';

  @override
  String get openGallery => 'Buka Galeri';

  @override
  String get takePhoto => 'Ambil Foto';

  @override
  String get historyAndAuditLog => 'Riwayat & Audit Log';

  @override
  String get clearAllHistoryTooltip => 'Hapus Semua Riwayat';

  @override
  String get localPrivacyAuditLog => 'Audit Log Privasi Lokal';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return 'Total $count dokumen telah distempel dengan aman secara 100% on-device. Rekaman ini hanya tersimpan di perangkat Anda.';
  }

  @override
  String get searchHistoryHint => 'Cari riwayat tujuan dokumen...';

  @override
  String get noWatermarkedDocsYet => 'Belum Ada Dokumen Ter-Watermark';

  @override
  String get noWatermarkedDocsDesc =>
      'Dokumen yang berhasil Anda beri watermark dan ekspor akan dicatat audit log-nya di sini.';

  @override
  String get noHistoryFound =>
      'Tidak ditemukan riwayat yang sesuai dengan pencarian.';

  @override
  String scoreLabel(int score) {
    return 'Skor $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count Sensor Sensitif';
  }

  @override
  String get exifSanitized => 'EXIF Sanitized';

  @override
  String get sha256Copied => 'Hash SHA-256 disalin ke clipboard!';

  @override
  String get clearHistoryConfirmTitle => 'Hapus Seluruh Riwayat?';

  @override
  String get clearHistoryConfirmBody =>
      'Daftar audit log di perangkat Anda akan dibersihkan permanen.';

  @override
  String get historyClearedSuccess => 'Riwayat berhasil dibersihkan.';

  @override
  String get templatePresetHub => 'Template & Preset Hub';

  @override
  String get createPresetTooltip => 'Buat Preset Baru';

  @override
  String get officialTemplateCatalog => 'Katalog Template Watermark Resmi';

  @override
  String get officialTemplateDesc =>
      'Pilih template standar perbankan, lamaran kerja, atau buat preset kustom pribadi yang tersimpan di perangkat Anda.';

  @override
  String get searchTemplateHint =>
      'Cari template (bank, pinjol, hrd, kpr, rental)...';

  @override
  String showingTemplatesCount(int count) {
    return 'Menampilkan $count template';
  }

  @override
  String get createCustom => 'Buat Kustom';

  @override
  String get noTemplatesFound =>
      'Tidak ditemukan template yang cocok dengan filter.';

  @override
  String get customBadge => 'Kustom';

  @override
  String get deleteCustomPresetTooltip => 'Hapus Preset Kustom';

  @override
  String get activeBadge => 'Aktif';

  @override
  String patternInfo(String pattern) {
    return 'Pola: $pattern';
  }

  @override
  String get usePreset => 'Gunakan Preset';

  @override
  String presetApplied(String title) {
    return 'Preset \"$title\" berhasil diterapkan!';
  }

  @override
  String get createNewCustomPreset => 'Buat Preset Kustom Baru';

  @override
  String get presetName => 'Nama Preset';

  @override
  String get presetNameHint => 'Misal: Verifikasi Beasiswa Kemendikbud';

  @override
  String get category => 'Kategori';

  @override
  String get categoryHint => 'Misal: Pendidikan / Kustom';

  @override
  String get purposeTemplateText => 'Teks Template Tujuan';

  @override
  String get purposeTemplateHint => 'Misal: PENGAJUAN BEASISWA 2026';

  @override
  String get additionalSubtext => 'Subtext Tambahan';

  @override
  String get subtextTemplateHint => 'Catatan internal';

  @override
  String get stampPattern => 'Pola Stempel';

  @override
  String get savePreset => 'Simpan Preset';

  @override
  String customPresetSaved(String title) {
    return 'Preset kustom \"$title\" disimpan!';
  }

  @override
  String get deletePresetConfirmTitle => 'Hapus Preset?';

  @override
  String deletePresetConfirmBody(String title) {
    return 'Preset \"$title\" akan dihapus dari daftar template lokal Anda.';
  }

  @override
  String get presetDeletedSuccess => 'Preset berhasil dihapus.';

  @override
  String get protectDigitalId => 'Lindungi Identitas Digital Anda';

  @override
  String get protectDigitalIdDesc =>
      'Kementerian Kominfo dan UU No. 27/2022 (PDP) mewajibkan masyarakat berhati-hati saat membagikan foto e-KTP agar tidak dijadikan jaminan pinjaman online bodong atau pembukaan rekening fiktif.';

  @override
  String get safeSharingChecklist => 'Checklist Aman Sebelum Kirim e-KTP';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 Selesai';
  }

  @override
  String get checkItem1 =>
      'Nama instansi/penerima tertulis jelas pada watermark';

  @override
  String get checkItem2 => 'Tanggal transaksi terkini dicantumkan pada cap';

  @override
  String get checkItem3 =>
      'Watermark melintang di atas data teks agar tidak bisa dicrop';

  @override
  String get checkItem4 =>
      'Tanda tangan disensor jika verifikator tidak meminta spesimen tanda tangan';

  @override
  String get checkItem5 =>
      'Metadata EXIF dan koordinat GPS telah dihapus dari gambar';

  @override
  String get zeroServerTitle => 'Privasi Mutlak (Zero Server Upload)';

  @override
  String get zeroServerDesc =>
      'IDMark berjalan 100% di peramban atau perangkat lokal Anda. Foto identitas e-KTP tidak pernah dikirim, disimpan, atau diproses di peladen (server) eksternal manapun.';

  @override
  String get dataSecuritySanitation => 'Sanitasi & Keamanan Data';

  @override
  String get autoExifSubtitle =>
      'Menghapus tag metadata koordinat GPS dan tipe kamera dari foto hasil ekspor';

  @override
  String get defaultExportFormat => 'Format Ekspor Default';

  @override
  String get localDeviceStorage => 'Penyimpanan Lokal Perangkat';

  @override
  String get resetDefaultsDesc =>
      'Mengembalikan template dan pengaturan teks ke bawaan pabrik';

  @override
  String get appLabel => 'Aplikasi';
}
