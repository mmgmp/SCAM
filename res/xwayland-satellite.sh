#!/bin/bash

# Comprobar si las herramientas están instaladas
[ -f /usr/bin/7z ] || sudo nala install -y p7zip-full
[ -f /usr/bin/cargo ] || sudo nala install -y cargo

# Instalar dependencias
sudo nala install -y xwayland clang libxcb-cursor-dev libxcb1-dev

# Descargar xwayland-satellite
wget https://github.com/Supreeeme/xwayland-satellite/archive/refs/tags/v0.8.zip

# Compilar xwayland-satellite
7z x v0.8.zip && cd xwayland-satellite-0.8
cargo build --release -F systemd

# Mover los archivos
sudo cp target/release/xwayland-satellite /usr/bin/
sudo cp resources/xwayland-satellite.service /etc/systemd/user/

cd ..
