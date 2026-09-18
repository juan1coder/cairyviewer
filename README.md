# Cairy Image Viewer

A minimalist, lightweight image viewer for Linux built in Python 3, powered by GTK 3 (`PyGObject`) and Cairo for smooth, hardware-accelerated rendering.
<img src="cairyimgviewer.png" alt="Cairy Viewer" width="60%">
![Cairy Viewer](cairyimgviewer.png)

---

## ✨ Features

- **Distraction-Free Interface**: Borderless, chrome-free canvas focusing entirely on your images.
- **Hardware-Accelerated Canvas**: Smooth panning and cursor-centered zooming from 0.1× to 20.0× using Cairo.
- **Seamless Directory Browsing**: Natural alphanumeric sorting of sibling images in the same folder.
- **Outbound Drag-and-Drop**: Drag images directly from the viewer into web browsers, messengers, or image editors (`text/uri-list`).
- **System Clipboard Support**: Instant one-key copy of the image directly to your desktop clipboard.
- **Safe Trashing**: Integrated with FreeDesktop/GIO Trash API (`gio trash`) to safely remove files without permanent deletion.

---

## 🏗️ Architecture

- **`ImageCanvas (Gtk.DrawingArea)`**: Custom rendering surface managing aspect-ratio-preserving scaling, cursor-relative zoom transformations, pan offsets, and drag-and-drop source negotiation.
- **`ImageViewer (Gtk.Window)`**: Top-level application window managing directory scanning, keyboard and pointer event dispatching, window state (fullscreen/windowed), clipboard transfers, and file management operations.

---

## 📦 Requirements & Dependencies

`cairyviewer` requires Python 3 and GTK 3 bindings (`PyGObject`). Install the required dependencies using your distribution's package manager:

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

---

## 🚀 Installation

### 1. Clone & Set Up Local Executable

Clone the repository and link the executable to your user binary path (`~/.local/bin`):

```bash
# Clone repository to local user share
git clone https://github.com/juan1coder/cairyviewer.git ~/.local/share/cairyviewer

# Grant execute permissions
chmod +x ~/.local/share/cairyviewer/cairyviewer

# Create a symlink in ~/.local/bin
mkdir -p ~/.local/bin
ln -sf ~/.local/share/cairyviewer/cairyviewer ~/.local/bin/cairyviewer
```

> **Note:** Ensure `~/.local/bin` is in your `$PATH`. If not, add `export PATH="$HOME/.local/bin:$PATH"` to your `~/.bashrc` or `~/.profile`.

---

## 🖥️ Desktop & File Manager Integration

To make `cairyviewer` available in your desktop application menus and "Open With..." options across file managers (Thunar, PCManFM, Nautilus, Nemo):

### 1. Install Application Icon
```bash
mkdir -p ~/.local/share/icons
cp ~/.local/share/cairyviewer/cairyimgviewer.png ~/.local/share/icons/cairyviewer.png
```

### 2. Create Desktop Entry
Create `~/.local/share/applications/cairyviewer.desktop`:

```desktop
[Desktop Entry]
Name=Cairy Viewer
Comment=Minimalist Cairo & GTK Image Viewer
Exec=cairyviewer %F
Terminal=false
Type=Application
Icon=cairyviewer
Categories=Graphics;Viewer;2DGraphics;
MimeType=image/bmp;image/gif;image/jpeg;image/jpg;image/png;image/tiff;image/webp;image/x-portable-pixmap;image/svg+xml;
StartupNotify=true
```

### 3. Update Desktop Database
```bash
update-desktop-database ~/.local/share/applications
```

---

## 🎮 Usage & Controls

### Command Line
```bash
# Open a specific image file (sibling images are automatically indexed)
cairyviewer /path/to/image.png

# Open all images in the current working directory
cairyviewer .
```

### Keyboard & Mouse Shortcuts

| Action | Shortcut / Input |
| :--- | :--- |
| **Next Image** | <kbd>→</kbd>, <kbd>Page Down</kbd>, <kbd>Space</kbd>, <kbd>J</kbd> |
| **Previous Image** | <kbd>←</kbd>, <kbd>Page Up</kbd>, <kbd>K</kbd> |
| **Zoom In / Out** | `Mouse Wheel Up` / `Down` (cursor-centered), <kbd>+</kbd> / <kbd>-</kbd> |
| **Reset Zoom / Fit to Window** | <kbd>0</kbd>, <kbd>R</kbd>, `Double-Click` |
| **Pan / Move Viewport** | `Left-Click + Drag` (when zoomed in) |
| **Outbound Drag-and-Drop** | `Left-Click + Drag` into external app (browser, GIMP, chat, etc.) |
| **Toggle Fullscreen** | <kbd>F</kbd>, <kbd>F11</kbd> |
| **Copy Image to Clipboard** | <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>C</kbd> |
| **Send to System Trash** | <kbd>Delete</kbd>, <kbd>Shift</kbd> + <kbd>Delete</kbd> |
| **Quit** | <kbd>Q</kbd>, <kbd>Esc</kbd> |

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
