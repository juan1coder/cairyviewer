# Cairy Image Viewer

A minimalist, lightweight image viewer for Linux built in Python 3, powered by GTK 3 (`PyGObject`) and Cairo for smooth, hardware-accelerated rendering.

<img src="cairyimgviewer.png" alt="Cairy Viewer" width="60%">

---

## ✨ Features

- **Distraction-Free Minimalist UI**: Clean, borderless canvas focusing purely on image content.
- **Hardware-Accelerated Cairo Rendering**: Cursor-centered smooth zooming (from 0.1× to 20.0×) and responsive panning.
- **Natural File Sorting**: Seamlessly browse sibling images in natural alphanumeric order.
- **Unique Right-Click App Absorption**: Drag and drop any `.desktop` file onto the window to instantly add custom "Open in..." actions to your right-click context menu.
- **Outbound Drag-and-Drop**: Drag images directly from the viewer into web browsers, messengers, or image editors (`text/uri-list`).
- **Desktop Clipboard Integration**: Instant one-key copying of the image or URI to your clipboard.
- **Safe Trashing**: Direct integration with the FreeDesktop/GIO Trash API (`gio trash`) to safely remove files without accidental permanent deletion.

---

## ⚡ Unique Feature: Dynamic Right-Click "Open With" Menu

`cairyviewer` features a unique, dynamic context menu that can be expanded on the fly without editing configuration files or writing code.

### How it works:
1. **The Defined Folder**:  
   Custom applications are stored in:  
   `~/.config/cairyviewer/apps/`
2. **Adding Apps via Drag-and-Drop**:  
   Open your file manager, navigate to `/usr/share/applications/` (or `~/.local/share/applications/`), and drag your favorite application shortcuts (e.g., `gimp.desktop`, `inkscape.desktop`, `blender.desktop`, `shotwell.desktop`) **directly onto the `cairyviewer` window**.
3. **Instant Absorption**:  
   `cairyviewer` automatically copies the `.desktop` file into `~/.config/cairyviewer/apps/` and immediately rebuilds the right-click menu.
4. **Accessing Your Apps**:  
   Right-click anywhere on the image canvas. Your custom apps will appear under the menu as:
   - `Open in GNU Image Manipulation Program`
   - `Open in Inkscape`
   - *(and any other tools you dropped!)*

---

## 📦 Dependencies & Missing Pip Packages

All standard imports used in `cairyviewer` (`sys`, `os`, `re`, `urllib.parse`, `subprocess`, `shutil`) are part of the **Python Standard Library**—no `pip` installation is required for them!

The only external dependency is **`gi` (PyGObject / GTK 3)**.  
> **Recommendation:** Install PyGObject via your Linux distribution's package manager rather than `pip`. System packages are pre-compiled with Cairo and GTK C libraries.

### Debian / Ubuntu / Linux Mint
```bash
sudo apt update
sudo apt install -y python3 python3-gi python3-gi-cairo gir1.2-gtk-3.0
```

### Arch Linux / Manjaro
```bash
sudo pacman -S python python-gobject gtk3
```

### Fedora
```bash
sudo dnf install -y python3-gobject gtk3
```

*(If using a Python virtual environment, you can install via pip: `pip install PyGObject`, but ensure system development headers like `libgirepository1.0-dev` and `libcairo2-dev` are present).*

---

## 🚀 Easy Installation (`install.sh`)

An automated installation script is included. It checks dependencies, sets up executable symlinks, creates the `~/.config/cairyviewer/apps` folder, installs the desktop launcher, and updates desktop caches.

```bash
# 1. Clone the repository
git clone https://github.com/juan1coder/cairyviewer.git
cd cairyviewer

# 2. Run the installer
chmod +x install.sh
./install.sh
```

### Uninstallation
To cleanly remove `cairyviewer` and its desktop shortcuts:
```bash
./install.sh --uninstall
# or run:
./uninstall.sh
```

---

## 🛠️ Manual Installation (Without Script)

If you prefer manual setup:

```bash
# 1. Make executable
chmod +x cairyviewer

# 2. Link to user binary path
mkdir -p ~/.local/bin
ln -sf "$(pwd)/cairyviewer" ~/.local/bin/cairyviewer

# 3. Create the defined custom apps folder
mkdir -p ~/.config/cairyviewer/apps

# 4. Install icon & desktop entry
mkdir -p ~/.local/share/icons ~/.local/share/applications
cp cairyimgviewer.png ~/.local/share/icons/cairyviewer.png
cp cairyviewer.desktop ~/.local/share/applications/cairyviewer.desktop

# 5. Update desktop database
update-desktop-database ~/.local/share/applications
```

---

## 🎮 Usage & Controls

### Command Line
```bash
# Open a specific image (sibling images in the directory are automatically indexed)
cairyviewer /path/to/image.png

# Open all images in the current working directory
cairyviewer .
```

### Controls & Shortcuts

| Action | Shortcut / Input |
| :--- | :--- |
| **Next Image** | <kbd>→</kbd>, <kbd>Page Down</kbd>, <kbd>Space</kbd>, <kbd>J</kbd> |
| **Previous Image** | <kbd>←</kbd>, <kbd>Page Up</kbd>, <kbd>K</kbd> |
| **Zoom In / Out** | `Mouse Wheel Up` / `Down` (cursor-centered), <kbd>+</kbd> / <kbd>-</kbd> |
| **Reset Zoom / Fit to Window** | <kbd>0</kbd>, <kbd>R</kbd>, `Double-Click` |
| **Pan / Move Viewport** | `Left-Click + Drag` (when zoomed in) |
| **Open Context Menu** | `Right-Click` (File location, wallpaper, custom apps) |
| **Absorb App Shortcut** | `Drag & Drop .desktop file` onto window |
| **Outbound Drag-and-Drop** | `Left-Click + Drag` into external app (browser, GIMP, chat) |
| **Toggle Fullscreen** | <kbd>F</kbd>, <kbd>F11</kbd> |
| **Copy Image to Clipboard** | <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>C</kbd> |
| **Send to System Trash** | <kbd>Delete</kbd>, <kbd>Shift</kbd> + <kbd>Delete</kbd> |
| **Quit** | <kbd>Q</kbd>, <kbd>Esc</kbd> |

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
