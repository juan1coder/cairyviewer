#!/usr/bin/env bash
# ==============================================================================
# Cairy Viewer Installer
# Minimalist GTK3 & Cairo Image Viewer
# ==============================================================================

set -e

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

echo -e "${BLUE}====================================================${RESET}"
echo -e "${BLUE}        Installing Cairy Image Viewer               ${RESET}"
echo -e "${BLUE}====================================================${RESET}"

# Handle --uninstall flag
if [ "$1" == "--uninstall" ] || [ "$1" == "-u" ]; then
    echo -e "${YELLOW}Uninstalling Cairy Viewer...${RESET}"
    rm -f "$HOME/.local/bin/cairyviewer"
    rm -f "$HOME/.local/share/applications/cairyviewer.desktop"
    rm -f "$HOME/.local/share/icons/cairyviewer.png"
    if command -v update-desktop-database &> /dev/null; then
        update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
    fi
    echo -e "${GREEN}✓ Cairy Viewer successfully removed.${RESET}"
    echo -e "Note: Your custom actions in ~/.config/cairyviewer were preserved."
    exit 0
fi

# 1. Check Python 3 and GTK3 / PyGObject dependencies
echo -e "\n${YELLOW}[1/4] Checking Python & system dependencies...${RESET}"

if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: python3 is not installed.${RESET}"
    echo "Please install Python 3 via your package manager."
    exit 1
fi

python3 -c "
import sys
missing = []
for mod in ['sys', 'os', 're', 'urllib.parse', 'subprocess', 'shutil']:
    try:
        __import__(mod)
    except ImportError:
        missing.append(mod)

try:
    import gi
    gi.require_version('Gtk', '3.0')
    gi.require_version('Gio', '2.0')
    from gi.repository import Gtk, Gdk, GdkPixbuf, Gio
except (ImportError, ValueError) as e:
    missing.append('PyGObject / GTK 3 (gi)')

if missing:
    print(f'MISSING: {\", \".join(missing)}')
    sys.exit(1)
else:
    print('All required Python and GTK 3 libraries are detected.')
" || {
    echo -e "${RED}Warning: Missing required GTK3 / PyGObject libraries!${RESET}"
    echo -e "Install them with your package manager (no pip needed):"
    echo -e "  Debian/Ubuntu:  ${GREEN}sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0${RESET}"
    echo -e "  Arch Linux:     ${GREEN}sudo pacman -S python python-gobject gtk3${RESET}"
    echo -e "  Fedora:         ${GREEN}sudo dnf install python3-gobject gtk3${RESET}"
    read -rp "Proceed with installation anyway? [y/N] " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        exit 1
    fi
}

# 2. Create required system and user configuration directories
echo -e "\n${YELLOW}[2/4] Creating directories...${RESET}"
INSTALL_BIN="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
APPS_DIR="$HOME/.config/cairyviewer/apps"

mkdir -p "$INSTALL_BIN"
mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_DIR"
mkdir -p "$APPS_DIR"
echo -e "✓ Defined apps folder ready: ${GREEN}$APPS_DIR${RESET}"

# 3. Locate and install cairyviewer executable & icon
echo -e "\n${YELLOW}[3/4] Installing executable and assets...${RESET}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check where the executable is located (current dir, parent dir, or package)
if [ -f "$SCRIPT_DIR/cairyviewer" ]; then
    SRC_EXEC="$SCRIPT_DIR/cairyviewer"
elif [ -f "$SCRIPT_DIR/../cairyviewer" ]; then
    SRC_EXEC="$SCRIPT_DIR/../cairyviewer"
elif [ -f "$HOME/.local/share/cairyviewer/cairyviewer" ]; then
    SRC_EXEC="$HOME/.local/share/cairyviewer/cairyviewer"
else
    SRC_EXEC=""
fi

if [ -n "$SRC_EXEC" ]; then
    chmod +x "$SRC_EXEC"
    ln -sf "$SRC_EXEC" "$INSTALL_BIN/cairyviewer"
    echo -e "✓ Linked executable to ${GREEN}$INSTALL_BIN/cairyviewer${RESET}"
else
    echo -e "${YELLOW}Notice: 'cairyviewer' script not found in current folder.${RESET}"
    echo -e "Symlink will expect 'cairyviewer' to be placed at ${GREEN}$INSTALL_BIN/cairyviewer${RESET}"
fi

# Icon installation
if [ -f "$SCRIPT_DIR/cairyimgviewer.png" ]; then
    cp "$SCRIPT_DIR/cairyimgviewer.png" "$ICON_DIR/cairyviewer.png"
    echo -e "✓ Installed icon to ${GREEN}$ICON_DIR/cairyviewer.png${RESET}"
elif [ -f "$SCRIPT_DIR/../cairyimgviewer.png" ]; then
    cp "$SCRIPT_DIR/../cairyimgviewer.png" "$ICON_DIR/cairyviewer.png"
    echo -e "✓ Installed icon to ${GREEN}$ICON_DIR/cairyviewer.png${RESET}"
fi

# Desktop entry installation
cat << 'DESK' > "$DESKTOP_DIR/cairyviewer.desktop"
[Desktop Entry]
Name=Cairy Viewer
GenericName=Image Viewer
Comment=Minimalist Cairo & GTK Image Viewer
Exec=cairyviewer %F
Terminal=false
Type=Application
Icon=cairyviewer
Categories=Graphics;Viewer;2DGraphics;
MimeType=image/bmp;image/gif;image/jpeg;image/jpg;image/png;image/tiff;image/webp;image/x-portable-pixmap;image/svg+xml;
StartupNotify=true
DESK
echo -e "✓ Created desktop entry in ${GREEN}$DESKTOP_DIR/cairyviewer.desktop${RESET}"

# 4. Update desktop MIME and application database
echo -e "\n${YELLOW}[4/4] Refreshing desktop databases...${RESET}"
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
    echo -e "✓ Desktop database updated."
fi

# Check PATH
echo -e "\n${GREEN}====================================================${RESET}"
echo -e "${GREEN}       Installation Completed Successfully!         ${RESET}"
echo -e "${GREEN}====================================================${RESET}"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}Notice: $HOME/.local/bin is not in your current PATH.${RESET}"
    echo -e "Add it to your environment by running:"
    echo -e "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
    echo -e "  source ~/.bashrc"
fi

echo -e "\n${BLUE}Usage:${RESET}"
echo -e "  cairyviewer /path/to/image.png"
echo -e "  cairyviewer ."
echo -e "\n${BLUE}Custom Right-Click Apps Folder:${RESET}"
echo -e "  Drop .desktop files into: ${GREEN}$APPS_DIR${RESET}"
echo -e "  or drag .desktop files from /usr/share/applications straight into the viewer window!"
