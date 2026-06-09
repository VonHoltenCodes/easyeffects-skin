# EasyEffects 8.x (Qt/QML) skins — WORK IN PROGRESS

EasyEffects 8.0 dropped the GTK4 frontend and was rewritten in **Qt6 / QML
(Kirigami)**. The GTK CSS skins on the `main` branch do **not** apply to 8.x —
there is no GTK CSS surface to attach to anymore.

This branch tracks a parallel skin set built for the QML UI.

## Status

- [ ] Confirm EE 8.x theming hook (QML theme files vs Kirigami color sets / env)
- [ ] Identify which QML objects / Kirigami.Theme roles are restyleable
- [ ] Port each `main` skin concept (onkyo-green, red-black, glass-future,
      cyberpunk, woodgrain, easyamp) to the QML model — a re-build, not a port
- [ ] New skin-manager path for 8.x (the GTK gsettings spectrum-color trick
      likely changes too)

## Why a separate branch

GTK CSS (cascade, widget selectors, `~/.config/gtk-4.0/gtk.css`, flatpak GTK
theme overrides) and QML styling (Kirigami color sets, QML theme objects) are
fundamentally different models. Keeping 7.x and 8.x apart avoids one README/
installer trying to serve two incompatible engines.
