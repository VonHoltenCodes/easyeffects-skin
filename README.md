# Easy Effects Skins

**WinAmp-style skins for Easy Effects on Linux!**

Custom themes for Easy Effects inspired by classic audio equipment and modern design aesthetics — just like WinAmp skins, but for your Linux audio processing.

![VonHoltenCodes](https://img.shields.io/badge/VonHoltenCodes-Custom%20Skins-blueviolet)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-blue)

## ⚠️ Which EasyEffects do you have? (this matters)

EasyEffects **8.0 was rewritten from GTK4 to Qt6/QML (Kirigami)** and the two lines
need completely different skins. Check with `flatpak info com.github.wwmm.easyeffects`.

| Your EasyEffects | Skin type | Where |
|---|---|---|
| **8.0+** (Qt/QML) — current Flathub | KDE color schemes (`.colors`) | **this `main` branch → [`qml-skins/`](qml-skins/)** |
| **7.x** (GTK4) — older | GTK CSS skins | **[`legacy-7.x-gtk4`](../../tree/legacy-7.x-gtk4) branch** |

**8.x is the going-forward standard.** The 7.x GTK CSS skins are frozen on the
`legacy-7.x-gtk4` branch and still work great for anyone still on 7.x — they just
can't apply to 8.x (no GTK CSS surface anymore).

---

## 🎨 EasyEffects 8.x skins (current standard — BETA)

8.x is themed with **KDE color schemes**, not CSS. Six schemes mirror the color
identity of the classic skins (Onkyo Green, Red Black, Glass Future, Cyberpunk,
Woodgrain, EasyAmp). They are **palette-only** — flat recolors, no textures/bevels
(Qt/Kirigami can't do those, and EE ignores Kvantum). See [`qml-skins/README.md`](qml-skins/README.md)
for the full research + limitations.

```bash
# install the color schemes
cp qml-skins/color-schemes/*.colors ~/.local/share/color-schemes/
# then: EasyEffects → Preferences → "custom color theme" → pick one
```

Regenerate from source colors with `qml-skins/generate-colors.sh`. The spectrum
graph has its own color controls (Preferences → spectrum → "User" theme).

> Status: schemes install where EE 8.2.4 reads them; **in-app visual polish is
> still being tuned**. Feedback/PRs welcome.

---

## 🕹️ EasyEffects 7.x skins (legacy GTK4 line)

The original WinAmp-style GTK CSS skins — beveled chrome, woodgrain texture, glass
blur, neon glow — live on the **[`legacy-7.x-gtk4`](../../tree/legacy-7.x-gtk4)**
branch with their interactive `easyeffects-skin` manager. The same skin files are
also kept in this branch's `skins/` for reference, but **7.x users should use the
legacy branch** (it has the matching installer/manager and screenshots).

The rest of this README documents that 7.x GTK CSS workflow.

## 🎮 Interactive Skin Manager (7.x)

Easy-to-use interactive menu for switching skins on the fly:

![Script Menu](screenshots/script-menu.png)

## 🎨 Available Skins

### 1. Onkyo Green
**1980s Hi-Fi Receiver Aesthetic**
- Brushed black aluminum chassis
- White screenprinted labels
- Green LED indicators and borders
- Lime green spectrum analyzer
- Inspired by classic Onkyo receivers

![Onkyo Green](screenshots/onkyo-green.png)

### 2. Red Black
**Racing-Inspired Aggressive Style**
- Carbon fiber texture
- Red LED indicators
- Deep black background
- Orange-to-red VU meters
- Performance-focused design

![Red Black](screenshots/red-black.png)

### 3. Glass Future
**Modern Minimalist Design**
- Frosted glass effects
- Blue accent colors
- Transparency and blur
- Clean, professional look
- Perfect for modern desktops

![Glass Future](screenshots/glass-future.png)

### 4. Cyberpunk
**Neon Synthwave Outrun**
- Hot pink and cyan neon colors
- Purple accent lighting
- Grid-pattern background
- Intense glow effects
- Pure 1980s cyberpunk aesthetic

![Cyberpunk](screenshots/cyberpunk.png)

### 5. Woodgrain
**Vintage 1970s Hi-Fi**
- Wood panel texture
- Warm amber LED displays
- Gold accents
- Classic wood grain pattern
- Retro warmth and nostalgia

![Woodgrain](screenshots/woodgrain.png)

### 6. EasyAmp
**Classic media-player tribute**
- Beveled gunmetal chrome
- Green 7-segment LCD readouts
- EQ-style sliders (green→amber→red) with a beveled grip
- Green spectrum bars on black
- A loving nod to late-90s players — original art, no trademarked assets

> Looks best with two optional OFL fonts installed to `~/.local/share/fonts`:
> **DSEG7 Classic** (7-segment LCD) and **Pixelify Sans** (pixel chrome).
> Without them it falls back to monospace/sans cleanly.

## 📋 Requirements

- **Easy Effects 7.x** (installed via Flatpak) — **not** 8.0+, which uses Qt/QML and ignores GTK CSS
- **Linux** (tested on Pop!_OS 22.04, should work on most distros)
- **GTK4** support
- **Bash** shell

## 🚀 Installation

### Quick Install

```bash
# Clone the repository
git clone https://github.com/VonHoltenCodes/easyeffects-skins.git
cd easyeffects-skins

# Run the installer
chmod +x install.sh
./install.sh
```

### Manual Installation

1. **Create the skins directory:**
   ```bash
   mkdir -p ~/.var/app/com.github.wwmm.easyeffects/config/gtk-4.0/themes
   ```

2. **Copy skin files:**
   ```bash
   cp skins/*.css ~/.var/app/com.github.wwmm.easyeffects/config/gtk-4.0/themes/
   ```

3. **Install the skin manager:**
   ```bash
   mkdir -p ~/bin
   cp easyeffects-skin ~/bin/
   chmod +x ~/bin/easyeffects-skin
   ```

4. **Add ~/bin to your PATH (if not already):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

## 🎮 Usage

### Interactive Menu (Recommended)

Simply run:
```bash
easyeffects-skin
```

This will launch an interactive menu where you can select your desired skin.

### Command Line

**List all available skins:**
```bash
easyeffects-skin list
```

**Show currently active skin:**
```bash
easyeffects-skin current
```

**Apply a specific skin:**
```bash
easyeffects-skin apply cyberpunk
```

**Quick switches (direct skin names):**
```bash
easyeffects-skin onkyo-green
easyeffects-skin red-black
easyeffects-skin glass-future
easyeffects-skin cyberpunk
easyeffects-skin woodgrain
```

## 🛠️ How It Works

The skin manager:
1. **Applies CSS** - Copies the selected skin's CSS to Easy Effects' active configuration
2. **Sets spectrum colors** - Configures spectrum analyzer colors via gsettings
3. **Restarts Easy Effects** - Gracefully stops and restarts Easy Effects to apply changes

Each skin includes:
- Custom GTK4 CSS styling
- Spectrum analyzer color configuration
- Axis label color configuration
- Complete theme consistency

## 🎨 Creating Your Own Skins

Want to create your own skin? It's easy!

1. **Copy an existing skin as a template:**
   ```bash
   cp skins/onkyo-green.css skins/my-custom-skin.css
   ```

2. **Edit the CSS** - Modify colors, backgrounds, borders, shadows, etc.

3. **Add spectrum colors to the script** - Edit `easyeffects-skin` and add your skin's colors to the `SPECTRUM_COLORS` and `AXIS_COLORS` arrays

4. **Test it:**
   ```bash
   cp skins/my-custom-skin.css ~/.var/app/com.github.wwmm.easyeffects/config/gtk-4.0/themes/
   easyeffects-skin apply my-custom-skin
   ```

## 🤝 Contributing

Contributions are welcome! If you create a cool skin, please share it:

1. Fork the repository
2. Add your skin CSS file to the `skins/` directory
3. Add a screenshot to `screenshots/`
4. Update this README with your skin description
5. Submit a pull request

## 📸 Screenshots

All screenshots are taken with the same Easy Effects preset to show the pure visual differences between skins. Screenshots should be named:
- `onkyo-green.png`
- `red-black.png`
- `glass-future.png`
- `cyberpunk.png`
- `woodgrain.png`

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details

This project is completely open source and free to use, modify, and distribute.

## 🙏 Credits

**Created by:** [VonHoltenCodes](https://github.com/VonHoltenCodes)

**Inspired by:**
- WinAmp skins (the original customizable audio player)
- Classic 1970s-1980s Hi-Fi equipment
- Modern UI/UX design trends
- Retro computing aesthetics

## 💬 Support

If you encounter issues or have suggestions:
- Open an issue on GitHub
- Check existing issues for solutions
- Contribute fixes via pull requests

## 🌟 Show Your Support

If you like this project:
- ⭐ Star the repository
- 🍴 Fork it and create your own skins
- 📢 Share it with the Linux audio community
- 💡 Submit your custom skins

## 📝 Changelog

### v1.0.0 (2025-11-08)
- Initial release
- 5 custom skins included
- Interactive skin manager
- Automatic Easy Effects restart
- Full spectrum analyzer integration

---

**Made with ❤️ for the Linux audio community**
