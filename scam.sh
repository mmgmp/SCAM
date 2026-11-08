#!/bin/bash

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

#===== INSTALACIÓN =====#

# Paquetes de los repositorios oficiales
source ./res/pkgs.conf
sudo apt install -y "${ENVIROMENT[@]}" "${SOUND[@]}" "${MULTIMEDIA[@]}" "${THEME[@]}" "${EXTRA[@]}" || exit 1

# Descargar e instalar Niri
bash ./res/niri.sh && bash ./res/xwayland-satellite.sh || exit 1

# Instalar quickshell
bash ./res/quickshell.sh || exit 1

# Navegador web
curl -fsS https://dl.brave.com/install.sh | sh

# Flatpak
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Crear carpetas para fuentes
[ -d ~/.local/share/fonts ] || mkdir -p ~/.local/share/fonts

# Descargar FiraMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
7z x FiraMono.zip -oFiraMono
cp FiraMono/Fira*.otf ~/.local/share/fonts

# Actualizar cache de fuentes
fc-cache -f

# Instalar Ly (display manager)
bash ./res/ly.sh

# Instalar Newsraft (rss)
bash ./res/newsraft.sh

# Descargar yt-dlp de github
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
chmod +x yt-dlp
sudo mv -f yt-dlp /usr/bin/yt-dlp

# Instalar Starship prompt
curl -sS https://starship.rs/install.sh | sh
sudo mv /usr/local/bin/starship /usr/bin/
mkdir -p ~/.config && starship preset plain-text-symbols -o ~/.config/starship.toml

# Función para paquetes opcionales
ask() {
	local prompt=$1 script=$2
    while true; do
		read -rp "¿Quieres instalar $prompt? (s/n): " a
        case $a in
			[Ss]) bash "$script"; return ;;
            [Nn]) echo "No se instalará $prompt."; return ;;
            *) echo "Introduce s o n." ;;
        esac
    done
}

# Paquetes opcionales
ask auto-cpufreq ./res/auto-cpufreq.sh
ask Typst ./res/typst.sh

#===== CONFIGURACIÓN =====#

# Configuración de GTK3
bash ./cfg/gtk3.sh

# Aplicaciones GTk4 oscuras
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

# Configurar GRUB
bash ./cfg/grub.sh

# Desactivar archivo .sudo_as_admin_successful
echo 'Defaults !admin_flag' | sudo tee /etc/sudoers.d/no_admin_flag
rm -f ~/.sudo_as_admin_successful

# Montar USB en /media con udisks2
[ -d /etc/udev/rules.d/ ] || sudo mkdir -p /etc/udev/rules.d/
echo 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' | sudo tee /etc/udev/rules.d/99-udisks2.rules

# Crear carpetas del usuario
xdg-user-dirs-update

# Instalar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp -r dotfiles/{.bashrc,.profile,.config,.local} ~/

# Instalar mis scripts
git clone https://github.com/mmgmp/scripts
cp -r scripts/{menus/*,notifications/*,user-tools/*} ~/

# Historial de bash en XDG
mkdir -p ~/.local/state/bash && mv ~/.bash_history ~/.local/state/bash/history

# Configuracion de git en XDG
mkdir -p ~/.config/git && mv ~/.gitconfig ~/.config/git/config 

echo -e "\nCompletado, puedes reiniciar el ordenador con el comando 'systemctl reboot'\n"
