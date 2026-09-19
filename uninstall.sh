#!/usr/bin/env bash
# ==============================================================================
# Cairy Viewer Uninstaller
# ==============================================================================

set -e

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${YELLOW}Uninstalling Cairy Viewer...${RESET}"

rm -f "$HOME/.local/bin/cairyviewer"
rm -f "$HOME/.local/share/applications/cairyviewer.desktop"
rm -f "$HOME/.local/share/icons/cairyviewer.png"

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
fi

echo -e "${GREEN}✓ Cairy Viewer desktop entry, icon, and binary symlink removed.${RESET}"
echo -e "Your custom actions in ~/.config/cairyviewer/ have been preserved."
echo -e "If you want to remove config and custom apps too, run: rm -rf ~/.config/cairyviewer"
