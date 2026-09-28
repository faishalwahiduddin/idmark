# AGENTS.md — KtpMark (ktpmark)

> Guidelines for AI agents working in this Flutter codebase.
> Workspace root: `../` · Canonical fleet guide: [`../AGENTS.md`](../AGENTS.md)

## Mulai di sini (60 detik)

<!-- trace:begin start-here -->
- **App**: `ktpmark` (KtpMark) — KtpMark — Watermark e-KTP & Identitas Aman: bubuhkan cap tujuan verifikasi dan tanggal pada foto/scan e-KTP on-device untuk cegah penyalahgunaan data pinjol & verifikasi digital.
- **Platform & jalankan**: Flutter Web (Cloudflare Pages `ktpmark-faishal` → https://ktpmark.faishal.id) + Android + iOS. `flutter run -d chrome` untuk web, `flutter run -d <device>` untuk mobile. applicationId: `id.faishal.ktpmark`.
- **Branch**: `main` = default dan rilis.
- **Cek**: `flutter analyze && flutter test` sebelum commit — wajib nol peringatan.
- **CLI**: `gh-faishal` (remote `faishalwahiduddin/ktpmark`) dan `wrangler-faishal` — jangan bare `gh`/`wrangler`.
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

**KtpMark** — KtpMark — Watermark e-KTP & Identitas Aman: aplikasi pelindung privasi identitas warga Indonesia yang membubuhkan cap tujuan dan tanggal (rekomendasi Kominfo) langsung ke foto/scan e-KTP, SIM, Paspor, atau KK tanpa mengirim data ke server.

- **Ecosystem**: Privacy & Utility Fleet
- **Subdomain**: https://ktpmark.faishal.id
- **Application ID**: `id.faishal.ktpmark`
- **Repository**: `faishalwahiduddin/ktpmark`

## Domain Terminology

| Term (ID) | Term (EN) | Context |
|-----------|-----------|---------|
| Watermark e-KTP | ID Watermark | Teks cap pelindung berisikan tujuan verifikasi dan tanggal transaksi |
| Tujuan Verifikasi | Verification Purpose | Alasan penggunaan KTP (misal: Verifikasi Rekening Bank, Lamaran Kerja, Sewa Kendaraan) |
| Tanggal Cap | Timestamp Stamp | Tanggal sah berlakunya dokumen untuk membatasi masa pakai salinan |
| Penempatan Melintang | Diagonal Pattern / Band | Penempatan watermark menyilang di atas informasi penting agar sulit dihapus/di-crop |
| Redaksi Sensitif | Sensitive Redaction | Opsi sensor tanda tangan atau bagian sensitif tertentu |
| On-Device Processing | Local Client-Side Render | Pemrosesan piksel 100% lokal di browser/perangkat pengguna tanpa server |

## Mandatory Rules

1. **Privasi Mutlak (Zero Server Upload)**: Foto dokumen KTP TIDAK PERNAH dikirim ke server/cloud manapun. Semua rendering dan manipulasi gambar wajib dilakukan secara lokal (client-side / on-device).
2. **Preset Tujuan Kominfo**: Sediakan preset tujuan populer yang sering dibutuhkan (Verifikasi Bank, Fintech/Pinjol Legal, Lamaran Pekerjaan, Rental Kendaraan, Pendaftaran SIM Card, Pembukaan Akun Sekuritas).
3. **Fleksibilitas Watermark**: Pengguna dapat mengatur teks custom, tanggal otomatis, warna/kontras cap, tingkat opasitas (transparansi), dan pola (diagonal tunggal, repetisi grid, atau pita garis).
4. **Ekspor Resolusi Penuh**: Hasil akhir dirender dengan resolusi asli gambar input tanpa degradasi berlebihan agar tetap terbaca oleh pihak verifikator yang sah.
5. **Tanpa backend, tanpa akun**: Aplikasi langsung siap dipakai tanpa registrasi, tanpa tracking data sensitif pengguna.
