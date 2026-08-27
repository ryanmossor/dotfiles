#!/usr/bin/env bash
# shellcheck disable=2154

have az && exit 0

case "$os" in
    mac)     brew install azure-cli ;;
    omarchy) omarchy-pkg-add azure-cli ;;
    ubuntu)  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ;;
    *)       echo "OS not supported. Skipping azure-cli installation." ;;
esac
