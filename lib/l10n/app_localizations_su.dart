// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sundanese (`su`).
class AppLocalizationsSu extends AppLocalizations {
  AppLocalizationsSu([String locale = 'su']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Watermark KTP Aman';

  @override
  String get tabWatermark => 'Tanda Cai';

  @override
  String get tabPreset => 'Cithakan';

  @override
  String get tabHistory => 'Riwayat';

  @override
  String get tabGuide => 'Panduan';

  @override
  String get tabSettings => 'Setélan';

  @override
  String get settings => 'Setélan';

  @override
  String get appearance => 'Pidangan';

  @override
  String get theme => 'Téma';

  @override
  String get themeLight => 'Caang';

  @override
  String get themeDark => 'Poék';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get selectTheme => 'Pilih Téma';

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
  String get about => 'Ngeunaan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpen';

  @override
  String get delete => 'Pupus';

  @override
  String get edit => 'Édit';

  @override
  String get reset => 'Balikkeun';

  @override
  String get kominfoGuide => 'Panduan Kominfo';

  @override
  String get history => 'Riwayat Log';

  @override
  String get presets => 'Preset Pamaké';

  @override
  String get resetDefaults => 'Reset ka Bawaan';

  @override
  String get resetWarningTitle => 'Reset Setélan?';

  @override
  String get resetWarningBody =>
      'Setélan watermark bakal di-reset kana bawaan.';

  @override
  String get aboutApp => 'Ngeunaan Aplikasi';

  @override
  String get appVersion => 'Vérsi';

  @override
  String get appDomain => 'Doméin';

  @override
  String get appCompliance => 'Standar Patuh';

  @override
  String get appProvider => 'Panyadia';

  @override
  String get clearHistory => 'Beresihkeun';

  @override
  String get historyCleared => 'Riwayat tos diberesihkeun.';

  @override
  String get preferencesReset => 'Setélan tos di-reset.';

  @override
  String get guideRules => '4 Aturan Pokok Watermark';

  @override
  String get guideRule1Title => 'Tulis Ngaran & Tujuan';

  @override
  String get guideRule1Desc =>
      'Ulah ukur nulis \"VÉRIFIKASI\". Tulis lengkep sangkan aman.';

  @override
  String get guideRule2Title => 'Lebetkeun Tanggal';

  @override
  String get guideRule2Desc => 'Tambahkeun tanggal pikeun ngawatesan waktosna.';

  @override
  String get guideRule3Title => 'Posisi Nyerong';

  @override
  String get guideRule3Desc => 'Simpen watermark nyerong luhureun téks.';

  @override
  String get guideRule4Title => 'Tutupan Tanda Tangan';

  @override
  String get guideRule4Desc => 'Tutupan tanda tangan anjeun sangkan aman.';

  @override
  String get warningRejectTitle => 'Waspada nu Nolak Watermark';

  @override
  String get warningRejectDesc =>
      'Kade lamun aya nu ménta KTP tanpa watermark.';

  @override
  String get verifiedOfficial => '★ DIVÉRIFIKASI RESMI ★';

  @override
  String get dateLabel => 'TGL';

  @override
  String get verifyIdentity => 'VÉRIFIKASI IDENTITAS';

  @override
  String get idmarkVerified => 'IDMARK KAPARIKSA';

  @override
  String get privacySettings => 'Privasi';

  @override
  String get autoStripExif => 'Hapus EXIF';

  @override
  String get autoStripExifDesc => 'Hapus data lokasi GPS';

  @override
  String historySubtitle(int count) {
    return 'Disimpen $count catetan';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count citakan disimpen';
  }

  @override
  String get selectImageFirst => 'Pilih atanapi candak poto KTP heula.';

  @override
  String checkConfigError(String error) {
    return 'Pariksa konfigurasi: $error';
  }

  @override
  String get watermarkDone => 'Watermark Rengse!';

  @override
  String get watermarkDoneDesc =>
      'Dokumen KTP anjeun parantos hasil ditangtayungan ku watermark résolusi lengkep sareng sensor permanén 100% dina alat.';

  @override
  String get hashCopied => 'Hash integritas disalin kana papan klip!';

  @override
  String get close => 'Tutup';

  @override
  String get share => 'Bagikeun';

  @override
  String get resetWatermarkTooltip => 'Balikkeun Watermark';

  @override
  String get configResetKominfo =>
      'Konfigurasi dibalikeun deui kana standar saran Kominfo.';

  @override
  String get bannerUuPdp =>
      'Standar UU PDP: Pasang watermark tujuan khusus, kaping, sareng sénsor data sénsitip sateuacan ngabagikeun poto KTP.';

  @override
  String sensorBoxAdded(String label) {
    return 'Kotak sénsor \"$label\" ditambahkeun.';
  }

  @override
  String get processingOnDevice => 'Ngolah Dokumen Dina Alat...';

  @override
  String saveDocument(String format) {
    return 'Simpen Dokumen ($format)';
  }

  @override
  String get shareDirect => 'Bagikeun Langsung';

  @override
  String failedToExport(String error) {
    return 'Gagal ngékspor dokumen: $error';
  }

  @override
  String shareSubject(String purpose) {
    return 'Dokumen Idéntitas Ku Watermark - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'Dokumen idéntitas aman kalayan watermark via IDMark ($purpose) • 100% dina alat';
  }

  @override
  String get watermarkConfigTitle => 'Konfigurasi Watermark';

  @override
  String get sensorMaskTab => 'Sénsor / Masker';

  @override
  String get privacyExifTab => 'Privasi & EXIF';

  @override
  String get exportFormatTab => 'Format Ékspor';

  @override
  String get watermarkPurposeLabel =>
      'Tujuan Watermark (Luyu sareng Kabutuhan)';

  @override
  String get watermarkPurposeHint => 'Conto: VERIFIKASI NGINJEUM BANK ABC';

  @override
  String get transactionDate => 'Kaping Transaksi';

  @override
  String get includeDateChip => 'Pintonkeun Kaping';

  @override
  String get subtextLabel => 'Catetan Tambahan / Subtéks (Opsional)';

  @override
  String get subtextHint => 'Conto: NGAN KANGGO DOKUMEN INTERNAL';

  @override
  String get patternLabel => 'Pola Cap Watermark (7 Gaya)';

  @override
  String get colorLabel => 'Warna Cap Watermark';

  @override
  String get opacityLevel => 'Tingkat Opasitas (Transparansi)';

  @override
  String get watermarkFontSize => 'Ukuran Téks Watermark';

  @override
  String get rotationAngle => 'Sudut Kamiringan';

  @override
  String get redactionIntro =>
      'Tutup bagian data penting sapertos tanda tangan atanapi digit NIK anu teu relevan pikeun ngirangan résiko maling idéntitas.';

  @override
  String get quickSensorLabel => 'Tambah Sénsor Gancang:';

  @override
  String get sensorNik => 'Sénsor NIK';

  @override
  String get sensorSignature => 'Sénsor Tanda Tangan';

  @override
  String get sensorAddress => 'Sénsor Alamat';

  @override
  String get sensorBirthDate => 'Sénsor Tgl Lahir';

  @override
  String get customArea => 'Wewengkon Kustom';

  @override
  String get noRedactionsYet => 'Teu acan aya area anu disénsor.';

  @override
  String get deleteSensorTooltip => 'Hapus Sénsor';

  @override
  String get sensorTypeLabel => 'Jinis Sénsor:';

  @override
  String positionX(int percent) {
    return 'Posisi X ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'Posisi Y ($percent%)';
  }

  @override
  String get privacyComplianceIndex => 'Indéks Kepatuhan Privasi Dokumen';

  @override
  String get complianceChecklistTitle =>
      'Daptar Pariksa Kepatuhan UU PDP No. 27/2022:';

  @override
  String get checkPurposeTitle => 'Tujuan Pamakéan Husus';

  @override
  String get checkPurposeDesc =>
      'Ngawatesan supados salinan henteu tiasa dialihkeun kana transaksi sanés';

  @override
  String get checkDateTitle => 'Kaping Transaksi Dipintonkeun';

  @override
  String get checkDateDesc =>
      'Ngawatesan kadaluwarsa dokumen supados henteu disalahgunakeun dina waktos payun';

  @override
  String get checkExifTitle => 'Sanitasi Metadata EXIF & GPS';

  @override
  String get checkExifDesc =>
      'Ngaleungitkeun lokasi koordinat bumi tina payil poto';

  @override
  String get checkSensorTitle => 'Sénsor Bagian Vital (NIK / Tanda Tangan)';

  @override
  String get checkSensorDesc =>
      'Nyumputkeun inpormasi anu henteu diperyogikeun ku panarima';

  @override
  String get autoSanitizeExifTitle => 'Sanitasi Metadata EXIF Otomatis';

  @override
  String get autoSanitizeExifDesc =>
      'Mupus tag metadata kaméra, modél HP, sareng koordinat GPS sacara otomatis nalika ékspor';

  @override
  String get chooseExportFormat => 'Pilih Format Dokumen Kaluaran:';

  @override
  String get jpegCompressionQuality => 'Kualitas Komprési JPEG';

  @override
  String protectionGrade(String grade, int score) {
    return 'Panangtayungan $grade ($score%)';
  }

  @override
  String get viewingOriginal => 'Ningali Aslina';

  @override
  String get holdToCompare => 'Tahan: Bandingkeun';

  @override
  String activeWatermarkWithCount(int count) {
    return 'Watermark Aktip ($count sénsor)';
  }

  @override
  String get activeWatermarkPreview => 'Sawangan Watermark Aktip';

  @override
  String get changePhoto => 'Ganti Poto';

  @override
  String get deleteImage => 'Pupus Gambar';

  @override
  String get uploadIdPhoto => 'Unggah Poto KTP / Idéntitas';

  @override
  String get uploadIdPhotoDesc =>
      'Pilih poto KTP, SIM, atanapi Paspor kanggo nambihan cap tujuan, kaping, sareng sénsor data penting.';

  @override
  String get onDeviceBadge =>
      '100% Dina Alat • Gambar moal kantos dikirim ka sérvér';

  @override
  String get openGallery => 'Buka Galéri';

  @override
  String get takePhoto => 'Candak Poto';

  @override
  String get historyAndAuditLog => 'Riwayat & Audit Log';

  @override
  String get clearAllHistoryTooltip => 'Hapus Sadaya Riwayat';

  @override
  String get localPrivacyAuditLog => 'Audit Log Privasi Lokal';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return 'Total $count dokumen parantos dicap kalayan aman 100% dina alat. Rékaman ieu ngan disimpen dina alat anjeun.';
  }

