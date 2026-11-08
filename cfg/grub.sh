#!/bin/bash

# Crear drop-in
sudo mkdir -p /etc/default/grub.d
sudo tee /etc/default/grub.d/99-custom.cfg >/dev/null <<'EOF'
# Menú oculto, pero accesible con Shift/Esc durante 2 s
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=2

# Arranque silencioso con Plymouth
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
EOF

# Tema de Plymouth (-R regenera el initramfs)
sudo plymouth-set-default-theme -R spinner

# Regenerar grub.cfg
sudo update-grub
