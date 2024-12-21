#!/usr/bin/env bash

set -e

arch=""
if [[ $(uname -s) == "Linux" ]]; then
    arch="linux-amd64"
elif [[ $(uname -s) == "Darwin" ]]; then
    arch="darwin-amd64"
else
    echo "Operating system not recognized. Exiting go installation..."
    exit 1
fi

download_page="/tmp/go_dl.html"
curl -fsSL "https://go.dev/dl/" --output "$download_page"
# [^>]> lazy matches to next >
go_latest=$(grep --ignore-case --only-matching '<span>go.*</span>' "$download_page" | sed -n '6p' | sed 's/<[^>]*>//g')

if [[ $(go version) == *"$go_latest"* ]]; then
    echo "Go already up to date."
    exit 0
fi

download_filename="$go_latest.$arch.tar.gz"
curl -fsSL "https://go.dev/dl/$download_filename" -o "/tmp/$download_filename"
if [ $? -ne 0 ]; then
    echo "Download failed. Exiting..."
    exit 1
fi

[ -d /usr/local/go ] && sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "/tmp/$download_filename"

echo -e "\nGo updated to $(go version)\n"

