// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Javanese (`jv`).
class AppLocalizationsJv extends AppLocalizations {
  AppLocalizationsJv([String locale = 'jv']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Watermark KTP Aman';

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
  String get themeLight => 'Padhang';

  @override
  String get themeDark => 'Peteng';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get language => 'Basa';

  @override
  String get selectLanguage => 'Pilih Basa';

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
  String get about => 'Babagan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpen';

  @override
  String get delete => 'Busak';

  @override
  String get edit => 'Ubah';

  @override
  String get reset => 'Reset';

  @override
  String get kominfoGuide => 'Panduan Kominfo';

  @override
  String get history => 'Riwayat Log';

  @override
  String get presets => 'Preset Pangguna';

  @override
  String get resetDefaults => 'Reset menyang Gawan';

  @override
  String get resetWarningTitle => 'Reset Pengaturan?';

  @override
  String get resetWarningBody =>
      'Pengaturan watermark bakal dibalekake menyang gawan.';

  @override
  String get aboutApp => 'Babagan Aplikasi';

  @override
  String get appVersion => 'Versi';

  @override
  String get appDomain => 'Domain';

  @override
  String get appCompliance => 'Standar Kepatuhan';

  @override
  String get appProvider => 'Penyedia';

  @override
  String get clearHistory => 'Bersihake';

  @override
  String get historyCleared => 'Riwayat wis dibersihake.';

  @override
  String get preferencesReset => 'Pengaturan wis direset.';

  @override
  String get guideRules => '4 Aturan Pokok Watermark';

  @override
  String get guideRule1Title => 'Tulis Jeneng & Tujuan';

  @override
  String get guideRule1Desc =>
      'Aja mung nulis \"VERIFIKASI\". Tulis lengkap supaya ora disalahgunakake.';

  @override
  String get guideRule2Title => 'Lebokake Tanggal';

  @override
  String get guideRule2Desc => 'Tambahake tanggal kanggo matesi masa berlaku.';

  @override
  String get guideRule3Title => 'Posisi Miring';

  @override
  String get guideRule3Desc => 'Selehake watermark miring ing ndhuwur teks.';

  @override
  String get guideRule4Title => 'Tutup Tanda Tangan';

  @override
  String get guideRule4Desc =>
      'Tutup tanda tangan sampeyan kanggo nyegah pemalsuan.';

  @override
  String get warningRejectTitle => 'Ati-ati sing Nolak Watermark';

  @override
  String get warningRejectDesc =>
      'Curiga marang sing njaluk KTP tanpa watermark.';

  @override
  String get verifiedOfficial => '★ DIVERIFIKASI RESMI ★';

  @override
  String get dateLabel => 'TGL';

  @override
  String get verifyIdentity => 'VERIFIKASI IDENTITAS';

  @override
  String get idmarkVerified => 'IDMARK VERIFIED';

  @override
  String get privacySettings => 'Privasi';

  @override
  String get autoStripExif => 'Busak EXIF';

  @override
  String get autoStripExifDesc => 'Busak data lokasi GPS';

  @override
  String historySubtitle(int count) {
    return 'Kesimpen $count cathetan';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count template kesimpen';
  }

  @override
  String get selectImageFirst => 'Pilih utawa jupuk foto KTP dhisik.';

  @override
  String checkConfigError(String error) {
    return 'Priksa konfigurasi: $error';
  }

  @override
  String get watermarkDone => 'Watermark Rampung!';

  @override
  String get watermarkDoneDesc =>
      'Dokumen KTP panjenengan wis kasil dilindhungi nganggo watermark resolusi kebak lan sensor permanen 100% ing piranti.';

  @override
  String get hashCopied => 'Hash integritas kasalin ing clipboard!';

  @override
  String get close => 'Tutup';

  @override
  String get share => 'Bagekake';

  @override
  String get resetWatermarkTooltip => 'Reset Watermark';

  @override
  String get configResetKominfo =>
      'Konfigurasi dibalekake menyang standar rekomendasi Kominfo.';

  @override
  String get bannerUuPdp =>
      'Standar UU PDP: Wenehi watermark tujuan tartamtu, tanggal, lan sensor data sensitif sadurunge nuduhake foto KTP.';

  @override
  String sensorBoxAdded(String label) {
    return 'Kothak sensor \"$label\" ditambahi.';
  }

  @override
  String get processingOnDevice => 'Mroses Dokumen Ing Piranti...';

  @override
  String saveDocument(String format) {
    return 'Simpen Dokumen ($format)';
  }

  @override
  String get shareDirect => 'Bagekake Langsung';

  @override
  String failedToExport(String error) {
    return 'Gagal ngèkspor dokumen: $error';
  }

  @override
  String shareSubject(String purpose) {
    return 'Dokumen Idhèntitas Kanthi Watermark - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'Dokumen idhèntitas mawa watermark aman liwat IDMark ($purpose) • 100% ing piranti';
  }

  @override
  String get watermarkConfigTitle => 'Konfigurasi Watermark';

  @override
  String get sensorMaskTab => 'Sensor / Topeng';

  @override
  String get privacyExifTab => 'Privasi & EXIF';

  @override
  String get exportFormatTab => 'Format Ekspor';

  @override
  String get watermarkPurposeLabel => 'Tujuan Watermark (Miturut Kabutuhan)';

  @override
  String get watermarkPurposeHint => 'Tuladha: VERIFIKASI PINJAMAN BANK ABC';

  @override
  String get transactionDate => 'Tanggal Transaksi';

  @override
  String get includeDateChip => 'Lebokake Tgl';

  @override
  String get subtextLabel => 'Cathetan Tambahan / Subteks (Opsional)';

  @override
  String get subtextHint => 'Tuladha: MUNG KANGGO DOKUMEN INTERNAL';

  @override
  String get patternLabel => 'Pola Cap Watermark (7 Gaya)';

  @override
  String get colorLabel => 'Werna Cap Watermark';

  @override
  String get opacityLevel => 'Tingkat Opasitas (Transparansi)';

  @override
  String get watermarkFontSize => 'Ukuran Teks Watermark';

  @override
  String get rotationAngle => 'Sudut Miring';

  @override
  String get redactionIntro =>
      'Tutup bagean data vital kaya tandha tangan utawa nomer KTP sing ora relevan kanggo nyuda risiko nyolong identitas.';

  @override
  String get quickSensorLabel => 'Tambah Sensor Cepet:';

  @override
  String get sensorNik => 'Sensor NIK';

  @override
  String get sensorSignature => 'Sensor Tandha Tangan';

  @override
  String get sensorAddress => 'Sensor Alamat';

  @override
  String get sensorBirthDate => 'Sensor Tgl Lair';

  @override
  String get customArea => 'Area Kustom';

  @override
  String get noRedactionsYet => 'Durung ana area sing disensor.';

  @override
  String get deleteSensorTooltip => 'Busak Sensor';

  @override
  String get sensorTypeLabel => 'Jinis Sensor:';

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
  String get checkPurposeTitle => 'Tujuan Panggunan Spesifik';

  @override
  String get checkPurposeDesc =>
      'Matesi supaya salinan ora bisa dialihake menyang transaksi liyane';

  @override
  String get checkDateTitle => 'Tanggal Transaksi Dilebokake';

  @override
  String get checkDateDesc =>
      'Matesi wektu kadaluwarsa supaya ora disalah gunakake ing mangsa ngarep';

  @override
  String get checkExifTitle => 'Sanitasi Metadata EXIF & GPS';

  @override
  String get checkExifDesc => 'Mbusak lokasi koordinat omah saka berkas foto';

  @override
  String get checkSensorTitle => 'Sensor Bagean Vital (NIK / Tandha Tangan)';

  @override
  String get checkSensorDesc =>
      'Ndelikake informasi sing ora dibutuhake dening panampa';

  @override
  String get autoSanitizeExifTitle => 'Sanitasi Metadata EXIF Otomatis';

  @override
  String get autoSanitizeExifDesc =>
      'Mbusak tag metadata kamera, tipe HP, lan koordinat GPS kanthi otomatis nalika ekspor';

  @override
  String get chooseExportFormat => 'Pilih Format Dokumen Asil:';

  @override
  String get jpegCompressionQuality => 'Kualitas Kompresi JPEG';

  @override
  String protectionGrade(String grade, int score) {
    return 'Proteksi $grade ($score%)';
  }

  @override
  String get viewingOriginal => 'Ndeleng Asli';

  @override
  String get holdToCompare => 'Tahan: Bandingake';

  @override
  String activeWatermarkWithCount(int count) {
    return 'Watermark Aktif ($count sensor)';
  }

  @override
  String get activeWatermarkPreview => 'Pratinjau Watermark Aktif';

  @override
  String get changePhoto => 'Ganti Foto';

  @override
  String get deleteImage => 'Busak Gambar';

  @override
  String get uploadIdPhoto => 'Unggah Foto KTP / Idhèntitas';

  @override
  String get uploadIdPhotoDesc =>
      'Pilih foto KTP, SIM, utawa Paspor kanggo nambahake cap tujuan, tanggal, lan sensor data wigati.';

  @override
  String get onDeviceBadge =>
      '100% Ing Piranti • Gambar ora tau dikirim menyang server';

  @override
  String get openGallery => 'Bukak Galeri';

  @override
  String get takePhoto => 'Jupuk Foto';

  @override
  String get historyAndAuditLog => 'Riwayat & Audit Log';

  @override
  String get clearAllHistoryTooltip => 'Busak Kabeh Riwayat';

  @override
  String get localPrivacyAuditLog => 'Audit Log Privasi Lokal';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return 'Gunggung $count dokumen wis dicap kanthi aman 100% ing piranti. Cathetan iki mung disimpen ing piranti sampeyan.';
  }

