# KtpMark

> KtpMark — Watermark e-KTP & Identitas Aman: bubuhkan cap tujuan verifikasi dan tanggal pada foto eKTP secara instan dan 100% on-device untuk melindungi privasi Anda.

Part of the **faishal.id** fleet (Privacy & Utility Series).

- **Production / Web**: https://ktpmark.faishal.id
- **Application ID**: `id.faishal.ktpmark`
- **Repository**: private `faishalwahiduddin/ktpmark`

## Tech Stack
- **Framework**: [Flutter](https://flutter.dev) (Web, Android, iOS)
- **Language**: [Dart](https://dart.dev)
- **State Management**: [Riverpod](https://riverpod.dev)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Rendering**: Client-side canvas rendering (zero server upload)
- **Platform Deploy**: Cloudflare Pages (`ktpmark-faishal`)

## Fitur Utama
1. **100% On-Device & Privat**: Foto e-KTP tidak pernah diunggah ke internet atau server manapun. Seluruh proses pembubuhan cap terjadi di perangkat Anda.
2. **Standar Kominfo**: Watermark menyertakan tujuan spesifik ("VERIFIKASI REKENING BANK", "LAMARAN KERJA", dll.) dan tanggal transaksi.
3. **Preset Siap Pakai**: Pilihan cepat untuk pinjol legal, perbankan, lamaran kerja, rental, provider seluler, dan kustom bebas.
4. **Kustomisasi Lengkap**:
   - Gaya cap: Garis Diagonal, Pita Melintang, Grid Berulang, atau Sudut Resmi.
   - Opasitas / Transparansi yang dapat disesuaikan.
   - Pilihan warna kontras (putih, hitam, merah, biru).
5. **Ekspor Mudah**: Unduh gambar beresolusi penuh dalam format PNG/JPEG atau bagikan langsung.

## Getting Started

```bash
flutter pub get
flutter test
flutter analyze
```

## Agent Guides
- [`AGENTS.md`](./AGENTS.md) — Comprehensive guide for AI coding agents.
- [`CLAUDE.md`](./CLAUDE.md) — Quick developer reference.
- [`GEMINI.md`](./GEMINI.md) — Antigravity & Gemini instructions.

## License
Private repository © Faishal Wahiduddin. All rights reserved.
