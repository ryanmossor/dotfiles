#!/usr/bin/env bash
# shellcheck disable=2154

if have az; then
    echo "az cli already installed"
    exit 0
fi

if [[ "$os" == "mac" ]]; then
    brew install azure-cli
else
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

