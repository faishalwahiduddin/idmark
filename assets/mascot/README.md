# Maskot Madi — kandidat anchor

**trenggiling (armadillo/pangolin)** · peran Expert

Trenggiling menggulung diri dengan sisik baja untuk memproteksi diri — metafora perlindungan dokumen dan enkripsi watermark.

Spesifikasi dan prompt: [`docs/mascots/prompts/idmark.md`](../../../docs/mascots/prompts/idmark.md)

| File | Uji terukur | Catatan |
|---|---|---|
| `anchor-candidate-01.png` | pending | Belum digenerate |

Uji terukur hanya menyaring rasio, transparansi, palet, dominasi aksen, outline,
dan pemisahan grayscale. **Tiga hal ini tetap butuh mata:**

- Signature detail: stempel perisai air transparan bercahaya cyan #38BDF8 melingkari tempurung sisik punggung
- Siluet: tubuh membulat bertekstur sisik geometris tersusun rapi, moncong tumpul menggemaskan
- Selalu: tanpa hidung, satu highlight per mata, tanpa cast shadow

Regenerate: `bash docs/mascots/generate_anchors.sh idmark`

Dibuat via Gemini "Gambar" (Pro Mendalam), dikendalikan `gstack browse`.