  @override
  String get searchHistoryHint => 'Milari riwayat tujuan dokumen...';

  @override
  String get noWatermarkedDocsYet => 'Teu Acan Aya Dokumen Ber-Watermark';

  @override
  String get noWatermarkedDocsDesc =>
      'Dokumen anu parantos dipaparin watermark sareng diékspor bakal kacatet log auditna di dieu.';

  @override
  String get noHistoryFound =>
      'Henteu kapendak riwayat anu cocog sareng pamilarian.';

  @override
  String scoreLabel(int score) {
    return 'Skor $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count Sénsor Sénsitip';
  }

  @override
  String get exifSanitized => 'EXIF Diberesihan';

  @override
  String get sha256Copied => 'Hash SHA-256 disalin kana papan klip!';

  @override
  String get clearHistoryConfirmTitle => 'Hapus Sadaya Riwayat?';

  @override
  String get clearHistoryConfirmBody =>
      'Daptar log audit dina alat anjeun bakal dihapus sacara permanén.';

  @override
  String get historyClearedSuccess => 'Riwayat parantos hasil dihapus.';

  @override
  String get templatePresetHub => 'Hub Citakan & Prisét';

  @override
  String get createPresetTooltip => 'Damel Prisét Anyar';

  @override
  String get officialTemplateCatalog => 'Katalog Citakan Watermark Resmi';

