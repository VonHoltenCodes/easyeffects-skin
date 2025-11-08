#!/bin/bash
# ============================================
# Easy Effects Skins Installer
# VonHoltenCodes
# ============================================

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}"
cat << 'EOF'
 ██╗   ██╗ ██████╗ ███╗   ██╗██╗  ██╗ ██████╗ ██╗  ████████╗███████╗███╗   ██╗
 ██║   ██║██╔═══██╗████╗  ██║██║  ██║██╔═══██╗██║  ╚══██╔══╝██╔════╝████╗  ██║
 ██║   ██║██║   ██║██╔██╗ ██║███████║██║   ██║██║     ██║   █████╗  ██╔██╗ ██║
 ╚██╗ ██╔╝██║   ██║██║╚██╗██║██╔══██║██║   ██║██║     ██║   ██╔══╝  ██║╚██╗██║
  ╚████╔╝ ╚██████╔╝██║ ╚████║██║  ██║╚██████╔╝███████╗██║   ███████╗██║ ╚████║
   ╚═══╝   ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚══════╝╚═╝  ╚═══╝
  ██████╗ ██████╗ ██████╗ ███████╗███████╗
 ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝
 ██║     ██║   ██║██║  ██║█████╗  ███████╗
 ██║     ██║   ██║██║  ██║██╔══╝  ╚════██║
 ╚██████╗╚██████╔╝██████╔╝███████╗███████║
  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝

  Easy Effects Skins - Installer
EOF
echo -e "${NC}\n"

# Check if Easy Effects is installed
echo -e "${CYAN}Checking for Easy Effects...${NC}"
if ! flatpak list | grep -q "com.github.wwmm.easyeffects"; then
    echo -e "${RED}✗ Easy Effects not found!${NC}"
    echo -e "${YELLOW}Please install Easy Effects via Flatpak first:${NC}"
    echo -e "  flatpak install flathub com.github.wwmm.easyeffects"
    exit 1
fi
echo -e "${GREEN}✓ Easy Effects found${NC}\n"

# Create directories
echo -e "${CYAN}Creating directories...${NC}"
SKIN_DIR="$HOME/.var/app/com.github.wwmm.easyeffects/config/gtk-4.0/themes"
mkdir -p "$SKIN_DIR"
mkdir -p "$HOME/bin"
echo -e "${GREEN}✓ Directories created${NC}\n"

# Copy skin files
echo -e "${CYAN}Installing skins...${NC}"
cp skins/*.css "$SKIN_DIR/"
echo -e "${GREEN}✓ Installed 5 skins:${NC}"
echo -e "  • onkyo-green"
echo -e "  • red-black"
echo -e "  • glass-future"
echo -e "  • cyberpunk"
echo -e "  • woodgrain"
echo ""

# Install skin manager
echo -e "${CYAN}Installing skin manager...${NC}"
cp easyeffects-skin "$HOME/bin/"
chmod +x "$HOME/bin/easyeffects-skin"
echo -e "${GREEN}✓ Skin manager installed to ~/bin/easyeffects-skin${NC}\n"

# Check PATH
echo -e "${CYAN}Checking PATH...${NC}"
if ! echo "$PATH" | grep -q "$HOME/bin"; then
    echo -e "${YELLOW}⚠ ~/bin is not in your PATH${NC}"
    echo -e "${CYAN}Adding to ~/.bashrc...${NC}"
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    echo -e "${GREEN}✓ Added to ~/.bashrc${NC}"
    echo -e "${YELLOW}Please run: source ~/.bashrc${NC}"
    echo -e "${YELLOW}Or restart your terminal${NC}\n"
else
    echo -e "${GREEN}✓ ~/bin is in PATH${NC}\n"
fi

# Done!
echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Installation Complete!                   ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}\n"

echo -e "${CYAN}To use:${NC}"
echo -e "  ${YELLOW}easyeffects-skin${NC}              # Interactive menu"
echo -e "  ${YELLOW}easyeffects-skin list${NC}         # List all skins"
echo -e "  ${YELLOW}easyeffects-skin cyberpunk${NC}    # Quick switch"
echo ""
echo -e "${CYAN}Enjoy your skins! 🎨${NC}\n"
