# BRD — IDMark

> Batas SSOT. Dokumen ini milik **WHY dan WHAT tingkat bisnis**: tujuan,
> aktor, glosarium, dan aturan bisnis IDMark. Alur rinci per fitur,
> katalog validasi, dan kriteria terima ada di [PRD](./PRD.md).

- App: `idmark` — watermark dokumen identitas 100% on-device.
- Stack: Flutter 3.x, Riverpod, image_picker, crypto, pdf, share_plus.
- Subdomain: idmark.faishal.id · appId: `id.faishal.idmark`.
- Repo: `faishalwahiduddin/idmark`. Aturan: [AGENTS.md](../AGENTS.md).

## 1. Tujuan dan latar

IDMark ada agar salinan identitas yang beredar selalu membawa keterangan
tujuan dan tanggal, sehingga tidak mudah disalahgunakan untuk pinjol atau
penipuan. Dan itu dikerjakan sepenuhnya di perangkat pengguna.

Nilai yang diimplementasikan:

1. **Privasi mutlak.** Foto identitas tidak pernah dikirim ke server atau
   cloud mana pun; semua rendering lokal.
2. **Siap pakai global.** Preset tujuan populer lokal (e-KTP Kominfo) dan
   global (KYC bank, lamaran, rental) tersedia langsung.
3. **Fleksibel.** Teks custom, tanggal otomatis, warna, opasitas, dan pola
   (diagonal, grid, bottom bar, corner stamp) bisa diatur.
4. **Terbaca verifikator.** Ekspor resolusi penuh agar pihak sah tetap bisa
   membaca dokumen yang dicap.

Di luar lingkup: deteksi KTP palsu, tanda tangan digital kriptografis,
backend atau akun.

## 2. Aktor dan peran

| Aktor | Sifat | Kemampuan |
|---|---|---|
| Pemilik dokumen | Tanpa akun | Cap, sensor, ekspor dokumennya sendiri |

Satu aktor saja; tidak ada peran berbasis server.

## 3. Glosarium domain

- **Watermark identitas.** Cap pelindung berisi tujuan dan stempel waktu
  yang dibakar ke piksel gambar.
- **Tujuan verifikasi.** Alasan eksplisit pemakaian salinan (rekening bank,
  lamaran kerja, sewa).
- **Tanggal cap.** Tanggal validitas salinan yang membatasi masa lakunya.
- **Pola pita melintang.** Garis diagonal standar agar tidak mudah dipotong.
- **Pola grid berulang.** Pola ubin berulang untuk perlindungan maksimal.
- **Sensor/redaksi.** Penutupan elemen sensitif seperti tanda tangan.
- **Render lokal.** Seluruh pengolahan gambar di perangkat tanpa jaringan.

## 4. Kebutuhan bisnis dan aturan

ID `BR-NNN` dideklarasikan di sini; kolom terakhir menunjuk kebutuhan produk
di [PRD](./PRD.md) yang merealisasikannya (§TRACE).

| ID | Kebutuhan / aturan bisnis | Direalisasi oleh |
|---|---|---|
| BR-001 | Foto dokumen identitas tidak boleh dikirim ke server atau cloud mana pun dalam keadaan apa pun. | FR-001, NFR-001 |
| BR-002 | Hasil render wajib mempertahankan resolusi asli gambar input dan terbaca verifikator. | FR-005 |
| BR-003 | Setiap ekspor wajib memuat tujuan dan tanggal yang terbaca manusia. | FR-002, NFR-003 |
| BR-004 | Tanpa backend, tanpa akun, tanpa tracking data sensitif; jejak ekspor hanya tersimpan lokal. | FR-007, FR-009 |
| BR-005 | Preset wajib mencakup kebutuhan lokal Indonesia dan kebutuhan global. | FR-003 |
| BR-006 | Cap cukup jelas dan menyeluruh sehingga pemotongan bagian ber-cap merusak kegunaan salinan bagi oknum. | FR-004, FR-008 |
| BR-007 | Elemen sensitif yang tidak diminta penerima (tanda tangan, NIK) bisa ditutup permanen. | FR-006 |
| BR-008 | Semua input pengguna divalidasi sebelum dipakai atau disimpan (§VAL). | NFR-002 |

## 5. Risiko dan batasan

- Watermark menaikkan keamanan salinan, bukan menjamin anti-pemalsuan total.
- Kualitas hasil bergantung pada kualitas foto sumber pengguna.
