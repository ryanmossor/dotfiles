#!/usr/bin/env bash

packages=(
    feh
    i3
    i3lock
    picom
)
sudo apt-get install -y "${packages[@]}"

if ! have autotiling; then
    sudo apt-get install -y python3 python3-i3ipc
    git clone https://github.com/ryanmossor/autotiling /tmp/autotiling
    chmod +x /tmp/autotiling/autotiling/main.py
    sudo cp /tmp/autotiling/autotiling/main.py /usr/bin/autotiling
fi
