#!/bin/bash

# Comprovar que git está instalado
[ -f /usr/bin/git ] || sudo apt install -y git

# Instalar dependencias
sudo apt install build-essential libcurl4-openssl-dev libexpat-dev libgumbo-dev libsqlite3-dev

# Descargar e instalar newsraft
git clone https://codeberg.org/newsraft/newsraft.git
cd newsraft && make
sudo make install

cd ..