  @override
  String get officialTemplateDesc =>
      'Pilih citakan baku perbankan, lamaran padamelan, atanapi damel prisét kustom pribadi anu disimpen dina alat anjeun.';

  @override
  String get searchTemplateHint =>
      'Milari citakan (bank, nginjeum, hrd, kpr, réntal)...';

  @override
  String showingTemplatesCount(int count) {
    return 'Nembongkeun $count citakan';
  }

  @override
  String get createCustom => 'Damel Kustom';

  @override
  String get noTemplatesFound =>
      'Henteu kapendak citakan anu cocog sareng saringan.';

  @override
  String get customBadge => 'Kustom';

  @override
  String get deleteCustomPresetTooltip => 'Hapus Prisét Kustom';

  @override
  String get activeBadge => 'Aktip';

  @override
  String patternInfo(String pattern) {
    return 'Pola: $pattern';
  }

  @override
  String get usePreset => 'Anggo Prisét';

  @override
  String presetApplied(String title) {
    return 'Prisét \"$title\" parantos hasil dilarapkeun!';
  }

  @override
  String get createNewCustomPreset => 'Damel Prisét Kustom Anyar';

  @override
  String get presetName => 'Nami Prisét';

  @override
  String get presetNameHint => 'Conto: Verifikasi Béasiswa Kemendikbud';

