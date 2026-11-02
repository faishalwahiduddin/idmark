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

  /// No description provided for @licenseUsageTitle.
  ///
  /// In id, this message translates to:
  /// **'Lisensi Penggunaan'**
  String get licenseUsageTitle;

  /// No description provided for @licenseUsageNotice.
  ///
  /// In id, this message translates to:
  /// **'Bebas digunakan untuk keperluan personal dan non-profit.'**
  String get licenseUsageNotice;

  /// No description provided for @licenseUsageBadgeText.
  ///
  /// In id, this message translates to:
  /// **'Pribadi & Nirlaba'**
  String get licenseUsageBadgeText;

  /// No description provided for @validationPurposeRequired.
  ///
  /// In id, this message translates to:
  /// **'Tujuan watermark tidak boleh kosong'**
  String get validationPurposeRequired;

  /// No description provided for @validationPurposeMinLength.
  ///
  /// In id, this message translates to:
  /// **'Tujuan minimal 3 karakter'**
  String get validationPurposeMinLength;

  /// No description provided for @validationPurposeMaxLength.
  ///
  /// In id, this message translates to:
  /// **'Tujuan maksimal 60 karakter'**
  String get validationPurposeMaxLength;

  /// No description provided for @validationSubtextMaxLength.
  ///
  /// In id, this message translates to:
  /// **'Catatan tambahan maksimal 80 karakter'**
  String get validationSubtextMaxLength;

  /// No description provided for @validationOpacityRange.
  ///
  /// In id, this message translates to:
  /// **'Opasitas harus berada di antara 10% dan 100%'**
  String get validationOpacityRange;

  /// No description provided for @validationFontSizeRange.
  ///
  /// In id, this message translates to:
  /// **'Ukuran teks harus antara 10 dan 60 pt'**
  String get validationFontSizeRange;

  /// No description provided for @validationRotationRange.
  ///
  /// In id, this message translates to:
  /// **'Sudut rotasi harus antara -90° dan +90°'**
  String get validationRotationRange;

  /// No description provided for @validationImageBytesEmpty.
  ///
  /// In id, this message translates to:
  /// **'File gambar kosong atau korup'**
  String get validationImageBytesEmpty;

  /// No description provided for @validationImageBytesTooLarge.
  ///
  /// In id, this message translates to:
  /// **'Ukuran gambar melebihi batas maksimal'**
  String get validationImageBytesTooLarge;

  /// No description provided for @validationQualityRange.
  ///
  /// In id, this message translates to:
  /// **'Kualitas gambar harus antara 10% dan 100%'**
  String get validationQualityRange;

  /// No description provided for @validationPresetTitleRequired.
  ///
  /// In id, this message translates to:
  /// **'Nama preset tidak boleh kosong'**
  String get validationPresetTitleRequired;

  /// No description provided for @validationPresetTitleMinLength.
  ///
  /// In id, this message translates to:
  /// **'Nama preset minimal 3 karakter'**
  String get validationPresetTitleMinLength;

  /// No description provided for @validationPresetTitleMaxLength.
  ///
  /// In id, this message translates to:
  /// **'Nama preset maksimal 50 karakter'**
  String get validationPresetTitleMaxLength;

  /// No description provided for @validationPresetCategoryRequired.
  ///
  /// In id, this message translates to:
  /// **'Kategori preset tidak boleh kosong'**
  String get validationPresetCategoryRequired;

  /// No description provided for @validationPresetCategoryMaxLength.
  ///
  /// In id, this message translates to:
  /// **'Kategori maksimal 30 karakter'**
  String get validationPresetCategoryMaxLength;

  /// No description provided for @privacyGradeDescMax.
  ///
  /// In id, this message translates to:
  /// **'Proteksi Maksimal • Memenuhi rekomendasi Kominfo & UU PDP'**
  String get privacyGradeDescMax;

  /// No description provided for @privacyGradeDescVeryGood.
  ///
  /// In id, this message translates to:
  /// **'Proteksi Sangat Baik • Dokumen aman dibagikan'**
  String get privacyGradeDescVeryGood;

  /// No description provided for @privacyGradeDescFair.
  ///
  /// In id, this message translates to:
  /// **'Proteksi Cukup • Disarankan menambah tanggal dan sensor NIK'**
  String get privacyGradeDescFair;

  /// No description provided for @privacyGradeDescWeak.
  ///
  /// In id, this message translates to:
  /// **'Proteksi Lemah • Tambahkan tujuan spesifik dan tanggal'**
  String get privacyGradeDescWeak;

  /// No description provided for @appTitle.
  ///
  /// In id, this message translates to:
  /// **'IDMark'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In id, this message translates to:
  /// **'Beri cap watermark teks pada foto KTP, SIM & dokumen penting.'**
  String get appTagline;

  /// No description provided for @appSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Secure ID Card & Privacy Shield'**
  String get appSubtitle;

  /// No description provided for @onbSkip.
  ///
  /// In id, this message translates to:
  /// **'Lewati'**
  String get onbSkip;

  /// No description provided for @onbNext.
  ///
  /// In id, this message translates to:
  /// **'Lanjut'**
  String get onbNext;

  /// No description provided for @onbGetStarted.
  ///
  /// In id, this message translates to:
  /// **'Mulai Sekarang'**
  String get onbGetStarted;

  /// No description provided for @onbPrivacyHeadline.
  ///
  /// In id, this message translates to:
  /// **'Privasi & Offline Terjamin'**
  String get onbPrivacyHeadline;

  /// No description provided for @onbPrivacyDetail.
  ///
  /// In id, this message translates to:
  /// **'Semua data tersimpan aman di perangkat Anda tanpa pelacak.'**
  String get onbPrivacyDetail;

  /// No description provided for @onbSlide1Title.
  ///
  /// In id, this message translates to:
  /// **'Stempel identitas'**
  String get onbSlide1Title;

  /// No description provided for @onbSlide1Sub.
  ///
  /// In id, this message translates to:
  /// **'Tujuan & tanggal di dokumen'**
  String get onbSlide1Sub;

  /// No description provided for @onbSlide1Badge.
  ///
  /// In id, this message translates to:
  /// **'100% Offline & Privat'**
  String get onbSlide1Badge;

  /// No description provided for @onbSlide2Title.
  ///
  /// In id, this message translates to:
  /// **'Preset'**
  String get onbSlide2Title;

  /// No description provided for @onbSlide2Sub.
  ///
  /// In id, this message translates to:
  /// **'Template siap pakai'**
  String get onbSlide2Sub;

  /// No description provided for @onbSlide2Badge.
  ///
  /// In id, this message translates to:
  /// **'Ringan & Responsif'**
  String get onbSlide2Badge;

  /// No description provided for @onbSlide3Title.
  ///
  /// In id, this message translates to:
  /// **'Riwayat'**
  String get onbSlide3Title;

  /// No description provided for @onbSlide3Sub.
  ///
  /// In id, this message translates to:
  /// **'Hasil stempel tersimpan'**
  String get onbSlide3Sub;

  /// No description provided for @onbSlide3Badge.
  ///
  /// In id, this message translates to:
  /// **'Tanpa Iklan & Tanpa Akun'**
  String get onbSlide3Badge;

  /// No description provided for @onbSlide4Title.
  ///
  /// In id, this message translates to:
  /// **'On-device'**
  String get onbSlide4Title;

  /// No description provided for @onbSlide4Sub.
  ///
  /// In id, this message translates to:
  /// **'Tanpa unggah ke cloud'**
  String get onbSlide4Sub;

  /// No description provided for @onbSlide4Badge.
  ///
  /// In id, this message translates to:
  /// **'Data Tersimpan di Perangkat'**
  String get onbSlide4Badge;

  /// No description provided for @loadingLabel.
  ///
  /// In id, this message translates to:
  /// **'Memuat…'**
  String get loadingLabel;

  /// No description provided for @download.
  ///
  /// In id, this message translates to:
  /// **'Unduh'**
  String get download;

  /// No description provided for @downloadSuccess.
  ///
  /// In id, this message translates to:
  /// **'Dokumen ter-watermark berhasil diunduh ({filename})! 🛡️✨'**
  String downloadSuccess(String filename);

  /// No description provided for @protectionProof.
  ///
  /// In id, this message translates to:
  /// **'Bukti Proteksi'**
  String get protectionProof;

  /// No description provided for @tierExemplary.
  ///
  /// In id, this message translates to:
  /// **'Teladan'**
  String get tierExemplary;

  /// No description provided for @tierDisciplined.
  ///
  /// In id, this message translates to:
  /// **'Disiplin'**
  String get tierDisciplined;

  /// No description provided for @tierOrderly.
  ///
  /// In id, this message translates to:
  /// **'Tertib'**
  String get tierOrderly;

  /// No description provided for @tierStarting.
  ///
  /// In id, this message translates to:
  /// **'Mulai'**
  String get tierStarting;

  /// No description provided for @disciplineCount.
  ///
  /// In id, this message translates to:
  /// **'{count} file watermark • {tier}'**
  String disciplineCount(int count, String tier);

  /// No description provided for @disciplineDesc.
  ///
  /// In id, this message translates to:
  /// **'Setiap ekspor aman menambah disiplin proteksi dokumen.'**
  String get disciplineDesc;

  /// No description provided for @shareDiscipline.
  ///
  /// In id, this message translates to:
  /// **'Bagikan disiplin'**
  String get shareDiscipline;

  /// No description provided for @disciplineShareText.
  ///
  /// In id, this message translates to:
  /// **'{count} file watermark • {tier} #IDMark'**
  String disciplineShareText(int count, String tier);

  /// No description provided for @allTemplates.
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get allTemplates;

  /// No description provided for @myPresets.
  ///
  /// In id, this message translates to:
  /// **'Preset Saya'**
  String get myPresets;

  /// No description provided for @catBanking.
  ///
  /// In id, this message translates to:
  /// **'Perbankan'**
  String get catBanking;

  /// No description provided for @catFinance.
  ///
  /// In id, this message translates to:
  /// **'Finansial & Pinjol'**
  String get catFinance;

  /// No description provided for @catCareer.
  ///
  /// In id, this message translates to:
  /// **'Karir & HR'**
  String get catCareer;

  /// No description provided for @catRental.
  ///
  /// In id, this message translates to:
  /// **'Rental & Wisata'**
  String get catRental;

  /// No description provided for @catTelecom.
  ///
  /// In id, this message translates to:
  /// **'Telekomunikasi'**
  String get catTelecom;

  /// No description provided for @catMultifinance.
  ///
  /// In id, this message translates to:
  /// **'Multifinance'**
  String get catMultifinance;

  /// No description provided for @catInvestment.
  ///
  /// In id, this message translates to:
  /// **'Investasi'**
  String get catInvestment;

  /// No description provided for @catPublicService.
  ///
  /// In id, this message translates to:
  /// **'Layanan Publik'**
  String get catPublicService;

  /// No description provided for @catInternational.
  ///
  /// In id, this message translates to:
  /// **'Internasional'**
  String get catInternational;

  /// No description provided for @appearanceAndLanguage.
  ///
  /// In id, this message translates to:
  /// **'Tampilan & Bahasa'**
  String get appearanceAndLanguage;

  /// No description provided for @themeMode.
  ///
  /// In id, this message translates to:
  /// **'Mode Tema'**
  String get themeMode;

  /// No description provided for @identity.
  ///
  /// In id, this message translates to:
  /// **'Identitas'**
  String get identity;

  /// No description provided for @patternDiagonalBand.
  ///
  /// In id, this message translates to:
  /// **'Pita Melintang'**
  String get patternDiagonalBand;

  /// No description provided for @patternDiagonalBandDesc.
  ///
  /// In id, this message translates to:
  /// **'Satu garis diagonal tebal melintang di tengah dokumen (Rekomendasi Kominfo)'**
  String get patternDiagonalBandDesc;

  /// No description provided for @patternRepeatedGrid.
  ///
  /// In id, this message translates to:
  /// **'Pola Berulang (Grid)'**
  String get patternRepeatedGrid;

  /// No description provided for @patternRepeatedGridDesc.
  ///
  /// In id, this message translates to:
  /// **'Pola teks berulang di seluruh permukaan foto untuk proteksi maksimal'**
  String get patternRepeatedGridDesc;

  /// No description provided for @patternBottomBar.
  ///
  /// In id, this message translates to:
  /// **'Pita Bawah'**
  String get patternBottomBar;

  /// No description provided for @patternBottomBarDesc.
  ///
  /// In id, this message translates to:
  /// **'Pita teks solid di bagian bawah dokumen'**
  String get patternBottomBarDesc;

  /// No description provided for @patternCornerStamp.
  ///
  /// In id, this message translates to:
  /// **'Cap Sudut'**
  String get patternCornerStamp;

  /// No description provided for @patternCornerStampDesc.
  ///
  /// In id, this message translates to:
  /// **'Cap verifikasi di sudut kanan bawah'**
  String get patternCornerStampDesc;

  /// No description provided for @patternSecuritySeal.
  ///
  /// In id, this message translates to:
  /// **'Segel Resmi Melingkar'**
  String get patternSecuritySeal;

  /// No description provided for @patternSecuritySealDesc.
  ///
  /// In id, this message translates to:
  /// **'Stempel segel melingkar ganda dengan border verifikasi'**
  String get patternSecuritySealDesc;

  /// No description provided for @patternCrossStamp.
  ///
  /// In id, this message translates to:
  /// **'Silang Ganda (X-Band)'**
  String get patternCrossStamp;

  /// No description provided for @patternCrossStampDesc.
  ///
  /// In id, this message translates to:
  /// **'Dua garis diagonal menyilang melindungi seluruh isi dokumen'**
  String get patternCrossStampDesc;

  /// No description provided for @patternQrBadge.
  ///
  /// In id, this message translates to:
  /// **'Lencana QR Verifikasi'**
  String get patternQrBadge;

  /// No description provided for @patternQrBadgeDesc.
  ///
  /// In id, this message translates to:
  /// **'Lencana verifikasi ber-QR code keabsahan tujuan dan tanggal'**
  String get patternQrBadgeDesc;

  /// No description provided for @colorWhite.
  ///
  /// In id, this message translates to:
  /// **'Putih Bersih'**
  String get colorWhite;

  /// No description provided for @colorDark.
  ///
  /// In id, this message translates to:
  /// **'Hitam Pekat'**
  String get colorDark;

  /// No description provided for @colorRed.
  ///
  /// In id, this message translates to:
  /// **'Merah Resmi'**
  String get colorRed;

  /// No description provided for @colorBlue.
  ///
  /// In id, this message translates to:
  /// **'Biru Verifikasi'**
  String get colorBlue;

  /// No description provided for @colorEmerald.
  ///
  /// In id, this message translates to:
  /// **'Hijau Aman'**
  String get colorEmerald;

  /// No description provided for @colorAmber.
  ///
  /// In id, this message translates to:
  /// **'Kuning Peringatan'**
  String get colorAmber;

  /// No description provided for @colorPurple.
  ///
  /// In id, this message translates to:
  /// **'Ungu Segel'**
  String get colorPurple;

  /// No description provided for @formatPng.
  ///
  /// In id, this message translates to:
  /// **'PNG (Resolusi Penuh)'**
  String get formatPng;

  /// No description provided for @formatPngDesc.
  ///
  /// In id, this message translates to:
  /// **'Format lossless kualitas asli tanpa penurunan ketajaman'**
  String get formatPngDesc;

  /// No description provided for @formatJpeg.
  ///
  /// In id, this message translates to:
  /// **'JPEG (Ukuran Ringan)'**
  String get formatJpeg;

  /// No description provided for @formatJpegDesc.
  ///
  /// In id, this message translates to:
  /// **'Format terkompresi hemat kuota untuk upload portal cepat'**
  String get formatJpegDesc;

  /// No description provided for @formatPdf.
  ///
  /// In id, this message translates to:
  /// **'Dokumen PDF (Siap Cetak)'**
  String get formatPdf;

  /// No description provided for @formatPdfDesc.
  ///
  /// In id, this message translates to:
  /// **'Format berkas dokumen resmi standar kantor & perbankan'**
  String get formatPdfDesc;

  /// No description provided for @redactBlackout.
  ///
  /// In id, this message translates to:
  /// **'Sensor Hitam (Blackout)'**
  String get redactBlackout;

  /// No description provided for @redactBlackoutDesc.
  ///
  /// In id, this message translates to:
  /// **'Kotak hitam pekat permanen menutup data'**
  String get redactBlackoutDesc;

  /// No description provided for @redactMosaic.
  ///
  /// In id, this message translates to:
  /// **'Sensor Mosaik (Pixelate)'**
  String get redactMosaic;

  /// No description provided for @redactMosaicDesc.
  ///
  /// In id, this message translates to:
  /// **'Efek pikselasi mengaburkan teks sensitif'**
  String get redactMosaicDesc;

  /// No description provided for @redactBlur.
  ///
  /// In id, this message translates to:
  /// **'Sensor Buram (Blur)'**
  String get redactBlur;

  /// No description provided for @redactBlurDesc.
  ///
  /// In id, this message translates to:
  /// **'Efek buram meratakan detail data pribadi'**
  String get redactBlurDesc;

  /// No description provided for @targetNik.
  ///
  /// In id, this message translates to:
  /// **'Nomor NIK / ID'**
  String get targetNik;

  /// No description provided for @targetSignature.
  ///
  /// In id, this message translates to:
  /// **'Tanda Tangan'**
  String get targetSignature;

  /// No description provided for @targetAddress.
  ///
  /// In id, this message translates to:
  /// **'Alamat Lengkap'**
  String get targetAddress;

  /// No description provided for @targetBirthPlace.
  ///
  /// In id, this message translates to:
  /// **'Tempat / Tgl Lahir'**
  String get targetBirthPlace;

  /// No description provided for @targetPhoto.
  ///
  /// In id, this message translates to:
  /// **'Foto Wajah'**
  String get targetPhoto;

  /// No description provided for @shareProofTitle.
  ///
  /// In id, this message translates to:
  /// **'Bukti Proteksi Dokumen'**
  String get shareProofTitle;

  /// No description provided for @shareProofSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Sertifikat integritas watermark & sensor sesuai Kominfo'**
  String get shareProofSubtitle;

  /// No description provided for @shareFormatFeed.
  ///
  /// In id, this message translates to:
  /// **'Unggahan (4:5)'**
  String get shareFormatFeed;

  /// No description provided for @shareFormatStory.
  ///
  /// In id, this message translates to:
  /// **'Story (9:16)'**
  String get shareFormatStory;

  /// No description provided for @shareCopyText.
  ///
  /// In id, this message translates to:
  /// **'Salin Teks'**
  String get shareCopyText;

  /// No description provided for @shareProcessing.
  ///
  /// In id, this message translates to:
  /// **'Memproses...'**
  String get shareProcessing;

  /// No description provided for @shareDownloadProofPng.
  ///
  /// In id, this message translates to:
  /// **'Unduh Bukti PNG'**
  String get shareDownloadProofPng;

  /// No description provided for @shareShareProof.
  ///
  /// In id, this message translates to:
  /// **'Bagikan Bukti'**
  String get shareShareProof;

  /// No description provided for @shareCardBrand.
  ///
  /// In id, this message translates to:
  /// **'IDMARK • SECURE ID'**
  String get shareCardBrand;

  /// No description provided for @shareCardOnDevice.
  ///
  /// In id, this message translates to:
  /// **'100% ON-DEVICE'**
  String get shareCardOnDevice;

  /// No description provided for @shareCardTitle.
  ///
  /// In id, this message translates to:
  /// **'BUKTI PROTEKSI WATERMARK DOKUMEN'**
  String get shareCardTitle;

  /// No description provided for @shareCardPurposeLabel.
  ///
  /// In id, this message translates to:
  /// **'UNTUK KEPERLUAN KHUSUS:'**
  String get shareCardPurposeLabel;

  /// No description provided for @shareCardPrivacyScore.
  ///
  /// In id, this message translates to:
  /// **'SKOR PRIVASI'**
  String get shareCardPrivacyScore;

  /// No description provided for @shareCardRedactions.
  ///
  /// In id, this message translates to:
  /// **'SENSOR'**
  String get shareCardRedactions;

  /// No description provided for @shareCardAreaCount.
  ///
  /// In id, this message translates to:
  /// **'{count} Area'**
  String shareCardAreaCount(int count);

  /// No description provided for @shareCardFormat.
  ///
  /// In id, this message translates to:
  /// **'FORMAT'**
  String get shareCardFormat;

  /// No description provided for @shareCardDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal: {date}'**
  String shareCardDate(String date);

  /// No description provided for @shareCardFooter.
  ///
  /// In id, this message translates to:
  /// **'idmark.faishal.id • Standar Watermark KTP Kominfo RI'**
  String get shareCardFooter;

  /// No description provided for @shareCardIntegrityHash.
  ///
  /// In id, this message translates to:
  /// **'INTEGRITY HASH (SHA-256):'**
  String get shareCardIntegrityHash;

  /// No description provided for @shareProofHeading.
  ///
  /// In id, this message translates to:
  /// **'🛡️ BUKTI PROTEKSI DOKUMEN — IDMARK'**
  String get shareProofHeading;

  /// No description provided for @shareProofPurposeLine.
  ///
  /// In id, this message translates to:
  /// **'📌 Keperluan Khusus: \"{purpose}\"'**
  String shareProofPurposeLine(String purpose);

  /// No description provided for @shareProofDateLine.
  ///
  /// In id, this message translates to:
  /// **'📅 Tanggal Stempel: {date}'**
  String shareProofDateLine(String date);

  /// No description provided for @shareProofScoreLine.
  ///
  /// In id, this message translates to:
  /// **'🔒 Skor Privasi: {score}/100'**
  String shareProofScoreLine(int score);

  /// No description provided for @shareProofRedactionLine.
  ///
  /// In id, this message translates to:
  /// **'✂️ Sensor Permanen: {count} Area Tertutup'**
  String shareProofRedactionLine(int count);

  /// No description provided for @shareProofHashLine.
  ///
  /// In id, this message translates to:
  /// **'🔑 SHA-256: {hash}'**
  String shareProofHashLine(String hash);

  /// No description provided for @shareProofOnDeviceLine.
  ///
  /// In id, this message translates to:
  /// **'✅ Diproses 100% on-device tanpa server (Sesuai Panduan Kominfo RI)'**
  String get shareProofOnDeviceLine;

  /// No description provided for @shareProofCtaLine.
  ///
  /// In id, this message translates to:
  /// **'Lindungi identitas Anda dengan IDMark: https://idmark.faishal.id'**
  String get shareProofCtaLine;

  /// No description provided for @shareProofDownloaded.
  ///
  /// In id, this message translates to:
  /// **'Sertifikat proteksi dokumen berhasil diunduh! 🛡️✨'**
  String get shareProofDownloaded;

  /// No description provided for @shareProofFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal membagikan bukti: {error}'**
  String shareProofFailed(String error);

  /// No description provided for @shareProofCopied.
  ///
  /// In id, this message translates to:
  /// **'Bukti proteksi disalin ke clipboard! 📋✨'**
  String get shareProofCopied;

  /// No description provided for @themeCyberShield.
  ///
  /// In id, this message translates to:
  /// **'Perisai Siber'**
  String get themeCyberShield;

  /// No description provided for @themeEmeraldSafe.
  ///
  /// In id, this message translates to:
  /// **'Zamrud Aman'**
  String get themeEmeraldSafe;

  /// No description provided for @themeObsidianVault.
  ///
  /// In id, this message translates to:
  /// **'Brankas Obsidian'**
  String get themeObsidianVault;

  /// No description provided for @themeAmberProof.
  ///
  /// In id, this message translates to:
  /// **'Bukti Ambar'**
  String get themeAmberProof;

  /// No description provided for @quickSensorShort.
  ///
  /// In id, this message translates to:
  /// **'Sensor Cepat:'**
  String get quickSensorShort;

  /// No description provided for @redactedTag.
  ///
  /// In id, this message translates to:
  /// **'[DISENSOR: {label}]'**
  String redactedTag(String label);

  /// No description provided for @defaultWatermarkText.
  ///
  /// In id, this message translates to:
  /// **'HANYA UNTUK VERIFIKASI IDENTITAS'**
  String get defaultWatermarkText;

  /// No description provided for @pdfHeader.
  ///
  /// In id, this message translates to:
  /// **'IDMARK — DOKUMEN IDENTITAS TER-WATERMARK'**
  String get pdfHeader;

  /// No description provided for @pdfComplianceNote.
  ///
  /// In id, this message translates to:
  /// **'Sesuai Prinsip Pelindungan Data Pribadi (UU No. 27/2022)'**
  String get pdfComplianceNote;

  /// No description provided for @pdfOnDevice.
  ///
  /// In id, this message translates to:
  /// **'100% On-Device'**
  String get pdfOnDevice;

  /// No description provided for @pdfPurposeLabel.
  ///
  /// In id, this message translates to:
  /// **'Tujuan Penggunaan: '**
  String get pdfPurposeLabel;

  /// No description provided for @pdfDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Transaksi: {date}'**
  String pdfDateLabel(String date);

  /// No description provided for @pdfPrintedAt.
  ///
  /// In id, this message translates to:
  /// **'Waktu Cetak: {date}'**
  String pdfPrintedAt(String date);

  /// No description provided for @pdfChecksum.
  ///
  /// In id, this message translates to:
  /// **'SHA-256 Checksum: '**
  String get pdfChecksum;

  /// No description provided for @catEcommerce.
  ///
  /// In id, this message translates to:
  /// **'E-Commerce'**
  String get catEcommerce;

  /// No description provided for @presetBank.
  ///
  /// In id, this message translates to:
  /// **'Pembukaan Rekening Bank'**
  String get presetBank;

  /// No description provided for @presetBankUpdate.
  ///
  /// In id, this message translates to:
  /// **'Pengkinian Data Nasabah Bank'**
  String get presetBankUpdate;

  /// No description provided for @presetFintech.
  ///
  /// In id, this message translates to:
  /// **'Pinjol / Fintech Resmi OJK'**
  String get presetFintech;

  /// No description provided for @presetPaylater.
  ///
  /// In id, this message translates to:
  /// **'Aktivasi Paylater / Kartu Kredit'**
  String get presetPaylater;

  /// No description provided for @presetJob.
  ///
  /// In id, this message translates to:
  /// **'Lamaran Pekerjaan'**
  String get presetJob;

  /// No description provided for @presetHrOnboarding.
  ///
  /// In id, this message translates to:
  /// **'Onboarding Karyawan Baru'**
  String get presetHrOnboarding;

  /// No description provided for @presetRental.
  ///
  /// In id, this message translates to:
  /// **'Sewa Mobil / Motor / Rental'**
  String get presetRental;

  /// No description provided for @presetHotel.
  ///
  /// In id, this message translates to:
  /// **'Check-In Hotel / Villa / Kost'**
  String get presetHotel;

  /// No description provided for @presetTelco.
  ///
  /// In id, this message translates to:
  /// **'Registrasi Kartu SIM Prabayar'**
  String get presetTelco;

  /// No description provided for @presetSimReplace.
  ///
  /// In id, this message translates to:
  /// **'Ganti Kartu SIM Hilang / Rusak'**
  String get presetSimReplace;

  /// No description provided for @presetKredit.
  ///
  /// In id, this message translates to:
  /// **'Pengajuan Leasing / Multifinance'**
  String get presetKredit;

  /// No description provided for @presetKpr.
  ///
  /// In id, this message translates to:
  /// **'Pengajuan KPR / Properti'**
  String get presetKpr;

  /// No description provided for @presetInvestment.
  ///
  /// In id, this message translates to:
  /// **'Akun Sekuritas Saham IDX'**
  String get presetInvestment;

  /// No description provided for @presetCrypto.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Akun Kripto Bappebti'**
  String get presetCrypto;

  /// No description provided for @presetEcommerce.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Merchant Marketplace'**
  String get presetEcommerce;

  /// No description provided for @presetBpjs.
  ///
  /// In id, this message translates to:
  /// **'Klaim JHT / Saldo BPJS'**
  String get presetBpjs;

  /// No description provided for @presetGovKelurahan.
  ///
  /// In id, this message translates to:
  /// **'Administrasi Kependudukan / Kelurahan'**
  String get presetGovKelurahan;

  /// No description provided for @presetGlobalKyc.
  ///
  /// In id, this message translates to:
  /// **'International KYC Verification'**
  String get presetGlobalKyc;

  /// No description provided for @defaultInternalSubtext.
  ///
  /// In id, this message translates to:
  /// **'HANYA UNTUK DOKUMEN INTERNAL'**
  String get defaultInternalSubtext;

  /// No description provided for @pdfLegalNotice.
  ///
  /// In id, this message translates to:
  /// **'PEMBERITAHUAN HUKUM: Salinan dokumen identitas ini hanya sah dan diizinkan untuk tujuan yang tertera di atas. Penggunaan di luar peruntukan tersebut merupakan tindak pidana penyalahgunaan data pribadi.'**
  String get pdfLegalNotice;

  /// No description provided for @validationRedactionLabelRequired.
  ///
  /// In id, this message translates to:
  /// **'Label sensor tidak boleh kosong'**
  String get validationRedactionLabelRequired;

  /// No description provided for @validationRedactionXRange.
  ///
  /// In id, this message translates to:
  /// **'Posisi X sensor harus berada dalam rentang 0.0 - 1.0'**
  String get validationRedactionXRange;

  /// No description provided for @validationRedactionYRange.
  ///
  /// In id, this message translates to:
  /// **'Posisi Y sensor harus berada dalam rentang 0.0 - 1.0'**
  String get validationRedactionYRange;

  /// No description provided for @validationRedactionWidthRange.
  ///
  /// In id, this message translates to:
  /// **'Lebar sensor harus berada dalam rentang >0.0 - 1.0'**
  String get validationRedactionWidthRange;

  /// No description provided for @validationRedactionHeightRange.
  ///
  /// In id, this message translates to:
  /// **'Tinggi sensor harus berada dalam rentang >0.0 - 1.0'**
  String get validationRedactionHeightRange;

  /// No description provided for @validationAuditIdRequired.
  ///
  /// In id, this message translates to:
  /// **'ID audit log tidak boleh kosong'**
  String get validationAuditIdRequired;

  /// No description provided for @validationAuditPurposeRequired.
  ///
  /// In id, this message translates to:
  /// **'Tujuan audit log tidak boleh kosong'**
  String get validationAuditPurposeRequired;

  /// No description provided for @validationAuditHashRequired.
  ///
  /// In id, this message translates to:
  /// **'Hash SHA-256 tidak boleh kosong'**
  String get validationAuditHashRequired;

  /// No description provided for @validationAuditScoreRange.
  ///
  /// In id, this message translates to:
  /// **'Skor privasi harus berada antara 0 dan 100'**
  String get validationAuditScoreRange;
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