  @override
  String get searchHistoryHint => 'Goleki riwayat tujuan dokumen...';

  @override
  String get noWatermarkedDocsYet => 'Durung Ana Dokumen Mawa Watermark';

  @override
  String get noWatermarkedDocsDesc =>
      'Dokumen sing kasil panjenengan wenehi watermark lan ekspor bakal dicathet log audit-e ing kene.';

  @override
  String get noHistoryFound =>
      'Ora ditemokake riwayat sing cocog karo padosan.';

  @override
  String scoreLabel(int score) {
    return 'Skor $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count Sensor Sensitif';
  }

  @override
  String get exifSanitized => 'EXIF Diresiki';

  @override
  String get sha256Copied => 'Hash SHA-256 kasalin ing clipboard!';

  @override
  String get clearHistoryConfirmTitle => 'Busak Kabeh Riwayat?';

  @override
  String get clearHistoryConfirmBody =>
      'Daftar audit log ing piranti sampeyan bakal dibusak permanen.';

  @override
  String get historyClearedSuccess => 'Riwayat kasil dibusak.';

  @override
  String get templatePresetHub => 'Hub Cithakan & Preset';

  @override
  String get createPresetTooltip => 'Gawe Preset Anyar';

  @override
  String get officialTemplateCatalog => 'Katalog Cithakan Watermark Resmi';