  @override
  String get category => 'Kategori';

  @override
  String get categoryHint => 'Conto: Atikan / Kustom';

  @override
  String get purposeTemplateText => 'Téks Citakan Tujuan';

  @override
  String get purposeTemplateHint => 'Conto: PENGAJUAN BÉASISWA 2026';

  @override
  String get additionalSubtext => 'Subtéks Tambahan';

  @override
  String get subtextTemplateHint => 'Catetan internal';

  @override
  String get stampPattern => 'Pola Cap';

  @override
  String get savePreset => 'Simpen Prisét';

  @override
  String customPresetSaved(String title) {
    return 'Prisét kustom \"$title\" disimpen!';
  }

  @override
  String get deletePresetConfirmTitle => 'Hapus Prisét?';

  @override
  String deletePresetConfirmBody(String title) {
    return 'Prisét \"$title\" bakal dihapus tina daptar citakan lokal anjeun.';
  }

  @override
  String get presetDeletedSuccess => 'Prisét parantos hasil dihapus.';

  @override
  String get protectDigitalId => 'Tangtayungan Idéntitas Digital Anjeun';

  @override
  String get protectDigitalIdDesc =>
      'Kamentrian Kominfo sareng UU No. 27/2022 (PDP) meryogikeun masarakat ati-ati nalika ngabagikeun poto KTP supados henteu dianggo pikeun jaminan pinjol atanapi rékening fiktif.';

