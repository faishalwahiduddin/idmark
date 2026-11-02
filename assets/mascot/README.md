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

<!-- mascot-sheet:begin -->
## Mascot sheet (50 poses + 50 expressions)

The full character sheet for **Madi** (trenggiling (armadillo/pangolin)) lives **outside this repo** in the fleet library
`../docs/mascots/sheets/idmark/` (`~/projects/faishal.id/docs/mascots/sheets/idmark/`). It is on this machine
only, not in git and not in the app bundle.

- `poses/pose-NN-<id>.png` (01 to 50) and `expressions/expr-NN-<id>.png` (01 to 50): transparent RGBA 1024x1024.
- `README.md` there: an index of every file (ID, what it shows, QA result). Pick a pose from it by meaning.
- Pose and expression lists: `../tools/mascot_kits/catalog.py`. How the sheet was made: `../tools/mascot_kits/README.md`.
- Known gaps: `expressions/expr-12-enraged-screaming.png` missing.

To use one in the app:
1. Copy only the files `lib/` uses into `assets/mascot/poses/` or `assets/mascot/expressions/` (keep the file name).
   Downscale to 512 px when shown small. Never copy the whole sheet (about 50 MB).
2. List each new subfolder under `flutter: assets:` in `pubspec.yaml`: `assets/mascot/` does not include subfolders.
3. Bump the version (§VER) from the fleet root: `python3 tools/bump_version.py idmark minor`.
<!-- mascot-sheet:end -->
