# IDMark icon style

SVGs live in `assets/icons/` and render through `AppIcon` (`lib/core/ui/app_icon.dart`), tinted with `srcIn` so only alpha matters.

## Personality
Protective, precise, trustworthy. Reads like a security/privacy tool, never playful.

## Grid
- 24×24 `viewBox`, 2px safe padding (live area 2–22). Strokes may touch the padding edge, never cross it by more than half a stroke.
- Card shapes fill ~18×14 (ID-1 card ratio); round shapes use r = 9.

## Stroke
- 1.75px, round caps, round joins. Uniform on every icon, no hairlines.

## Corners
- Cards, documents and frames: rx 2. Small inner boxes (photo slot, redaction bar): rx 1–1.5.
- The shield keeps its pointed base; everything else is softly rounded.

## Outline vs duotone
- Base shape: outline in `currentColor`.
- Secondary body (photo slot, stamp plate, fold, shield body, scanned card): `fill-opacity="0.3"` (shield 0.25).
- Meaning-carrying solid: only the redaction bar is fully filled, because "blacked out" is the message.

## Active / selected (bottom nav)
- Unselected `nav_x`: outline only, tinted by the NavigationBar's muted icon colour.
- Selected `nav_x_active`: main body becomes duotone (0.3 fill) and the accent (watermark seal, bookmark ribbon) turns solid; tinted `AppColors.primaryLight`.

## Kept standard (Material)
Back, close, chevron, search, share, download, delete, edit, more, add, copy, settings gear, check, radio/checkbox, warning.

## Inventory
| File | Used in |
|------|---------|
| `nav_watermark`, `nav_preset`, `nav_history`, `nav_guide` (+ `_active`) | bottom nav (`features/shell/navigation_shell.dart`); Settings keeps the gear |
| `stamp_seal` | editor tab "Watermark" |
| `redact_box` | editor tab "Sensor", redaction empty state, redaction list leading |
| `shield_check` | editor tab "Privasi", History header badge, "Bukti Proteksi" button |
| `export_file` | editor tab "Format", export-result format row |
| `exif_strip` | Privacy tab EXIF auto-sanitise switch |
| `hash_fingerprint` | SHA-256 rows (export result, History cards) |
| `scan_id` | editor upload empty state |
| `id_card` | History empty state, UU PDP banner |

Preview: `test/icons/goldens/icon_sheet.png` (regenerate with `flutter test test/icons --update-goldens`).
