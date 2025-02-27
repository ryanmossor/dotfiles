#!/usr/bin/env bash

if [[ $(uname -a) != *desktop* ]]; then
    exit 0
fi

if [[ $(uname -a) == *desktop* ]] && [ ! -f ~/.local/share/applications/jetbrains-toolbox.desktop ]; then
    firefox --new-window "https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux"
fi

