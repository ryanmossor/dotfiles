#!/usr/bin/env bash
# shellcheck disable=2154

if have bat; then
    exit 0
fi

if [[ $os == "omarchy" ]]; then
    sudo pacman -S --noconfirm --needed bat
elif [[ $os == "mac" ]]; then
    brew install bat
elif [[ $os == "ubuntu" || $os == "wsl" ]]; then
    sudo apt-get install -y bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi
