import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_jv.dart';
import 'app_localizations_su.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('id'),
    Locale('ja'),
    Locale('jv'),
    Locale('su'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'IDMark'**
  String get appName;

  /// No description provided for @appDescription.
  ///
  /// In id, this message translates to:
  /// **'Secure ID & Document Watermark'**
  String get appDescription;

  /// No description provided for @tabWatermark.
  ///
  /// In id, this message translates to:
  /// **'Watermark'**
  String get tabWatermark;

  /// No description provided for @tabPreset.
  ///
  /// In id, this message translates to:
  /// **'Preset'**
  String get tabPreset;

  /// No description provided for @tabHistory.
  ///
  /// In id, this message translates to:
  /// **'Riwayat'**
  String get tabHistory;

  /// No description provided for @tabGuide.
  ///
  /// In id, this message translates to:
  /// **'Panduan'**
  String get tabGuide;

  /// No description provided for @tabSettings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get tabSettings;

  /// No description provided for @settings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In id, this message translates to:
  /// **'Tampilan'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In id, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In id, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @selectTheme.
  ///
  /// In id, this message translates to:
  /// **'Pilih Tema'**
  String get selectTheme;

  /// No description provided for @language.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get selectLanguage;

  /// No description provided for @localeIndonesian.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Indonesia'**
  String get localeIndonesian;

  /// No description provided for @localeEnglish.
  ///
  /// In id, this message translates to:
  /// **'English'**
  String get localeEnglish;

  /// No description provided for @localeArabic.
  ///
  /// In id, this message translates to:
  /// **'العربية'**
  String get localeArabic;

  /// No description provided for @localeJavanese.
  ///
  /// In id, this message translates to:
  /// **'Basa Jawa'**
  String get localeJavanese;

  /// No description provided for @localeSundanese.
  ///
  /// In id, this message translates to:
  /// **'Basa Sunda'**
  String get localeSundanese;

  /// No description provided for @localeChinese.
  ///
  /// In id, this message translates to:
  /// **'中文'**
  String get localeChinese;

  /// No description provided for @localeJapanese.
  ///
  /// In id, this message translates to:
  /// **'日本語'**
  String get localeJapanese;

  /// No description provided for @localeSpanish.
  ///
  /// In id, this message translates to:
  /// **'Español'**
  String get localeSpanish;

  /// No description provided for @about.
  ///
  /// In id, this message translates to:
  /// **'Tentang'**
  String get about;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In id, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @reset.
  ///
  /// In id, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @kominfoGuide.
  ///
  /// In id, this message translates to:
  /// **'Panduan Kominfo'**
  String get kominfoGuide;

  /// No description provided for @history.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Audit Log'**
  String get history;

  /// No description provided for @presets.
  ///
  /// In id, this message translates to:
  /// **'Preset Kustom Pengguna'**
  String get presets;

  /// No description provided for @resetDefaults.
  ///
  /// In id, this message translates to:
  /// **'Reset Pengaturan Bawaan'**
  String get resetDefaults;

  /// No description provided for @resetWarningTitle.
  ///
  /// In id, this message translates to:
  /// **'Reset Preferensi?'**
  String get resetWarningTitle;

  /// No description provided for @resetWarningBody.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan watermark terakhir akan dikembalikan ke standar awal Kominfo.'**
  String get resetWarningBody;

  /// No description provided for @aboutApp.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In id, this message translates to:
  /// **'Versi'**
  String get appVersion;

  /// No description provided for @appDomain.
  ///
  /// In id, this message translates to:
  /// **'Domain'**
  String get appDomain;

  /// No description provided for @appCompliance.
  ///
  /// In id, this message translates to:
  /// **'Standar Kepatuhan'**
  String get appCompliance;

  /// No description provided for @appProvider.
  ///
  /// In id, this message translates to:
  /// **'Penyedia'**
  String get appProvider;

  /// No description provided for @clearHistory.
  ///
  /// In id, this message translates to:
  /// **'Bersihkan'**
  String get clearHistory;

  /// No description provided for @historyCleared.
  ///
  /// In id, this message translates to:
  /// **'Riwayat audit log dibersihkan.'**
  String get historyCleared;

  /// No description provided for @preferencesReset.
  ///
  /// In id, this message translates to:
  /// **'Preferensi berhasil direset ke rekomendasi Kominfo.'**
  String get preferencesReset;

  /// No description provided for @guideRules.
  ///
  /// In id, this message translates to:
  /// **'4 Aturan Pokok Watermark Kominfo'**
  String get guideRules;

  /// No description provided for @guideRule1Title.
  ///
  /// In id, this message translates to:
  /// **'Tuliskan Nama Lembaga & Tujuan Spesifik'**
  String get guideRule1Title;

  /// No description provided for @guideRule1Desc.
  ///
  /// In id, this message translates to:
  /// **'Jangan hanya menulis \"VERIFIKASI\". Tuliskan lengkap seperti \"VERIFIKASI PINJAMAN PT BANK ABC\". Dengan begitu, pihak lain tidak dapat menggunakan foto tersebut di tempat lain.'**
  String get guideRule1Desc;

  /// No description provided for @guideRule2Title.
  ///
  /// In id, this message translates to:
  /// **'Cantumkan Tanggal Transaksi Lengkap'**
  String get guideRule2Title;

  /// No description provided for @guideRule2Desc.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan tanggal saat Anda mengirimkan dokumen (misal: 28-09-2026). Ini membatasi masa berlaku dokumen salinan sehingga tidak dapat didaur ulang di masa mendatang.'**
  String get guideRule2Desc;

  /// No description provided for @guideRule3Title.
  ///
  /// In id, this message translates to:
  /// **'Posisikan Melintang di Atas Dokumen'**
  String get guideRule3Title;

  /// No description provided for @guideRule3Desc.
  ///
  /// In id, this message translates to:
  /// **'Letakkan watermark melintang di atas teks KTP secara semi-transparan. Jangan meletakkannya di area kosong di pinggir foto karena pelaku kejahatan bisa memotongnya (crop) dengan mudah.'**
  String get guideRule3Desc;

  /// No description provided for @guideRule4Title.
  ///
  /// In id, this message translates to:
  /// **'Sensor Tanda Tangan & Digit Sensitif'**
  String get guideRule4Title;

  /// No description provided for @guideRule4Desc.
  ///
  /// In id, this message translates to:
  /// **'Tanda tangan basah adalah aset biometrik terpenting Anda. Jika verifikator hanya membutuhkan NIK dan nama, tutupi tanda tangan Anda untuk mencegah pemalsuan dokumen.'**
  String get guideRule4Desc;

  /// No description provided for @warningRejectTitle.
  ///
  /// In id, this message translates to:
  /// **'Waspada: Pihak yang Menolak Foto Ber-Watermark'**
  String get warningRejectTitle;

  /// No description provided for @warningRejectDesc.
  ///
  /// In id, this message translates to:
  /// **'Jika ada pihak atau aplikasi yang bersikeras meminta foto e-KTP polosan tanpa watermark padahal tujuan transaksi sudah jelas, Anda patut mencurigai niat pihak tersebut dan mempertimbangkan membatalkan transaksi.'**
  String get warningRejectDesc;

  /// No description provided for @verifiedOfficial.
  ///
  /// In id, this message translates to:
  /// **'★ RESMI DIVERIFIKASI ★'**
  String get verifiedOfficial;

  /// No description provided for @dateLabel.
  ///
  /// In id, this message translates to:
  /// **'TGL'**
  String get dateLabel;

  /// No description provided for @verifyIdentity.
  ///
  /// In id, this message translates to:
  /// **'VERIFIKASI IDENTITAS'**
  String get verifyIdentity;

  /// No description provided for @idmarkVerified.
  ///
  /// In id, this message translates to:
  /// **'IDMARK VERIFIED'**
  String get idmarkVerified;

  /// No description provided for @privacySettings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan Privasi'**
  String get privacySettings;

  /// No description provided for @autoStripExif.
  ///
  /// In id, this message translates to:
  /// **'Otomatis hapus EXIF'**
  String get autoStripExif;

  /// No description provided for @autoStripExifDesc.
  ///
  /// In id, this message translates to:
  /// **'Hapus metadata lokasi GPS dan kamera dari foto sebelum diekspor'**
  String get autoStripExifDesc;

  /// No description provided for @historySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Tersimpan {count} catatan ekspor on-device'**
  String historySubtitle(int count);

  /// No description provided for @presetsSubtitle.
  ///
  /// In id, this message translates to:
  /// **'{count} template kustom tersimpan'**
  String presetsSubtitle(int count);

  /// No description provided for @selectImageFirst.
  ///
  /// In id, this message translates to:
  /// **'Pilih atau ambil foto KTP terlebih dahulu.'**
  String get selectImageFirst;

  /// No description provided for @checkConfigError.
  ///
  /// In id, this message translates to:
  /// **'Periksa konfigurasi: {error}'**
  String checkConfigError(String error);

  /// No description provided for @watermarkDone.
  ///
  /// In id, this message translates to:
  /// **'Watermark Selesai!'**
  String get watermarkDone;

  /// No description provided for @watermarkDoneDesc.
  ///
  /// In id, this message translates to:
  /// **'Dokumen e-KTP Anda telah berhasil diproteksi dengan watermark resolusi penuh dan sensor permanen secara 100% on-device.'**
  String get watermarkDoneDesc;

  /// No description provided for @hashCopied.
  ///
  /// In id, this message translates to:
  /// **'Hash integritas disalin ke clipboard!'**
  String get hashCopied;

  /// No description provided for @close.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get close;

  /// No description provided for @share.
  ///
  /// In id, this message translates to:
  /// **'Bagikan'**
  String get share;

  /// No description provided for @resetWatermarkTooltip.
  ///
  /// In id, this message translates to:
  /// **'Reset Watermark'**
  String get resetWatermarkTooltip;

  /// No description provided for @configResetKominfo.
  ///
  /// In id, this message translates to:
  /// **'Konfigurasi dikembalikan ke standar rekomendasi Kominfo.'**
  String get configResetKominfo;

  /// No description provided for @bannerUuPdp.
  ///
  /// In id, this message translates to:
  /// **'Standar UU PDP: Bubuhkan watermark tujuan spesifik, tanggal, dan sensor data sensitif sebelum membagikan foto e-KTP.'**
  String get bannerUuPdp;

  /// No description provided for @sensorBoxAdded.
  ///
  /// In id, this message translates to:
  /// **'Kotak sensor \"{label}\" ditambahkan.'**
  String sensorBoxAdded(String label);

  /// No description provided for @processingOnDevice.
  ///
  /// In id, this message translates to:
  /// **'Memproses Dokumen On-Device...'**
  String get processingOnDevice;

  /// No description provided for @saveDocument.
  ///
  /// In id, this message translates to:
  /// **'Simpan Dokumen ({format})'**
  String saveDocument(String format);

  /// No description provided for @shareDirect.
  ///
  /// In id, this message translates to:
  /// **'Bagikan Langsung'**
  String get shareDirect;

  /// No description provided for @failedToExport.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengekspor dokumen: {error}'**
  String failedToExport(String error);

  /// No description provided for @shareSubject.
  ///
  /// In id, this message translates to:
  /// **'Dokumen Identitas Ter-Watermark - {purpose}'**
  String shareSubject(String purpose);

  /// No description provided for @shareText.
  ///
  /// In id, this message translates to:
  /// **'Dokumen identitas ter-watermark aman via IDMark ({purpose}) • 100% on-device'**
  String shareText(String purpose);

  /// No description provided for @watermarkConfigTitle.
  ///
  /// In id, this message translates to:
  /// **'Konfigurasi Watermark'**
  String get watermarkConfigTitle;

  /// No description provided for @sensorMaskTab.
  ///
  /// In id, this message translates to:
  /// **'Sensor / Mask'**
  String get sensorMaskTab;

  /// No description provided for @privacyExifTab.
  ///
  /// In id, this message translates to:
  /// **'Privasi & EXIF'**
  String get privacyExifTab;

  /// No description provided for @exportFormatTab.
  ///
  /// In id, this message translates to:
  /// **'Format Ekspor'**
  String get exportFormatTab;

  /// No description provided for @watermarkPurposeLabel.
  ///
  /// In id, this message translates to:
  /// **'Tujuan Watermark (Sesuai Kebutuhan)'**
  String get watermarkPurposeLabel;

  /// No description provided for @watermarkPurposeHint.
  ///
  /// In id, this message translates to:
  /// **'Misal: VERIFIKASI PINJAMAN BANK ABC'**
  String get watermarkPurposeHint;

  /// No description provided for @transactionDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Transaksi'**
  String get transactionDate;

  /// No description provided for @includeDateChip.
  ///
  /// In id, this message translates to:
  /// **'Cantumkan Tgl'**
  String get includeDateChip;

  /// No description provided for @subtextLabel.
  ///
  /// In id, this message translates to:
  /// **'Catatan Tambahan / Subtext (Opsional)'**
  String get subtextLabel;

  /// No description provided for @subtextHint.
  ///
  /// In id, this message translates to:
  /// **'Misal: HANYA UNTUK KELENGKAPAN BERKAS INTERNAL'**
  String get subtextHint;

  /// No description provided for @patternLabel.
  ///
  /// In id, this message translates to:
  /// **'Pola Stempel Watermark (7 Gaya)'**
  String get patternLabel;

  /// No description provided for @colorLabel.
  ///
  /// In id, this message translates to:
  /// **'Warna Cap Watermark'**
  String get colorLabel;

  /// No description provided for @opacityLevel.
  ///
  /// In id, this message translates to:
  /// **'Tingkat Opasitas (Transparansi)'**
  String get opacityLevel;

  /// No description provided for @watermarkFontSize.
  ///
  /// In id, this message translates to:
  /// **'Ukuran Teks Watermark'**
  String get watermarkFontSize;

  /// No description provided for @rotationAngle.
  ///
  /// In id, this message translates to:
  /// **'Kemiringan Sudut'**
  String get rotationAngle;

  /// No description provided for @redactionIntro.
  ///
  /// In id, this message translates to:
  /// **'Tutup bagian data vital seperti tanda tangan atau digit NIK yang tidak relevan dengan transaksi untuk meminimalkan risiko pencurian identitas.'**
  String get redactionIntro;

  /// No description provided for @quickSensorLabel.
  ///
  /// In id, this message translates to:
  /// **'Tambah Sensor Cepat:'**
  String get quickSensorLabel;

  /// No description provided for @sensorNik.
  ///
  /// In id, this message translates to:
  /// **'Sensor NIK'**
  String get sensorNik;

  /// No description provided for @sensorSignature.
  ///
  /// In id, this message translates to:
  /// **'Sensor Tanda Tangan'**
  String get sensorSignature;

  /// No description provided for @sensorAddress.
  ///
  /// In id, this message translates to:
  /// **'Sensor Alamat'**
  String get sensorAddress;

  /// No description provided for @sensorBirthDate.
  ///
  /// In id, this message translates to:
  /// **'Sensor Tgl Lahir'**
  String get sensorBirthDate;

  /// No description provided for @customArea.
  ///
  /// In id, this message translates to:
  /// **'Area Kustom'**
  String get customArea;

  /// No description provided for @noRedactionsYet.
  ///
  /// In id, this message translates to:
  /// **'Belum ada area yang disensor.'**
  String get noRedactionsYet;

  /// No description provided for @deleteSensorTooltip.
  ///
  /// In id, this message translates to:
  /// **'Hapus Sensor'**
  String get deleteSensorTooltip;

  /// No description provided for @sensorTypeLabel.
  ///
  /// In id, this message translates to:
  /// **'Tipe Sensor:'**
  String get sensorTypeLabel;

  /// No description provided for @positionX.
  ///
  /// In id, this message translates to:
  /// **'Posisi X ({percent}%)'**
  String positionX(int percent);

  /// No description provided for @positionY.
  ///
  /// In id, this message translates to:
  /// **'Posisi Y ({percent}%)'**
  String positionY(int percent);

  /// No description provided for @privacyComplianceIndex.
  ///
  /// In id, this message translates to:
  /// **'Indeks Kepatuhan Privasi Dokumen'**
  String get privacyComplianceIndex;

  /// No description provided for @complianceChecklistTitle.
  ///
  /// In id, this message translates to:
  /// **'Checklist Kepatuhan UU PDP No. 27/2022:'**
  String get complianceChecklistTitle;

  /// No description provided for @checkPurposeTitle.
  ///
  /// In id, this message translates to:
  /// **'Tujuan Penggunaan Spesifik'**
  String get checkPurposeTitle;

  /// No description provided for @checkPurposeDesc.
  ///
  /// In id, this message translates to:
  /// **'Membatasi agar salinan tidak bisa dialihkan ke transaksi lain'**
  String get checkPurposeDesc;

  /// No description provided for @checkDateTitle.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Transaksi Dicantumkan'**
  String get checkDateTitle;

  /// No description provided for @checkDateDesc.
  ///
  /// In id, this message translates to:
  /// **'Membatasi masa kedaluwarsa dokumen agar tidak disalahgunakan di masa depan'**
  String get checkDateDesc;

  /// No description provided for @checkExifTitle.
  ///
  /// In id, this message translates to:
  /// **'Sanitasi Metadata EXIF & GPS'**
  String get checkExifTitle;

  /// No description provided for @checkExifDesc.
  ///
  /// In id, this message translates to:
  /// **'Menghilangkan lokasi geografis koordinat rumah dari file foto'**
  String get checkExifDesc;

  /// No description provided for @checkSensorTitle.
  ///
  /// In id, this message translates to:
  /// **'Sensor Bagian Vital (NIK / Tanda Tangan)'**
  String get checkSensorTitle;

  /// No description provided for @checkSensorDesc.
  ///
  /// In id, this message translates to:
  /// **'Menyembunyikan informasi yang tidak diwajibkan oleh penerima'**
  String get checkSensorDesc;

  /// No description provided for @autoSanitizeExifTitle.
  ///
  /// In id, this message translates to:
  /// **'Sanitasi Metadata EXIF Otomatis'**
  String get autoSanitizeExifTitle;

  /// No description provided for @autoSanitizeExifDesc.
  ///
  /// In id, this message translates to:
  /// **'Menghapus tag metadata kamera, model HP, dan koordinat GPS secara otomatis saat ekspor'**
  String get autoSanitizeExifDesc;

  /// No description provided for @chooseExportFormat.
  ///
  /// In id, this message translates to:
  /// **'Pilih Format Dokumen Keluaran:'**
  String get chooseExportFormat;

  /// No description provided for @jpegCompressionQuality.
  ///
  /// In id, this message translates to:
  /// **'Kualitas Kompresi JPEG'**
  String get jpegCompressionQuality;

  /// No description provided for @protectionGrade.
  ///
  /// In id, this message translates to:
  /// **'Proteksi {grade} ({score}%)'**
  String protectionGrade(String grade, int score);

  /// No description provided for @viewingOriginal.
  ///
  /// In id, this message translates to:
  /// **'Melihat Asli'**
  String get viewingOriginal;

  /// No description provided for @holdToCompare.
  ///
  /// In id, this message translates to:
  /// **'Tahan: Bandingkan'**
  String get holdToCompare;

  /// No description provided for @activeWatermarkWithCount.
  ///
  /// In id, this message translates to:
  /// **'Watermark Aktif ({count} sensor)'**
  String activeWatermarkWithCount(int count);

  /// No description provided for @activeWatermarkPreview.
  ///
  /// In id, this message translates to:
  /// **'Pratinjau Watermark Aktif'**
  String get activeWatermarkPreview;

  /// No description provided for @changePhoto.
  ///
  /// In id, this message translates to:
  /// **'Ganti Foto'**
  String get changePhoto;

  /// No description provided for @deleteImage.
  ///
  /// In id, this message translates to:
  /// **'Hapus Gambar'**
  String get deleteImage;

  /// No description provided for @uploadIdPhoto.
  ///
  /// In id, this message translates to:
  /// **'Unggah Foto e-KTP / Identitas'**
  String get uploadIdPhoto;

  /// No description provided for @uploadIdPhotoDesc.
  ///
  /// In id, this message translates to:
  /// **'Pilih foto e-KTP, SIM, atau Paspor untuk menambahkan stempel tujuan, tanggal, dan sensor data vital.'**
  String get uploadIdPhotoDesc;

  /// No description provided for @onDeviceBadge.
  ///
  /// In id, this message translates to:
  /// **'100% On-Device • Gambar tidak pernah dikirim ke server'**
  String get onDeviceBadge;

  /// No description provided for @openGallery.
  ///
  /// In id, this message translates to:
  /// **'Buka Galeri'**
  String get openGallery;

  /// No description provided for @takePhoto.
  ///
  /// In id, this message translates to:
  /// **'Ambil Foto'**
  String get takePhoto;

  /// No description provided for @historyAndAuditLog.
  ///
  /// In id, this message translates to:
  /// **'Riwayat & Audit Log'**
  String get historyAndAuditLog;

  /// No description provided for @clearAllHistoryTooltip.
  ///
  /// In id, this message translates to:
  /// **'Hapus Semua Riwayat'**
  String get clearAllHistoryTooltip;

  /// No description provided for @localPrivacyAuditLog.
  ///
  /// In id, this message translates to:
  /// **'Audit Log Privasi Lokal'**
  String get localPrivacyAuditLog;

  /// No description provided for @localPrivacyAuditLogDesc.
  ///
  /// In id, this message translates to:
  /// **'Total {count} dokumen telah distempel dengan aman secara 100% on-device. Rekaman ini hanya tersimpan di perangkat Anda.'**
  String localPrivacyAuditLogDesc(int count);

  /// No description provided for @searchHistoryHint.
  ///
  /// In id, this message translates to:
  /// **'Cari riwayat tujuan dokumen...'**
  String get searchHistoryHint;

  /// No description provided for @noWatermarkedDocsYet.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Dokumen Ter-Watermark'**
  String get noWatermarkedDocsYet;

  /// No description provided for @noWatermarkedDocsDesc.
  ///
  /// In id, this message translates to:
  /// **'Dokumen yang berhasil Anda beri watermark dan ekspor akan dicatat audit log-nya di sini.'**
  String get noWatermarkedDocsDesc;

  /// No description provided for @noHistoryFound.
  ///
  /// In id, this message translates to:
  /// **'Tidak ditemukan riwayat yang sesuai dengan pencarian.'**
  String get noHistoryFound;

  /// No description provided for @scoreLabel.
  ///
  /// In id, this message translates to:
  /// **'Skor {score}%'**
  String scoreLabel(int score);

  /// No description provided for @sensitiveSensorsCount.
  ///
  /// In id, this message translates to:
  /// **'{count} Sensor Sensitif'**
  String sensitiveSensorsCount(int count);

  /// No description provided for @exifSanitized.
  ///
  /// In id, this message translates to:
  /// **'EXIF Sanitized'**
  String get exifSanitized;

  /// No description provided for @sha256Copied.
  ///
  /// In id, this message translates to:
  /// **'Hash SHA-256 disalin ke clipboard!'**
  String get sha256Copied;

  /// No description provided for @clearHistoryConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Seluruh Riwayat?'**
  String get clearHistoryConfirmTitle;

  /// No description provided for @clearHistoryConfirmBody.
  ///
  /// In id, this message translates to:
  /// **'Daftar audit log di perangkat Anda akan dibersihkan permanen.'**
  String get clearHistoryConfirmBody;

  /// No description provided for @historyClearedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Riwayat berhasil dibersihkan.'**
  String get historyClearedSuccess;

  /// No description provided for @templatePresetHub.
  ///
  /// In id, this message translates to:
  /// **'Template & Preset Hub'**
  String get templatePresetHub;

  /// No description provided for @createPresetTooltip.
  ///
  /// In id, this message translates to:
  /// **'Buat Preset Baru'**
  String get createPresetTooltip;

  /// No description provided for @officialTemplateCatalog.
  ///
  /// In id, this message translates to:
  /// **'Katalog Template Watermark Resmi'**
  String get officialTemplateCatalog;

  /// No description provided for @officialTemplateDesc.
  ///
  /// In id, this message translates to:
  /// **'Pilih template standar perbankan, lamaran kerja, atau buat preset kustom pribadi yang tersimpan di perangkat Anda.'**
  String get officialTemplateDesc;

  /// No description provided for @searchTemplateHint.
  ///
  /// In id, this message translates to:
  /// **'Cari template (bank, pinjol, hrd, kpr, rental)...'**
  String get searchTemplateHint;

  /// No description provided for @showingTemplatesCount.
  ///
  /// In id, this message translates to:
  /// **'Menampilkan {count} template'**
  String showingTemplatesCount(int count);

  /// No description provided for @createCustom.
  ///
  /// In id, this message translates to:
  /// **'Buat Kustom'**
  String get createCustom;

  /// No description provided for @noTemplatesFound.
  ///
  /// In id, this message translates to:
  /// **'Tidak ditemukan template yang cocok dengan filter.'**
  String get noTemplatesFound;

  /// No description provided for @customBadge.
  ///
  /// In id, this message translates to:
  /// **'Kustom'**
  String get customBadge;

  /// No description provided for @deleteCustomPresetTooltip.
  ///
  /// In id, this message translates to:
  /// **'Hapus Preset Kustom'**
  String get deleteCustomPresetTooltip;

  /// No description provided for @activeBadge.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get activeBadge;

  /// No description provided for @patternInfo.
  ///
  /// In id, this message translates to:
  /// **'Pola: {pattern}'**
  String patternInfo(String pattern);

  /// No description provided for @usePreset.
  ///
  /// In id, this message translates to:
  /// **'Gunakan Preset'**
  String get usePreset;

  /// No description provided for @presetApplied.
  ///
  /// In id, this message translates to:
  /// **'Preset \"{title}\" berhasil diterapkan!'**
  String presetApplied(String title);

  /// No description provided for @createNewCustomPreset.
  ///
  /// In id, this message translates to:
  /// **'Buat Preset Kustom Baru'**
  String get createNewCustomPreset;

  /// No description provided for @presetName.
  ///
  /// In id, this message translates to:
  /// **'Nama Preset'**
  String get presetName;

  /// No description provided for @presetNameHint.
  ///
  /// In id, this message translates to:
  /// **'Misal: Verifikasi Beasiswa Kemendikbud'**
  String get presetNameHint;

  /// No description provided for @category.
  ///
  /// In id, this message translates to:
  /// **'Kategori'**
  String get category;

  /// No description provided for @categoryHint.
  ///
  /// In id, this message translates to:
  /// **'Misal: Pendidikan / Kustom'**
  String get categoryHint;

  /// No description provided for @purposeTemplateText.
  ///
  /// In id, this message translates to:
  /// **'Teks Template Tujuan'**
  String get purposeTemplateText;

  /// No description provided for @purposeTemplateHint.
  ///
  /// In id, this message translates to:
  /// **'Misal: PENGAJUAN BEASISWA 2026'**
  String get purposeTemplateHint;

  /// No description provided for @additionalSubtext.
  ///
  /// In id, this message translates to:
  /// **'Subtext Tambahan'**
  String get additionalSubtext;

  /// No description provided for @subtextTemplateHint.
  ///
  /// In id, this message translates to:
  /// **'Catatan internal'**
  String get subtextTemplateHint;

  /// No description provided for @stampPattern.
  ///
  /// In id, this message translates to:
  /// **'Pola Stempel'**
  String get stampPattern;

  /// No description provided for @savePreset.
  ///
  /// In id, this message translates to:
  /// **'Simpan Preset'**
  String get savePreset;

  /// No description provided for @customPresetSaved.
  ///
  /// In id, this message translates to:
  /// **'Preset kustom \"{title}\" disimpan!'**
  String customPresetSaved(String title);

  /// No description provided for @deletePresetConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Preset?'**
  String get deletePresetConfirmTitle;

  /// No description provided for @deletePresetConfirmBody.
  ///
  /// In id, this message translates to:
  /// **'Preset \"{title}\" akan dihapus dari daftar template lokal Anda.'**
  String deletePresetConfirmBody(String title);

  /// No description provided for @presetDeletedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Preset berhasil dihapus.'**
  String get presetDeletedSuccess;

  /// No description provided for @protectDigitalId.
  ///
  /// In id, this message translates to:
  /// **'Lindungi Identitas Digital Anda'**
  String get protectDigitalId;

  /// No description provided for @protectDigitalIdDesc.
  ///
  /// In id, this message translates to:
  /// **'Kementerian Kominfo dan UU No. 27/2022 (PDP) mewajibkan masyarakat berhati-hati saat membagikan foto e-KTP agar tidak dijadikan jaminan pinjaman online bodong atau pembukaan rekening fiktif.'**
  String get protectDigitalIdDesc;

  /// No description provided for @safeSharingChecklist.
  ///
  /// In id, this message translates to:
  /// **'Checklist Aman Sebelum Kirim e-KTP'**
  String get safeSharingChecklist;

  /// No description provided for @checklistDoneCount.
  ///
  /// In id, this message translates to:
  /// **'{count} / 5 Selesai'**
  String checklistDoneCount(int count);

  /// No description provided for @checkItem1.
  ///
  /// In id, this message translates to:
  /// **'Nama instansi/penerima tertulis jelas pada watermark'**
  String get checkItem1;

  /// No description provided for @checkItem2.
  ///
  /// In id, this message translates to:
  /// **'Tanggal transaksi terkini dicantumkan pada cap'**
  String get checkItem2;

  /// No description provided for @checkItem3.
  ///
  /// In id, this message translates to:
  /// **'Watermark melintang di atas data teks agar tidak bisa dicrop'**
  String get checkItem3;

  /// No description provided for @checkItem4.
  ///
  /// In id, this message translates to:
  /// **'Tanda tangan disensor jika verifikator tidak meminta spesimen tanda tangan'**
  String get checkItem4;

  /// No description provided for @checkItem5.
  ///
  /// In id, this message translates to:
  /// **'Metadata EXIF dan koordinat GPS telah dihapus dari gambar'**
  String get checkItem5;

  /// No description provided for @zeroServerTitle.
  ///
  /// In id, this message translates to:
  /// **'Privasi Mutlak (Zero Server Upload)'**
  String get zeroServerTitle;

  /// No description provided for @zeroServerDesc.
  ///
  /// In id, this message translates to:
  /// **'IDMark berjalan 100% di peramban atau perangkat lokal Anda. Foto identitas e-KTP tidak pernah dikirim, disimpan, atau diproses di peladen (server) eksternal manapun.'**
  String get zeroServerDesc;

  /// No description provided for @dataSecuritySanitation.
  ///
  /// In id, this message translates to:
  /// **'Sanitasi & Keamanan Data'**
  String get dataSecuritySanitation;

  /// No description provided for @autoExifSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Menghapus tag metadata koordinat GPS dan tipe kamera dari foto hasil ekspor'**
  String get autoExifSubtitle;

  /// No description provided for @defaultExportFormat.
  ///
  /// In id, this message translates to:
  /// **'Format Ekspor Default'**
  String get defaultExportFormat;

  /// No description provided for @localDeviceStorage.
  ///
  /// In id, this message translates to:
  /// **'Penyimpanan Lokal Perangkat'**
  String get localDeviceStorage;

  /// No description provided for @resetDefaultsDesc.
  ///
  /// In id, this message translates to:
  /// **'Mengembalikan template dan pengaturan teks ke bawaan pabrik'**
  String get resetDefaultsDesc;

  /// No description provided for @appLabel.
  ///
  /// In id, this message translates to:
  /// **'Aplikasi'**
  String get appLabel;

  /// No description provided for @officialKominfoGuide.
  ///
  /// In id, this message translates to:
  /// **'Panduan Resmi Kominfo & UU PDP'**
  String get officialKominfoGuide;

  /// No description provided for @privacyAndSettings.
  ///
  /// In id, this message translates to:
  /// **'Privasi & Pengaturan'**
  String get privacyAndSettings;

  /// No description provided for @appLanguage.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Aplikasi'**
  String get appLanguage;

  /// Judul seksi pengaturan zona waktu
  ///
  /// In id, this message translates to:
  /// **'Zona Waktu'**
  String get timezone;

  /// Opsi zona waktu otomatis yang mengikuti zona perangkat
  ///
  /// In id, this message translates to:
  /// **'Otomatis (ikut perangkat)'**
  String get timezoneAuto;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'id',
    'ja',
    'jv',
    'su',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'jv':
      return AppLocalizationsJv();
    case 'su':
      return AppLocalizationsSu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