  @override
  String get safeSharingChecklist => 'Daptar Pariksa Aman Sateuacan Ngirim KTP';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 Rengse';
  }

  @override
  String get checkItem1 => 'Nami instansi/panarima katulis écés dina watermark';

  @override
  String get checkItem2 => 'Kaping transaksi panganyarna dipintonkeun dina cap';

  @override
  String get checkItem3 =>
      'Watermark ngalintang dina luhureun téks supados teu tiasa dikroping';

  @override
  String get checkItem4 =>
      'Tanda tangan disénsor upami verifikator henteu nyungkeun conto tanda tangan';

  @override
  String get checkItem5 =>
      'Metadata EXIF sareng koordinat GPS parantos dihapus tina gambar';

  @override
  String get zeroServerTitle => 'Privasi Mutlak (Zero Server Upload)';

  @override
  String get zeroServerDesc =>
      'IDMark jalan 100% dina panyungsi atanapi alat lokal anjeun. Poto KTP moal kantos dikirim, disimpen, atanapi diprosés dina sérvér éksternal mana waé.';

  @override
  String get dataSecuritySanitation => 'Sanitasi & Kaamanan Data';

  @override
  String get autoExifSubtitle =>
      'Mupus tag metadata koordinat GPS sareng modél kaméra tina poto hasil ékspor';

  @override
  String get defaultExportFormat => 'Format Ékspor Default';

  @override
  String get localDeviceStorage => 'Panyimpenan Lokal Alat';

  @override
  String get resetDefaultsDesc =>
      'Mbalikeun deui citakan sareng setélan téks ka standar pabrik';

  @override
  String get appLabel => 'Aplikasi';

  @override
  String get officialKominfoGuide => 'Pituduh Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Setelan';

  @override
  String get appLanguage => 'Basa Aplikasi';

  @override
  String get timezone => 'Zona Waktos';

  @override
  String get timezoneAuto => 'Otomatis (nurutkeun parangkat)';

  @override
  String get licenseUsageTitle => 'Lisensi Pamakean';

  @override
  String get licenseUsageNotice =>
      'Bebas dianggo pikeun kaperluan pribadi jeung non-profit.';

  @override
  String get licenseUsageBadgeText => 'Pribadi & Non-Profit';

  @override
  String get validationPurposeRequired => 'Tujuan watermark teu kenging kosong';

  @override
  String get validationPurposeMinLength => 'Tujuan sahenteuna 3 karakter';

  @override
  String get validationPurposeMaxLength => 'Tujuan maksimal 60 karakter';

  @override
  String get validationSubtextMaxLength =>
      'Catetan tambahan maksimal 80 karakter';

  @override
  String get validationOpacityRange =>
      'Katingalina kedah aya di antara 10% sareng 100%';

  @override
  String get validationFontSizeRange =>
      'Ukuran teks kedah antara 10 sareng 60 pt';

  @override
  String get validationRotationRange =>
      'Sudut puteran kedah antara -90° sareng +90°';

  @override
  String get validationImageBytesEmpty => 'Berkas gambar kosong atanapi ruksak';

  @override
  String get validationImageBytesTooLarge =>
      'Ukuran gambar ngaleuwihan wates maksimal';

  @override
  String get validationQualityRange =>
      'Kualitas gambar kedah antara 10% sareng 100%';

  @override
  String get validationPresetTitleRequired => 'Nami preset teu kenging kosong';

  @override
  String get validationPresetTitleMinLength =>
      'Nami preset sahenteuna 3 karakter';

  @override
  String get validationPresetTitleMaxLength =>
      'Nami preset maksimal 50 karakter';

  @override
  String get validationPresetCategoryRequired =>
      'Kategori preset teu kenging kosong';

  @override
  String get validationPresetCategoryMaxLength =>
      'Kategori maksimal 30 karakter';

  @override
  String get privacyGradeDescMax =>
      'Panangtayungan Maksimal • Nyumponan standar panangtayungan data';

  @override
  String get privacyGradeDescVeryGood =>
      'Panangtayungan Sae Pisan • Dokumén aman dibagikeun';

  @override
  String get privacyGradeDescFair =>
      'Panangtayungan Cukup • Disarankeun nambihan tanggal sareng sensor NIK';

  @override
  String get privacyGradeDescWeak =>
      'Panangtayungan Lemah • Tambihkeun tujuan spésifik sareng tanggal';

  @override
  String get appTitle => 'IDMark';

  @override
  String get appTagline =>
      'Cap watermark téks dina poto KTP, SIM jeung dokumén penting.';

  @override
  String get appSubtitle => 'Pangjaga Identitas & Privasi';

  @override
  String get onbSkip => 'Lese';

  @override
  String get onbNext => 'Teruskeun';

  @override
  String get onbGetStarted => 'Mimiti Ayeuna';

  @override
  String get onbPrivacyHeadline => 'Privasi & Offline Kacangking';

  @override
  String get onbPrivacyDetail =>
      'Sakabéh data disimpen aman dina alat anjeun tanpa palacak.';

  @override
  String get onbSlide1Title => 'Cap identitas';

  @override
  String get onbSlide1Sub => 'Tujuan & tanggal dina dokumén';

  @override
  String get onbSlide1Badge => '100% Offline & Pribadi';

  @override
  String get onbSlide2Title => 'Cithakan';

  @override
  String get onbSlide2Sub => 'Cithakan siap pakai';

  @override
  String get onbSlide2Badge => 'Ringan & Responsif';

  @override
  String get onbSlide3Title => 'Riwayat';

  @override
  String get onbSlide3Sub => 'Hasil cap disimpen';

  @override
  String get onbSlide3Badge => 'Tanpa Iklan & Tanpa Akun';

  @override
  String get onbSlide4Title => 'Dina alat';

  @override
  String get onbSlide4Sub => 'Tanpa unggah ka cloud';

  @override
  String get onbSlide4Badge => 'Data Disimpen dina Alat';

  @override
  String get loadingLabel => 'Ngamuat…';

  @override
  String get download => 'Undeur';

  @override
  String downloadSuccess(String filename) {
    return 'Dokumén ter-watermark hasil diundeur ($filename)! 🛡️✨';
  }

  @override
  String get protectionProof => 'Bukti Proteksi';

  @override
  String get tierExemplary => 'Conto';

  @override
  String get tierDisciplined => 'Disiplin';

  @override
  String get tierOrderly => 'Tertib';

  @override
  String get tierStarting => 'Mimiti';

  @override
  String disciplineCount(int count, String tier) {
    return '$count berkas watermark • $tier';
  }

  @override
  String get disciplineDesc =>
      'Unggal ékspor aman nambahan disiplin protéksi dokumén.';

  @override
  String get shareDiscipline => 'Bagikeun disiplin';

  @override
  String disciplineShareText(int count, String tier) {
    return '$count berkas watermark • $tier #IDMark';
  }

  @override
  String get allTemplates => 'Sadayana';

  @override
  String get myPresets => 'Cithakan Kuring';

  @override
  String get catBanking => 'Perbankan';

  @override
  String get catFinance => 'Finansial & Pinjol';

  @override
  String get catCareer => 'Karir & SDM';

  @override
  String get catRental => 'Séwa & Wisata';

  @override
  String get catTelecom => 'Télékomunikasi';

  @override
  String get catMultifinance => 'Multikeuangan';

  @override
  String get catInvestment => 'Investasi';

  @override
  String get catPublicService => 'Palayanan Umum';

  @override
  String get catInternational => 'Internasional';

  @override
  String get appearanceAndLanguage => 'Pintonan & Basa';

  @override
  String get themeMode => 'Mode Téma';

  @override
  String get identity => 'Identitas';

  @override
  String get patternDiagonalBand => 'Pita Melintang';

  @override
  String get patternDiagonalBandDesc =>
      'Hiji garis diagonal kandel ngaliwatan tengah dokumén (Rekomendasi Kominfo)';

  @override
  String get patternRepeatedGrid => 'Pola Malikan (Grid)';

  @override
  String get patternRepeatedGridDesc =>
      'Pola téks malikan dina sakabéh poto pikeun protéksi maksimal';

  @override
  String get patternBottomBar => 'Pita Handap';

  @override
  String get patternBottomBarDesc => 'Pita téks padet di bagian handap dokumén';

  @override
  String get patternCornerStamp => 'Cap Juruk';

  @override
  String get patternCornerStampDesc => 'Cap vérifikasi di juru katuhu handap';

  @override
  String get patternSecuritySeal => 'Segel Resmi Bunder';

  @override
  String get patternSecuritySealDesc =>
      'Stempel segel bunder ganda kalawan wates vérifikasi';

  @override
  String get patternCrossStamp => 'Silang Ganda (X-Band)';

  @override
  String get patternCrossStampDesc =>
      'Dua garis diagonal silang ngajaga sakabéh eusi dokumén';

  @override
  String get patternQrBadge => 'Lencana QR Vérifikasi';

  @override
  String get patternQrBadgeDesc =>
      'Lencana vérifikasi mawa QR code kaabsahan tujuan jeung tanggal';

  @override
  String get colorWhite => 'Bodas Beresih';

  @override
  String get colorDark => 'Hideung Pekat';

  @override
  String get colorRed => 'Beureum Resmi';

  @override
  String get colorBlue => 'Biru Vérifikasi';

  @override
  String get colorEmerald => 'Héjo Aman';

  @override
  String get colorAmber => 'Konéng Pépéling';

  @override
  String get colorPurple => 'Ungu Segel';

  @override
  String get formatPng => 'PNG (Résolusi Pinuh)';

  @override
  String get formatPngDesc =>
      'Format lossless kualitas asli tanpa ngurangan katejaman';

  @override
  String get formatJpeg => 'JPEG (Ukuran Ringan)';

  @override
  String get formatJpegDesc =>
      'Format kakomprési hémat kuota pikeun unggah portal gancang';

  @override
  String get formatPdf => 'Dokumén PDF (Siap Citak)';

  @override
  String get formatPdfDesc =>
      'Format berkas dokumén resmi standar kantor & bank';

  @override
  String get redactBlackout => 'Sensor Hideung (Blackout)';

  @override
  String get redactBlackoutDesc => 'Kotak hideung padet permanén nutupan data';

  @override
  String get redactMosaic => 'Sensor Mosaik (Pixelate)';

  @override
  String get redactMosaicDesc => 'Éfék pikselasi ngaburkeun téks sénsitip';

  @override
  String get redactBlur => 'Sensor Burem (Blur)';

  @override
  String get redactBlurDesc => 'Éfék burem ngaratakeun rincian data pribadi';

  @override
  String get targetNik => 'Nomer NIK / ID';

  @override
  String get targetSignature => 'Tanda Tangan';

  @override
  String get targetAddress => 'Alamat Lengkep';

  @override
  String get targetBirthPlace => 'Tempat / Tgl Lahir';

  @override
  String get targetPhoto => 'Poto Beungeut';

  @override
  String get shareProofTitle => 'Bukti Protéksi Dokumén';

  @override
  String get shareProofSubtitle =>
      'Sertipikat integritas watermark & sensor luyu jeung Kominfo';

  @override
  String get shareFormatFeed => 'Unggahan (4:5)';

  @override
  String get shareFormatStory => 'Carita (9:16)';

  @override
  String get shareCopyText => 'Salin Téks';

  @override
  String get shareProcessing => 'Ngolah...';

  @override
  String get shareDownloadProofPng => 'Undeur Bukti PNG';

  @override
  String get shareShareProof => 'Bagikeun Bukti';

  @override
  String get shareCardBrand => 'IDMARK • ID AMAN';

  @override
  String get shareCardOnDevice => '100% DINA ALAT';

  @override
  String get shareCardTitle => 'BUKTI PROTÉKSI WATERMARK DOKUMÉN';

  @override
  String get shareCardPurposeLabel => 'PIKEUN KAPERLUAN KHUSUS:';

  @override
  String get shareCardPrivacyScore => 'SKOR PRIVASI';

  @override
  String get shareCardRedactions => 'SENSOR';

  @override
  String shareCardAreaCount(int count) {
    return '$count Wewengkon';
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
  String get shareProofHeading => '🛡️ BUKTI PROTÉKSI DOKUMÉN — IDMARK';

  @override
  String shareProofPurposeLine(String purpose) {
    return '📌 Kaperluan Khusus: \"$purpose\"';
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
    return '✂️ Sensor Permanén: $count Wewengkon Katutup';
  }

  @override
  String shareProofHashLine(String hash) {
    return '🔑 Hash SHA-256: $hash';
  }

  @override
  String get shareProofOnDeviceLine =>
      '✅ Diprosés 100% on-device tanpa server (Luyu jeung Panduan Kominfo RI)';

  @override
  String get shareProofCtaLine =>
      'Ngajaga identitas anjeun ku IDMark: https://idmark.faishal.id';

  @override
  String get shareProofDownloaded =>
      'Sertipikat protéksi dokumén hasil diundeur! 🛡️✨';

  @override
  String shareProofFailed(String error) {
    return 'Gagal ngabagikeun bukti: $error';
  }

  @override
  String get shareProofCopied => 'Bukti protéksi disalin ka clipboard! 📋✨';

  @override
  String get themeCyberShield => 'Taméng Siber';

  @override
  String get themeEmeraldSafe => 'Zamrud Aman';

  @override
  String get themeObsidianVault => 'Brankas Obsidian';

  @override
  String get themeAmberProof => 'Bukti Ambar';

  @override
  String get quickSensorShort => 'Sensor Gancang:';

  @override
  String redactedTag(String label) {
    return '[DISENSOR: $label]';
  }

  @override
  String get defaultWatermarkText => 'UKUR KEUR VÉRIFIKASI IDENTITAS';

  @override
  String get pdfHeader => 'IDMARK — DOKUMÉN IDENTITAS TER-WATERMARK';

  @override
  String get pdfComplianceNote =>
      'Luyu jeung Prinsip Perlindungan Data Pribadi (UU No. 27/2022)';

  @override
  String get pdfOnDevice => '100% Dina Alat';

  @override
  String get pdfPurposeLabel => 'Tujuan Pamakéan: ';

  @override
  String pdfDateLabel(String date) {
    return 'Tanggal Transaksi: $date';
  }

  @override
  String pdfPrintedAt(String date) {
    return 'Waktu Citak: $date';
  }

  @override
  String get pdfChecksum => 'Checksum SHA-256: ';

  @override
  String get catEcommerce => 'Dagang Éléktronik';

  @override
  String get presetBank => 'Buka Rekening Bank';

  @override
  String get presetBankUpdate => 'Ngamutahirkeun Data Nasabah Bank';

  @override
  String get presetFintech => 'Pinjol / Fintech Resmi OJK';

  @override
  String get presetPaylater => 'Aktivasina Paylater / Kartu Kiridit';

  @override
  String get presetJob => 'Lamaran Pagawéan';

  @override
  String get presetHrOnboarding => 'Onboarding Karyawan Anyar';

  @override
  String get presetRental => 'Séwa Mobil / Motor / Rental';

  @override
  String get presetHotel => 'Check-In Hotel / Villa / Kost';

  @override
  String get presetTelco => 'Registrasi Kartu SIM Prabayar';

  @override
  String get presetSimReplace => 'Ganti Kartu SIM Leungit / Ruksak';

  @override
  String get presetKredit => 'Pangajuan Leasing / Multifinance';

  @override
  String get presetKpr => 'Pangajuan KPR / Properti';

  @override
  String get presetInvestment => 'Akun Sekuritas Saham IDX';

  @override
  String get presetCrypto => 'Vérifikasi Akun Kripto Bappebti';

  @override
  String get presetEcommerce => 'Vérifikasi Merchant Marketplace';

  @override
  String get presetBpjs => 'Klaim JHT / Saldo BPJS';

  @override
  String get presetGovKelurahan => 'Administrasi Kependudukan / Kalurahan';

  @override
  String get presetGlobalKyc => 'Vérifikasi KYC Internasional';

  @override
  String get defaultInternalSubtext => 'UKUR KEUR DOKUMÉN INTERNAL';

  @override
  String get pdfLegalNotice =>
      'BEWARA HUKUM: Salinan dokumén identitas ieu ngan sah jeung diidinan pikeun tujuan nu katulis di luhur. Pamakéan di luar éta mangrupa tindak pidana nyalahgunakeun data pribadi.';

  @override
  String get validationRedactionLabelRequired =>
      'Label sensor teu meunang kosong';

  @override
  String get validationRedactionXRange =>
      'Posisi X sensor kudu aya dina rentang 0.0 - 1.0';

  @override
  String get validationRedactionYRange =>
      'Posisi Y sensor kudu aya dina rentang 0.0 - 1.0';

  @override
  String get validationRedactionWidthRange =>
      'Rubak sensor kudu aya dina rentang >0.0 - 1.0';

  @override
  String get validationRedactionHeightRange =>
      'Jangkung sensor kudu aya dina rentang >0.0 - 1.0';

  @override
  String get validationAuditIdRequired => 'ID audit log teu meunang kosong';

  @override
  String get validationAuditPurposeRequired =>
      'Tujuan audit log teu meunang kosong';

  @override
  String get validationAuditHashRequired => 'Hash SHA-256 teu meunang kosong';

  @override
  String get validationAuditScoreRange =>
      'Skor privasi kudu aya antara 0 jeung 100';
}
