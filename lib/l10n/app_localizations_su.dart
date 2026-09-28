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
  String get tabWatermark => 'Watermark';

  @override
  String get tabPreset => 'Preset';

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
  String get about => 'Ngeunaan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpen';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Édit';

  @override
  String get reset => 'Reset';

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
  String get appDomain => 'Domain';

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
  String get idmarkVerified => 'IDMARK VERIFIED';

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
  String get resetWatermarkTooltip => 'Reset Watermark';

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
  String get deleteImage => 'Hapus Gambar';

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
  String get officialKominfoGuide => 'Panduan Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Pengaturan';
}
