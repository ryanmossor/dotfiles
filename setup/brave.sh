#!/usr/bin/env bash
# shellcheck disable=2154

if have brave-browser || [[ $os == "wsl" ]]; then
    exit 0
fi

curl -fsS https://dl.brave.com/install.sh | sh
