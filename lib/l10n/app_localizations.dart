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
