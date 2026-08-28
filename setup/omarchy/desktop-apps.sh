#!/usr/bin/env bash

packages=(
    # flameshot
    gimp
    screenkey
)
omarchy-pkg-add "${packages[@]}"

# ! have steam && omarchy-install-gaming-steam

flatpaks=(
    org.DolphinEmu.dolphin-emu
    org.onlyoffice.desktopeditors
)
if [ -x /usr/bin/flatpak ]; then
    flatpak update -y
    # sudo flatpak install flathub --noninteractive --assumeyes "${flatpaks[@]}"
    flatpak install flathub --noninteractive --assumeyes "${flatpaks[@]}"
fi
