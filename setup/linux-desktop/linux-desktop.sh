#!/usr/bin/env bash
# shellcheck disable=2154

packages=(
    feh
    flameshot
    gimp
    i3
    i3lock
    lxappearance
    openssh-server
    pavucontrol
    picom
    playerctl
    screenkey
    # steam
    ufw
    xclip
)
sudo apt-get install -y "${packages[@]}"

flatpaks=(
    com.chatterino.chatterino/x86_64/stable
    com.getpostman.Postman
    com.github.PintaProject.Pinta
    com.obsproject.Studio
    org.DolphinEmu.dolphin-emu
    org.localsend.localsend_app
    org.onlyoffice.desktopeditors
)
if [ -x /usr/bin/flatpak ]; then
    flatpak update -y
    sudo flatpak install flathub --noninteractive --assumeyes "${flatpaks[@]}"
fi

