#!/usr/bin/env bash
# shellcheck disable=2154

have ghostty && exit 0

case "$os" in
    mac)
        brew install --cask ghostty ;;
    omarchy)
        omarchy-install-terminal ghostty ;;
    ubuntu)
        sudo add-apt-repository ppa:mkasberg/ghostty-ubuntu
        sudo apt-get update
        sudo apt-get install ghostty -y
        ;;
    *)
        echo "OS not supported. Skipping ghostty installation." ;;
esac
