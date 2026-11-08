#!/bin/bash

# Comprobar si las herramientas están instaladas
[ -f /usr/bin/7z ] || sudo apt install -y p7zip-full
[ -f /usr/bin/cargo ] || sudo apt install -y cargo

# Instalar las dependencias
sudo apt install -y gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev

# Descargar niri v25.11
wget https://github.com/YaLTeR/niri/archive/refs/tags/v25.11.zip

# Compilar niri
7z x v25.11.zip && cd niri-25.11
cargo build --release

# Crear carpetas
[ -d /usr/share/wayland-sessions/ ] || sudo mkdir /usr/share/wayland-sessions/
[ -d /usr/share/xdg-desktop-portal/ ] || sudo mkdir /usr/share/xdg-desktop-portal/

# Usar GTK3 como selector de archivos
echo "org.freedesktop.impl.portal.FileChooser=gtk;" >> resources/niri-portals.conf

# Mover los archivos
sudo cp target/release/niri /usr/bin/
sudo cp resources/niri-session /usr/bin/
sudo cp resources/niri.desktop /usr/share/wayland-sessions/
sudo cp resources/niri-portals.conf /usr/share/xdg-desktop-portal/
sudo cp resources/niri.service /etc/systemd/user/
sudo cp resources/niri-shutdown.target /etc/systemd/user/

# Portales
sudo apt install --no-install-recommends -y xdg-desktop-portal-gnome

cd ..
