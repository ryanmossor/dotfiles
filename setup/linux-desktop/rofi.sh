#!/usr/bin/env bash
# shellcheck disable=2154

if have rofi; then
    exit 0
fi

sudo apt install -y rofi

rofimoji_deps=(
    python3
    xdotool
)
sudo apt install -y "${rofimoji_deps[@]}"

pip3 install rofimoji

