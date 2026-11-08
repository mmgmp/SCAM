#!/bin/bash

# Configuración
GTK_FONT="Inter 11"
GTK_THEME="Arc-Dark"
GTK_ICONS="Papirus-Dark"
GTK_CURSOR="Breeze_Light"

# gsettings (lo que leen las apps GTK en Wayland)
gsettings set org.gnome.desktop.interface font-name "$GTK_FONT"
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$GTK_ICONS"
gsettings set org.gnome.desktop.interface cursor-theme "$GTK_CURSOR"

# Crear settings.ini con mismos ajustes
mkdir -p ~/.config/gtk-3.0
cat > ~/.config/gtk-$v.0/settings.ini <<EOF
[Settings]
gtk-font-name=$GTK_FONT
gtk-theme-name=$GTK_THEME
gtk-icon-theme-name=$GTK_ICONS
gtk-cursor-theme-name=$GTK_CURSOR
EOF
