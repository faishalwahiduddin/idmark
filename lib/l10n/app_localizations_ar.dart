// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'علامة مائية آمنة';

  @override
  String get tabWatermark => 'علامة مائية';

  @override
  String get tabPreset => 'مسبق الضبط';

  @override
  String get tabHistory => 'السجل';

  @override
  String get tabGuide => 'الدليل';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appearance => 'المظهر';

  @override
  String get theme => 'السمة';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';

  @override
  String get selectTheme => 'اختر السمة';

  @override
  String get language => 'اللغة';

  @override
  String get selectLanguage => 'اختر اللغة';

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
  String get about => 'حول';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get kominfoGuide => 'دليل كومينفو';

  @override
  String get history => 'سجل التدقيق';

  @override
  String get presets => 'إعدادات المستخدم';

  @override
  String get resetDefaults => 'استعادة الافتراضيات';

  @override
  String get resetWarningTitle => 'إعادة تعيين التفضيلات؟';

  @override
  String get resetWarningBody =>
      'سيتم استعادة إعدادات العلامة المائية إلى الافتراضيات.';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get appVersion => 'الإصدار';

  @override
  String get appDomain => 'النطاق';

  @override
  String get appCompliance => 'معيار الامتثال';

  @override
  String get appProvider => 'المزود';

  @override
  String get clearHistory => 'مسح';

  @override
  String get historyCleared => 'تم مسح السجل.';

  @override
  String get preferencesReset => 'تمت إعادة تعيين التفضيلات.';

  @override
  String get guideRules => '٤ قواعد رئيسية للعلامة المائية';

  @override
  String get guideRule1Title => 'اكتب الاسم والغرض';

  @override
  String get guideRule1Desc =>
      'لا تكتب \"تحقق\" فقط. اكتب بالكامل لمنع إساءة الاستخدام.';

  @override
  String get guideRule2Title => 'تضمين التاريخ الكامل';

  @override
  String get guideRule2Desc => 'أضف التاريخ للحد من فترة صلاحية المستند.';

  @override
  String get guideRule3Title => 'وضع بشكل قطري';

  @override
  String get guideRule3Desc => 'ضع العلامة المائية بشكل قطري عبر النص.';

  @override
  String get guideRule4Title => 'إخفاء التوقيعات';

  @override
  String get guideRule4Desc => 'قم بتغطية توقيعك لمنع تزوير المستندات.';

  @override
  String get warningRejectTitle => 'احذر من الرفض';

  @override
  String get warningRejectDesc =>
      'اشتبه في التطبيقات التي تتطلب صورًا بدون علامة مائية.';

  @override
  String get verifiedOfficial => '★ تم التحقق رسميًا ★';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get verifyIdentity => 'التحقق من الهوية';

  @override
  String get idmarkVerified => 'تم التحقق بواسطة IDMARK';

  @override
  String get privacySettings => 'الخصوصية';

  @override
  String get autoStripExif => 'إزالة EXIF';

  @override
  String get autoStripExifDesc => 'إزالة بيانات GPS';

  @override
  String historySubtitle(int count) {
    return 'تم حفظ $count سجل';
  }

  @override
  String presetsSubtitle(int count) {
    return 'تم حفظ $count قالب';
  }
}
