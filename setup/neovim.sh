#!/usr/bin/env bash
# shellcheck disable=2154

nvim_current=$(nvim -v | head -n 1 | sed 's/NVIM v\(.*\)$/\1/')
nvim_latest=$(github_latest_tag "neovim/neovim")

if [[ "$nvim_current" == "$nvim_latest" ]]; then
    echo "Neovim already up to date."
    exit 0
fi

# Install build deps if neovim not already installed
if ! have nvim; then
    if [[ "$os" == "mac" ]]; then
        brew install cmake curl gettext ninja
    elif [[ "$os" == "ubuntu" || "$os" == "wsl" ]]; then
        sudo apt-get install -y build-essential cmake curl gettext ninja-build unzip
    fi
fi

git clone --branch stable --depth 1 https://github.com/neovim/neovim.git /tmp/neovim
pushd /tmp/neovim &> /dev/null || exit
make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
popd &> /dev/null || exit

