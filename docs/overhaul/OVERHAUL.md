# IDMark UI/UX Overhaul — Report (Repo #11/30)

Date: 2026-10-01 · Device: AC100M8766XC000046 (Android 11, P10, 720x1600)
Mode: refinement (preserve dark brand world) · Rounds used: 1 capture-fix-confirm per screen (max 2 allowed)

## Root cause

Screens were authored for the dark brand world, but the app followed the OS theme
and `lightTheme` was skeletal (no input/button/nav/dialog/chip/divider tokens).
On a light-mode device this produced a washed-out mixed theme: white text on pale
washes, invisible section headers, inconsistent default buttons.

## Fix strategy

1. Fresh installs default to dark (`local_storage_service.dart`); Light/System
   still selectable in Settings.
2. Completed `lightTheme` token set + extended `darkTheme` (text, divider, nav
   bar, chip, dialog, sheet, tab, snackbar, selection).
3. All pale alpha-wash banners → solid `bannerSurface` + colored border (readable
   in either theme). Guide header gradient → flat `primaryDark`.
4. Always-dark cards made explicit (`bgCard`): control panel, upload prompt,
   guide rules. Scaffold-level headers use brightness-aware `AppColors`
   title/body/muted helpers. Search fields pin white text on dark fills.
5. Settings dividers → theme dividers; about rows get theme-aware colors + flex.

## Master Checklist

| # | Surface | Before | After | Initial | Final | Status |
|---|---------|--------|-------|---------|-------|--------|
| 1 | Editor (/) | editor-before.png | editor-after.png | 5.5 | 8.5 | DONE |
| 2 | Presets (/presets) | presets-before.png | presets-after.png | 5.0 | 8.5 | DONE |
| 3 | History (/history) | history-before.png | history-after.png | 4.5 | 8.0 | DONE |
| 4 | Guide (/guide) | guide-before.png | guide-after.png | 5.0 | 8.5 | DONE |
| 5 | Settings (/settings) | settings-before.png | settings-after.png | 5.0 | 8.5 | DONE |
| 6 | Dialogs/sheets (create preset, export, confirm, language, timezone) | func-create-dialog.png, func-validation.png | same | — | 8.5 | DONE |

Remaining minors (non-blocking): search-hint ellipsis, filter-chip edge clip
(horizontal scroll by design), scroll-viewport clipping, history empty-state
top-weighted whitespace.

## Functional tests (live, on device)

- Guide checklist toggle: 0/5 → 1/5 + strike-through — PASS (func-checklist.png)
- Preset apply: navigates to Editor + snackbar "successfully applied" — PASS
- Create-preset dialog open + empty-submit → Indonesian inline errors,
  dialog held open — PASS (§VAL)
- logcat: zero exceptions/errors/fatals during session — PASS

## Static verification

- `flutter analyze`: No issues found (0 pre-existing, 0 new).
- `flutter test`: 54/54 passed (7 files, incl. widget + timezone + validation).

## Changed files

- lib/core/storage/local_storage_service.dart (dark default)
- lib/core/constants/app_colors.dart (title/body/muted helpers + bannerSurface)
- lib/core/theme/app_theme.dart (full light theme, extended dark theme)
- lib/features/shell/navigation_shell.dart (theme nav bar)
- lib/features/editor/editor_screen.dart (solid banner)
- lib/features/editor/widgets/watermark_control_panel.dart (explicit dark card)
- lib/features/editor/widgets/watermark_canvas_preview.dart (explicit dark card)
- lib/features/presets/presets_screen.dart (solid banner, search text)
- lib/features/history/history_screen.dart (solid banner, empty-state, search text)
- lib/features/guide/kominfo_guide_screen.dart (flat header, solid warning, contrast)
- lib/features/settings/settings_screen.dart (solid card, helpers, theme dividers)

No release build, no commit, no other repo touched.
