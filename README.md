# IDMark

> IDMark — Secure ID Card & Document Watermark: Stamp custom purpose & date onto national IDs (e-KTP, Aadhaar, MyKad), passports, and driver's licenses 100% on-device to protect your identity privacy and prevent fraud.

Part of the **faishal.id** fleet (Privacy & Utility Series).

- **Production / Web**: https://idmark.faishal.id
- **Application ID**: `id.faishal.idmark`
- **Repository**: private `faishalwahiduddin/idmark`

## Tech Stack
- **Framework**: [Flutter](https://flutter.dev) (Web, Android, iOS)
- **Language**: [Dart](https://dart.dev)
- **State Management**: [Riverpod](https://riverpod.dev)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Rendering**: Client-side canvas rendering (zero server upload)
- **Platform Deploy**: Cloudflare Pages (`idmark-faishal`)

## Fitur Utama / Key Features
1. **100% On-Device & Private**: Identity documents are never uploaded to any server or cloud. All pixel composition happens directly inside your browser or device.
2. **Official Security Standard**: Stamps verification purpose and date stamp directly over key document regions to make reuse impossible.
3. **Quick Presets**: Instant templates for banking KYC, legal lending/fintech, employment applications, vehicle rental, telco SIM registration, and general verification.
4. **Rich Customization**:
   - 4 patterns: Diagonal Band, Repeated Grid, Bottom Bar, Official Corner Stamp.
   - Opacity slider (15% - 90%).
   - Color contrasts: Warning Red, Official Blue, Dark Charcoal, Clean White.
5. **High-Res Export**: Save watermarked image at full original camera resolution (PNG) or share immediately.

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
