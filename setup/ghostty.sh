#!/usr/bin/env bash
# shellcheck disable=2154

if [[ $os == "mac" ]]; then
    brew install --cask ghostty
elif [[ $os == "ubuntu" ]]; then
    if ! have ghostty; then
        sudo add-apt-repository ppa:mkasberg/ghostty-ubuntu
        sudo apt-get update
    fi
    sudo apt-get install ghostty -y
fi
