// BAST IDMark (§TRACE) — rekam panduan langkah per flow dari build web lokal.
//   node test/bast/bast_flows.mjs        (dari akar app; build web ±1 menit)
// Gambar sumber: test/bast/fixtures/contoh-identitas.png (kartu contoh berdata fiktif, bukan identitas nyata).
import { runFlutterBast } from "/Users/rumah/projects/scripts/trace-graph/kit/flutter-web.mjs";

const SAMPLE = import.meta.dirname + "/fixtures/contoh-identitas.png";

/** Konteks bersih: bahasa Indonesia; onboarding dilewati kecuali flow yang memperagakannya. */
async function boot(page, { onboarding = false, prefs = {} } = {}) {
  await page.evaluate(([onb, extra]) => {
    localStorage.setItem("flutter.locale", '"id"');
    if (!onb) localStorage.setItem("flutter.onboarding_completed", "true");
    for (const [k, v] of Object.entries(extra)) localStorage.setItem("flutter." + k, v);
  }, [onboarding, prefs]);
  await page.reload({ waitUntil: "load" });
  const ph = page.locator("flt-semantics-placeholder");
  await ph.waitFor({ state: "attached", timeout: 30000 }).catch(() => {});
  await ph.dispatchEvent("click").catch(() => {});
  await page.waitForTimeout(3000);
}
const btn = (page, name) => page.getByRole("button", { name }).first();
const tab = (page, name) => page.getByRole("tab", { name }).first();
const chip = (page, name) => page.getByRole("checkbox", { name }).first();

/** Gulir layar sampai elemen berada di area terlihat (di atas bilah navigasi bawah). */
async function reveal(page, loc) {
  await loc.waitFor({ state: "attached", timeout: 15000 });
  for (let i = 0; i < 14; i++) {
    const b = await loc.boundingBox();
    if (b && b.y > 80 && b.y + b.height < 800) return loc;
    await page.mouse.move(215, 450);
    await page.mouse.wheel(0, b ? Math.max(-500, Math.min(500, b.y - 400)) : 400);
    await page.waitForTimeout(500);
  }
  return loc;
}
/** Unggah foto contoh lewat pemilih berkas peramban (jalur image_picker web). */
async function pickSample(page, g) {
  const chooser = page.waitForEvent("filechooser", { timeout: 15000 });
  await g.tap(btn(page, /^Buka Galeri/));
  await (await chooser).setFiles(SAMPLE);
  await page.waitForTimeout(2500);
}
/** Ganti isi kolom teks (klik, pilih semua, ketik). */
async function replaceText(page, g, loc, text) {
  await g.tap(await reveal(page, loc));
  await page.waitForTimeout(400);
  await page.keyboard.press("ControlOrMeta+A");
  // insertText: Flutter rebuilds its hidden <input> after the first change and drops later keystrokes.
  await page.keyboard.insertText(text);
  await page.waitForTimeout(500);
}
const purposeField = (page) => page.getByLabel("Tujuan Watermark (Sesuai Kebutuhan)").first();

