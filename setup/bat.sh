#!/usr/bin/env bash
# shellcheck disable=2154

have bat && exit 0

case "$os" in
    mac)
        brew install bat ;;
    omarchy)
        omarchy-pkg-add bat ;;
    ubuntu|wsl)
        sudo apt-get install -y bat
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
        ;;
    *)
        echo "OS not supported. Skipping bat installation." ;;
esac
