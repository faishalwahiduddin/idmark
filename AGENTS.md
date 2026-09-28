# AGENTS.md — IDMark (idmark)

> Guidelines for AI agents working in this Flutter codebase.
> Workspace root: `../` · Canonical fleet guide: [`../AGENTS.md`](../AGENTS.md)

## Mulai di sini (60 detik)

<!-- trace:begin start-here -->
- **App**: `idmark` (IDMark) — IDMark — Secure ID Card & Document Watermark: Stamp custom verification purpose & date onto national IDs (e-KTP), passports, and driver's licenses on-device to protect identity privacy and prevent fraud.
- **Platform & jalankan**: Flutter Web (Cloudflare Pages `idmark-faishal` → https://idmark.faishal.id) + Android + iOS. `flutter run -d chrome` untuk web, `flutter run -d <device>` untuk mobile. applicationId: `id.faishal.idmark`.
- **Branch**: `main` = default dan rilis.
- **Cek**: `flutter analyze && flutter test` sebelum commit — wajib nol peringatan.
- **CLI**: `gh-faishal` (remote `faishalwahiduddin/idmark`) dan `wrangler-faishal` — jangan bare `gh`/`wrangler`.
- **Validasi (§VAL)**: Di setiap project tanpa kecuali, setiap input, form, dan mutation wajib divalidasi di frontend dan backend.
- **Larangan**: Jangan menjalankan dev server (`flutter run`) atau `flutter build` kecuali diminta secara eksplisit oleh pengguna.
<!-- trace:end -->

## Quick Commands

```bash
flutter run -d chrome                                       # Dev server (web)
flutter test                                                # Run all tests
flutter analyze                                             # Static analysis (run before every commit)
flutter build web --release                                 # Production web build
flutter build apk --release                                 # Android APK
flutter build appbundle --release                           # Android App Bundle (Play Store)
```

## Project Overview

**IDMark** — Global Privacy & Identity Shield: Client-side watermarking tool for sensitive identity documents (Indonesian e-KTP, international ID cards, passports, driving licenses). It burns non-removable purpose and timestamp stamps directly into image pixels on-device without transmitting a single byte to external servers.

- **Ecosystem**: Privacy & Utility Fleet
- **Subdomain**: https://idmark.faishal.id
- **Application ID**: `id.faishal.idmark`
- **Repository**: `faishalwahiduddin/idmark`

## Domain Terminology

| Term (ID) | Term (EN) | Context |
|-----------|-----------|---------|
| Watermark e-KTP / ID | ID Watermark | Protective stamp with purpose and transaction timestamp |
| Tujuan Verifikasi | Verification Purpose | Explicit reason for document use (e.g. Bank Account, Job Application, Rental) |
| Tanggal Cap | Timestamp Stamp | Explicit validation date limiting the lifetime of the copy |
| Pola Pita Melintang | Diagonal Band | Standard diagonal stripe across key details to prevent cropping |
| Pola Grid Berulang | Repeated Grid | Tiled repetitive pattern for maximum fraud prevention |
| Sensor / Redaksi | Redaction | Masking sensitive elements (e.g. signature or partial digits) |
| Pemrosesan Lokal | Client-Side Render | 100% on-device canvas rendering without network dependencies |

## Mandatory Rules

1. **Privasi Mutlak (Zero Server Upload)**: Foto dokumen identitas TIDAK PERNAH dikirim ke server/cloud manapun. Semua rendering dan manipulasi gambar wajib dilakukan secara lokal (client-side / on-device).
2. **Preset Siap Pakai & Global Ready**: Sediakan preset tujuan populer baik lokal (e-KTP Kominfo) maupun global (KYC Bank, Job Application, Car Rental, SIM Verification).
3. **Fleksibilitas Watermark**: Pengguna dapat mengatur teks custom, tanggal otomatis, warna/kontras cap, tingkat opasitas (transparansi), dan pola (diagonal, grid, bottom bar, corner stamp).
4. **Ekspor Resolusi Penuh**: Hasil akhir dirender dengan resolusi asli gambar input tanpa degradasi berlebihan agar tetap terbaca oleh pihak verifikator yang sah.
5. **Tanpa backend, tanpa akun**: Aplikasi langsung siap dipakai tanpa registrasi, tanpa tracking data sensitif pengguna.
