#!/bin/bash

# Comprivar que 7z esté instalado
[ -f /usr/bin/7z ] || sudo apt install -y p7zip-full

wget https://github.com/typst/typst/releases/download/v0.14.2/typst-x86_64-unknown-linux-musl.tar.xz
7z x typst-x86_64-unknown-linux-musl.tar.xz && 7z x typst-x86_64-unknown-linux-musl.tar

# Crear carpeta bin en caso de que no esté
[ -d ~/.local/bin ] || mkdir -p ~/.local/bin

mv typst-x86_64-unknown-linux-musl/typst ~/.local/bin/
