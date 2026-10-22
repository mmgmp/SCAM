#!/bin/bash

# Añadir repasitorio
echo 'deb http://download.opensuse.org/repositories/home:/AvengeMedia:/danklinux/Debian_13/ /' | sudo tee /etc/apt/sources.list.d/home:AvengeMedia:danklinux.list
curl -fsSL https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_13/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_AvengeMedia_danklinux.gpg > /dev/null

# Instalar QuickShell
sudo apt update
sudo apt install quickshell

# Dependencias para algunos módulos
sudo apt install qml6-module-qtquick-controls qml6-module-qtquick-layouts qml6-module-qtquick-templates
