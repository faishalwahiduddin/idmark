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
}
