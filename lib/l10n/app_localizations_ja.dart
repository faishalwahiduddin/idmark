// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => '安全なID透かし';

  @override
  String get tabWatermark => '透かし';

  @override
  String get tabPreset => 'プリセット';

  @override
  String get tabHistory => '履歴';

  @override
  String get tabGuide => 'ガイド';

  @override
  String get tabSettings => '設定';

  @override
  String get settings => '設定';

  @override
  String get appearance => '外観';

  @override
  String get theme => 'テーマ';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム';

  @override
  String get selectTheme => 'テーマを選択';

  @override
  String get language => '言語';

  @override
  String get selectLanguage => '言語を選択';

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
  String get about => '約';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get edit => '編集';

  @override
  String get reset => 'リセット';

  @override
  String get kominfoGuide => 'Kominfoガイド';

  @override
  String get history => '履歴ログ';

  @override
  String get presets => 'ユーザープリセット';

  @override
  String get resetDefaults => 'デフォルトにリセット';

  @override
  String get resetWarningTitle => '設定をリセットしますか？';

  @override
  String get resetWarningBody => '透かしの設定はデフォルトに復元されます。';

  @override
  String get aboutApp => 'アプリについて';

  @override
  String get appVersion => 'バージョン';

  @override
  String get appDomain => 'ドメイン';

  @override
  String get appCompliance => 'コンプライアンス';

  @override
  String get appProvider => 'プロバイダー';

  @override
  String get clearHistory => 'クリア';

  @override
  String get historyCleared => '履歴がクリアされました。';

  @override
  String get preferencesReset => '設定がリセットされました。';

  @override
  String get guideRules => '透かしの4つのルール';

  @override
  String get guideRule1Title => '名前と目的を書く';

  @override
  String get guideRule1Desc => '「検証」とだけ書かないでください。悪用を防ぐために完全に書いてください。';

  @override
  String get guideRule2Title => '完全な日付を含める';

  @override
  String get guideRule2Desc => '有効期間を制限するために日付を追加します。';

  @override
  String get guideRule3Title => '斜めに配置';

  @override
  String get guideRule3Desc => 'テキストの上に透かしを半透明に斜めに配置します。';

  @override
  String get guideRule4Title => '署名を隠す';

  @override
  String get guideRule4Desc => 'ドキュメントの偽造を防ぐために署名を隠します。';

  @override
  String get warningRejectTitle => '透かしを拒否する当事者に注意';

  @override
  String get warningRejectDesc => '透かしのない写真を要求するアプリに注意してください。';

  @override
  String get verifiedOfficial => '★ 公式検証済み ★';

  @override
  String get dateLabel => '日付';

  @override
  String get verifyIdentity => '本人確認';

  @override
  String get idmarkVerified => 'IDMARK確認済み';

  @override
  String get privacySettings => 'プライバシー';

  @override
  String get autoStripExif => 'EXIFを削除';

  @override
  String get autoStripExifDesc => 'GPS位置データを削除';

  @override
  String historySubtitle(int count) {
    return '$count 件の記録が保存されました';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count 個のテンプレートが保存されました';
  }

  @override
  String get selectImageFirst => '最初に身分証明書の写真を選択または撮影してください。';

  @override
  String checkConfigError(String error) {
    return '設定を確認してください: $error';
  }

  @override
  String get watermarkDone => '透かし完了！';

  @override
  String get watermarkDoneDesc =>
      '身分証明書は、100%デバイス上の完全な解像度の透かしと永続的な墨消しで正常に保護されました。';

  @override
  String get hashCopied => '整合性ハッシュをクリップボードにコピーしました！';

  @override
  String get close => '閉じる';

  @override
  String get share => '共有';

  @override
  String get resetWatermarkTooltip => '透かしをリセット';

  @override
  String get configResetKominfo => '設定が通信省の推奨標準にリセットされました。';

  @override
  String get bannerUuPdp =>
      '個人情報保護法基準: 身分証明書の写真を共有する前に、具体的な目的の透かしと日付を追加し、機密データを墨消ししてください。';

  @override
  String sensorBoxAdded(String label) {
    return '墨消しボックス「$label」が追加されました。';
  }

  @override
  String get processingOnDevice => '端末上でドキュメントを処理中...';

  @override
  String saveDocument(String format) {
    return 'ドキュメントを保存 ($format)';
  }

  @override
  String get shareDirect => '直接共有';

  @override
  String failedToExport(String error) {
    return 'ドキュメントのエクスポートに失敗しました: $error';
  }

  @override
  String shareSubject(String purpose) {
    return '透かし入り身分証明書 - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'IDMarkで安全に透かしを入れた身分証明書 ($purpose) • 100% デバイス上';
  }

  @override
  String get watermarkConfigTitle => '透かし設定';

  @override
  String get sensorMaskTab => '墨消し / マスク';

  @override
  String get privacyExifTab => 'プライバシーとEXIF';

  @override
  String get exportFormatTab => 'エクスポート形式';

  @override
  String get watermarkPurposeLabel => '透かしの目的（必要に応じて）';

  @override
  String get watermarkPurposeHint => '例：ABC銀行ローン審査用';

  @override
  String get transactionDate => '取引日';

  @override
  String get includeDateChip => '日付を含める';

  @override
  String get subtextLabel => '補足 / サブテキスト（任意）';

  @override
  String get subtextHint => '例：内部書類手続きのみ有効';

  @override
  String get patternLabel => '透かしスタンプパターン（7種類）';

  @override
  String get colorLabel => '透かしスタンプの色';

  @override
  String get opacityLevel => '不透明度（透明度）';

  @override
  String get watermarkFontSize => '透かし文字サイズ';

  @override
  String get rotationAngle => '回転角度';

  @override
  String get redactionIntro => '取引に関係のない署名や身分証明書番号の一部を隠すことで、身元盗用のリスクを最小限に抑えます。';

  @override
  String get quickSensorLabel => 'クイック墨消し追加:';

  @override
  String get sensorNik => '身元番号墨消し';

  @override
  String get sensorSignature => '署名墨消し';

  @override
  String get sensorAddress => '住所墨消し';

  @override
  String get sensorBirthDate => '生年月日墨消し';

  @override
  String get customArea => 'カスタム領域';

  @override
  String get noRedactionsYet => 'まだ墨消しエリアはありません。';

  @override
  String get deleteSensorTooltip => '墨消しを削除';

  @override
  String get sensorTypeLabel => '墨消しタイプ:';

  @override
  String positionX(int percent) {
    return 'X位置 ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'Y位置 ($percent%)';
  }

  @override
  String get privacyComplianceIndex => 'ドキュメントプライバシー準拠指数';

  @override
  String get complianceChecklistTitle => '個人データ保護法2022年第27号コンプライアンスチェックリスト:';

  @override
  String get checkPurposeTitle => '具体的な使用目的';

  @override
  String get checkPurposeDesc => 'コピーが他の取引に流用されるのを防ぎます';

  @override
  String get checkDateTitle => '取引日を明記';

  @override
  String get checkDateDesc => '文書の有効期限を限定し、将来の不正使用を防ぎます';

  @override
  String get checkExifTitle => 'EXIFおよびGPSメタデータを消去';

  @override
  String get checkExifDesc => '写真ファイルから自宅のGPS位置情報を削除します';

  @override
  String get checkSensorTitle => '重要項目の墨消し（身元番号 / 署名）';

  @override
  String get checkSensorDesc => '受取人が必須としない情報を非表示にします';

  @override
  String get autoSanitizeExifTitle => 'EXIFメタデータの自動消去';

  @override
  String get autoSanitizeExifDesc => 'エクスポート時にカメラ情報、端末機種、GPS座標を自動消去します';

  @override
  String get chooseExportFormat => '出力ドキュメント形式を選択:';

  @override
  String get jpegCompressionQuality => 'JPEG圧縮品質';

  @override
  String protectionGrade(String grade, int score) {
    return '保護等級 $grade ($score%)';
  }

  @override
  String get viewingOriginal => '元画像を表示中';

  @override
  String get holdToCompare => '長押し: 比較';

  @override
  String activeWatermarkWithCount(int count) {
    return '透かし適用中 ($count箇所の墨消し)';
  }

  @override
  String get activeWatermarkPreview => 'アクティブな透かしプレビュー';

  @override
  String get changePhoto => '写真を変更';

  @override
  String get deleteImage => '画像を削除';

  @override
  String get uploadIdPhoto => '身分証明書 / ID写真をアップロード';

  @override
  String get uploadIdPhotoDesc =>
      '身分証明書、運転免許証、パスポートの写真を選択し、目的のスタンプ、日付、および重要項目の墨消しを追加します。';

  @override
  String get onDeviceBadge => '100%端末内処理 • 画像がサーバーに送信されることはありません';

  @override
  String get openGallery => 'ギャラリーを開く';

  @override
  String get takePhoto => '写真を撮影';

  @override
  String get historyAndAuditLog => '履歴と監査ログ';

  @override
  String get clearAllHistoryTooltip => 'すべての履歴を消去';

  @override
  String get localPrivacyAuditLog => 'ローカルプライバシー監査ログ';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return '合計 $count 件の文書が端末内で100%安全に処理されました。この記録はお使いの端末にのみ保存されます。';
  }

  @override
  String get searchHistoryHint => 'ドキュメントの目的履歴を検索...';

  @override
  String get noWatermarkedDocsYet => '透かし入り文書はまだありません';

  @override
  String get noWatermarkedDocsDesc => '透かしを入れてエクスポートしたドキュメントの監査ログがここに記録されます。';

  @override
  String get noHistoryFound => '検索に一致する履歴は見つかりませんでした。';

  @override
  String scoreLabel(int score) {
    return 'スコア $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count 箇所の重要墨消し';
  }

  @override
  String get exifSanitized => 'EXIF消去済み';

  @override
  String get sha256Copied => 'SHA-256ハッシュをクリップボードにコピーしました！';

  @override
  String get clearHistoryConfirmTitle => 'すべての履歴を消去しますか？';

  @override
  String get clearHistoryConfirmBody => '端末上の監査ログリストは完全に消去されます。';

  @override
  String get historyClearedSuccess => '履歴が正常に消去されました。';

  @override
  String get templatePresetHub => 'テンプレート＆プリセットハブ';

  @override
  String get createPresetTooltip => '新しいプリセットを作成';

  @override
  String get officialTemplateCatalog => '公式透かしテンプレートカタログ';

  @override
  String get officialTemplateDesc =>
      '銀行や求人応募用の標準テンプレートを選択するか、デバイスに保存される独自のカスタムプリセットを作成します。';

  @override
  String get searchTemplateHint => 'テンプレートを検索（銀行、ローン、HR、住宅ローン、レンタル）...';

  @override
  String showingTemplatesCount(int count) {
    return '$count 件のテンプレートを表示中';
  }

  @override
  String get createCustom => 'カスタム作成';

  @override
  String get noTemplatesFound => '条件に一致するテンプレートは見つかりませんでした。';

  @override
  String get customBadge => 'カスタム';

  @override
  String get deleteCustomPresetTooltip => 'カスタムプリセットを削除';

  @override
  String get activeBadge => 'アクティブ';

  @override
  String patternInfo(String pattern) {
    return 'パターン: $pattern';
  }

  @override
  String get usePreset => 'プリセットを使用';

  @override
  String presetApplied(String title) {
    return 'プリセット「$title」が適用されました！';
  }

  @override
  String get createNewCustomPreset => '新しいカスタムプリセットを作成';

  @override
  String get presetName => 'プリセット名';

  @override
  String get presetNameHint => '例：奨学金申請確認';

  @override
  String get category => 'カテゴリ';

  @override
  String get categoryHint => '例：教育 / カスタム';

  @override
  String get purposeTemplateText => '目的テンプレートのテキスト';

  @override
  String get purposeTemplateHint => '例：2026年度奨学金申請';

  @override
  String get additionalSubtext => '追加サブテキスト';

  @override
  String get subtextTemplateHint => '内部メモ';

  @override
  String get stampPattern => 'スタンプパターン';

  @override
  String get savePreset => 'プリセットを保存';

  @override
  String customPresetSaved(String title) {
    return 'カスタムプリセット「$title」が保存されました！';
  }

  @override
  String get deletePresetConfirmTitle => 'プリセットを削除しますか？';

  @override
  String deletePresetConfirmBody(String title) {
    return 'プリセット「$title」はローカルテンプレートリストから削除されます。';
  }

  @override
  String get presetDeletedSuccess => 'プリセットが削除されました。';

  @override
  String get protectDigitalId => 'デジタルIDを保護';

  @override
  String get protectDigitalIdDesc =>
      '通信情報省および個人情報保護法は、不正なオンラインローンの担保や架空口座の開設を防ぐため、身分証の写真を共有する際には注意を払うよう求めています。';

  @override
  String get safeSharingChecklist => '身分証送信前の安全チェックリスト';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 完了';
  }

  @override
  String get checkItem1 => '機関名・受取人名が透かしに明記されている';

  @override
  String get checkItem2 => 'スタンプに最新の取引日が含まれている';

  @override
  String get checkItem3 => '切り取られないように透かしがテキストデータに重なっている';

  @override
  String get checkItem4 => '認証側が署名見本を要求しない場合は署名を墨消しする';

  @override
  String get checkItem5 => 'EXIFメタデータとGPS座標が画像から削除されている';

  @override
  String get zeroServerTitle => '絶対的なプライバシー（サーバー送信ゼロ）';

  @override
  String get zeroServerDesc =>
      'IDMarkは100%ブラウザまたはローカル端末内で動作します。身分証明書画像が外部サーバーに送信、保存、処理されることは一切ありません。';

  @override
  String get dataSecuritySanitation => 'データクリーンアップとセキュリティ';

  @override
  String get autoExifSubtitle => 'エクスポートされた写真からGPS座標やカメラ機種などのメタデータを削除します';

  @override
  String get defaultExportFormat => 'デフォルトのエクスポート形式';

  @override
  String get localDeviceStorage => '端末ローカルストレージ';

  @override
  String get resetDefaultsDesc => 'テンプレートとテキスト設定を初期値に戻す';

  @override
  String get appLabel => 'アプリ';

  @override
  String get officialKominfoGuide => 'Panduan Resmi Kominfo & UU PDP';

  @override
  String get privacyAndSettings => 'Privasi & Pengaturan';
}
