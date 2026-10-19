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

### 4.1 MVP

| Kode | Fitur | SP | Deskripsi | Lokasi kode |
|---|---|:---:|---|---|
| `US-001` | **Shell + ambil gambar** | 2 | image_picker kamera/galeri | `lib/features/` |
| `US-002` | **Watermark teks** | 5 | Teks tujuan + tanggal, atur posisi | `lib/features/` |
| `US-003` | **Preset tujuan** | 3 | e-KTP Kominfo, KYC bank, lamaran, rental, SIM | `lib/features/` |
| `US-004` | **Pola cap** | 3 | Diagonal, grid berulang, bottom bar, corner | `lib/features/` |
| `US-005` | **Opasitas dan warna** | 2 | Kontras, transparansi, warna cap | `lib/features/` |
| `US-006` | **Redaksi/sensor** | 3 | Tutup elemen sensitif (tanda tangan, digit) | `lib/features/` |
| `US-007` | **Ekspor resolusi penuh** | 2 | Render resolusi asli + share_plus | `lib/features/` |
| `US-008` | **i18n** | 3 | Indonesia + Inggris | `lib/l10n/` |

### 4.2 Di luar cakupan

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

1. **Cap cepat.** Pilih foto KTP → pilih preset (misal "KYC Bank +
   tanggal hari ini") → atur posisi → ekspor dan kirim.
2. **Cap custom.** Ketik tujuan sendiri → pilih pola grid → atur opasitas
   → pratinjau → ekspor resolusi penuh.
3. **Sensor.** Tutup tanda tangan atau digit sensitif → timpa cap tanggal
   → ekspor.

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
