#!/bin/bash

[ -f /usr/bin/git ] || sudo apt install -y git

# Descarga e instala auto-cpufreq
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer

sudo auto-cpufreq --install

cd ..
