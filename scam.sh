#!/bin/bash

# Instalar nala (más estético)
sudo apt update
sudo apt install -y nala

# Descargar e instalar Niri
bash ./res/wm/niri.sh && bash ./res/std/xwayland-satellite.sh || exit 1

# Paquetes de los repositorios oficiales
source ./res/pkgs.conf
sudo nala install "${ENVIROMENT[@]}" "${SOUND[@]}" "${MULTIMEDIA[@]}" "${THEME[@]}" "${EXTRA[@]}"

# Navegador web
echo -e "\nElige el navegador web (separar varios con espacios):"
echo -e " 1) Brave\n 2) Firefox-esr\n"
read -p "Selección/es (Enter para saltar): " browser_choices

for choice in $browser_choices; do
	case $choice in
		1) curl -fsS https://dl.brave.com/install.sh | sh ;;
        2) sudo apt install -y firefox-esr ;;
    esac
done

# Flatpak
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Aplicaciones GTk4 oscuras
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

# Crear carpetas para fuentes
[ -d ~/.local/share/fonts ] || mkdir -p ~/.local/share/fonts

# Descargar FiraMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
7z x FiraMono.zip -oFiraMono
cp FiraMono/Fira*.otf ~/.local/share/fonts

# Actualizar cache de fuentes
fc-cache -f

# Instalar Ly (display manager)
bash ./res/std/ly.sh

# Instalar Newsraft (rss)
bash ./res/std/newsraft.sh

# Configuración de GTK3
spawn-sh-at-startup "gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark"
spawn-sh-at-startup "gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark"

# Descargar yt-dlp de github
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
chmod +x yt-dlp
sudo mv -f yt-dlp /usr/bin/yt-dlp

# Preguntar si quieres instalar auto-cpufreq
while true; do
	echo -e "\n¿Quieres instalar auto-cpufreq?\n[Ayuda a prolongar la batería en los portátiles]\n"
	read -p "(s/n): " answer
	case $answer in
		[Ss]) bash ./res/auto-cpufreq.sh && break ;;
        [Nn]) echo "No se instalará auto-cpufreq." && break ;;
        *) echo "Por favor, introduce s o n." ;;
    esac
done

# Preguntar si quieres instalar Typst
while true; do
	echo -e "\n¿Quieres instalar Typst?\n[Alternativa moderna a LaTeX]\n"
	read -p "(s/n): " answer
	case $answer in
		[Ss]) bash ./res/std/typst.sh && break ;;
        [Nn]) echo "No se instalará Typst." && break ;;
        *) echo "Por favor, introduce s o n." ;;
    esac
done

#===== CONFIGURACIÓN =====#

# Ocultar el manú GRUB
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub

# Mostrar rueda giratoria
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
sudo plymouth-set-default-theme -R spinner

# Actualizar GRUB
sudo update-grub

# Desactivar archivo .sudo_as_admin_successful
echo 'Defaults !admin_flag' | sudo tee /etc/sudoers.d/no_admin_flag
rm ~/.sudo_as_admin_successful

# Montar USB en /media con udisks2
[ -d /etc/udev/rules.d/ ] || mkdir -p /etc/udev/rules.d/
echo 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' | sudo tee /etc/udev/rules.d/99-udisks2.rules

# Crear carpetas del usuario
xdg-user-dirs-update

# Instalar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp -r dotfiles/{.bashrc,.profile,.config,.local} ~/

# Instalar mis scripts
git clone https://github.com/mmgmp/scrips
cp -r scripts/{menus/*,notifications/*,user-tools/*} ~/

# Instalar Starship prompt
curl -sS https://starship.rs/install.sh | sh
sudo mv /usr/local/bin/starship /usr/bin/
source ~/.bashrc && starship preset plain-text-symbols -o ~/.config/starship.toml

# Historial de bash en XDG
mkdir -p ~/.local/state/bash && mv ~/.bash_history ~/.local/state/bash/history

# Configuracion de git en XDG
mkdir -p ~/.config/git && mv ~/.gitconfig ~/.config/git/config 

echo -e "\nCompletado, puedes reiniciar el ordenador con el comando 'systemctl reboot'\n"
