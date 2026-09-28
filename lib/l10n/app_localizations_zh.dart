// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => '安全身份证水印';

  @override
  String get tabWatermark => '水印';

  @override
  String get tabPreset => '预设';

  @override
  String get tabHistory => '历史';

  @override
  String get tabGuide => '指南';

  @override
  String get tabSettings => '设置';

  @override
  String get settings => '设置';

  @override
  String get appearance => '外观';

  @override
  String get theme => '主题';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '系统';

  @override
  String get selectTheme => '选择主题';

  @override
  String get language => '语言';

  @override
  String get selectLanguage => '选择语言';

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
  String get about => '关于';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get reset => '重置';

  @override
  String get kominfoGuide => 'Kominfo指南';

  @override
  String get history => '审计日志';

  @override
  String get presets => '用户预设';

  @override
  String get resetDefaults => '重置为默认值';

  @override
  String get resetWarningTitle => '重置首选项？';

  @override
  String get resetWarningBody => '水印设置将恢复为默认值。';

  @override
  String get aboutApp => '关于应用';

  @override
  String get appVersion => '版本';

  @override
  String get appDomain => '域';

  @override
  String get appCompliance => '合规标准';

  @override
  String get appProvider => '提供者';

  @override
  String get clearHistory => '清除';

  @override
  String get historyCleared => '历史记录已清除。';

  @override
  String get preferencesReset => '首选项已重置。';

  @override
  String get guideRules => '水印四大规则';

  @override
  String get guideRule1Title => '写明名称和目的';

  @override
  String get guideRule1Desc => '不要只写“验证”。写完整以防止滥用。';

  @override
  String get guideRule2Title => '包含完整日期';

  @override
  String get guideRule2Desc => '添加日期以限制文档的有效期。';

  @override
  String get guideRule3Title => '对角线放置';

  @override
  String get guideRule3Desc => '将水印半透明地对角放置在文本上。';

  @override
  String get guideRule4Title => '隐藏签名';

  @override
  String get guideRule4Desc => '覆盖您的签名以防止伪造文档。';

  @override
  String get warningRejectTitle => '警惕拒绝水印的各方';

  @override
  String get warningRejectDesc => '警惕要求提供无水印照片的应用程序。';

  @override
  String get verifiedOfficial => '★ 官方验证 ★';

  @override
  String get dateLabel => '日期';

  @override
  String get verifyIdentity => '身份验证';

  @override
  String get idmarkVerified => 'IDMARK验证';

  @override
  String get privacySettings => '隐私';

  @override
  String get autoStripExif => '去除EXIF';

  @override
  String get autoStripExifDesc => '去除GPS位置数据';

  @override
  String historySubtitle(int count) {
    return '保存了 $count 条记录';
  }

  @override
  String presetsSubtitle(int count) {
    return '保存了 $count 个模板';
  }
}
