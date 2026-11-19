# Design Audit — IDMark

**Date:** 2026-11-20 · **Version:** 1.1.2+24 · **Grade: 60 / 100 — D**
**Mode:** deep (all 7 screens + shared widgets + tokens + real renders + code path)
**Reviewer stance:** senior mobile designer. Grades are earned; "looks fine" is a C at best.

> **Read the grade correctly.** User-facing craft is a **C** (dark-only, coherent, genuinely
> custom). System integrity is an **F**: the app bans inline colours in writing and then uses
> them **201 times**, and its core privacy promise ("watermark is burned into the pixels") ships
> with **no warning before the watermarked ID leaves the device** and a **15% minimum opacity**
> that makes a white stamp invisible over a bright e-KTP. The composite is **D** because the
> domain is national ID + passport PII: a legibility or consent defect here is not cosmetic.
> The fix is system-ward, not a redesign: **guard the exit, harden the overlay, tokenise.**

---

## 1. Snapshot

| Field | Value |
|---|---|
| Product | IDMark — Secure ID Card & Document Watermark (e-KTP, passport, SIM) |
| Version | `1.1.2+24` |
| Platform | Flutter Web (CF Pages) + Android + iOS · Material 3 · light + dark (dark default) |
| Dart files | 61 (`find lib -name '*.dart'`) |
| Routes / screens | **7 routes / 7 screens** (parsed: 7 `GoRoute` leaves) |
| Router | `lib/core/router/app_router.dart` — `StatefulShellRoute.indexedStack`, 5 branches; `/splash` + `/onboarding` on root navigator |
| State | Riverpod (`flutter_riverpod`), local-only (`shared_preferences`) |
| Locales | 8 (`id, en, ar, jv, su, zh, ja, es`) — `settings_screen.dart:25-34` |
| Design tokens | `lib/core/constants/app_colors.dart` (81 L) + `app_theme.dart` (339 L) + `app_motion.dart` (21 L) — **3 of 12** standard token files (Tier 3) |
| Documented system | `DESIGN.md` → `docs/reference/design-system/{foundations,components}.md` |
| Test rigour | 24 test files incl. **dual-theme contrast audit for all 5 product screens** (`test/flows/theme_contrast_test.dart:64-77`), flow tests, store-render harness — above fleet average |
| Design-debt index | **65.2** (rank #4 of 37) |

**The one number that matters.** `docs/reference/design-system/components.md:40` states:
> *"**Dilarang** menulis `Color(0x...)` literal langsung di widget presentation; pakai token …"*

Measured reality (`grep -rho 'Color(0x' <dir>`):

| Layer | `Color(0x…)` | raw `TextStyle(` | `fontSize:` literals |
|---|---:|---:|---:|
| `lib/features/editor` | **84** | 89 | 76 |
| `lib/features/presets` | 14 | 25 | 22 |
| `lib/features/history` | 9 | 17 | 15 |
| `lib/features/guide` | 6 | 11 | 11 |
| `lib/features/settings` | 2 | 35 | 33 |
| `lib/features/shell` | 0 | 0 | 0 |
| **presentation subtotal (`features/`)** | **115** | **177** | **157** |
| `lib/core/ui` | 16 | 10 | 8 |
| `lib/core/theme` (legal) | 28 | 34 | 20 |
| `lib/core/constants` (legal tokens) | 32 | 0 | 0 |
| `lib/core/services` | 10 | 24 | 12 |
| **whole `lib/`** | **201** | **245** | **198** |

Per product screen: **16.4** inline colours and **25.3** raw `TextStyle`s. The editor alone is
**84 colours / 89 raw text styles / 76 font-size literals** — one of the highest per-screen
densities in the fleet. This is not drift; it is a second, parallel design system authored in
widgets.

**Offline claim — verified true in code (credit).** The ID path makes **zero** network calls:
`watermark_renderer_service.dart:29-44` records to a `PictureRecorder`/`Canvas`; PDF export has no
HTTP symbols; `image_picker_service.dart:19-24` reads bytes into memory only. The sole network
dependency is `url_launcher` in `commercial_contact_cards.dart:5,55`, used to open the user's mail
client — never to upload an image. The "100% on-device" copy is therefore **honest**, which few
scan apps can claim.

---

## 2. Sitemap

Generated from `lib/core/router/app_router.dart` — **7 route leaves**, matching `_inventory.json` (7).

```
/splash            → FleetSplashScreen        core/ui/fleet_splash_screen.dart (305 LOC)   [root navigator]
/onboarding        → FleetOnboardingScreen    core/ui/fleet_onboarding_screen.dart (1006) [root navigator]
/                  → EditorScreen             features/editor/editor_screen.dart (493)    [shell branch 1 · Watermark]
/presets           → PresetsScreen            features/presets/presets_screen.dart (729)  [shell branch 2 · Preset]
/history           → HistoryScreen            features/history/history_screen.dart (387)   [shell branch 3 · Riwayat]
/guide             → KominfoGuideScreen       features/guide/kominfo_guide_screen.dart (311)[shell branch 4 · Panduan]
/settings          → SettingsScreen           features/settings/settings_screen.dart (573) [shell branch 5 · Pengaturan]
```

Structural notes:

- **The shell is correct.** `StatefulShellRoute.indexedStack` (`app_router.dart:29-75`) gives each
  of 5 tabs its own Navigator, so editor state survives tab switches. Splash and onboarding sit on
  the root navigator (`:19-28`), correctly outside the shell. Credit — this is the right IA for a
  single-tool utility.
- **Zero `Navigator.push`** (`grep` = 0). Navigation is declarative throughout — no nav debt.
- **No entity routes.** An audit-log entry, a saved preset, or an exported document has no route.
  There is no `/history/:id`, `/presets/:id`. `PresetsScreen` "Use Preset" calls `context.go('/')`
  (`presets_screen.dart:431`), which **resets the branch stack** rather than pushing a detail or
  returning to the editor with history intact.
- **No deep links.** A saved-template link or a "verify this stamp" link cannot open a specific
  object; the share payload is plain text + a generated proof card (`idmark_share_dialog.dart:142-171`).
- **Default page transitions.** Unlike some fleet apps, no `NoTransitionPage` is used; branch
  switches get the platform default, which is acceptable.

---

## 3. Screen inventory

| # | Route | Screen | LOC | Archetype | Primary action | Loading | Empty | Error | Offline |
|---|---|---|---|---:|---|---|---|---|---|
| 1 | `/` | EditorScreen | 493 | Form / editor (canvas + controls) | pick photo → export | ✓ spinner (`editor_screen.dart:452-457`) | ✓ upload prompt (`watermark_canvas_preview.dart:288-394`) | ✓ snackbar (`editor_screen.dart:160-168`) | n/a (offline by design) |
| 2 | `/presets` | PresetsScreen | 729 | List / template library | apply preset | ✗ | ✓ "no templates" (`presets_screen.dart:231-243`) | ✗ (save failure snackbar only, `:662-668`) | n/a |
| 3 | `/history` | HistoryScreen | 387 | List / audit log | copy hash / clear | ✗ | ✓ (`history_screen.dart:123-124,134-163`) | ✗ | n/a |
| 4 | `/guide` | KominfoGuideScreen | 311 | Reader / checklist | tick checklist | ✗ | n/a (static content) | n/a | n/a |
| 5 | `/settings` | SettingsScreen | 573 | Settings | theme / language / reset | ✗ | n/a | ✗ | n/a |
| — | `/splash` | FleetSplashScreen | 305 | Launch | — | — | — | — | — |
| — | `/onboarding` | FleetOnboardingScreen | 1006 | Onboarding | finish | — | — | — | — |

**Loading is real on exactly one screen** (the editor's export spinner). Every other asynchronous
operation — saving a custom preset, persisting config, clearing history — has **no loading and no
error surface** except an optimistic snackbar. The shared `FleetLoadingView` / `FleetStateSwitcher`
/ `FleetShimmerCard` ship in `lib/core/ui/` and are used **0 times** (measured; `grep -rl` outside
`core/ui`).

---

## 4. Screen anatomy

Spacing/type/colour below are the values **actually in code**, not the intended ones.

### 4.1 Editor (`editor_screen.dart` + `widgets/watermark_canvas_preview.dart` + `widgets/watermark_control_panel.dart`)

| Section | Components | Type / colour (actual) | Verdict |
|---|---|---|---|
| App bar (`editor_screen.dart:306-358`) | 20dp app icon tile + `IDMark` + subtitle + reset icon | title 17/w700 hardcoded, subtitle 11 hardcoded (`:333,337`) | Logo doubles as title — no contextual page title for "what am I editing" |
| UU-PDP banner (`:369-388`) | `Container` r16, `bannerSurface`, shield icon | 12sp, hardcoded `Color(0xFFE2E8F0)` (`:383`) | Solid dark banner: readable in both themes; a good pattern the rest of the app should copy |
| Canvas preview (`watermark_canvas_preview.dart:53-153`) | `Image.memory` + `CustomPaint` overlay, `maxHeight: 420`, black bed | score pill 11/w800; compare pill 11 | **The product's whole value lives here** — 420dp tall, unzoomable, and the overlay alpha is fixed regardless of the photo behind it |
| Quick redaction bar (`:156-200`) | 4 `PressScale` chips, horizontal scroll | 11sp, `Color(0xFFCBD5E1)` | Chips are text-only, no icon; four targets in one 8dp-spaced scroll row |
| Config panel (`watermark_control_panel.dart:129-218`) | `Card` r18, `Theme(data: AppTheme.darkTheme)`, 4-tab `TabBar` + `TabBarView` | header 16/w700; tabs icon+label | **Fixed `SizedBox(height: 520)` (`:202-204`)** — clips at 1.6× text scale; pins dark inside a light app |
| Watermark tab (`:222-524`) | purpose field, date row, subtext, 7 pattern chips, 7 colour chips, 3 sliders | labels 12-13, chips 11 | 7 pattern + 7 colour chips = **14 choices with no previews** except the live canvas; sliders labelled but no ticks |
| Export actions (`editor_screen.dart:440-484`) | `ElevatedButton.icon` + `OutlinedButton.icon` | full-width, 16/14 vertical padding | Two export CTAs; **neither shows a consent/warning step** (see 4.7c) |

### 4.2 Presets (`presets_screen.dart`)

| Section | Components | Values | Verdict |
|---|---|---|---|
| App bar (`:73-89`) | title + `+` icon | 22dp add icon, tooltip | Correct single action |
| Banner (`:95-138`) | `bannerSurface` r18 | title 14, body 12 `Color(0xFFE2E8F0)` | Readable; another good solid-surface example |
| Search (`:142-169`) | `TextField`, `fillColor: AppColors.bgSurface`, white text | 14sp white on `#111827` | In **light theme** this paints a dark field on a white page — visually foreign, though contrast passes |
| Category chips (`:173-207`) | horizontal `FilterChip` row, 11 categories | 12sp label | 11 chips in a horizontal scroller with **no trailing fade**; last chip clipped at the edge |
| Preset card (`:256-464`) | icon tile, title 14, category 12, monospace plate, pattern + `Use Preset` | monospace 12, `Color(0xFFE2E8F0)` | The monospace plate is the app's strongest signature; 2 of 6 cards stack under the nav in the store render (`iphone69-2.png`) |
| Empty (`:231-243`) | centred text | 13sp muted | Text-only empty state — no icon, no CTA back to preset creation (the `+` is in the app bar, off-attention) |

### 4.3 History (`history_screen.dart`)

| Section | Components | Values | Verdict |
|---|---|---|---|
| Discipline badge (`widgets/discipline_badge.dart:43-100`) | medal icon, count, tier, share | 14/w800 + 11 | Gamification that leads nowhere beyond a share — no streak detail |
| Security banner (`:53-93`) | `bannerSurface` r18, green verified icon | 14/w700 + 12 `Color(0xFFCBD5E1)` | Solid and readable |
| Search (`:98-118`) | same dark-field pattern as presets | 14 white on `#111827` | Same light-theme discord |
| Audit card (`:177-332`) | timestamp 12, score pill 11, monospace purpose 13, 4 tag chips 11, SHA-256 10 | dozens of raw colours (`:208,212,295,303`) | 10-11sp metadata on the most forensic screen; the SHA-256 line (`:295-306`) is the smallest text in the card — the integrity proof is the least legible thing |
| Empty (`:134-163`) | circular icon + title + body | 16/w700 + 13 | **The best empty state in the app** — icon, headline, explanation, though no CTA |

### 4.4 Guide (`kominfo_guide_screen.dart`)

- Solid blue hero (`:37-73`, `primaryDark`) with white text — the one place a saturated brand
  surface is used correctly.
- Interactive 5-item checklist (`:76-124`, `:207-239`): `PressScale` on a row, 12sp, strikethrough
  on tick. Useful, but **not persisted** — a `StatefulWidget` map (`:15-21`) resets on rebuild/route
  change; the user's progress is lost every time they leave the tab.
- 4 numbered rule cards (`:241-310`) use `bgCard` + white text; number badge 14/w800 `#7DD3FC`.
- Everything is authored **dark** and stays dark in light mode (`Colors.white` at `:56,187,289`).

### 4.5 Settings (`settings_screen.dart`)

| Section | Components | Values | Verdict |
|---|---|---|---|
| Zero-server card (`:57-92`) | `bannerSurface`, shield | 15/w700 + 12 | Correct privacy framing, but the copy is the only reassurance |
| Theme/language (`:106-187`) | `SegmentedButton<ThemeMode>` **icon-only**, language `ListTile` | icons 16, labels 14/12 | **3 icon-only segments with no `label`, no tooltip, no `Semantics`** (`:122-141`) — auto-fail for accessible name |
| Data sanitation (`:200-244`) | `SwitchListTile` + export-format dropdown | 14/12 | Good grouping |
| Local storage (`:257-339`) | history, presets, reset rows | 14/12 | "Presets" row (`:282-289`) is a **dead end** — no tap, no route, just a count |
| About (`:352-411`) | version via `package_info_plus`, domain, compliance, license | 13/12 | Correct use of `PackageInfo`, not a hardcoded version |
| Contact cards (`widgets/commercial_contact_cards.dart:97-101`) | `Semantics(button, label)` + `InkWell` | 14/12 | **Model a11y** — explicit label, `ExcludeSemantics` on the visual subtree, 48dp min |

### 4.6 Splash & onboarding (`core/ui/`)

- `FleetSplashScreen` (305 L) and `FleetOnboardingScreen` (1006 L) are shared fleet components —
  consistent with the other 36 apps, which is a feature, not a defect.
- Onboarding respects reduced motion via `AppMotion.resolve` (`fleet_onboarding_screen.dart:194,309`).

### 4.7 Domain integrity checks (ID / passport PII) — mandatory

This is a national-ID tool. A generic UI grade cannot be fair without these five checks.

| # | Question | Evidence | Verdict |
|---|---|---|---|
| **a** | Does the UI state on capture and share that processing is on-device, and is it true? | Capture: `watermark_canvas_preview.dart:339-364` ("100% On-Device • Gambar tidak pernah dikirim ke server"). Share: `idmark_share_dialog.dart:568` ("100% ON-DEVICE"). Code: full canvas render, no network (see §1). | **PASS, and the copy is honest.** Credit — rare and correct. |
| **b** | Is the watermark legible over both a light and a dark ID photo? | Overlay = `colorOption.color.withValues(alpha: opacity)` (`watermark_canvas_preview.dart:496`). The band behind it is `white/black at (opacity*0.4).clamp(0.05,0.4)` (`:557-559`). White option = `#F8FAFC` (`app_colors.dart:77`); slider floor **0.15** (`watermark_control_panel.dart:459-466`). | **FAIL.** At 15%, a near-white stamp over a bright e-KTP face is **invisible**; at the default 0.50 the white band is only 20% and the stamp depends entirely on the photo's local luminance. No luminance-aware halo, no contrast floor. |
| **c** | Is there a warning before a watermarked ID leaves the device? | `_exportWatermarkedImage()` (`editor_screen.dart:55-172`) begins rendering immediately; the share CTA calls it directly (`:473`), and the success dialog's share button calls it again (`:282`). No `showDialog`/confirmation on either path. | **FAIL — CRITICAL.** The file is a full-resolution identity document. There is **no** "this file will leave your device" gate. |
| **d** | Are preview / history / share free of failure states that leak a full-res ID? | Preview holds bytes in memory only (`app_providers.dart`, `selectedImageBytesProvider`, no disk). History persists **metadata only** — `local_storage_service.dart:123-128` serialises `AuditLogEntry`, never image bytes. Share card is a generated proof (`idmark_share_dialog.dart:490-816`), no ID image. | **PASS.** No cached-file path, no gallery of originals. One nit: export/pick failures print `e.toString()` into a snackbar (`editor_screen.dart:47,164`), which can echo a platform path. |
| **e** | Contrast of translucency over photography. | Same as (b): 12–20% white overlay on a bright ID is unreadable; the `cornerStamp`/`qrBadge` use 0.90–0.95 **white** plates (`:679,859`) which rescue those two patterns only; `bottomBar` uses 0.85 (`:641`); `securitySeal`/`crossStamp` sit at `opacity*0.35 ≤ 0.35` (`:734,802`). | **FAIL.** Four of seven patterns have no guaranteed backing plate; the two legible ones are the exception, not the rule. |

---

## 5. Visual evidence review (real renders)

Sources (read as images):
`docs/store/metadata/ios-screenshots/en-US/iphone69-{1..4}.png` (1290×2796) and
`docs/store/metadata/android/en-US/images/phoneScreenshots/{1..4}.png` (1080×1920). Both sets are
**marketing composites** (phone frame + headline above each screen), not raw device captures.

| # | Severity | Finding | Evidence | Fix |
|---|---|---|---|---|
| 1 | **CRITICAL** | **No screenshot anywhere shows an ID photo with an applied watermark.** The app's entire value — a legible purpose+date stamp over a real identity document — is never demonstrated. The closest artefact is opaque monospace placeholder text in a preset card. | `iphone69-1.png` (empty upload), `iphone69-2.png` (preset plate `VERIFIKASI REKENING BANK [NAMA BANK]`), `iphone69-3.png` (audit list), `iphone69-4.png` (checklist); Android `1.png`–`4.png` identical gaps | Add 2 store slides: one light e-KTP, one dark passport, same stamp, with the "hold to compare" state shown |
| 2 | **HIGH** | Content sits under the opaque bottom nav with no scroll padding in the composite: preset card #2 and the guide's first rule are cut mid-sentence. | `iphone69-2.png`, `iphone69-4.png`; code relies on `AppScroll.pagePadding` bottom = 80+inset (`app_scroll.dart:16-21`) | Verify `extendBody` + bottom padding against the real nav height; add `viewPadding` not a magic 80 |
| 3 | **HIGH** | Filter chip row clips at the viewport edge with no fade. | `iphone69-2.png` ("Finance & Lend…" clipped) | Trailing `ShaderMask` 24dp fade, or replace with a Filters sheet + count badge |
| 4 | **MEDIUM** | Search placeholder truncates mid-word inside the field. | `iphone69-2.png` ("…mortg…") | Shorten hint or allow 2 lines; the hint is l10n-controlled (`presets_screen.dart:146`) |
| 5 | **MEDIUM** | Four different app-bar patterns across four slides (branded+reset; title+add; title+delete; title only), and the bottom nav is absent in 2 of 4. | `iphone69-1.png` vs `2` vs `3` vs `4` | One `AppBar` contract: contextual title left, at most one action right; always show the nav |
| 6 | **MEDIUM** | `Score 95%` and `Score 100%` render in the same green success style. | `iphone69-3.png` | Tier the pill colour by band (`privacyScore ≥ 80` green, 65–79 amber) — code already computes the band (`history_screen.dart:219-229`) |
| 7 | **POLISH** | Indonesian preset titles and `[NAMA BANK]` placeholders remain inside the `en-US` asset set; one title reads `PENGIKTIAN` (non-standard). | `iphone69-2.png` | Localise preset sample text for store renders; fix the typo |

**What the renders get right and must not be thrown away:** the navy → slate gradient language, the
monospace stamp plates, the green "on-device" pill, the audit SHA-256 block, and the guide's
number-badge cards. The app already looks like a privacy product; it just never shows its output.

---

## 6. Scorecard

`score = Σ(category × weight) / Σ(weight)`; Touch (6) and Accessibility (10) weigh **1.5×**.

| # | Category | W | P/W/F | Score | Grade |
|---|---|---:|---|---:|---|
| 1 | Visual hierarchy & composition | 1.0 | 5/2/2 | 66.7 | D |
| 2 | Typography | 1.0 | 3/4/5 | 41.7 | F |
| 3 | Color & theming | 1.0 | 3/4/5 | **41.7** (auto-fail band) | F |
| 4 | Spacing & layout | 1.0 | 6/4/4 | 57.1 | F |
| 5 | Navigation | 1.0 | 8/2/1 | 81.8 | B |
| 6 | Touch & gesture | **1.5** | 4/4/2 | 60.0 | D |
| 7 | Platform conventions | 1.0 | 5/3/2 | 65.0 | D |
| 8 | Motion & animation | 1.0 | 5/4/1 | 70.0 | C |
| 9 | Content states | 1.0 | 4/4/2 | 60.0 | D |
| 10 | Accessibility | **1.5** | 3/5/3 | 50.0 | F |
| 11 | Responsive & adaptive | 1.0 | 4/4/2 | 60.0 | D |
| 12 | Performance as design | 1.0 | 5/2/1 | 75.0 | C |
| 13 | AI-slop detection | 1.0 | 3/3/2 | 56.3 | F |
| | **Weighted total** | **14.0** | | **60.0** | **D** |

**Arithmetic:**
```
(66.7 + 41.7 + 41.7 + 57.1 + 81.8 + 60.0×1.5 + 65.0 + 70.0
 + 60.0 + 50.0×1.5 + 60.0 + 75.0 + 56.3) / 14.0
= (66.7 + 41.7 + 41.7 + 57.1 + 81.8 + 90.0 + 65.0 + 70.0
   + 60.0 + 75.0 + 60.0 + 75.0 + 56.3) / 14.0
= 840.3 / 14.0 = 60.02 → 60.0  (D: ≥60, <70)
```

### Item-level failures (the ones that set the grade)

| SEVERITY | CATEGORY | Location | Issue | Fix |
|---|---|---|---|---|
| CRITICAL | Content states / product | `editor_screen.dart:55-172`, CTAs `:451,:473` | No pre-export warning that the watermarked ID leaves the device | `showDialog` gate: "This file leaves your device" → Export/Cancel before `_exportWatermarkedImage` |
| CRITICAL | Color | `features/*` (115), `core/ui` (16), `core/services` (10) | 141 inline `Color(0x…)` in presentation against a written ban | Replace with `colorScheme`/`AppColors`; add the 8 undocumented hexes (`foundations.md:62`) to `app_colors.dart` |
| CRITICAL | Color / domain | `watermark_control_panel.dart:459-466`; `watermark_canvas_preview.dart:496,557-559` | 15% opacity floor + no luminance-aware backing → white stamp invisible on a bright ID | Floor at 0.35 for white; draw a contrast-checked plate or dual-stroke outline per pattern |
| CRITICAL | Accessibility | `settings_screen.dart:122-141` | Theme `SegmentedButton` = 3 icon-only segments, no label/tooltip/`Semantics` | Add `label:` or `tooltip:` + `Semantics(label: ...)` per segment |
| HIGH | Typography | 198 `fontSize`, **44 below 12sp**; `history_screen.dart:295,303` (10sp) | `TextTheme` never used for body; SHA-256 proof at 10sp | `app_typography.dart` with 6 steps; floor 12sp; key numbers ≥14 |
| HIGH | A11y | `Semantics` 10, `MergeSemantics` **1**, `semanticLabel` 9 across 7 screens | Compound rows (audit card, preset card) expose multiple nodes | `MergeSemantics` on each card; label = purpose + score + hash |
| HIGH | Layout | `watermark_control_panel.dart:202-204` | `SizedBox(height: 520)` clips at 1.6× text scale | `ConstrainedBox` + intrinsic/`LayoutBuilder`, or let the sheet grow |
| MEDIUM | Theming | `watermark_control_panel.dart:130`, `presets_screen.dart:487`, `idmark_share_dialog.dart:249` | `Theme(data: AppTheme.darkTheme)` pins dark sub-surfaces inside a light app | Adopt one policy: either dark-only (drop the theme toggle) or theme-aware panels |
| MEDIUM | Consistency | `idmark_share_dialog.dart:205-206` vs `editor_screen.dart:149` | Deprecated `Share.shareXFiles` in one path, `SharePlus.instance.share` in the other | One share helper |
| MEDIUM | States | `presets_screen.dart`, `history_screen.dart` | Async persist has no loading/error UI | `FleetStateSwitcher` around save/clear |
| POLISH | AI slop | `kominfo_guide_screen.dart:117-121` | Checklist state not persisted → progress lost per tab visit | Persist to `shared_preferences` |

---

## 7. Harsh verdict

1. **The privacy promise is real and the consent gate is missing.** This is the one app in the
   fleet where a single tap hands a full-resolution national ID to WhatsApp. The code proves the
   bytes never touch a server — and then proves nothing else: there is no "this leaves your device"
   confirmation anywhere on the export path. For an identity-fraud product this is the defect that
   matters more than every colour in this report.
2. **The stamp can be invisible and the app cannot tell.** A 15% white watermark over a bright
   e-KTP is not a watermark; it is a rumour. The overlay painter applies the same alpha to a night
   passport photo and a flash-lit KTP, and four of seven patterns have no backing plate. "Burned
   into the pixels" is only protection if a human — or a fraudster's eyes — can see it.
3. **It is two design systems again: `components.md` and the widgets.** 201 inline colours and 245
   raw `TextStyle`s in an app that explicitly bans inline colour. The dark surfaces look coherent
   today because someone hand-picked similar hexes; the next brand change will expose 141
   presentation sites that disagree.
4. **The craft is above the fleet and the discipline is below it.** Real contrast tests for all five
   screens, spring press feedback with reduced-motion respect, `TapTarget` with haptics, a genuine
   offline pipeline. And then an icon-only theme switch with no accessible name, a 520dp fixed-height
   panel, and a guide checklist that forgets itself. Ship-able, not portfolio-able.

---

## 8. Competitor analysis

Scope: products solving the same job — capture a document, protect it, and hand a safe copy to a
third party. Feature comparison at the IA level (stable across releases); verify specifics before build.

| Product | Model | Core IA | What they do that IDMark does not |
|---|---|---|---|
| **CamScanner** | freemium + cloud | Camera → crop/enhance → PDF; batch; OCR; optional watermark | **Capture overlay with edge detection** — IDMark uses the raw system picker, no framing guide |
| **Adobe Scan** | freemium + cloud | Auto-detect, OCR, PDF, cloud share | Real OCR + a multi-page document model |
| **Microsoft Lens** | free + cloud | Capture → filter → OCR → PDF | A filter/enhance step before export |
| **TapScanner** | freemium | Scan → OCR → sign → watermark | Signing + a watermark from the same flow |
| **Watermarkly / MyWatermark** (web) | freemium | Batch watermark; opacity, position, font, logo | **Batch** across many files; a full opacity/position editor as the primary surface |
| **CLEAR** | subscription identity | Encrypted ID wallet; per-document masked fields; share passes | A **vault of documents** with masked values — IDMark keeps only metadata, never the document |
| **Aura / IDShield** | subscription | Monitoring + alerts + restoration | Ongoing monitoring; IDMark is one-shot at export |
| **Privy (PrivyID)** / **IKD (KTP Digital)** | gov/enterprise | Verified digital identity, e-sign, QR | A **real, verifiable QR**; IDMark's QR badge is decorative (see below) |

**Positioning gap.** IDMark is the only one of these that **burns a purpose+date stamp on-device
with no account and no upload** — that is a genuine, defensible wedge against cloud-first scanners
and subscription monitors. Its weakness is that it stops at the stamp: there is no capture-time
framing, no batch, and the "verification" QR is not a QR at all — `_drawQrBadge` paints four
alternating squares (`watermark_canvas_preview.dart:874-883`), so no scanner can read it. The app
promises verifiability it does not implement.

**Three competitor moves worth copying, cheapest first**

1. **Framing overlay on capture** (Google Drive / CamScanner) — a 2dp blue document rectangle and a
   large white shutter, so the user frames the ID instead of guessing in the system picker.
2. **Contrast-guaranteed stamp** (Watermarkly) — pair the stamp colour with a computed backing plate
   so the watermark is legible on the darkest and lightest photo.
3. **Real verification receipt** (CLEAR / PrivyID) — either make the QR encode `{purpose, date,
   sha256}` or drop the QR pattern; do not ship a fake.

---

## 9. Mobbin reference delta

Pulled with `mobbin screens "<query>" --platform ios --deep`, downloaded with `mobbin download`,
**read as rendered images**. Four references, four archetypes. Values were read off the reference.

### 9.1 Capture overlay → Google Drive · `mobbin.com/screens/1e8afd16-6fe4-420f-b810-dca6f8234a5f`

| Dimension | IDMark | Google Drive | Verdict |
|---|---|---|---|
| Capture surface | system `image_picker` (`image_picker_service.dart:19-24`) — no in-app camera | full-bleed live preview with edge detection | **worse** — no framing, no feedback the ID is aligned |
| Framing guide | none | ~2dp blue rectangle inset ~24pt, square corners | missing |
| Shutter | OS-native | 58dp white ring/disc, ~90pt above bottom scrim | worse (no in-app shutter) |
| Top controls | OS picker chrome | `Cancel` · flash · flip · `Auto`, white 17pt | worse |
| Instruction text | none | none (geometry teaches the task) | equal |

### 9.2 Photo editor → Lapse · `mobbin.com/screens/7435ee8f-9932-4849-bda5-002b6be5576d`

| Dimension | IDMark | Lapse | Verdict |
|---|---|---|---|
| Timestamp stamp style | monospace uppercase plate (`presets_screen.dart:401-409`) | amber dot-matrix date/time burned on the photo | different, both valid — IDMark's is more official, Lapse's is more legible |
| Tool rail | 4-tab vertical label bar inside a 520dp box (`watermark_control_panel.dart:165-212`) | 5 circular 50dp outline buttons + 13pt labels | worse — IDMark's tabs are text-heavy and height-locked |
| Opacity control | slider 15–90% (`:459-466`) | **not shown** | n/a; but IDMark's floor is the bug |
| Primary export | two full-width buttons + success dialog (`editor_screen.dart:440-484`) | single electric-blue pill `Export to` + share glyph | worse — two competing CTAs vs one |
| Canvas | 420dp `maxHeight`, `BoxFit.contain` (`watermark_canvas_preview.dart:54`) | near-full-height, letterboxed | worse — IDMark's preview is the smallest element on a screen about the image |
| Accent discipline | sky + emerald + amber + red + 7 watermark colours | one electric blue + amber stamps | worse |

### 9.3 Document wallet → CLEAR · `mobbin.com/screens/6d34748e-dba6-4891-8eea-40ec8ff9f446`

| Dimension | IDMark | CLEAR | Verdict |
|---|---|---|---|
| Document representation | history = metadata rows only (`local_storage_service.dart:123-128`) | translucent card with ID-photo thumbnail + masked fields | different — IDMark is intentionally never-save-the-image |
| Privacy signal | explicit "on-device" banner + green pill | masked/blurred values only (no copy) | **better** — IDMark states the promise; CLEAR relies on visual obfuscation |
| Field affordance | copy SHA-256 (`history_screen.dart:310-323`) | per-field copy icon on every masked value | worse — only the hash is copyable |
| Document switcher | none | lime `Passport ▾` pill | missing (IDMark has no document-type concept) |
| Vault navigation | 5-tab shell | floating 3-item capsule (`Vault` active) | equal |

### 9.4 ID upload guidance → Binance · `mobbin.com/screens/f64fa10a-926f-49d0-a36d-d3a300b9daf6`

| Dimension | IDMark | Binance | Verdict |
|---|---|---|---|
| Upload guidance | one paragraph + 2 buttons (`watermark_canvas_preview.dart:318-388`) | numbered requirement card ("original ID, all info visible, not expired") | **worse** — IDMark never states capture requirements (glare, full frame, no crop) |
| Primary vs secondary CTA | filled blue vs outlined (both full width) | black 2pt border vs grey 1pt border, equal height | equal |
| Privacy reassurance | strong "100% on-device" pill | none (only "scanned for data extraction") | **better** — IDMark wins on trust copy |
| Pre-submit warning | **none** (4.7c) | requirements stated as warnings, still no confirm modal | worse — both lack a confirm step; IDMark's file is the sensitive one |
| Progress/error state | spinner + snackbar, editor only | none shown | equal |

**Cross-cutting deltas (component level)**

| Component | IDMark | Reference norm | Action |
|---|---|---|---|
| Capture | system picker | in-app overlay + frame + shutter | build `IdCaptureScreen` (P1) |
| Preview canvases | 420dp, `contain` | near-full-height | raise to ~60% viewport with pinch-zoom |
| Opacity control | 15–90% slider | editor slider with live preview | floor 35% for light stamps + haloS |
| Export | 2 CTAs, no confirm | single pill, guidance before submit | one primary + consent gate |
| Icon-only controls | theme switch unlabeled | labelled segmented control | add labels/`Semantics` |
| Empty states | icon+title+body (history) / text-only (presets) | in-place + recovery CTA | add CTA to both |

---

## 10. Missing features, screens and components

Ranked by user value per hour of work.

### Screens missing

| Screen | Why it matters | Reference |
|---|---|---|
| **Capture** (`IdCaptureScreen` with frame + shutter) | The system picker gives no framing or glare feedback; a mis-framed ID is a bad export | Google Drive, CamScanner |
| **Audit entry detail** (`/history/:id`) | The hash, stamp text, and redactions have no full view; the card is the ceiling | CLEAR |
| **Preset detail/edit** (`/presets/:id`) | Custom presets are create-and-delete only; no edit | Watermarkly |
| **Verification receipt** (`/verify/:hash`) | A real, scannable proof the recipient can check | PrivyID, IKD |
| **Batch watermark** | Small businesses stamp many IDs; today it is one at a time | Watermarkly |

### Features missing

- **Pre-export consent gate** (domain-critical; §4.7c).
- **Contrast-guaranteed overlay** (domain-critical; §4.7b/e).
- **Persisted guide checklist** — resets on every tab visit (`kominfo_guide_screen.dart:15-21`).
- **Real QR** — `_drawQrBadge` draws decorative squares (`watermark_canvas_preview.dart:874-883`).
- **Document-type model** (KTP / passport / SIM) so presets and warnings can specialise.
- **A "sensitive" export warning banner** in the share sheet (currently absent).
- **A11y names** on icon-only controls (theme switch, some toolbar icons).

### Components missing

`ConsentSheet` · `CaptureFrame` · `ContrastSafeStampPainter` (luminance-aware backing) ·
`AppTypography` (currently none) · `IconSegmentedButton` with required labels · `EmptyWithCta`
(presets) · `AuditRow` using `MergeSemantics` · `QrPayload` (real encoding) ·
`BatchExportQueue`.

---

## 11. Improvement plan

Effort in engineer-hours for one developer who knows the codebase.

### P0 — broken (blocks the grade, 10–13 h)

| # | Change | Files | Effort | Score delta |
|---|---|---|---|---|
| P0-1 | **Consent gate before export/share**: confirm dialog "file leaves your device" (+ reason), then render | `editor_screen.dart:55-172`, CTAs `:451,:473` | 1.5 h | States 60→68; safety-critical |
| P0-2 | **Contrast-safe stamp**: luminance-aware backing plate; raise white floor to 0.35; per-pattern plate | `watermark_canvas_preview.dart:492-520,557-559,640-642,679,734,802`; `watermark_control_panel.dart:459-466` | 3 h | Color 41.7→52; domain-critical |
| P0-3 | **Kill inline colours**: `AppColors`/`colorScheme`; add the 8 undocumented hexes to tokens | `features/*` (115), `core/ui` (16), `core/services` (10) | 4 h | Color 41.7→72 |
| P0-4 | **A11y names** on icon-only controls; `MergeSemantics` on audit/preset cards | `settings_screen.dart:122-141`, `history_screen.dart:177-332`, `presets_screen.dart:256-464` | 2 h | A11y 50→66 |
| P0-5 | **Type floor**: `app_typography.dart`, 6 steps, no meta < 12sp | all features; `history_screen.dart:295,303` | 3 h | Typography 41.7→64 |

### P1 — system (14–19 h)

| # | Change | Files | Effort | Delta |
|---|---|---|---|---|
| P1-1 | **States**: `FleetStateSwitcher` + skeletons on preset save, history clear, export | `presets_screen.dart`, `history_screen.dart`, `core/ui` | 2.5 h | States 68→82 |
| P1-2 | **Responsive**: replace fixed 520 height; `LayoutBuilder`; tablet 2-pane for editor | `watermark_control_panel.dart:202-204`, `editor_screen.dart:359-390` | 3 h | Responsive 60→76 |
| P1-3 | **Capture screen**: frame + shutter + requirements card | new `features/capture/`, route, `image_picker_service.dart` | 5 h | Hierarchy +6, Platform +4 |
| P1-4 | **Entity routes**: `/history/:id`, `/presets/:id`; `context.push` not `context.go('/')` | `app_router.dart`, `presets_screen.dart:431` | 2.5 h | Nav 81.8→86 |
| P1-5 | **One theme policy**: dark-only or theme-aware panels (remove `Theme(data: dark)` pins) | `watermark_control_panel.dart:130`, `presets_screen.dart:487`, `idmark_share_dialog.dart:249` | 2.5 h | Color +4, Consistency +3 |
| P1-6 | **Real QR / verification receipt** or remove the QR pattern | `watermark_canvas_preview.dart:841-905` | 3 h | AI-slop +4 (honesty) |

### P2 — polish (9–12 h)

| # | Change | Effort | Delta |
|---|---|---|---|
| P2-1 | Persist the guide checklist to `shared_preferences` | 1 h | States +3 |
| P2-2 | Trailing `ShaderMask` fade on every horizontal chip scroller | 1 h | Layout +4 |
| P2-3 | One share helper (drop deprecated `Share.shareXFiles`) | 0.5 h | Consistency +2 |
| P2-4 | Store slides that actually show a watermarked light ID and a dark passport | 2 h | product proof |
| P2-5 | Tier the history score pill by band (amber 65–79) | 0.5 h | Hierarchy +2 |
| P2-6 | Copy pass: fix `PENGIKTIAN`, localise preset samples in `en-US` | 1.5 h | AI-slop +3 |
| P2-7 | Sanitise exception text in snackbars (no raw `e.toString()`) | 0.5 h | Privacy +2 |

**Projected after P0+P1:** 60 → ~78 (B). After P2: ~86 (B+). Reaching a true **A** additionally
requires the capture screen, real verification, and a11y coverage at ≥1 labelled `Semantics` per
interactive row (today `MergeSemantics` is used once across 7 screens).

---

## 12. Definition of done

- [ ] `grep -rc "Color(0x" lib/features lib/core/ui lib/core/services` → **0**
- [ ] `grep -rc "fontSize:" lib/features` → **0** (all via `app_typography`)
- [ ] Export/share requires an explicit consent dialog; verified on both CTAs and the success dialog
- [ ] White watermark ≥ 35% opacity, and every pattern has a luminance-aware plate; screenshot proof
      over the brightest and darkest sample IDs
- [ ] `MergeSemantics` count ≥ number of interactive cards; every icon-only control has a label
- [ ] Zero fixed pixel heights that clip at 1.6× text scale (verified at 320dp and 200%)
- [ ] Theme switch has visible labels or semantic names; light mode inspected screen-by-screen
- [ ] `/history/:id` routable; `context.go('/')` from presets replaced by a history-preserving push
- [ ] Guide checklist survives tab switches
- [ ] Store slide set includes at least one watermarked light ID and one dark passport
- [ ] Scorecard re-run ≥ 90 with evidence

---

## Appendix — method and reproduction

- **Sitemap:** parsed from `lib/core/router/app_router.dart`; counted 7 `GoRoute` leaves, matching
  `docs/design-audit/_inventory.json` (`routes.length == 7`).
- **Counts:** `grep -rho '<pattern>' <dir> --include='*.dart' | wc -l`; reported per directory.
  Whole-`lib` totals: `Color(0x` = **201**, `TextStyle(` = **245**, `fontSize: [0-9]` = **198**,
  `Semantics(` = 10, `semanticLabel` = 9, `MergeSemantics` = 1, `tooltip:` = 7, `TapTarget` = 11,
  `HapticFeedback` = 7, `TextOverflow` = 7, `maxLines:` = 8, `RefreshIndicator` = 0,
  `LayoutBuilder` = 2, `Navigator.push` = **0**, `SingleChildScrollView` = 6.
- **Offline verification:** `grep -rniE "http|dio|url_launcher|HttpClient" lib` → only
  `url_launcher` in `commercial_contact_cards.dart` (mailto); renderer and PDF export have no HTTP
  symbols. `pubspec.yaml` network deps: only `url_launcher` (+ platform interface).
- **Renders:** `iphone69-{1..4}.png` (1290×2796) and Android `{1..4}.png` (1080×1920), read as
  images. Both sets are marketing composites, not raw captures; none shows a live watermark over an ID.
- **Mobbin:** `mobbin screens "<query>" --platform ios --deep`, four references downloaded with
  `mobbin download` and read as images: Google Drive `1e8afd16-…`, Lapse `7435ee8f-…`, CLEAR
  `6d34748e-…`, Binance `f64fa10a-…`.
- **Tests inspected, not executed (audit mode):** `theme_contrast_test.dart`, `contrast_audit.dart`,
  `watermark_flow_test.dart`, `history_guide_settings_flow_test.dart`,
  `store_screens/store_screens_test.dart`.
- **Not done (per brief):** no `flutter build/run/test`, no `dart analyze`, no source or `pubspec`
  edits; docs-only change, no version bump (§VER).
