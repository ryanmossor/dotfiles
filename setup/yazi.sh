#!/usr/bin/env bash
# shellcheck disable=2154

if [[ "$os" == "mac" ]]; then
    brew install yazi
else
    yazi_latest=$(github_latest_tag "sxyazi/yazi")
    yazi_current=$(yazi --version | cut -d ' ' -f 2)
    if [[ "$yazi_current" == "$yazi_latest" ]]; then
        echo "Yazi already up to date."
        exit 0
    fi

    pushd /tmp &> /dev/null || exit
    curl -Lo yazi.zip "https://github.com/sxyazi/yazi/releases/download/v${yazi_latest}/yazi-x86_64-unknown-linux-gnu.zip"
    mkdir -p yazi
    unzip yazi.zip
    sudo install yazi-x86_64-unknown-linux-gnu/yazi -D -t /usr/local/bin/
    popd &> /dev/null || exit
fi
