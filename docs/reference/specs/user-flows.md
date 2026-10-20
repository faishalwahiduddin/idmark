# User flows — IDMark

Narasi alur pengguna. ID flow, role, modul, layar: `docs/reference/system/traceability.json`;
test case: `docs/trace/flows.yaml`; panduan BAST (video + langkah): `docs/client/bast/guide/index.html`.
Satu role: **Pemilik dokumen** (`ROL-001`, tanpa akun). Semua pengolahan gambar di perangkat.

| Flow | Alur | Langkah utama |
|---|---|---|
| FLOW-WMK-01 | Cap tujuan + tanggal lalu simpan | Onboarding (Lewati) → **Buka Galeri** / **Ambil Foto** → isi **Tujuan Watermark** → tanggal otomatis → **Simpan Dokumen (PNG/PDF)** → dialog **Watermark Selesai!** |
| FLOW-WMK-02 | Atur gaya cap | Pilih pola (7), warna (7), opasitas, ukuran, kemiringan → pratinjau langsung |
| FLOW-RED-01 | Sensor data sensitif | Tab **Sensor / Mask** → **Sensor NIK** / **Sensor Tanda Tangan** / area lain → atur jenis dan posisi |
| FLOW-PRS-01 | Preset tujuan | Tab Preset → cari/saring → **Gunakan Preset** → editor terisi; **Buat Preset Baru** → **Simpan Preset** |
| FLOW-HIS-01 | Riwayat audit | Simpan dokumen → tab **Riwayat** → daftar ekspor (tujuan, format, SHA-256, nilai privasi) → **Bersihkan** |
| FLOW-GDE-01 | Panduan Kominfo | Tab **Panduan** → centang checklist aman → 4 aturan pokok; nilai privasi A+…D di editor |
| FLOW-SET-01 | Pengaturan | Tab **Pengaturan** → tema → **Bahasa Aplikasi** → **Zona Waktu** → sanitasi EXIF → format bawaan → reset |
