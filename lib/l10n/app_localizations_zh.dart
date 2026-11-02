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
  String get localeIndonesian => '印度尼西亚语';

  @override
  String get localeEnglish => '英语';

  @override
  String get localeArabic => '阿拉伯语';

  @override
  String get localeJavanese => '爪哇语';

  @override
  String get localeSundanese => '巽他语';

  @override
  String get localeChinese => '中文';

  @override
  String get localeJapanese => '日语';

  @override
  String get localeSpanish => '西班牙语';

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
  String get officialKominfoGuide => 'Kominfo 与个人数据保护法官方指南';

  @override
  String get privacyAndSettings => '隐私与设置';

  @override
  String get appLanguage => '应用语言';

  @override
  String get timezone => '时区';

  @override
  String get timezoneAuto => '自动（根据设备）';

  @override
  String get licenseUsageTitle => '使用许可';

  @override
  String get licenseUsageNotice => '个人及非营利性用途免费使用。';

  @override
  String get licenseUsageBadgeText => '个人与非营利';

  @override
  String get validationPurposeRequired => '水印用途不能为空';

  @override
  String get validationPurposeMinLength => '用途至少需要 3 个字符';

  @override
  String get validationPurposeMaxLength => '用途不能超过 60 个字符';

  @override
  String get validationSubtextMaxLength => '附加说明不能超过 80 个字符';

  @override
  String get validationOpacityRange => '不透明度必须在 10% 到 100% 之间';

  @override
  String get validationFontSizeRange => '字体大小必须在 10 到 60 pt 之间';

  @override
  String get validationRotationRange => '旋转角度必须在 -90° 到 +90° 之间';

  @override
  String get validationImageBytesEmpty => '图片文件为空或已损坏';

  @override
  String get validationImageBytesTooLarge => '图片大小超过最大限制';

  @override
  String get validationQualityRange => '图片质量必须在 10% 到 100% 之间';

  @override
  String get validationPresetTitleRequired => '预设名称不能为空';

  @override
  String get validationPresetTitleMinLength => '预设名称至少需要 3 个字符';

  @override
  String get validationPresetTitleMaxLength => '预设名称不能超过 50 个字符';

  @override
  String get validationPresetCategoryRequired => '预设分类不能为空';

  @override
  String get validationPresetCategoryMaxLength => '分类不能超过 30 个字符';

  @override
  String get privacyGradeDescMax => '最高防护 • 符合数据安全与合规标准';

  @override
  String get privacyGradeDescVeryGood => '防护良好 • 文件可安全共享';

  @override
  String get privacyGradeDescFair => '防护适中 • 建议添加日期并遮盖证件号码';

  @override
  String get privacyGradeDescWeak => '防护较弱 • 请添加特定用途和日期';

  @override
  String get appTitle => 'IDMark';

  @override
  String get appTagline => '在身份证、驾照和重要文件照片上添加文字水印。';

  @override
  String get appSubtitle => '身份与隐私防护';

  @override
  String get onbSkip => '跳过';

  @override
  String get onbNext => '下一步';

  @override
  String get onbGetStarted => '立即开始';

  @override
  String get onbPrivacyHeadline => '隐私与离线双重保障';

  @override
  String get onbPrivacyDetail => '所有数据都安全保存在您的设备上，没有任何跟踪器。';

  @override
  String get onbSlide1Title => '身份印章';

  @override
  String get onbSlide1Sub => '文件上的用途与日期';

  @override
  String get onbSlide1Badge => '100% 离线且私密';

  @override
  String get onbSlide2Title => '预设模板';

  @override
  String get onbSlide2Sub => '可直接使用的模板';

  @override
  String get onbSlide2Badge => '轻量且流畅';

  @override
  String get onbSlide3Title => '历史记录';

  @override
  String get onbSlide3Sub => '印章结果已保存';

  @override
  String get onbSlide3Badge => '无广告、免账号';

  @override
  String get onbSlide4Title => '本地处理';

  @override
  String get onbSlide4Sub => '不上传至云端';

  @override
  String get onbSlide4Badge => '数据保存在设备上';

  @override
  String get loadingLabel => '加载中…';

  @override
  String get download => '下载';

  @override
  String downloadSuccess(String filename) {
    return '已下载带水印的文件（$filename）！🛡️✨';
  }

  @override
  String get protectionProof => '保护凭证';

  @override
  String get tierExemplary => '典范';

  @override
  String get tierDisciplined => '自律';

  @override
  String get tierOrderly => '有序';

  @override
  String get tierStarting => '起步';

  @override
  String disciplineCount(int count, String tier) {
    return '$count 个带水印文件 • $tier';
  }

  @override
  String get disciplineDesc => '每次安全导出都会提升你的文档保护习惯。';

  @override
  String get shareDiscipline => '分享记录';

  @override
  String disciplineShareText(int count, String tier) {
    return '$count 个带水印文件 • $tier #IDMark';
  }

  @override
  String get allTemplates => '全部';

  @override
  String get myPresets => '我的预设';

  @override
  String get catBanking => '银行';

  @override
  String get catFinance => '金融与借贷';

  @override
  String get catCareer => '求职与人力资源';

  @override
  String get catRental => '租车与旅行';

  @override
  String get catTelecom => '电信';

  @override
  String get catMultifinance => '多元金融';

  @override
  String get catInvestment => '投资';

  @override
  String get catPublicService => '公共服务';

  @override
  String get catInternational => '国际';

  @override
  String get appearanceAndLanguage => '外观与语言';

  @override
  String get themeMode => '主题模式';

  @override
  String get identity => '身份';

  @override
  String get patternDiagonalBand => '斜向条带';

  @override
  String get patternDiagonalBandDesc => '一条粗斜线横跨文件中央（Kominfo 推荐）';

  @override
  String get patternRepeatedGrid => '重复网格';

  @override
  String get patternRepeatedGridDesc => '整张照片铺满重复文字，实现最大防护';

  @override
  String get patternBottomBar => '底部条带';

  @override
  String get patternBottomBarDesc => '文件底部一条实心文字条';

  @override
  String get patternCornerStamp => '角落印章';

  @override
  String get patternCornerStampDesc => '右下角的验证印章';

  @override
  String get patternSecuritySeal => '圆形官方印章';

  @override
  String get patternSecuritySealDesc => '带验证边框的双层圆形印章';

  @override
  String get patternCrossStamp => '双交叉条带';

  @override
  String get patternCrossStampDesc => '两条交叉斜线保护整份文件';

  @override
  String get patternQrBadge => '二维码验证徽章';

  @override
  String get patternQrBadgeDesc => '二维码徽章，验证用途与日期的真实性';

  @override
  String get colorWhite => '纯白';

  @override
  String get colorDark => '深黑';

  @override
  String get colorRed => '官方红';

  @override
  String get colorBlue => '验证蓝';

  @override
  String get colorEmerald => '安全绿';

  @override
  String get colorAmber => '警示黄';

  @override
  String get colorPurple => '印章紫';

  @override
  String get formatPng => 'PNG（全分辨率）';

  @override
  String get formatPngDesc => '无损格式，保留原始清晰度';

  @override
  String get formatJpeg => 'JPEG（体积更小）';

  @override
  String get formatJpegDesc => '压缩格式，节省流量，便于快速上传';

  @override
  String get formatPdf => 'PDF 文档（可直接打印）';

  @override
  String get formatPdfDesc => '办公室与银行通用的正式文件格式';

  @override
  String get redactBlackout => '黑色遮挡';

  @override
  String get redactBlackoutDesc => '永久覆盖数据的纯黑方块';

  @override
  String get redactMosaic => '马赛克遮挡';

  @override
  String get redactMosaicDesc => '像素化效果模糊敏感文字';

  @override
  String get redactBlur => '模糊遮挡';

  @override
  String get redactBlurDesc => '模糊效果抹平个人数据细节';

  @override
  String get targetNik => '身份证号';

  @override
  String get targetSignature => '签名';

  @override
  String get targetAddress => '完整地址';

  @override
  String get targetBirthPlace => '出生地／日期';

  @override
  String get targetPhoto => '人脸照片';

  @override
  String get shareProofTitle => '文件保护凭证';

  @override
  String get shareProofSubtitle => '符合 Kominfo 的水印与遮挡完整性证书';

  @override
  String get shareFormatFeed => '动态 (4:5)';

  @override
  String get shareFormatStory => '快拍 (9:16)';

  @override
  String get shareCopyText => '复制文本';

  @override
  String get shareProcessing => '处理中…';

  @override
  String get shareDownloadProofPng => '下载凭证 PNG';

  @override
  String get shareShareProof => '分享凭证';

  @override
  String get shareCardBrand => 'IDMARK • 安全身份';

  @override
  String get shareCardOnDevice => '100% 本地处理';

  @override
  String get shareCardTitle => '文件水印保护凭证';

  @override
  String get shareCardPurposeLabel => '专门用途：';

  @override
  String get shareCardPrivacyScore => '隐私评分';

  @override
  String get shareCardRedactions => '遮挡';

  @override
  String shareCardAreaCount(int count) {
    return '$count 处';
  }

  @override
  String get shareCardFormat => '格式';

  @override
  String shareCardDate(String date) {
    return '日期：$date';
  }

  @override
  String get shareCardFooter => 'idmark.faishal.id • Kominfo 印尼身份证水印标准';

  @override
  String get shareCardIntegrityHash => '完整性哈希（SHA-256）：';

  @override
  String get shareProofHeading => '🛡️ 文件保护凭证 — IDMARK';

  @override
  String shareProofPurposeLine(String purpose) {
    return '📌 专门用途：\"$purpose\"';
  }

  @override
  String shareProofDateLine(String date) {
    return '📅 盖章日期：$date';
  }

  @override
  String shareProofScoreLine(int score) {
    return '🔒 隐私评分：$score/100';
  }

  @override
  String shareProofRedactionLine(int count) {
    return '✂️ 永久遮挡：$count 处已覆盖';
  }

  @override
  String shareProofHashLine(String hash) {
    return '🔑 SHA-256 哈希：$hash';
  }

  @override
  String get shareProofOnDeviceLine => '✅ 100% 本地处理，无服务器（符合 Kominfo RI 指南）';

  @override
  String get shareProofCtaLine => '用 IDMark 保护你的身份：https://idmark.faishal.id';

  @override
  String get shareProofDownloaded => '文件保护证书已下载！🛡️✨';

  @override
  String shareProofFailed(String error) {
    return '分享凭证失败：$error';
  }

  @override
  String get shareProofCopied => '保护凭证已复制到剪贴板！📋✨';

  @override
  String get themeCyberShield => '赛博护盾';

  @override
  String get themeEmeraldSafe => '翡翠安全';

  @override
  String get themeObsidianVault => '黑曜石保险库';

  @override
  String get themeAmberProof => '琥珀凭证';

  @override
  String get quickSensorShort => '快速遮挡：';

  @override
  String redactedTag(String label) {
    return '[已遮挡：$label]';
  }

  @override
  String get defaultWatermarkText => '仅用于身份验证';

  @override
  String get pdfHeader => 'IDMARK — 带水印的身份文件';

  @override
  String get pdfComplianceNote => '符合个人数据保护原则（第 27/2022 号法律）';

  @override
  String get pdfOnDevice => '100% 本地处理';

  @override
  String get pdfPurposeLabel => '使用用途：';

  @override
  String pdfDateLabel(String date) {
    return '交易日期：$date';
  }

  @override
  String pdfPrintedAt(String date) {
    return '打印时间：$date';
  }

  @override
  String get pdfChecksum => 'SHA-256 校验和：';

  @override
  String get catEcommerce => '电子商务';

  @override
  String get presetBank => '开立银行账户';

  @override
  String get presetBankUpdate => '银行客户资料更新';

  @override
  String get presetFintech => 'OJK 持牌金融科技／借贷';

  @override
  String get presetPaylater => '先享后付／信用卡开通';

  @override
  String get presetJob => '求职申请';

  @override
  String get presetHrOnboarding => '新员工入职';

  @override
  String get presetRental => '汽车／摩托车租赁';

  @override
  String get presetHotel => '酒店／别墅／公寓入住';

  @override
  String get presetTelco => '预付费 SIM 卡注册';

  @override
  String get presetSimReplace => 'SIM 卡丢失／损坏补办';

  @override
  String get presetKredit => '租赁／多元金融申请';

  @override
  String get presetKpr => '房贷／房产申请';

  @override
  String get presetInvestment => 'IDX 股票证券账户';

  @override
  String get presetCrypto => 'Bappebti 加密账户验证';

  @override
  String get presetEcommerce => '电商平台商家验证';

  @override
  String get presetBpjs => 'BPJS 公积金／余额提取';

  @override
  String get presetGovKelurahan => '户籍／街道办事处事务';

  @override
  String get presetGlobalKyc => '国际 KYC 验证';

  @override
  String get defaultInternalSubtext => '仅供内部文件使用';

  @override
  String get pdfLegalNotice =>
      '法律声明：本身份证件副本仅在上述用途范围内有效且获准使用。任何超出该用途的使用均构成滥用个人数据的刑事犯罪。';

  @override
  String get validationRedactionLabelRequired => '遮挡标签不能为空';

  @override
  String get validationRedactionXRange => '遮挡 X 位置必须在 0.0 到 1.0 之间';

  @override
  String get validationRedactionYRange => '遮挡 Y 位置必须在 0.0 到 1.0 之间';

  @override
  String get validationRedactionWidthRange => '遮挡宽度必须在 0.0 到 1.0 之间';

  @override
  String get validationRedactionHeightRange => '遮挡高度必须在 0.0 到 1.0 之间';

  @override
  String get validationAuditIdRequired => '审计日志 ID 不能为空';

  @override
  String get validationAuditPurposeRequired => '审计日志用途不能为空';

  @override
  String get validationAuditHashRequired => 'SHA-256 哈希不能为空';

  @override
  String get validationAuditScoreRange => '隐私评分必须在 0 到 100 之间';
}
