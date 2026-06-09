# EasyEffects 8.x (Qt/QML) skins — research + plan

EasyEffects 8.0 dropped GTK4 and was rewritten in **Qt6 / QML / Kirigami**. The
GTK CSS skins on `main` have no surface to attach to in 8.x. This is the research
into what skinning *is* possible in 8.x and how it maps to our existing skins.

> Research date: 2026-06-09. Verified against EE master CHANGELOG + source AND
> **hands-on against EE 8.2.4** installed on this machine (KDE runtime 6.10).
> Note: flathub pruned 7.2.5, so a flatpak downgrade back to it is not possible —
> 7.x config is backed up at `~/easyeffects-7.2.5-backup-20260609-152200/`.

## ✅ Hands-on confirmed on EE 8.2.4

- **App-chrome skin hook = KDE `.colors` files in `~/.local/share/color-schemes/`.**
  The flatpak's sandbox permissions are exactly:
  `xdg-data/color-schemes:ro` + `xdg-config/kdeglobals:ro` + `xdg-config/gtk-3.0:ro`.
  So it reads color schemes from the host `~/.local/share/color-schemes/` (already
  exists — holds `CosmicDark.colors`, `CosmicLight.colors`). Our skins drop here
  and appear in Preferences → "custom color theme". `kdeglobals` records the active
  selection. **This is the definitive app-wide skin mechanism.**
- **Most settings still live in a GSettings keyfile**:
  `~/.var/app/com.github.wwmm.easyeffects/config/glib-2.0/settings/keyfile`
  (plugins, window size, devices, EQ bands, last preset). Still script-editable.
- **Graph/spectrum colors are NOT in GSettings** (no schema keys for color/graph/
  spectrum). They use the new `Db*` backend serialized under
  `~/.var/app/com.github.wwmm.easyeffects/config/easyeffects/db/`. That dir is
  **empty until a graph color is changed from default** — so to capture the exact
  file/format, toggle a graph color in the running UI and diff `db/`. (Still TODO.)
- **Migration is destructive-ish**: launching 8.x moved presets/IRS from
  `config/easyeffects/` to `data/easyeffects/` and trashed the old dirs. The old
  GTK CSS themes still sit in `config/gtk-4.0/themes/` but are inert. (Backup first.)

## How appearance works in EE 8.x — two independent layers

### 1. App-wide UI palette = Kirigami / KDE color scheme (NOT CSS)
- The whole window is a Kirigami app. It follows the **XDG Color Scheme portal**
  (system dark/light) automatically (added 8.0.1 for Flatpak).
- Preferences has a **"custom color theme"** selector (added 8.0.6). This is the
  Kirigami/KDE color-scheme picker — it recolors backgrounds/accents/text from a
  **KDE color scheme** (`.colors` file), the standard Plasma palette format.
