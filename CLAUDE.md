# CLAUDE.md — IDMark

## Overview
IDMark — Secure ID Card & Document Watermark: Stamp custom verification purpose & date onto national IDs (e-KTP, Aadhaar, MyKad), passports, and driver's licenses on-device to prevent fraud, identity theft, and unauthorized re-use. **100% on-device, zero server upload, no account needed.**
Bahasa Indonesia & English support.

**Subdomain:** idmark.faishal.id · **CF Project:** `idmark-faishal` · **appId:** `id.faishal.idmark`
**Git remote:** `git@github.com:faishalwahiduddin/idmark.git`

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
