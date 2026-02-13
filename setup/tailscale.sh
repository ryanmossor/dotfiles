#!/usr/bin/env bash

if ! have tailscale; then
    curl -fsSL https://tailscale.com/install.sh | sh
fi
