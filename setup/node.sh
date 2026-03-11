#!/usr/bin/env bash
# shellcheck disable=2154

if [[ $os == "omarchy" ]]; then
    omarchy-install-dev-env node
elif [[ $os == "ubuntu" ]]; then
    sudo apt-get install -y nodejs npm
    npm config set prefix ~/.local/npm
    npm i -g n
    n lts
fi
