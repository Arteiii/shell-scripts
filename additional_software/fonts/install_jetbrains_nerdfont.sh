#!/bin/bash

FONT_NAME="JetBrainsMono"
NERD_FONT_NAME="${FONT_NAME} Nerd Font"
TMP_DIR="/tmp/nerdfont-install"
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$TMP_DIR"

echo "Downloading ${NERD_FONT_NAME}..."
curl -fLo "$TMP_DIR/${NERD_FONT_NAME}.zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"

mkdir -p "$FONT_DIR"

echo "Installing ${NERD_FONT_NAME}..."
unzip -q "$TMP_DIR/${NERD_FONT_NAME}.zip" -d "$FONT_DIR"

echo "Refreshing font cache..."
fc-cache -fv

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Installation complete! ${NERD_FONT_NAME} is now installed."

