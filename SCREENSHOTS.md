# Screenshots Guide

This guide explains how to take consistent screenshots for each skin.

## Requirements

- Easy Effects installed and running
- All skins installed
- Audio playing (for spectrum visualization)
- Screenshot tool (GNOME Screenshot, Flameshot, etc.)

## Screenshot Standards

To maintain consistency across all skin screenshots:

### 1. Window Setup
- Open Easy Effects
- Select the **Equalizer** effect (or any effect that shows all UI elements)
- Make sure the spectrum analyzer is visible at the top
- Include VU meters at the bottom

### 2. Naming Convention
Screenshots should be named exactly as:
- `onkyo-green.png`
- `red-black.png`
- `glass-future.png`
- `cyberpunk.png`
- `woodgrain.png`

### 3. Taking Screenshots

For each skin:

1. **Apply the skin:**
   ```bash
   easyeffects-skin onkyo-green
   ```

2. **Wait for Easy Effects to restart**

3. **Open Easy Effects GUI:**
   ```bash
   flatpak run com.github.wwmm.easyeffects
   ```

4. **Play some audio** (so spectrum analyzer shows activity)

5. **Take screenshot:**
   - Full window capture recommended
   - Include window decorations
   - Make sure spectrum analyzer is active (showing bars)
   - VU meters should be visible and active

6. **Save to screenshots directory** with the correct filename

### 4. Recommended Settings

For best screenshots:
- **Resolution:** Native window size (don't resize)
- **Format:** PNG
- **Audio:** Play music with good bass and highs (to show full spectrum)
- **Effects:** Enable at least one effect to show active UI

## Example Workflow

```bash
cd ~/easyeffects-skins

# Take screenshot for each skin
for skin in onkyo-green red-black glass-future cyberpunk woodgrain; do
    echo "Switching to $skin..."
    easyeffects-skin $skin
    sleep 3

    # Open GUI (manually take screenshot here)
    flatpak run com.github.wwmm.easyeffects &

    echo "Take screenshot and save as screenshots/$skin.png"
    read -p "Press Enter when done..."

    # Close GUI
    pkill -f easyeffects
done
```

## Tips

- Use the same audio track for all screenshots
- Keep the same window position
- Same effects enabled for consistency
- Take screenshots at the same time of day (lighting consistency)
- Make sure all UI text is readable

## File Locations

Screenshots should be placed in:
```
easyeffects-skins/
  screenshots/
    onkyo-green.png
    red-black.png
    glass-future.png
    cyberpunk.png
    woodgrain.png
```
