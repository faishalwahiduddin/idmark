# PRD: IDMark — Watermark Aman untuk Dokumen Identitas

## 1. Overview

**IDMark** adalah alat watermark dokumen identitas yang 100% on-device:
menempelkan cap tujuan verifikasi dan tanggal ke e-KTP, paspor, dan SIM
langsung pada piksel gambar, tanpa satu byte pun dikirim ke server.

- **Subdomain**: idmark.faishal.id
- **CF Project**: `idmark-faishal` · **appId**: `id.faishal.idmark`
- **Platform**: Web, Android, iOS
- **Repository**: `faishalwahiduddin/idmark`

## 2. Problem Statement

1. **Fotokopi KTP disalahgunakan.** Salinan identitas tanpa keterangan
   tujuan rawan dipakai untuk pinjol dan penipuan.
2. **Tool online berisiko.** Mengunggah KTP ke situs watermark berarti
   menyerahkan data ke pihak asing.
3. **Cap manual jelek.** Edit manual di galeri HP tidak rapi dan mudah
   dihapus oknum.

## 3. Target Users

- Siapa pun yang diminta mengirim foto KTP/dokumen untuk verifikasi
- Pelamar kerja, penyewa, nasabah bank yang rutin KYC
- Pengguna peduli privasi yang menolak upload identitas ke situs acak

## 4. Features

### 4.1 MVP (story)

| Kode | Fitur | SP | Deskripsi | Lokasi kode |
|---|---|:---:|---|---|
| `US-001` | **Shell + ambil gambar** | 2 | image_picker kamera/galeri, 5 tab | `lib/features/editor/`, `lib/features/shell/` |
| `US-002` | **Watermark teks** | 5 | Teks tujuan + tanggal + subtext | `lib/features/editor/` |
| `US-003` | **Preset tujuan** | 3 | 18 template lokal & internasional + preset kustom | `lib/features/presets/` |
| `US-004` | **Pola cap** | 3 | 7 pola: pita melintang, grid, pita bawah, cap sudut, segel, silang, lencana QR | `lib/core/services/watermark_renderer_service.dart` |
| `US-005` | **Opasitas dan warna** | 2 | 7 warna, opasitas, ukuran, kemiringan | `lib/features/editor/widgets/` |
| `US-006` | **Redaksi/sensor** | 3 | Sensor NIK, tanda tangan, alamat, tgl lahir, area kustom | `lib/core/models/redaction_item.dart` |
| `US-007` | **Ekspor resolusi penuh** | 2 | Render resolusi asli PNG/PDF + bagikan | `lib/features/editor/` |
| `US-008` | **i18n & pengaturan** | 3 | 8 bahasa, tema, zona waktu, EXIF, format bawaan | `lib/features/settings/`, `lib/l10n/` |
| `US-009` | **Riwayat audit** | 2 | Log ekspor lokal (tujuan, SHA-256, nilai privasi) | `lib/features/history/` |
| `US-010` | **Panduan Kominfo** | 2 | Checklist aman + aturan pokok + nilai privasi | `lib/features/guide/` |

### 4.2 Kebutuhan produk (FR / NFR)

Setiap baris: asal `BR` dan story/flow yang merealisasikannya (§TRACE).

| ID | Kebutuhan | Asal | Realisasi |
|---|---|---|---|
| FR-001 | Ambil foto dokumen dari galeri/kamera dan proses seluruhnya di memori perangkat. | BR-001 | US-001, FLOW-WMK-01 |
| FR-002 | Teks tujuan (3–80 karakter) + tanggal transaksi + subtext opsional (≤100) dibakar ke piksel. | BR-003 | US-002, FLOW-WMK-01 |
| FR-003 | Katalog preset lokal & internasional, pencarian, dan preset kustom (nama 3–50, kategori ≤30). | BR-005 | US-003, FLOW-PRS-01 |
| FR-004 | 7 pola cap, 7 warna, opasitas 10–100%, ukuran 10–60 pt, kemiringan −90°…+90°. | BR-006 | US-004, US-005, FLOW-WMK-02 |
| FR-005 | Ekspor PNG/PDF pada resolusi asli; bagikan/unduh. | BR-002 | US-007, FLOW-WMK-01 |
| FR-006 | Sensor permanen (blackout/mosaik/blur) dengan kotak yang selalu di dalam gambar. | BR-007 | US-006, FLOW-RED-01 |
| FR-007 | Riwayat audit lokal maksimal 50 ekspor terbaru, bisa dibersihkan. | BR-004 | US-009, FLOW-HIS-01 |
| FR-008 | Panduan Kominfo/UU PDP dengan checklist dan nilai privasi A+…D. | BR-006 | US-010, FLOW-GDE-01 |
| FR-009 | Pengaturan tema, 8 bahasa, zona waktu, sanitasi EXIF, format ekspor bawaan, reset. | BR-004 | US-008, FLOW-SET-01 |
| NFR-001 | Nol request jaringan selama alur watermark; berjalan di peramban/perangkat. | BR-001 | FLOW-WMK-01 |
| NFR-002 | Validasi §VAL di setiap mutasi konfigurasi; data tersimpan yang tidak valid kembali ke bawaan. | BR-008 | FLOW-WMK-02, FLOW-SET-01 |
| NFR-003 | Tanggal disimpan UTC (`Z`) dan dicap sesuai zona pilihan (§TZ). | BR-003 | FLOW-WMK-01 |

### 4.3 Di luar cakupan

- Verifikasi keaslian dokumen (bukan pemeriksa KTP palsu)
- Tanda tangan digital kriptografis
- Backend, akun, penyimpanan cloud

## 5. Data Model

| Model | Isi |
|---|---|
| `MarkJob` | id, sourcePath, presetId, customText, createdAt |
| `MarkStyle` | pattern, color, opacity, fontSize, position |
| `Preset` | id, label, defaultText, locale |

Gambar diproses di memori perangkat; hanya hasil akhir yang disimpan
bila pengguna mengekspor. Tanpa database server.

## 6. User Flows

Narasi alur ada di [`reference/specs/user-flows.md`](reference/specs/user-flows.md);
ID flow, layar, dan test case di `reference/system/traceability.json` dan
`trace/flows.yaml` (§TRACE). Panduan BAST: `client/bast/guide/index.html`.

## 7. Validasi (§VAL)

- Gambar sumber wajib format didukung (JPEG/PNG) dan ukuran wajar.
- Teks watermark wajib non-kosong; tanggal memakai tanggal perangkat.
- Opasitas wajib dalam rentang 0 sampai 100 persen.
- Ekspor wajib mempertahankan resolusi asli tanpa degradasi berlebih.
- Dilarang keras mengirim gambar ke jaringan mana pun selama proses.

## 8. Acceptance Criteria

- [ ] Hasil cap terbaca jelas oleh verifikator manusia.
- [ ] Tidak ada request jaringan selama alur watermark (uji mode pesawat).
- [ ] Preset global dan lokal tersedia langsung tanpa unduhan.
- [ ] `flutter analyze` nol peringatan, `flutter test` hijau.
- [ ] Privasi: foto tidak pernah meninggalkan perangkat kecuali diekspor
      pengguna sendiri.

## 9. Technical Constraints

- 100% client-side rendering, zero server upload.
- Tanpa backend, tanpa akun, tanpa tracking data sensitif.
- MVVM + Riverpod + GoRouter feature-first.
- CLI: `gh-faishal`, `wrangler-faishal`.
- Version: `python3 ../tools/bump_version.py idmark patch`.