- ⚠️ **Custom Qt styles are NOT respected.** `QT_STYLE_OVERRIDE` / `QT_THEME_OVERRIDE`
  = kvantum, qt5ct, qt6ct all fail to theme EE (confirmed in 8.1.2, issue #4857).
  Kvantum is the only Qt mechanism that does textures/bevels/borders — and EE
  ignores it. So **the elaborate chassis art is dead in 8.x** (see Limitations).

### 2. Spectrum / level graph = `DbGraph` settings (the gsettings successor)
- Spectrum is drawn by **Qt Graphs** now. 8.0.0 only allowed Qt color presets;
  **8.0.6 added a "User" theme with full custom colors** — a big upgrade.
- The picker (`PreferencesSheet.qml` stylePage) exposes built-in themes:
  `Green, Green neon, Mix, Orange, Yellow, Blue, Purple, Grey, User`.
- Selecting **User** (`GraphsTheme.Theme.UserDefined`) enables per-color delegates
  backed by `DbGraph.*` properties: `backgroundColor`, `plotAreaBackgroundColor`,
  `seriesColors`, plus label/border colors.
- 🎉 **The spectrum background is now settable** (`backgroundColor`). In 7.x it was
  hardcoded black and un-themable — that limitation is gone in 8.x.

### Settings storage
- 8.x uses an internal **settings database** (the `Db*` backend objects), **not
  GSettings and not a plain text/config file**. There's an open feature request
  (#4881) asking for a writable config file. Until that lands, the old trick of
  scripting colors via `gsettings set` is gone — values are set through the UI or
  by writing the EE settings DB directly (path TBD, needs hands-on 8.x).

## What this means for our skins

A "skin" in 8.x = **(a) a KDE `.colors` color scheme** for the app chrome **+ (b) a
saved set of `DbGraph` User-theme colors** for the spectrum. Two artifacts per
skin, both palette-only.

### ❌ Limitations vs the 7.x GTK CSS skins (be honest about this)
Kirigami color schemes define a **palette only** — no background images, no
textures, no bevels, no per-widget border art, no blur. Combined with Kvantum
being ignored, these 7.x skin features **cannot be reproduced** in 8.x:
- woodgrain texture, brushed-aluminum / carbon-fiber backgrounds
- beveled gunmetal chrome, EasyAmp 7-segment LCD bezels
- glass-future frosted/blur, cyberpunk grid background + neon glow
The 8.x versions will be **flat recolors** capturing each skin's *color identity*
(onkyo green, red/black, amber woodgrain, pink/cyan cyberpunk…) but not its texture.

### ✅ What ports cleanly
- Every skin's **accent/background/text color palette** → a `.colors` scheme.
- Every skin's **spectrum colors** → a `DbGraph` User-theme preset. This is
  actually *more* capable than 7.x (settable bg, plot bg, multi-series colors).

## Build status (color schemes)

`generate-colors.sh` emits 6 KDE color schemes into `color-schemes/` — one per
7.x skin, mapping each skin's color identity (extracted from its CSS) onto the
KDE palette (`Window/View/Button/Selection/Header` + WM). Install:

```bash
cp qml-skins/color-schemes/*.colors ~/.local/share/color-schemes/
# then EasyEffects -> Preferences -> "custom color theme" -> pick it
```

Verified hands-on: files land where EE 8.2.4 reads them and the app launches
clean. **Not yet verified: the in-app visual render** — this box's compositor
isn't wlroots (no `grim` capture) and the flatpak `kdeglobals` is read-only, so
the picker selection + look must be eyeballed at the GUI. **These schemes are
BETA / palette-only** (no texture — see Limitations).

## Plan / checklist
- [ ] Install EE 8.x somewhere (separate Flatpak ref or a VM) to test hands-on —
      do NOT replace the working 7.2.5 on this box.
- [ ] Find the on-disk path of a KDE `.colors` scheme the Flatpak EE will read
      (host `~/.local/share/color-schemes/` vs flatpak `--filesystem` exposure).
- [ ] Author 6 `.colors` files (onkyo-green, red-black, glass-future, cyberpunk,
      woodgrain, easyamp) — palette only, derived from each CSS skin's colors.
- [ ] Capture the `DbGraph` User-theme color set per skin (bg, plot bg, series,
      labels, borders) and find how to set them non-interactively (DB write path).
- [ ] New manager script for 8.x: install/select `.colors` scheme + apply graph
      colors. Old gsettings/CSS/flatpak-override logic does not apply.
- [ ] README: set expectations — 8.x skins are flat color themes, not textured.

## Sources
- Phoronix: EasyEffects 8.0 GTK4→Qt/QML/Kirigami
- EE CHANGELOG (8.0.0 Qt Graphs presets; 8.0.1 XDG Color Scheme; 8.0.6 custom
  spectrum colors + custom app color theme; fps cap)
- `src/contents/ui/PreferencesSheet.qml` (stylePage / DbGraph color theme combo)
- Issue #4857 (Kvantum / QT_STYLE_OVERRIDE not respected, 8.1.2)
- Issue #4881 (request for writable color config file)
