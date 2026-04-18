#!/usr/bin/env bash
set -e

echo "=== mov-cli installer ==="
echo ""

# Check for Python
if ! command -v python3 &>/dev/null; then
    echo "ERROR: Python 3 is not installed."
    echo "Install it from https://www.python.org/downloads/ then re-run this script."
    exit 1
fi

# Check for pip
if ! command -v pip &>/dev/null && ! command -v pip3 &>/dev/null; then
    echo "ERROR: pip is not installed."
    echo "Run: python3 -m ensurepip --upgrade"
    exit 1
fi

PIP=$(command -v pip3 || command -v pip)

# Install system packages
echo "Installing fzf and mpv..."
if command -v dnf &>/dev/null; then
    sudo dnf install -y fzf mpv
elif command -v apt &>/dev/null; then
    sudo apt install -y fzf mpv
elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm fzf mpv
elif command -v brew &>/dev/null; then
    brew install fzf mpv
else
    echo "WARNING: Could not detect package manager."
    echo "Please install 'fzf' and 'mpv' manually, then re-run this script."
    exit 1
fi

# Install Python packages
echo "Installing Python dependencies..."
$PIP install -q requests playwright
playwright install chromium

# Install the script
echo "Installing mov-cli..."
mkdir -p ~/.local/bin
cp mov-cli ~/.local/bin/mov-cli
chmod +x ~/.local/bin/mov-cli

# Ensure ~/.local/bin is in PATH
PROFILE_UPDATED=0
for f in ~/.bashrc ~/.zshrc ~/.profile; do
    if [ -f "$f" ] && ! grep -q '.local/bin' "$f"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$f"
        PROFILE_UPDATED=1
    fi
done

echo ""
echo "=== Done! ==="
echo ""
if [ $PROFILE_UPDATED -eq 1 ]; then
    echo "Close and reopen your terminal, then run:"
else
    echo "Run:"
fi
echo ""
echo "    mov-cli <movie or show name>"
echo ""
echo "Example: mov-cli inception"
