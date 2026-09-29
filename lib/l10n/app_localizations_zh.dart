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

  @override
  String get selectImageFirst => '请先选择或拍摄身份证照片。';

  @override
  String checkConfigError(String error) {
    return '检查配置：$error';
  }

  @override
  String get watermarkDone => '水印已完成！';

  @override
  String get watermarkDoneDesc => '您的身份证明文件已通过全分辨率水印和永久遮盖获得保护，100%在设备端处理。';

  @override
  String get hashCopied => '完整性哈希已复制到剪贴板！';

  @override
  String get close => '关闭';

  @override
  String get share => '分享';

  @override
  String get resetWatermarkTooltip => '重置水印';

  @override
  String get configResetKominfo => '配置已重置为通信部推荐的标准。';

  @override
  String get bannerUuPdp => '个人数据保护法标准：在共享身份证照片之前，请添加明确用途的水印、日期并遮蔽敏感数据。';

  @override
  String sensorBoxAdded(String label) {
    return '已添加遮蔽框 \"$label\"。';
  }

  @override
  String get processingOnDevice => '正在设备端处理文件...';

  @override
  String saveDocument(String format) {
    return '保存文件 ($format)';
  }

  @override
  String get shareDirect => '直接分享';

  @override
  String failedToExport(String error) {
    return '导出文档失败：$error';
  }

  @override
  String shareSubject(String purpose) {
    return '已加水印的身份文件 - $purpose';
  }

  @override
  String shareText(String purpose) {
    return '通过 IDMark 安全加水印的身份证明文件 ($purpose) • 100% 设备端';
  }

  @override
  String get watermarkConfigTitle => '水印配置';

  @override
  String get sensorMaskTab => '遮盖 / 屏蔽';

  @override
  String get privacyExifTab => '隐私与 EXIF';

  @override
  String get exportFormatTab => '导出格式';

  @override
  String get watermarkPurposeLabel => '水印用途（按需填写）';

  @override
  String get watermarkPurposeHint => '例如：某银行贷款验证';

  @override
  String get transactionDate => '交易日期';

  @override
  String get includeDateChip => '包含日期';

  @override
  String get subtextLabel => '附加说明 / 副标题（可选）';

  @override
  String get subtextHint => '例如：仅用于内部归档';

  @override
  String get patternLabel => '水印图样风格（7种样式）';

  @override
  String get colorLabel => '水印印章颜色';

  @override
  String get opacityLevel => '不透明度（透明程度）';

  @override
  String get watermarkFontSize => '水印文字大小';

  @override
  String get rotationAngle => '旋转角度';

  @override
  String get redactionIntro => '遮盖与本次交易无关的签名或身份证号等重要信息，最大限度降低身份被盗用风险。';

  @override
  String get quickSensorLabel => '快速添加遮盖：';

  @override
  String get sensorNik => '遮蔽身份证号';

  @override
  String get sensorSignature => '遮蔽手写签名';

  @override
  String get sensorAddress => '遮蔽住址';

  @override
  String get sensorBirthDate => '遮蔽出生日期';

  @override
  String get customArea => '自定义区域';

  @override
  String get noRedactionsYet => '尚未添加任何遮盖区域。';

  @override
  String get deleteSensorTooltip => '删除遮盖';

  @override
  String get sensorTypeLabel => '遮盖类型：';

  @override
  String positionX(int percent) {
    return 'X 轴位置 ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'Y 轴位置 ($percent%)';
  }

  @override
  String get privacyComplianceIndex => '文件隐私合规指数';

  @override
  String get complianceChecklistTitle => '个人数据保护法第 27/2022 号合规清单：';

  @override
  String get checkPurposeTitle => '明确使用用途';

  @override
  String get checkPurposeDesc => '限制副本用途，防止挪作其他交易';

  @override
  String get checkDateTitle => '标明交易日期';

  @override
  String get checkDateDesc => '限制文件有效期，避免在未来被滥用';

  @override
  String get checkExifTitle => '清除 EXIF 和 GPS 元数据';

  @override
  String get checkExifDesc => '从照片文件中移除家庭地理坐标位置';

  @override
  String get checkSensorTitle => '遮蔽核心隐私（身份证号 / 签名）';

  @override
  String get checkSensorDesc => '隐藏接收方未强制要求的非必要隐私信息';

  @override
  String get autoSanitizeExifTitle => '自动清除 EXIF 元数据';

  @override
  String get autoSanitizeExifDesc => '导出时自动移除相机拍摄参数、手机型号及 GPS 坐标标签';

  @override
  String get chooseExportFormat => '选择输出文档格式：';

  @override
  String get jpegCompressionQuality => 'JPEG 压缩质量';

  @override
  String protectionGrade(String grade, int score) {
    return '防护等级 $grade ($score%)';
  }

  @override
  String get viewingOriginal => '查看原图';

  @override
  String get holdToCompare => '长按：对比';

  @override
  String activeWatermarkWithCount(int count) {
    return '已启用水印 ($count处遮盖)';
  }

  @override
  String get activeWatermarkPreview => '水印预览中';

  @override
  String get changePhoto => '更换照片';

  @override
  String get deleteImage => '删除图像';

  @override
  String get uploadIdPhoto => '上传身份证 / 身份证明照片';

  @override
  String get uploadIdPhotoDesc => '选择身份证、驾照或护照照片，以添加用途图章、日期和核心数据遮蔽。';

  @override
  String get onDeviceBadge => '100% 设备本地 • 照片绝不上送任何服务器';

  @override
  String get openGallery => '从相册选择';

  @override
  String get takePhoto => '拍照';

  @override
  String get historyAndAuditLog => '历史与审计日志';

  @override
  String get clearAllHistoryTooltip => '清空所有历史';

  @override
  String get localPrivacyAuditLog => '本地隐私审计日志';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return '共有 $count 份文件在设备本地完成安全水印盖章。记录仅保留在您的设备中。';
  }

  @override
  String get searchHistoryHint => '搜索文档用途历史...';

  @override
  String get noWatermarkedDocsYet => '暂无加水印文件';

  @override
  String get noWatermarkedDocsDesc => '您已成功添加水印并导出的文档将在此记录审计日志。';

  @override
  String get noHistoryFound => '未找到与搜索匹配的历史记录。';

  @override
  String scoreLabel(int score) {
    return '得分 $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count 处敏感遮盖';
  }

  @override
  String get exifSanitized => 'EXIF 已清除';

  @override
  String get sha256Copied => 'SHA-256 哈希已复制到剪贴板！';

  @override
  String get clearHistoryConfirmTitle => '清空所有历史记录？';

  @override
  String get clearHistoryConfirmBody => '设备上的所有审计日志将被永久清除。';

  @override
  String get historyClearedSuccess => '历史记录已成功清除。';

  @override
  String get templatePresetHub => '模板与预设中心';

  @override
  String get createPresetTooltip => '创建新预设';

  @override
  String get officialTemplateCatalog => '官方水印模板目录';

  @override
  String get officialTemplateDesc => '选择银行业务、求职等标准模板，或创建保存在设备上的自定义预设。';

  @override
  String get searchTemplateHint => '搜索模板（银行、贷款、HR、抵押贷款、租赁）...';

  @override
  String showingTemplatesCount(int count) {
    return '展示 $count 个模板';
  }

  @override
  String get createCustom => '创建自定义';

  @override
  String get noTemplatesFound => '未找到符合筛选条件的模板。';

  @override
  String get customBadge => '自定义';

  @override
  String get deleteCustomPresetTooltip => '删除自定义预设';

  @override
  String get activeBadge => '使用中';

  @override
  String patternInfo(String pattern) {
    return '样式：$pattern';
  }

  @override
  String get usePreset => '使用此预设';

  @override
  String presetApplied(String title) {
    return '预设 \"$title\" 已成功应用！';
  }

  @override
  String get createNewCustomPreset => '创建新自定义预设';

  @override
  String get presetName => '预设名称';

  @override
  String get presetNameHint => '例如：奖学金申请认证';

  @override
  String get category => '分类';

  @override
  String get categoryHint => '例如：教育 / 自定义';

  @override
  String get purposeTemplateText => '用途模板文本';

  @override
  String get purposeTemplateHint => '例如：2026奖学金申请';

  @override
  String get additionalSubtext => '附加副标题';

  @override
  String get subtextTemplateHint => '内部备注';

  @override
  String get stampPattern => '图章样式';

  @override
  String get savePreset => '保存预设';

  @override
  String customPresetSaved(String title) {
    return '自定义预设 \"$title\" 已保存！';
  }

  @override
  String get deletePresetConfirmTitle => '删除预设？';

  @override
  String deletePresetConfirmBody(String title) {
    return '预设 \"$title\" 将从您的本地模板列表中移除。';
  }

  @override
  String get presetDeletedSuccess => '预设已成功删除。';

  @override
  String get protectDigitalId => '保护您的数字身份';

  @override
  String get protectDigitalIdDesc =>
      '通信与信息技术部及个人数据保护法规定，在分享身份证照片时必须保持谨慎，以防被用于非法网贷担保或虚假账户开户。';

  @override
  String get safeSharingChecklist => '发送身份证前的安全检查清单';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 已完成';
  }

  @override
  String get checkItem1 => '水印上清晰写明机构/接收方名称';

  @override
  String get checkItem2 => '印章上包含当前交易日期';

  @override
  String get checkItem3 => '水印横跨文字数据以防被裁剪';

  @override
  String get checkItem4 => '若验证方无需签名样本，请遮盖手写签名';

  @override
  String get checkItem5 => '已从图像中清除 EXIF 元数据和 GPS 坐标';

  @override
  String get zeroServerTitle => '绝对隐私（零服务器上传）';

  @override
  String get zeroServerDesc =>
      'IDMark 100% 运行在您的浏览器或本地设备上。身份证照片绝不会被发送、存储或在任何外部服务器上处理。';

  @override
  String get dataSecuritySanitation => '数据清理与安全';

  @override
  String get autoExifSubtitle => '从导出的照片中移除 GPS 坐标和相机型号等元数据';

  @override
  String get defaultExportFormat => '默认导出格式';

  @override
  String get localDeviceStorage => '本地设备存储';

  @override
  String get resetDefaultsDesc => '将模板和文本设置恢复为出厂默认设置';

  @override
  String get appLabel => '应用';

  @override
  String get officialKominfoGuide => 'Panduan Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Pengaturan';

  @override
  String get appLanguage => '应用语言';
}
