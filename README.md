# cairyviewer
cairyviewer is an image viewer, with minimalism in mind in python, easy to setup and configure. 

Launching from the TerminalBash# Open a specific image (automatically indexes all sibling images in the folder)
cairyviewer /path/to/image.png

# Open from the current directory
cairyviewer .
Controls & ShortcutsActionShortcut / InputNext ImageRight Arrow, Page Down, Space, JPrevious ImageLeft Arrow, Page Up, KZoom In / OutScroll Up / Scroll Down (cursor-centered), + / -Reset Zoom / Fit to Window0, R, Double-ClickPan / Move ViewportLeft Click + Drag (when zoomed in)Outbound Drag-and-DropLeft Click + Drag into external app (browser, GIMP, chat, etc.)Toggle FullscreenF, F11Copy to ClipboardC, Ctrl + CSend to TrashDelete, Shift + DeleteQuitQ, Escape3. Installation & System IntegrationStep 1: Install System DependenciesOn Debian/Ubuntu-based distributions:Bashsudo apt update
sudo apt install -y python3 python3-gi python3-gi-cairo gir1.2-gtk-3.0
On Arch Linux:Bashsudo pacman -S python python-gobject gtk3
On Fedora:Bashsudo dnf install -y python3-gobject gtk3
Step 2: Quick Git Clone & Local Executable SetupTo make cairyviewer globally accessible from your user account without altering root system files:Bash# 1. Clone the repository
git clone https://github.com/juan1coder/cairyviewer.git ~/.local/share/cairyviewer

# 2. Ensure executable permissions
chmod +x ~/.local/share/cairyviewer/cairyviewer

# 3. Create a user-level symlink in ~/.local/bin
mkdir -p ~/.local/bin
ln -sf ~/.local/share/cairyviewer/cairyviewer ~/.local/bin/cairyviewer
(Ensure ~/.local/bin is present in your $PATH in ~/.bashrc or ~/.profile.)
