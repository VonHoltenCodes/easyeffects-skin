#!/bin/bash
# ============================================================
# Generate KDE color schemes (.colors) for EasyEffects 8.x
# from the color identity of the 7.x GTK CSS skins.
#
# EE 8.x reads color schemes from ~/.local/share/color-schemes/
# (sandbox perm: xdg-data/color-schemes:ro) and lists them in
# Preferences -> custom color theme. These are PALETTE-ONLY:
# no textures/bevels/blur (those 7.x features can't port).
# ============================================================
set -euo pipefail
OUT="$(dirname "$0")/color-schemes"
mkdir -p "$OUT"

# emit_scheme <slug> <DisplayName> <window_bg> <view_bg> <button_bg> \
#             <header_bg> <fg> <accent> <accent_fg> <neg> <neu> <pos>
# colors are "R,G,B"
emit_scheme() {
  local slug="$1" name="$2" win="$3" view="$4" btn="$5" hdr="$6" fg="$7" \
        acc="$8" accfg="$9" neg="${10}" neu="${11}" pos="${12}"
  cat > "$OUT/$slug.colors" <<EOF
[General]
ColorScheme=$name
Name=$name
shadeSortColumn=true

[KDE]
contrast=4

[ColorEffects:Disabled]
Color=56,56,56
ColorAmount=0
ColorEffect=0
ContrastAmount=0.65
ContrastEffect=1
IntensityAmount=0.1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=112,111,110
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Window]
BackgroundNormal=$win
BackgroundAlternate=$view
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$acc
ForegroundInactive=$fg
ForegroundLink=$acc
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$fg
ForegroundPositive=$pos
ForegroundVisited=$acc

[Colors:View]
BackgroundNormal=$view
BackgroundAlternate=$btn
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$acc
ForegroundInactive=$fg
ForegroundLink=$acc
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$fg
ForegroundPositive=$pos
ForegroundVisited=$acc

[Colors:Button]
BackgroundNormal=$btn
BackgroundAlternate=$hdr
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$acc
ForegroundInactive=$fg
ForegroundLink=$acc
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$fg
ForegroundPositive=$pos
ForegroundVisited=$acc

[Colors:Selection]
BackgroundNormal=$acc
BackgroundAlternate=$acc
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$accfg
ForegroundInactive=$accfg
ForegroundLink=$accfg
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$accfg
ForegroundPositive=$pos
ForegroundVisited=$accfg

[Colors:Tooltip]
BackgroundNormal=$win
BackgroundAlternate=$view
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$acc
ForegroundInactive=$fg
ForegroundLink=$acc
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$fg
ForegroundPositive=$pos
ForegroundVisited=$acc

[Colors:Complementary]
BackgroundNormal=$win
BackgroundAlternate=$view
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$acc
ForegroundInactive=$fg
ForegroundLink=$acc
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$fg
ForegroundPositive=$pos
ForegroundVisited=$acc

[Colors:Header]
BackgroundNormal=$hdr
BackgroundAlternate=$win
DecorationFocus=$acc
DecorationHover=$acc
ForegroundActive=$acc
ForegroundInactive=$fg
ForegroundLink=$acc
ForegroundNegative=$neg
ForegroundNeutral=$neu
ForegroundNormal=$fg
ForegroundPositive=$pos
ForegroundVisited=$acc

[WM]
activeBackground=$hdr
activeBlend=$acc
activeForeground=$fg
inactiveBackground=$win
inactiveBlend=$view
inactiveForeground=$fg
EOF
  echo "  wrote $OUT/$slug.colors"
}

echo "Generating EE 8.x color schemes..."
#            slug          DisplayName            window     view       button     header     fg            accent       accentfg    neg         neu          pos
emit_scheme onkyo-green   "Onkyo Green"          "5,5,5"    "10,31,21" "9,9,9"    "12,40,27" "216,237,226" "43,255,143" "5,5,5"     "255,42,26" "255,170,0"  "43,255,143"
emit_scheme red-black     "Red Black"            "10,10,10" "26,0,0"   "20,20,20" "40,0,0"   "232,232,232" "170,0,0"    "255,255,255" "255,65,65" "255,170,0" "0,200,90"
emit_scheme glass-future  "Glass Future"         "20,25,40" "36,41,56" "30,36,52" "44,52,74" "208,225,249" "100,150,255" "10,14,24"  "255,90,90" "255,200,90" "120,220,160"
emit_scheme cyberpunk     "Cyberpunk"            "13,2,33"  "26,9,51"  "20,6,42"  "38,12,72" "255,255,255" "255,0,255"  "13,2,33"   "255,60,90" "0,255,255"  "0,255,170"
emit_scheme woodgrain     "Woodgrain"            "31,16,8"  "47,31,18" "58,40,23" "74,53,32" "244,228,193" "255,170,0"  "31,16,8"   "220,60,40" "255,200,90" "139,175,80"
emit_scheme easyamp       "EasyAmp"              "12,12,12" "10,10,10" "58,58,58" "74,74,74" "200,210,200" "43,255,43"  "10,10,10"  "255,80,80" "255,190,0" "43,255,43"
echo "Done. Install with: cp $OUT/*.colors ~/.local/share/color-schemes/"
