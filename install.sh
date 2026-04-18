#!/usr/bin/env bash
set -e

# Install system dependencies
if command -v dnf &>/dev/null; then
    sudo dnf install -y fzf mpv
elif command -v apt &>/dev/null; then
    sudo apt install -y fzf mpv
elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm fzf mpv
else
    echo "Could not detect package manager. Install fzf and mpv manually."
fi

# Install Python dependencies
pip install -q requests playwright
playwright install chromium

# Install the script
mkdir -p ~/.local/bin
cp mov-cli ~/.local/bin/mov-cli
chmod +x ~/.local/bin/mov-cli

# Make sure ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc 2>/dev/null || true
    echo "Added ~/.local/bin to PATH. Restart your terminal or run: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo "Done! Run: mov-cli <search term>"
