#!/usr/bin/env bash
# shellcheck disable=2154

if have rofi; then
    have rofimoji && pipx upgrade rofimoji
    exit 0
fi

sudo apt-get install -y rofi

rofimoji_deps=(
    pipx
    python3
    python3-pip
    xdotool
)
sudo apt-get install -y "${rofimoji_deps[@]}"

pipx install rofimoji

