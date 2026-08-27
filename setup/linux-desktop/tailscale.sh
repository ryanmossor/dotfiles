#!/usr/bin/env bash
# shellcheck disable=2154

have tailscale && exit 0

case "$os" in
    omarchy) omarchy-install-service-tailscale ;;
    ubuntu)  curl -fsSL https://tailscale.com/install.sh | sh ;;
esac
