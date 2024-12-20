#!/usr/bin/env bash
# shellcheck disable=2154

mkdir -p "$HOME/Pictures/Wallpapers" "$HOME/Pictures/Screenshots"
if [ ! -f "$HOME/Pictures/Wallpapers/wall.png" ]; then
    cp "$script_dir/resources/wall.png" "$script_dir/resources/blur.png" "$HOME/Pictures/Wallpapers"
fi

packages=(
    feh
    flameshot
    gimp
    i3
    i3lock
    libfuse2
    lxappearance
    openssh-server
    pavucontrol
    picom
    pulseaudio
    steam
    ufw
    xclip
)
sudo apt install -y "${packages[@]}"

flatpaks=(
    com.chatterino.chatterino/x86_64/stable
    com.getpostman.Postman
    com.obsproject.Studio
    org.DolphinEmu.dolphin-emu
    org.onlyoffice.desktopeditors
)
if [ -x /usr/bin/flatpak ]; then
    flatpak update -y
    sudo flatpak install flathub --noninteractive --assumeyes "${flatpaks[@]}"
fi

