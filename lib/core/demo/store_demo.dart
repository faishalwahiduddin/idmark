import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localizations.dart';
import '../models/audit_log_entry.dart';
import '../models/watermark_config.dart';
import '../storage/local_storage_service.dart';
import '../utils/app_timezone.dart';
import '../utils/l10n_helpers.dart';

/// Store-screenshot mode: `--dart-define=STORE_DEMO=true`.
/// Without the flag nothing in this file runs.
const bool kStoreDemo = bool.fromEnvironment('STORE_DEMO');

/// Eight watermark purposes per locale (no personal data, generic parties).
const Map<String, List<String>> _purposes = {
  'en': [
    'BANK ACCOUNT OPENING - NORTHWIND BANK',
    'APARTMENT RENTAL APPLICATION',
    'JOB APPLICATION - HR SCREENING',
    'MOBILE PLAN REGISTRATION',
    'CAR RENTAL VERIFICATION',
    'LOAN VERIFICATION - BANK ABC',
    'HOTEL CHECK-IN VERIFICATION',
    'INSURANCE CLAIM SUBMISSION',
  ],
  'id': [
    'PEMBUKAAN REKENING - BANK NUSANTARA',
    'PENGAJUAN SEWA APARTEMEN',
    'LAMARAN KERJA - SELEKSI HR',
    'REGISTRASI PAKET SELULER',
    'VERIFIKASI SEWA MOBIL',
    'VERIFIKASI PINJAMAN BANK ABC',
    'VERIFIKASI CHECK-IN HOTEL',
    'PENGAJUAN KLAIM ASURANSI',
  ],
  'ar': [
    'فتح حساب مصرفي - بنك الشمال',
    'طلب استئجار شقة',
    'طلب وظيفة - فرز الموارد البشرية',
    'تسجيل باقة اتصالات',
    'التحقق لتأجير سيارة',
    'التحقق لطلب قرض - بنك ABC',
    'التحقق لتسجيل الوصول بالفندق',
    'تقديم مطالبة تأمين',
  ],
  'ja': [
    '銀行口座開設 - ノースウィンド銀行',
    'マンション賃貸申込',
    '求人応募 - 人事審査',
    'モバイル回線の契約',
    'レンタカー本人確認',
    'ローン審査 - ABC銀行',
    'ホテルチェックイン確認',
    '保険金請求の提出',
  ],
  'zh': [
    '银行开户 - 北风银行',
    '公寓租赁申请',
    '求职申请 - 人事初筛',
    '手机套餐办理',
    '租车身份核验',
    '贷款核验 - ABC银行',
    '酒店入住核验',
    '保险理赔提交',
  ],
  'es': [
    'APERTURA DE CUENTA - BANCO NORTE',
    'SOLICITUD DE ALQUILER DE PISO',
    'CANDIDATURA - FILTRO DE RRHH',
    'ALTA DE LÍNEA MÓVIL',
    'VERIFICACIÓN DE ALQUILER DE COCHE',
    'VERIFICACIÓN DE PRÉSTAMO - BANCO ABC',
    'VERIFICACIÓN DE CHECK-IN EN HOTEL',
    'ENVÍO DE PARTE DE SEGURO',
  ],
};

const _hashes = [
  '9f2c1ab47e03d5568c0be7a1d4f92e63b81a50c7d3e49f6a2b7c08d1e5f3a964',
  '3b7e90d4a1c85f26e0794bd3c6a18f52d90e47b3a6c1f08e25d7b94a0c63e1f8',
  'c41a8e57b20d93f6a85e1c7043bd9e62f08a37d5c1b64e90a2f7d83c5e16b0a9',
  '7d05f3b8e1a46c92d07be5384fa1c60d93e2b87a45f0c16d8e39a2b7f504c1de',
  'e86b24a0d7c13f95b68e0a42d1f7c3598ab06e4d27f1c93b5d80a6e3f1749b2c',
  '1a9d6e30c57b84f2a01e9d3b68c4f705d2a8e13b96c0f47a5e82d1b3c906f7a4',
  'b52f8c17e4a09d63f1b72e8a05c3d946e0f18b7a2d5c634e90a1f8b3d72c5e06',
  '48e0a7c3d1f95b26e8a04d7b3c1f62e950b8a4d3e7c1f9068a2d5b4e1c73f0a8',
];

/// Offsets (days ago) and hours for the 8 exports: spread over ~7 weeks.
const _daysAgo = [0, 1, 3, 6, 11, 18, 29, 47];
const _hours = [9, 16, 11, 14, 10, 19, 13, 8];
const _patterns = [
  WatermarkPattern.diagonalBand,
  WatermarkPattern.securitySeal,
  WatermarkPattern.repeatedGrid,
  WatermarkPattern.crossStamp,
  WatermarkPattern.diagonalBand,
  WatermarkPattern.qrBadge,
  WatermarkPattern.bottomBar,
  WatermarkPattern.cornerStamp,
];
const _sizesKb = [412, 1286, 836, 2145, 598, 944, 377, 1712];
const _redactions = [2, 3, 1, 2, 0, 3, 1, 2];
const _scores = [100, 95, 85, 100, 70, 95, 65, 85];

/// Seeds an 8-entry audit history, a localized current config and the
/// onboarding gate. Idempotent. Entries carry metadata only (no images).
Future<void> seedStoreDemo(LocalStorageService storage) async {
  final SharedPreferences prefs = storage.prefs;
  if (!kStoreDemo || prefs.getBool('store_demo_seeded') == true) return;
  await prefs.setBool('onboarding_completed', true);

  final saved = prefs.getString('locale');
  final code = saved ?? ui.PlatformDispatcher.instance.locale.languageCode;
  final purposes = _purposes[code] ??
      (code == 'jv' || code == 'su' ? _purposes['id']! : _purposes['en']!);
  final l10n = lookupAppLocalizations(
    AppLocalizations.supportedLocales.any((l) => l.languageCode == code)
        ? Locale(code)
        : const Locale('en'),
  );

  final now = AppTimeZone.nowUtc();
  final logs = <AuditLogEntry>[
    for (var i = 0; i < purposes.length; i++)
      AuditLogEntry(
        id: 'audit_demo_$i',
        timestamp: DateTime.utc(
          now.year,
          now.month,
          now.day - _daysAgo[i],
          _hours[i],
          10 + i * 4,
        ),
        purpose: purposes[i],
        pattern: _patterns[i].labelOf(l10n),
        exportFormat: i == 3 || i == 5 ? 'PDF' : 'PNG',
        fileSizeBytes: _sizesKb[i] * 1024 + 313 * (i + 1),
        sha256Hash: _hashes[i],
        redactionsCount: _redactions[i],
        metadataStripped: i != 4,
        privacyScore: _scores[i],
      ),
  ];
  await storage.saveAuditLogs(logs);

  await storage.saveConfig(
    WatermarkConfig.defaultConfig().copyWith(purpose: purposes[5]),
  );
  await prefs.setBool('store_demo_seeded', true);
}
