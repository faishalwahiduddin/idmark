# CLAUDE.md — KtpMark

## Overview
KtpMark — Watermark e-KTP & Identitas Aman: bubuhkan cap tujuan verifikasi dan tanggal pada foto/scan e-KTP dan dokumen identitas on-device untuk mencegah penyalahgunaan data pinjol dan penipuan digital. **100% on-device, tanpa backend, tanpa akun, tanpa kirim data.**
Bahasa Indonesia sebagai default.

**Subdomain:** ktpmark.faishal.id · **CF Project:** `ktpmark-faishal` · **appId:** `id.faishal.ktpmark`
**Git remote:** `git@github.com:faishalwahiduddin/ktpmark.git`

## Tech Stack
**Flutter 3.44.8 · Dart 3.12.2 · Riverpod 3.x · GoRouter · Cloudflare**

## Quick Commands
```bash
flutter run -d chrome                                       # Dev server (web)
flutter test                                                # Run all tests
flutter analyze                                             # Static analysis
flutter build web --release                                 # Production web build
flutter build appbundle --release                           # Android App Bundle
```

## Rules & Conventions
1. **Architecture: MVVM + Riverpod (feature-first)** di bawah `lib/features/` dan `lib/core/`.
2. **Offline-first & Zero Server Upload**: Seluruh proses pemuatan foto, pemberian watermark, dan ekspor dilakukan 100% di browser/perangkat pengguna.
3. **No dev servers**: Jangan jalankan dev server atau build kecuali diminta eksplisit.
4. **Validasi Wajib**: Setiap form dan input (teks watermark, tujuan, tanggal, opsi opasitas/rotasi) wajib divalidasi dengan jelas.
5. **CLI Wrappers**: Gunakan `gh-faishal` dan `wrangler-faishal`.
