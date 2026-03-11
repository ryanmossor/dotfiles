#!/usr/bin/env bash
# shellcheck disable=2154

if have tailscale; then
    echo "Tailscale already installed"
    exit 0
fi

if [[ $os == "omarchy" ]]; then
    omarchy-install-tailscale
elif [[ $os == "ubuntu" ]]; then
    curl -fsSL https://tailscale.com/install.sh | sh
fi
