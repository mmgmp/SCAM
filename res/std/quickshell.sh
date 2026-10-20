#!/bin/bash

echo 'deb http://download.opensuse.org/repositories/home:/AvengeMedia:/danklinux/Debian_13/ /' | sudo tee /etc/apt/sources.list.d/home:AvengeMedia:danklinux.list
curl -fsSL https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_13/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_AvengeMedia_danklinux.gpg > /dev/null
sudo apt update
sudo apt install quickshell
