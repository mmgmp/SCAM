#!/bin/bash

# Fuente FiraMono Nerd Font
FONT_VERSION="v3.2.1"
FONT_DIR="$HOME/.local/share/fonts/FiraMonoNerd"

if ! fc-list : family | grep -qi "FiraMono Nerd"; then
    tmp=$(mktemp -d)
    wget -q -P "$tmp" "https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION/FiraMono.zip" || exit 1
    mkdir -p "$FONT_DIR"
	7z x "$tmp/FiraMono.zip" -o"$FONT_DIR" '*.otf' -y >/dev/null || exit 1
    rm -rf "$tmp"
    fc-cache -f "$FONT_DIR"
fi
