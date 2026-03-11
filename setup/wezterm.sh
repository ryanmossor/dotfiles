#!/usr/bin/env bash
# shellcheck disable=2154

if have wezterm; then
    echo "Wezterm already installed"
    exit 0
fi

if [[ $os == "omarchy" ]]; then
    sudo pacman -S --noconfirm --needed wezterm
elif [[ $os == "mac" ]]; then
    brew install --cask wezterm
elif [[ $os == "ubuntu" ]]; then
    if ! have wezterm; then
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
        sudo apt-get update
    fi
    sudo apt-get install -y wezterm
fi
