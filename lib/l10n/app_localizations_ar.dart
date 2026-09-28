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

  @override
  String get selectImageFirst =>
      'يرجى تحديد أو التقاط صورة بطاقة الهوية أولاً.';

  @override
  String checkConfigError(String error) {
    return 'تحقق من الإعدادات: $error';
  }

  @override
  String get watermarkDone => 'اكتملت العلامة المائية!';

  @override
  String get watermarkDoneDesc =>
      'تمت حماية وثيقة الهوية بنجاح بعلامة مائية كاملة الدقة وتغطية دائمة بنسبة 100٪ على الجهاز.';

  @override
  String get hashCopied => 'تم نسخ تجزئة السلامة إلى الحافظة!';

  @override
  String get close => 'إغلاق';

  @override
  String get share => 'مشاركة';

  @override
  String get resetWatermarkTooltip => 'إعادة ضبط العلامة المائية';

  @override
  String get configResetKominfo =>
      'تمت استعادة التهيئة إلى معايير كومينفو الموصى بها.';

  @override
  String get bannerUuPdp =>
      'معيار قانون حماية البيانات الشخصية: أضف علامة مائية للغرض المحدد وتاريخاً واحجب البيانات الحساسة قبل مشاركة صور بطاقة الهوية.';

  @override
  String sensorBoxAdded(String label) {
    return 'تمت إضافة صندوق الحجب \"$label\".';
  }

  @override
  String get processingOnDevice => 'جاري معالجة الوثيقة على الجهاز...';

  @override
  String saveDocument(String format) {
    return 'حفظ الوثيقة ($format)';
  }

  @override
  String get shareDirect => 'مشاركة مباشرة';

  @override
  String failedToExport(String error) {
    return 'فشل تصدير الوثيقة: $error';
  }

  @override
  String shareSubject(String purpose) {
    return 'وثيقة هوية ذات علامة مائية - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'وثيقة هوية آمنة بعلامة مائية عبر IDMark ($purpose) • 100٪ على الجهاز';
  }

  @override
  String get watermarkConfigTitle => 'تهيئة العلامة المائية';

  @override
  String get sensorMaskTab => 'حجب / قناع';

  @override
  String get privacyExifTab => 'الخصوصية وبيانات EXIF';

  @override
  String get exportFormatTab => 'صيغة التصدير';

  @override
  String get watermarkPurposeLabel => 'غرض العلامة المائية (حسب الحاجة)';

  @override
  String get watermarkPurposeHint => 'مثال: التحقق من قرض بنك ABC';

  @override
  String get transactionDate => 'تاريخ المعاملة';

  @override
  String get includeDateChip => 'تضمين التاريخ';

  @override
  String get subtextLabel => 'ملاحظات إضافية / نص فرعي (اختياري)';

  @override
  String get subtextHint => 'مثال: لاستكمال الملفات الداخلية فقط';

  @override
  String get patternLabel => 'نمط ختم العلامة المائية (7 أنماط)';

  @override
  String get colorLabel => 'لون ختم العلامة المائية';

  @override
  String get opacityLevel => 'مستوى العتامة (الشفافية)';

  @override
  String get watermarkFontSize => 'حجم خط العلامة المائية';

  @override
  String get rotationAngle => 'زاوية الدوران';

  @override
  String get redactionIntro =>
      'قم بتغطية البيانات الحيوية مثل التوقيعات أو أرقام الهوية غير المتعلقة بالمعاملة لتقليل مخاطر سرقة الهوية.';

  @override
  String get quickSensorLabel => 'إضافة حجب سريع:';

  @override
  String get sensorNik => 'حجب رقم الهوية';

  @override
  String get sensorSignature => 'حجب التوقيع';

  @override
  String get sensorAddress => 'حجب العنوان';

  @override
  String get sensorBirthDate => 'حجب تاريخ الميلاد';

  @override
  String get customArea => 'منطقة مخصصة';

  @override
  String get noRedactionsYet => 'لا توجد مناطق محجوبة بعد.';

  @override
  String get deleteSensorTooltip => 'حذف الحجب';

  @override
  String get sensorTypeLabel => 'نوع الحجب:';

  @override
  String positionX(int percent) {
    return 'الموضع الأفقي ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'الموضع الرأسي ($percent%)';
  }

  @override
  String get privacyComplianceIndex => 'مؤشر الامتثال لخصوصية المستندات';

  @override
  String get complianceChecklistTitle =>
      'قائمة الامتثال لقانون حماية البيانات رقم 27/2022:';

  @override
  String get checkPurposeTitle => 'غرض استخدام محدد';

  @override
  String get checkPurposeDesc =>
      'يقيد الاستخدام حتى لا يمكن تحويل النسخة إلى معاملات أخرى';

  @override
  String get checkDateTitle => 'تضمين تاريخ المعاملة';

  @override
  String get checkDateDesc =>
      'يحدد فترة صلاحية المستند لمنع إساءة استخدامه مستقبلاً';

  @override
  String get checkExifTitle => 'تنظيف بيانات EXIF والموقع الجغرافي';

  @override
  String get checkExifDesc =>
      'يزيل إحداثيات الموقع الجغرافي للمنزل من ملفات الصور';

  @override
  String get checkSensorTitle => 'حجب الأجزاء الحساسة (رقم الهوية / التوقيع)';

  @override
  String get checkSensorDesc => 'يخفي المعلومات التي لا يشترطها المستلم';

  @override
  String get autoSanitizeExifTitle => 'تنظيف تلقائي لبيانات EXIF';

  @override
  String get autoSanitizeExifDesc =>
      'إزالة علامات بيانات الكاميرا وطراز الهاتف وإحداثيات GPS تلقائياً عند التصدير';

  @override
  String get chooseExportFormat => 'اختر صيغة المستند الناتجة:';

  @override
  String get jpegCompressionQuality => 'جودة ضغط JPEG';

  @override
  String protectionGrade(String grade, int score) {
    return 'الحماية $grade ($score%)';
  }

  @override
  String get viewingOriginal => 'عرض الأصل';

  @override
  String get holdToCompare => 'استمر بالضغط: مقارنة';

  @override
  String activeWatermarkWithCount(int count) {
    return 'العلامة المائية نشطة ($count حجب)';
  }

  @override
  String get activeWatermarkPreview => 'معاينة العلامة المائية النشطة';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get deleteImage => 'حذف الصورة';

  @override
  String get uploadIdPhoto => 'رفع صورة بطاقة الهوية / إثبات الشخصية';

  @override
  String get uploadIdPhotoDesc =>
      'حدد صورة بطاقة الهوية أو رخصة القيادة أو جواز السفر لإضافة ختم الغرض والتاريخ وحجب البيانات الحساسة.';

  @override
  String get onDeviceBadge =>
      '100٪ على الجهاز • لا يتم إرسال الصور إلى أي خادم أبداً';

  @override
  String get openGallery => 'فتح المعرض';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get historyAndAuditLog => 'السجل وسجل التدقيق';

  @override
  String get clearAllHistoryTooltip => 'مسح كل السجل';

  @override
  String get localPrivacyAuditLog => 'سجل تدقيق الخصوصية المحلي';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return 'تم ختم ما مجموعه $count وثيقة بأمان بنسبة 100٪ على الجهاز. يتم تخزين هذا السجل على جهازك فقط.';
  }

  @override
  String get searchHistoryHint => 'البحث في سجل أغراض المستندات...';

  @override
  String get noWatermarkedDocsYet => 'لا توجد مستندات ذات علامة مائية بعد';

  @override
  String get noWatermarkedDocsDesc =>
      'المستندات التي أضفت إليها علامة مائية وقم بتصديرها سيتم تسجيل عمليات تدقيقها هنا.';

  @override
  String get noHistoryFound => 'لم يتم العثور على سجل يطابق بحثك.';

  @override
  String scoreLabel(int score) {
    return 'الدرجة $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count حجب حساس';
  }

  @override
  String get exifSanitized => 'تم تنظيف EXIF';

  @override
  String get sha256Copied => 'تم نسخ تجزئة SHA-256 إلى الحافظة!';

  @override
  String get clearHistoryConfirmTitle => 'مسح كل السجل؟';

  @override
  String get clearHistoryConfirmBody =>
      'سيتم مسح قائمة سجل التدقيق على جهازك بشكل دائم.';

  @override
  String get historyClearedSuccess => 'تم مسح السجل بنجاح.';

  @override
  String get templatePresetHub => 'مركز القوالب والإعدادات المسبقة';

  @override
  String get createPresetTooltip => 'إنشاء إعداد مسبق جديد';

  @override
  String get officialTemplateCatalog => 'دليل قوالب العلامات المائية الرسمية';

  @override
  String get officialTemplateDesc =>
      'اختر قوالب مصرفية أو لطلبات التوظيف، أو أنشئ إعدادات مسبقة مخصصة محفوظة على جهازك.';

  @override
  String get searchTemplateHint =>
      'البحث في القوالب (بنك، قرض، موارد بشرية، تمويل عقاري، إيجار)...';

  @override
  String showingTemplatesCount(int count) {
    return 'عرض $count قالب';
  }

  @override
  String get createCustom => 'إنشاء مخصص';

  @override
  String get noTemplatesFound => 'لم يتم العثور على قوالب تطابق عامل التصفية.';

  @override
  String get customBadge => 'مخصص';

  @override
  String get deleteCustomPresetTooltip => 'حذف الإعداد المسبق المخصص';

  @override
  String get activeBadge => 'نشط';

  @override
  String patternInfo(String pattern) {
    return 'النمط: $pattern';
  }

  @override
  String get usePreset => 'استخدام الإعداد المسبق';

  @override
  String presetApplied(String title) {
    return 'تم تطبيق الإعداد المسبق \"$title\" بنجاح!';
  }

  @override
  String get createNewCustomPreset => 'إنشاء إعداد مسبق مخصص جديد';

  @override
  String get presetName => 'اسم الإعداد المسبق';

  @override
  String get presetNameHint => 'مثال: التحقق من المنحة الدراسية';

  @override
  String get category => 'الفئة';

  @override
  String get categoryHint => 'مثال: تعليم / مخصص';

  @override
  String get purposeTemplateText => 'نص نموذج الغرض';

  @override
  String get purposeTemplateHint => 'مثال: التقديم على المنحة 2026';

  @override
  String get additionalSubtext => 'نص فرعي إضافي';

  @override
  String get subtextTemplateHint => 'ملاحظات داخلية';

  @override
  String get stampPattern => 'نمط الختم';

  @override
  String get savePreset => 'حفظ الإعداد المسبق';

  @override
  String customPresetSaved(String title) {
    return 'تم حفظ الإعداد المسبق المخصص \"$title\"!';
  }

  @override
  String get deletePresetConfirmTitle => 'حذف الإعداد المسبق؟';

  @override
  String deletePresetConfirmBody(String title) {
    return 'سيتم حذف الإعداد المسبق \"$title\" من قائمة القوالب المحلية لديك.';
  }

  @override
  String get presetDeletedSuccess => 'تم حذف الإعداد المسبق بنجاح.';

  @override
  String get protectDigitalId => 'احمِ هويتك الرقمية';

  @override
  String get protectDigitalIdDesc =>
      'تتطلب وزارة الاتصالات وقانون حماية البيانات رقم 27/2022 توخي الحذر عند مشاركة صور بطاقة الهوية لمنع استخدامها كضمان لقروض احتيالية أو فتح حسابات وهمية.';

  @override
  String get safeSharingChecklist =>
      'قائمة التحقق الآمنة قبل إرسال بطاقة الهوية';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 مكتمل';
  }

  @override
  String get checkItem1 =>
      'اسم المؤسسة/المستلم مكتوب بوضوح على العلامة المائية';

  @override
  String get checkItem2 => 'تاريخ أحدث معاملة مضمن في الختم';

  @override
  String get checkItem3 =>
      'العلامة المائية تعبر فوق بيانات النص حتى لا يمكن قصها';

  @override
  String get checkItem4 => 'حجب التوقيع إذا لم يطلب موثق البيانات نموذج توقيع';

  @override
  String get checkItem5 => 'تمت إزالة بيانات EXIF وإحداثيات GPS من الصورة';

  @override
  String get zeroServerTitle => 'خصوصية مطلقة (صفر رفع إلى الخادم)';

  @override
  String get zeroServerDesc =>
      'يعمل IDMark بنسبة 100٪ في متصفحك أو جهازك المحلي. لا يتم إرسال صور الهوية أو تخزينها أو معالجتها على أي خادم خارجي.';

  @override
  String get dataSecuritySanitation => 'تنظيف البيانات والأمان';

  @override
  String get autoExifSubtitle =>
      'إزالة علامات إحداثيات GPS ونوع الكاميرا من الصور المصدرة';

  @override
  String get defaultExportFormat => 'صيغة التصدير الافتراضية';

  @override
  String get localDeviceStorage => 'التخزين المحلي للجهاز';

  @override
  String get resetDefaultsDesc =>
      'استعادة القوالب وإعدادات النص إلى الإعدادات الافتراضية الأصلية';

  @override
  String get appLabel => 'التطبيق';

  @override
  String get officialKominfoGuide => 'Panduan Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Pengaturan';
}