  @override
  String get officialTemplateDesc =>
      'Pilih cithakan standar perbankan, lamaran kerja, utawa gawe preset kustom pribadi sing disimpen ing piranti sampeyan.';

  @override
  String get searchTemplateHint =>
      'Goleki cithakan (bank, pinjol, hrd, kpr, rental)...';

  @override
  String showingTemplatesCount(int count) {
    return 'Nampilake $count cithakan';
  }

  @override
  String get createCustom => 'Gawe Kustom';

  @override
  String get noTemplatesFound =>
      'Ora ditemokake cithakan sing cocog karo panyaring.';

  @override
  String get customBadge => 'Kustom';

  @override
  String get deleteCustomPresetTooltip => 'Busak Preset Kustom';

  @override
  String get activeBadge => 'Aktif';

  @override
  String patternInfo(String pattern) {
    return 'Pola: $pattern';
  }

  @override
  String get usePreset => 'Gunakake Preset';

  @override
  String presetApplied(String title) {
    return 'Preset \"$title\" kasil ditrapake!';
  }

  @override
  String get createNewCustomPreset => 'Gawe Preset Kustom Anyar';

  @override
  String get presetName => 'Jeneng Preset';

  @override
  String get presetNameHint => 'Tuladha: Verifikasi Beasiswa Kemendikbud';