const FLOWS = [
  {
    flow: "FLOW-WMK-01", tc: "FLOW-WMK-01-T01", role: "ROL-001",
    title: "Membubuhkan cap tujuan dan tanggal lalu menyimpan dokumen",
    summary: "Pengguna membuka IDMark pertama kali, memilih foto kartu identitas, menulis tujuan verifikasi, lalu menyimpan dokumen ber-watermark resolusi penuh. Semua diproses di perangkat; foto tidak pernah diunggah.",
    async run(page, g) {
      await boot(page, { onboarding: true });
      await g.step("Buka IDMark", "Saat pertama dibuka, IDMark menampilkan layar perkenalan. Ketuk **Lewati** untuk langsung ke editor.");
      await g.tap("Lewati", { exact: true });
      await page.waitForTimeout(1500);
      await g.step("Masuk ke editor Watermark", "Tab **Watermark** menampilkan kotak **Unggah Foto e-KTP / Identitas** dan panel konfigurasi cap.");
      await pickSample(page, g);
      await g.step("Pilih foto identitas", "Ketuk **Buka Galeri** lalu pilih foto kartu identitas. Pratinjau langsung menampilkan cap merah melintang.");
      await replaceText(page, g, purposeField(page), "VERIFIKASI REKENING BANK CONTOH");
      await g.step("Tulis tujuan verifikasi", "Isi **Tujuan Watermark** dengan instansi dan keperluan spesifik, misalnya **VERIFIKASI REKENING BANK CONTOH**. Tanggal transaksi otomatis tercantum.");
      await g.tap(await reveal(page, btn(page, /^Simpan Dokumen/)));
      await page.waitForTimeout(2500);
      await g.step("Simpan dokumen", "Ketuk **Simpan Dokumen (PNG)**. Dokumen dirender di perangkat dengan resolusi asli dan dialog **Watermark Selesai!** muncul.");
    },
  },
  {
    flow: "FLOW-WMK-02", tc: "FLOW-WMK-02-T01", role: "ROL-001",
    title: "Mengatur pola, warna, dan opasitas cap",
    summary: "Pengguna mengganti pola cap menjadi grid berulang, memilih warna biru, dan melihat hasilnya langsung di pratinjau.",
    async run(page, g) {
      await boot(page);
      await pickSample(page, g);
      await g.step("Pilih foto", "Di tab **Watermark**, ketuk **Buka Galeri** dan pilih foto identitas. Cap bawaan **Pita Melintang** merah tampil di pratinjau.");
      await g.tap(await reveal(page, chip(page, /^Pola Berulang/)));
      await g.step("Pilih pola Grid", "Pada **Pola Stempel Watermark (7 Gaya)**, ketuk **Pola Berulang (Grid)** untuk perlindungan menyeluruh.");
      await g.tap(await reveal(page, chip(page, /^Biru Verifikasi/)));
      await g.step("Pilih warna cap", "Pada **Warna Cap Watermark**, ketuk **Biru Verifikasi**.");
      await reveal(page, page.getByText(/Tingkat Opasitas/).first());
      await g.step("Atur opasitas dan ukuran", "Geser **Tingkat Opasitas**, **Ukuran Teks Watermark**, dan **Kemiringan Sudut** sampai cap terbaca jelas tanpa menutup data penting.");
      await page.mouse.move(215, 450); await page.mouse.wheel(0, -3000); await page.waitForTimeout(800);
      await g.step("Periksa pratinjau", "Gulir ke atas: pratinjau memperlihatkan pola grid biru berulang di seluruh foto.");
    },
  },
  {
    flow: "FLOW-RED-01", tc: "FLOW-RED-01-T01", role: "ROL-001",
    title: "Menyensor data sensitif sebelum dicap",
    summary: "Pengguna menutup NIK dan tanda tangan dengan sensor permanen sebelum dokumen disimpan.",
    async run(page, g) {
      await boot(page);
      await pickSample(page, g);
      await g.step("Pilih foto", "Di tab **Watermark**, ketuk **Buka Galeri** dan pilih foto identitas.");
      await g.tap(await reveal(page, tab(page, /^Sensor/)));
      await g.step("Buka tab Sensor / Mask", "Ketuk tab **Sensor / Mask**. Tersedia tombol **Tambah Sensor Cepat**.");
      await g.tap(await reveal(page, chip(page, /^Sensor NIK$/)));
      await g.step("Sensor NIK", "Ketuk **Sensor NIK**. Kotak hitam menutup baris NIK pada pratinjau.");
      await g.tap(await reveal(page, chip(page, /^Sensor Tanda Tangan$/)));
      await g.step("Sensor tanda tangan", "Ketuk **Sensor Tanda Tangan** bila penerima tidak meminta spesimen tanda tangan. Daftar area tersensor bertambah.");
      await page.mouse.move(215, 450); await page.mouse.wheel(0, -3000); await page.waitForTimeout(800);
      await g.step("Periksa pratinjau", "Gulir ke atas: area NIK dan tanda tangan tertutup permanen, cap tujuan tetap melintang.");
    },
  },
  {
    flow: "FLOW-PRS-01", tc: "FLOW-PRS-01-T01", role: "ROL-001",
    title: "Memakai dan membuat preset tujuan",
    summary: "Pengguna memakai template resmi dari katalog, lalu membuat preset kustom untuk keperluan yang sering dipakai.",
    async run(page, g) {
      await boot(page);
      await g.tap(tab(page, /^Preset$/));
      await g.step("Buka tab Preset", "Ketuk tab **Preset**. **Katalog Template Watermark Resmi** berisi 18 template perbankan, karir, rental, hingga internasional.");
      await g.type("Cari template (bank, pinjol, hrd, kpr, rental)...", "rekening");
      await page.waitForTimeout(800);
      await g.step("Cari template", "Ketik kata kunci di **Cari template**, misalnya **rekening**. Daftar menyaring template yang cocok.");
      await g.tap(await reveal(page, btn(page, /^Gunakan Preset/)));
      await page.waitForTimeout(1200);
      await g.step("Gunakan preset", "Pada **Pembukaan Rekening Bank**, ketuk **Gunakan Preset**. Editor terbuka dengan tujuan, pola, dan warna cap terisi sesuai template; ganti **[NAMA BANK]** dengan nama bank tujuan.");
      await g.tap(tab(page, /^Preset$/));
      await g.tap(btn(page, /^Buat Preset Baru/));
      await page.waitForTimeout(800);
      await g.step("Buat preset kustom", "Kembali ke **Preset** lalu ketuk **Buat Preset Baru**. Isi **Nama Preset**, **Kategori**, dan **Teks Template Tujuan**.");
    },
  },
  {
    flow: "FLOW-HIS-01", tc: "FLOW-HIS-01-T01", role: "ROL-001",
    title: "Melihat riwayat audit ekspor",
    summary: "Setelah menyimpan dokumen, pengguna melihat jejak audit lokal: tujuan, pola, ukuran berkas, dan sidik SHA-256 tiap ekspor.",
    async run(page, g) {
      await boot(page);
      await pickSample(page, g);
      await g.tap(await reveal(page, btn(page, /^Simpan Dokumen/)));
      await page.waitForTimeout(2500);
      await g.step("Simpan satu dokumen", "Pilih foto di tab **Watermark** lalu ketuk **Simpan Dokumen (PNG)**. Setiap ekspor otomatis tercatat di riwayat lokal.");
      await page.keyboard.press("Escape");
      await page.waitForTimeout(800);
      await g.tap(tab(page, /^Riwayat$/));
      await page.waitForTimeout(1000);
      await g.step("Buka tab Riwayat", "Ketuk tab **Riwayat**. **Audit Log Privasi Lokal** menampilkan dokumen yang distempel beserta tujuan, format, dan nilai privasinya.");
    },
  },
  {
    flow: "FLOW-GDE-01", tc: "FLOW-GDE-01-T01", role: "ROL-001",
    title: "Memeriksa kepatuhan dengan panduan Kominfo",
    summary: "Pengguna membaca 4 aturan pokok watermark Kominfo dan mencentang checklist aman sebelum mengirim e-KTP.",
    async run(page, g) {
      await boot(page);
      await g.tap(tab(page, /^Panduan$/));
      await g.step("Buka tab Panduan", "Ketuk tab **Panduan**. Tampil **Checklist Aman Sebelum Kirim e-KTP** dan aturan Kominfo / UU PDP.");
      await g.tap(btn(page, /^Nama instansi/));
      await g.tap(btn(page, /^Tanggal transaksi terkini/));
      await g.step("Centang checklist", "Ketuk butir checklist yang sudah dipenuhi, misalnya **Nama instansi/penerima tertulis jelas** dan **Tanggal transaksi terkini**. Hitungan selesai bertambah.");
      await reveal(page, page.getByText(/4 Aturan Pokok/).first());
      await g.step("Baca 4 aturan pokok", "Gulir ke **4 Aturan Pokok Watermark Kominfo**: tujuan spesifik, tanggal, posisi melintang, dan sensor tanda tangan.");
    },
  },
  {
    flow: "FLOW-SET-01", tc: "FLOW-SET-01-T01", role: "ROL-001",
    title: "Mengatur tampilan, bahasa, dan privasi",
    summary: "Pengguna membuka Pengaturan untuk memilih tema, bahasa, zona waktu, sanitasi EXIF, dan format ekspor bawaan.",
    async run(page, g) {
      await boot(page);
      await g.tap(tab(page, /^Pengaturan$/));
      await g.step("Buka Pengaturan", "Ketuk tab **Pengaturan**. Bagian atas menegaskan **Privasi Mutlak (Zero Server Upload)**.");
      await g.tap(btn(page, /^Bahasa Aplikasi/));
      await page.waitForTimeout(800);
      await g.step("Pilih bahasa", "Ketuk **Bahasa Aplikasi**. Lembar **Pilih Bahasa** menampilkan 8 bahasa; ketuk **Bahasa Indonesia** untuk tetap memakai bahasa ini.");
      await g.tap(page.getByText("Bahasa Indonesia", { exact: true }).last());
      await page.waitForTimeout(800);
      await reveal(page, page.getByRole("switch").first());
      await g.step("Sanitasi EXIF", "Pastikan **Sanitasi Metadata EXIF Otomatis** aktif agar koordinat GPS dan tipe kamera terhapus dari hasil ekspor.");
      await reveal(page, btn(page, /^Reset Pengaturan Bawaan/));
      await g.step("Penyimpanan lokal", "Di **Penyimpanan Lokal Perangkat** tersedia **Bersihkan** riwayat audit dan **Reset Pengaturan Bawaan**.");
    },
  },
];

// BAST_ONLY=FLOW-A,FLOW-B merekam ulang sebagian; BAST_NOBUILD=1 memakai build/web yang ada.
const only = process.env.BAST_ONLY?.split(",");
await runFlutterBast(import.meta.dirname + "/../..", only ? FLOWS.filter((f) => only.includes(f.flow)) : FLOWS, { build: !process.env.BAST_NOBUILD });
