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
  String get tabWatermark => 'Tandha Banyu';

  @override
  String get tabPreset => 'Cithakan';

  @override
  String get tabHistory => 'Riwayat';

  @override
  String get tabGuide => 'Panduan';

  @override
  String get tabSettings => 'Pangaturan';

  @override
  String get settings => 'Pangaturan';

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
  String get localeIndonesian => 'Basa Indonésia';

  @override
  String get localeEnglish => 'Basa Inggris';

  @override
  String get localeArabic => 'Basa Arab';

  @override
  String get localeJavanese => 'Basa Jawa';

  @override
  String get localeSundanese => 'Basa Sunda';

  @override
  String get localeChinese => 'Basa Cina';

  @override
  String get localeJapanese => 'Basa Jepang';

  @override
  String get localeSpanish => 'Basa Spanyol';

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
  String get reset => 'Balèni';

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
  String get appDomain => 'Domén';

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
  String get idmarkVerified => 'IDMARK KAVERIFIKASI';

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
  String get resetWatermarkTooltip => 'Balèni Watermark';

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
  String get dataSecuritySanitation => 'Reresik & Keamanan Data';

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
  String get officialKominfoGuide => 'Pandhuan Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Pangaturan';

  @override
  String get appLanguage => 'Basa Aplikasi';

  @override
  String get timezone => 'Zona Wektu';

  @override
  String get timezoneAuto => 'Otomatis (miturut piranti)';

  @override
  String get licenseUsageTitle => 'Lisensi Panganggo';

  @override
  String get licenseUsageNotice =>
      'Bebas dienggo kanggo kaperluan pribadi lan non-profit.';

  @override
  String get licenseUsageBadgeText => 'Pribadi & Non-Profit';

  @override
  String get validationPurposeRequired => 'Tujuan watermark ora kena kothong';

  @override
  String get validationPurposeMinLength => 'Tujuan minimal 3 karakter';

  @override
  String get validationPurposeMaxLength => 'Tujuan maksimal 60 karakter';

  @override
  String get validationSubtextMaxLength =>
      'Cathetan tambahan maksimal 80 karakter';

  @override
  String get validationOpacityRange =>
      'Opasitas kudu ana ing antarane 10% lan 100%';

  @override
  String get validationFontSizeRange => 'Ukuran teks kudu antara 10 lan 60 pt';

  @override
  String get validationRotationRange =>
      'Sudut rotasi kudu antara -90° lan +90°';

  @override
  String get validationImageBytesEmpty => 'Berkas gambar kothong utawa rusak';

  @override
  String get validationImageBytesTooLarge =>
      'Ukuran gambar ngluwihi wates maksimal';

  @override
  String get validationQualityRange =>
      'Kualitas gambar kudu antara 10% lan 100%';

  @override
  String get validationPresetTitleRequired => 'Jeneng preset ora kena kothong';

  @override
  String get validationPresetTitleMinLength =>
      'Jeneng preset minimal 3 karakter';

  @override
  String get validationPresetTitleMaxLength =>
      'Jeneng preset maksimal 50 karakter';

  @override
  String get validationPresetCategoryRequired =>
      'Kategori preset ora kena kothong';

  @override
  String get validationPresetCategoryMaxLength =>
      'Kategori maksimal 30 karakter';

  @override
  String get privacyGradeDescMax =>
      'Proteksi Maksimal • Trep karo rekomendasi UU PDP';

  @override
  String get privacyGradeDescVeryGood =>
      'Proteksi Apik Banget • Dokumen aman dienggo bareng';

  @override
  String get privacyGradeDescFair =>
      'Proteksi Cukup • Disaranake nambah tanggal lan sensor NIK';

  @override
  String get privacyGradeDescWeak =>
      'Proteksi Lemah • Tambahna tujuan spesifik lan tanggal';

  @override
  String get appTitle => 'IDMark';

  @override
  String get appTagline =>
      'Cap watermark teks ing foto KTP, SIM lan dokumen penting.';

  @override
  String get appSubtitle => 'Pelindung Identitas & Privasi';

  @override
  String get onbSkip => 'Liwati';

  @override
  String get onbNext => 'Terus';

  @override
  String get onbGetStarted => 'Wiwiti Saiki';

  @override
  String get onbPrivacyHeadline => 'Privasi & Offline Kajaga';

  @override
  String get onbPrivacyDetail =>
      'Kabeh data kasimpen aman ing piranti panjenengan tanpa pelacak.';

  @override
  String get onbSlide1Title => 'Cap identitas';

  @override
  String get onbSlide1Sub => 'Tujuan & tanggal ing dokumen';

  @override
  String get onbSlide1Badge => '100% Offline & Pribadi';

  @override
  String get onbSlide2Title => 'Cithakan';

  @override
  String get onbSlide2Sub => 'Cithakan siap pakai';

  @override
  String get onbSlide2Badge => 'Ènthèng & Responsif';

  @override
  String get onbSlide3Title => 'Riwayat';

  @override
  String get onbSlide3Sub => 'Asil cap kasimpen';

  @override
  String get onbSlide3Badge => 'Tanpa Iklan & Tanpa Akun';

  @override
  String get onbSlide4Title => 'Ing piranti';

  @override
  String get onbSlide4Sub => 'Tanpa ngunggah menyang cloud';

  @override
  String get onbSlide4Badge => 'Data Kasimpen ing Piranti';

  @override
  String get loadingLabel => 'Ngamot…';

  @override
  String get download => 'Undhuh';

  @override
  String downloadSuccess(String filename) {
    return 'Dokumen ter-watermark kasil diundhuh ($filename)! 🛡️✨';
  }

  @override
  String get protectionProof => 'Bukti Proteksi';

  @override
  String get tierExemplary => 'Tuladha';

  @override
  String get tierDisciplined => 'Disiplin';

  @override
  String get tierOrderly => 'Tertib';

  @override
  String get tierStarting => 'Wiwit';

  @override
  String disciplineCount(int count, String tier) {
    return '$count file watermark • $tier';
  }

  @override
  String get disciplineDesc =>
      'Saben ekspor aman nambah disiplin proteksi dokumen.';

  @override
  String get shareDiscipline => 'Bagikake disiplin';

  @override
  String disciplineShareText(int count, String tier) {
    return '$count file watermark • $tier #IDMark';
  }

  @override
  String get allTemplates => 'Kabeh';

  @override
  String get myPresets => 'Cithakan Aku';

  @override
  String get catBanking => 'Perbankan';

  @override
  String get catFinance => 'Finansial & Pinjol';

  @override
  String get catCareer => 'Karir & SDM';

  @override
  String get catRental => 'Rental & Wisata';

  @override
  String get catTelecom => 'Telekomunikasi';

  @override
  String get catMultifinance => 'Multikeuangan';

  @override
  String get catInvestment => 'Investasi';

  @override
  String get catPublicService => 'Layanan Umum';

  @override
  String get catInternational => 'Internasional';

  @override
  String get appearanceAndLanguage => 'Tampilan & Basa';

  @override
  String get themeMode => 'Mode Tema';

  @override
  String get identity => 'Identitas';

  @override
  String get patternDiagonalBand => 'Pita Melintang';

  @override
  String get patternDiagonalBandDesc =>
      'Siji garis diagonal kandel nyabrang ing tengah dokumen (Rekomendasi Kominfo)';

  @override
  String get patternRepeatedGrid => 'Pola Bola-bali (Grid)';

  @override
  String get patternRepeatedGridDesc =>
      'Pola teks bola-bali ing sakuperenge foto kanggo proteksi maksimal';

  @override
  String get patternBottomBar => 'Pita Ngisor';

  @override
  String get patternBottomBarDesc => 'Pita teks solid ing sisih ngisor dokumen';

  @override
  String get patternCornerStamp => 'Cap Pojok';

  @override
  String get patternCornerStampDesc => 'Cap verifikasi ing pojok tengen ngisor';

  @override
  String get patternSecuritySeal => 'Segel Resmi Bunder';

  @override
  String get patternSecuritySealDesc =>
      'Stempel segel bunder pindho kanthi border verifikasi';

  @override
  String get patternCrossStamp => 'Silang Pindho (X-Band)';

  @override
  String get patternCrossStampDesc =>
      'Loro garis diagonal nyilang nglindhungi kabeh isi dokumen';

  @override
  String get patternQrBadge => 'Lencana QR Verifikasi';

  @override
  String get patternQrBadgeDesc =>
      'Lencana verifikasi mawa QR code keabsahan tujuan lan tanggal';

  @override
  String get colorWhite => 'Putih Resik';

  @override
  String get colorDark => 'Ireng Pekat';

  @override
  String get colorRed => 'Abang Resmi';

  @override
  String get colorBlue => 'Biru Verifikasi';

  @override
  String get colorEmerald => 'Ijo Aman';

  @override
  String get colorAmber => 'Kuning Pènget';

  @override
  String get colorPurple => 'Ungu Segel';

  @override
  String get formatPng => 'PNG (Résolusi Penuh)';

  @override
  String get formatPngDesc =>
      'Format lossless kualitas asli tanpa mudhun ketajaman';

  @override
  String get formatJpeg => 'JPEG (Ukuran Ènthèng)';

  @override
  String get formatJpegDesc =>
      'Format kakompresi ngirit kuota kanggo upload portal cepet';

  @override
  String get formatPdf => 'Dokumen PDF (Siap Cetak)';

  @override
  String get formatPdfDesc =>
      'Format berkas dokumen resmi standar kantor & bank';

  @override
  String get redactBlackout => 'Sensor Ireng (Blackout)';

  @override
  String get redactBlackoutDesc => 'Kothak ireng pekat permanen nutupi data';

  @override
  String get redactMosaic => 'Sensor Mosaik (Pixelate)';

  @override
  String get redactMosaicDesc => 'Efek pikselasi ngaburake teks sensitif';

  @override
  String get redactBlur => 'Sensor Burem (Blur)';

  @override
  String get redactBlurDesc => 'Efek burem nggabungake rincian data pribadi';

  @override
  String get targetNik => 'Nomer NIK / ID';

  @override
  String get targetSignature => 'Tandha Tangan';

  @override
  String get targetAddress => 'Alamat Jangkep';

  @override
  String get targetBirthPlace => 'Papan / Tgl Lair';

  @override
  String get targetPhoto => 'Foto Rai';

  @override
  String get shareProofTitle => 'Bukti Proteksi Dokumen';

  @override
  String get shareProofSubtitle =>
      'Sertifikat integritas watermark & sensor miturut Kominfo';

  @override
  String get shareFormatFeed => 'Unggahan (4:5)';

  @override
  String get shareFormatStory => 'Crita (9:16)';

  @override
  String get shareCopyText => 'Salin Teks';

  @override
  String get shareProcessing => 'Ngolah...';

  @override
  String get shareDownloadProofPng => 'Undhuh Bukti PNG';

  @override
  String get shareShareProof => 'Bagikake Bukti';

  @override
  String get shareCardBrand => 'IDMARK • ID AMAN';

  @override
  String get shareCardOnDevice => '100% ING PIRANTI';

  @override
  String get shareCardTitle => 'BUKTI PROTEKSI WATERMARK DOKUMEN';

  @override
  String get shareCardPurposeLabel => 'KANGO KEPERLUAN KHUSUS:';

  @override
  String get shareCardPrivacyScore => 'SKOR PRIVASI';

  @override
  String get shareCardRedactions => 'SENSOR';

  @override
  String shareCardAreaCount(int count) {
    return '$count Area';
  }

  @override
  String get shareCardFormat => 'JINIS';

  @override
  String shareCardDate(String date) {
    return 'Tanggal: $date';
  }

  @override
  String get shareCardFooter =>
      'idmark.faishal.id • Standar Watermark KTP Kominfo RI';

  @override
  String get shareCardIntegrityHash => 'HASH INTEGRITAS (SHA-256):';

  @override
  String get shareProofHeading => '🛡️ BUKTI PROTEKSI DOKUMEN — IDMARK';

  @override
  String shareProofPurposeLine(String purpose) {
    return '📌 Keperluan Khusus: \"$purpose\"';
  }

  @override
  String shareProofDateLine(String date) {
    return '📅 Tanggal Cap: $date';
  }

  @override
  String shareProofScoreLine(int score) {
    return '🔒 Skor Privasi: $score/100';
  }

  @override
  String shareProofRedactionLine(int count) {
    return '✂️ Sensor Permanen: $count Area Katutup';
  }

  @override
  String shareProofHashLine(String hash) {
    return '🔑 Hash SHA-256: $hash';
  }

  @override
  String get shareProofOnDeviceLine =>
      '✅ Diproses 100% on-device tanpa server (Sesuai Panduan Kominfo RI)';

  @override
  String get shareProofCtaLine =>
      'Nglindhungi identitas panjenengan nganggo IDMark: https://idmark.faishal.id';

  @override
  String get shareProofDownloaded =>
      'Sertifikat proteksi dokumen kasil diundhuh! 🛡️✨';

  @override
  String shareProofFailed(String error) {
    return 'Gagal mbagekake bukti: $error';
  }

  @override
  String get shareProofCopied =>
      'Bukti proteksi disalin menyang clipboard! 📋✨';

  @override
  String get themeCyberShield => 'Tameng Siber';

  @override
  String get themeEmeraldSafe => 'Zamrud Aman';

  @override
  String get themeObsidianVault => 'Brankas Obsidian';

  @override
  String get themeAmberProof => 'Bukti Ambar';

  @override
  String get quickSensorShort => 'Sensor Cepet:';

  @override
  String redactedTag(String label) {
    return '[DISENSOR: $label]';
  }

  @override
  String get defaultWatermarkText => 'MUNG KANGGO VERIFIKASI IDENTITAS';

  @override
  String get pdfHeader => 'IDMARK — DOKUMEN IDENTITAS TER-WATERMARK';

  @override
  String get pdfComplianceNote =>
      'Sesuai Prinsip Pelindhung Data Pribadi (UU No. 27/2022)';

  @override
  String get pdfOnDevice => '100% Ing Piranti';

  @override
  String get pdfPurposeLabel => 'Tujuan Panganggone: ';

  @override
  String pdfDateLabel(String date) {
    return 'Tanggal Transaksi: $date';
  }

  @override
  String pdfPrintedAt(String date) {
    return 'Wektu Cetak: $date';
  }

  @override
  String get pdfChecksum => 'Checksum SHA-256: ';

  @override
  String get catEcommerce => 'Dagang Elektronik';

  @override
  String get presetBank => 'Bukaan Rekening Bank';

  @override
  String get presetBankUpdate => 'Anyari Data Nasabah Bank';

  @override
  String get presetFintech => 'Pinjol / Fintech Resmi OJK';

  @override
  String get presetPaylater => 'Aktivasi Paylater / Kartu Kredit';

  @override
  String get presetJob => 'Lamaran Pagawéan';

  @override
  String get presetHrOnboarding => 'Onboarding Karyawan Anyar';

  @override
  String get presetRental => 'Sewa Mobil / Motor / Rental';

  @override
  String get presetHotel => 'Check-In Hotel / Villa / Kost';

  @override
  String get presetTelco => 'Registrasi Kartu SIM Prabayar';

  @override
  String get presetSimReplace => 'Ganti Kartu SIM Ilang / Rusak';

  @override
  String get presetKredit => 'Pengajuan Leasing / Multifinance';

  @override
  String get presetKpr => 'Pengajuan KPR / Properti';

  @override
  String get presetInvestment => 'Akun Sekuritas Saham IDX';

  @override
  String get presetCrypto => 'Verifikasi Akun Kripto Bappebti';

  @override
  String get presetEcommerce => 'Verifikasi Merchant Marketplace';

  @override
  String get presetBpjs => 'Klaim JHT / Saldo BPJS';

  @override
  String get presetGovKelurahan => 'Administrasi Kependudukan / Kelurahan';

  @override
  String get presetGlobalKyc => 'Verifikasi KYC Internasional';

  @override
  String get defaultInternalSubtext => 'MUNG KANGGO DOKUMEN INTERNAL';

  @override
  String get pdfLegalNotice =>
      'KABAR HUKUM: Salinan dokumen identitas iki mung sah lan diidinake kanggo tujuan sing katulis ing ndhuwur. Panganggone njaba peruntukan kasebut kalebu tindak pidana nyalahi data pribadi.';

  @override
  String get validationRedactionLabelRequired => 'Label sensor ora kena kosong';

  @override
  String get validationRedactionXRange =>
      'Posisi X sensor kudu ana ing rentang 0.0 - 1.0';

  @override
  String get validationRedactionYRange =>
      'Posisi Y sensor kudu ana ing rentang 0.0 - 1.0';

  @override
  String get validationRedactionWidthRange =>
      'Amba sensor kudu ana ing rentang >0.0 - 1.0';

  @override
  String get validationRedactionHeightRange =>
      'Dhuwur sensor kudu ana ing rentang >0.0 - 1.0';

  @override
  String get validationAuditIdRequired => 'ID audit log ora kena kosong';

  @override
  String get validationAuditPurposeRequired =>
      'Tujuan audit log ora kena kosong';

  @override
  String get validationAuditHashRequired => 'Hash SHA-256 ora kena kosong';

  @override
  String get validationAuditScoreRange =>
      'Skor privasi kudu ana ing antarane 0 lan 100';
}
