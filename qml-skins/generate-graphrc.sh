#!/bin/bash
# ============================================================
# Generate EE 8.x spectrum-graph color presets (db/graphrc)
# one per skin, matching the app color scheme's identity.
#
# Format = KConfig INI written to:
#   ~/.var/app/com.github.wwmm.easyeffects/config/easyeffects/db/graphrc
# Schema: src/contents/kcfg/easyeffects_db_graph.kcfg
#   colorTheme=userDefined  (unlocks custom colors)
#   *Color keys = "R,G,B"
# This is the part of 8.x that is actually richly themable
# (the spectrum is the visual centerpiece).
# ============================================================
set -euo pipefail
OUT="$(dirname "$0")/graphrc"
mkdir -p "$OUT"

# emit <slug> <bg> <plot> <series> <labeltext> <labelbg> <border>  (R,G,B each)
emit() {
  local slug="$1" bg="$2" plot="$3" series="$4" ltext="$5" lbg="$6" border="$7"
  cat > "$OUT/$slug.graphrc" <<EOF
[Graph]
colorScheme=dark
colorTheme=userDefined
backgroundColor=$bg
plotAreaBackgroundColor=$plot
seriesColors=$series
labelTextColor=$ltext
labelBackgroundColor=$lbg
borderColors=$border
lineWidth=2
gridVisible=true
EOF
  echo "  wrote $OUT/$slug.graphrc"
}

echo "Generating EE 8.x spectrum-graph presets..."
#    slug          bg           plot         series(bars)  labeltext      labelbg     border
emit onkyo-green   "5,5,5"      "10,31,21"   "43,255,143"  "216,237,226"  "9,9,9"     "43,255,143"
emit red-black     "10,10,10"   "26,0,0"     "255,65,65"   "232,232,232"  "26,0,0"    "170,0,0"
emit glass-future  "20,25,40"   "36,41,56"   "100,150,255" "208,225,249"  "36,41,56"  "100,150,255"
emit cyberpunk     "13,2,33"    "26,9,51"    "255,0,255"   "255,255,255"  "26,9,51"   "0,255,255"
emit woodgrain     "31,16,8"    "47,31,18"   "255,170,0"   "244,228,193"  "58,40,23"  "204,136,0"
emit easyamp       "10,10,10"   "12,12,12"   "43,255,43"   "200,210,200"  "26,26,26"  "21,192,21"
echo "Done."