  @override
  String get category => 'Kategori';

  @override
  String get categoryHint => 'Tuladha: Pendhidhikan / Kustom';

  @override
  String get purposeTemplateText => 'Teks Cithakan Tujuan';

  @override
  String get purposeTemplateHint => 'Tuladha: PENGAJUAN BEASISWA 2026';

  @override
  String get additionalSubtext => 'Subteks Tambahan';

  @override
  String get subtextTemplateHint => 'Cathetan internal';

  @override
  String get stampPattern => 'Pola Cap';

  @override
  String get savePreset => 'Simpen Preset';

  @override
  String customPresetSaved(String title) {
    return 'Preset kustom \"$title\" kasimpen!';
  }

  @override
  String get deletePresetConfirmTitle => 'Busak Preset?';

  @override
  String deletePresetConfirmBody(String title) {
    return 'Preset \"$title\" bakal dibusak saka dhaptar cithakan lokal panjenengan.';
  }

  @override
  String get presetDeletedSuccess => 'Preset kasil dibusak.';

  @override
  String get protectDigitalId => 'Lindhungi Idhèntitas Digital Sampeyan';

  @override
  String get protectDigitalIdDesc =>
      'Kementerian Kominfo lan UU No. 27/2022 (PDP) ngwajibake masyarakat luwih ngati-ati nalika nuduhake foto KTP supaya ora digunakake kanggo jaminan pinjol ilegal utawa rekening fiktif.';

  @override
  String get safeSharingChecklist => 'Checklist Aman Sadurunge Kirim KTP';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 Rampung';
  }

  @override
  String get checkItem1 =>
      'Jeneng instansi/panampa tinulis kanthi cetha ing watermark';

  @override
  String get checkItem2 => 'Tanggal transaksi paling anyar dilebokake ing cap';

  @override
  String get checkItem3 =>
      'Watermark malang ing sadhuwure teks supaya ora bisa dipotong';

  @override
  String get checkItem4 =>
      'Tandha tangan disensor yen verifikator ora njaluk spesimen tandha tangan';

  @override
  String get checkItem5 =>
      'Metadata EXIF lan koordinat GPS wis dibusak saka gambar';

  @override
  String get zeroServerTitle => 'Privasi Mutlak (Zero Server Upload)';

  @override
  String get zeroServerDesc =>
      'IDMark mlaku 100% ing browser utawa piranti lokal sampeyan. Foto KTP ora tau dikirim, disimpen, utawa diproses ing server eksternal endi wae.';

  @override
  String get dataSecuritySanitation => 'Sanitasi & Keamanan Data';

  @override
  String get autoExifSubtitle =>
      'Mbusak tag metadata koordinat GPS lan model kamera saka foto asil ekspor';

  @override
  String get defaultExportFormat => 'Format Ekspor Standar';

  @override
  String get localDeviceStorage => 'Panyimpenan Lokal Piranti';

  @override
  String get resetDefaultsDesc =>
      'Mbalekake cithakan lan setelan teks menyang standar pabrik';

  @override
  String get appLabel => 'Aplikasi';

  @override
  String get officialKominfoGuide => 'Panduan Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Pengaturan';

  @override
  String get appLanguage => 'Basa Aplikasi';

  @override
  String get timezone => 'Zona Waktu';

  @override
  String get timezoneAuto => 'Otomatis (ikut perangkat)';
}
