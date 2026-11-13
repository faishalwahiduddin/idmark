---
type: Reference
title: Design System Foundations
description: Visual tokens and theme for IDMark.
status: active
last-updated: 2026-11-13
---

# Foundations — IDMark

SSOT: [`DESIGN.md`](../../../DESIGN.md) · Panduan ini diturunkan dari kode tema yang ada, bukan sebaliknya: bila nilai di sini berbeda dengan kode, kodelah yang benar — perbarui dokumen ini.

## Sumber token di kode

- [`lib/core/constants/app_colors.dart`](../../../lib/core/constants/app_colors.dart)
- [`lib/core/theme/app_theme.dart`](../../../lib/core/theme/app_theme.dart)
- [`lib/core/theme/app_motion.dart`](../../../lib/core/theme/app_motion.dart) (durasi & kurva gerak)

## Tema

- **Material 3** (`useMaterial3: true`).
- **Terang + gelap**: `theme` dan `darkTheme` dipasang di `lib/main.dart`.

## Palet warna

Nilai dibaca dari konstanta `Color(0x…)` di berkas sumber. Gunakan lewat nama token, jangan menyalin heksa.

### `app_colors.dart`

| Token | Nilai | Catatan |
|---|---|---|
| `primary` | `#0284C7` | Sky 600 |
| `primaryDark` | `#0369A1` | Sky 700 |
| `primaryLight` | `#38BDF8` | Sky 400 |
| `secondary` | `#0F172A` | Slate 900 |
| `accent` | `#10B981` | Emerald 500 |
| `warning` | `#F59E0B` | Amber 500 |
| `danger` | `#EF4444` | Red 500 |
| `accentText` | `#6EE7B7` | Emerald 300 |
| `warningText` | `#FCD34D` | Amber 300 |
| `bgDark` | `#090D16` |  |
| `bgSurface` | `#111827` |  |
| `bgCard` | `#1F2937` |  |
| `border` | `#374151` |  |
| `lightBg` | `#F8FAFC` |  |
| `lightSurface` | `#FFFFFF` |  |
| `lightBorder` | `#E2E8F0` |  |
| `lightTextPrimary` | `#0F172A` |  |
| `lightTextSecondary` | `#64748B` |  |
| `watermarkRed` | `#DC2626` |  |
| `watermarkBlue` | `#2563EB` |  |
| `watermarkDark` | `#1E293B` |  |
| `watermarkWhite` | `#F8FAFC` |  |
| `watermarkEmerald` | `#059669` |  |
| `watermarkAmber` | `#D97706` |  |
| `watermarkPurple` | `#7C3AED` |  |

### Literal heksa tambahan di berkas tema

Nilai berikut dipakai langsung (tanpa nama token) di berkas sumber di atas:

`#047857`, `#075985`, `#334155`, `#475569`, `#94A3B8`, `#B91C1C`, `#CBD5E1`, `#F1F5F9`

Utang token: bila sebuah nilai dipakai berulang, angkat jadi konstanta bernama (DS-3).

## Tipografi

- Tidak ada keluarga font kustom ter-bundle di `pubspec.yaml`; teks memakai font bawaan platform.
- `fontFamily: 'monospace'` dipakai di 5 tempat di `lib/`.

## Radius

Nilai `BorderRadius.circular(...)` yang dipakai di tema/`main.dart`: `10`, `12`, `18`, `20`.

## Motion

Dari `AppMotion`: `fast` 150 ms, `base` 250 ms, `slow` 350 ms. Selalu resolve lewat `AppMotion.resolve(context, d)` agar mode reduced-motion dihormati (durasi menjadi nol).

## Aksesibilitas

- `AppTextScale` (`lib/core/a11y/text_scale.dart`) membatasi skala teks platform maksimum 1.6×; setiap layar harus bertahan di 1.6× tanpa terpotong.
- Target sentuh minimal 44pt lewat `TapTarget` (`lib/core/ui/tap_target.dart`).
- Kontras teks minimal WCAG AA 4.5:1 di kedua tema (DS-6).
