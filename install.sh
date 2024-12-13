#!/usr/bin/env bash

function have {
  command -v "$1" &> /dev/null
}
export -f have

github_latest_tag() {
    local repo="$1"
    if have jq; then
        curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' | sed 's/v//'
    else
        curl -s "https://api.github.com/repos/${repo}/releases/latest" | grep "tag_name" | cut -d '"' -f 4 | sed 's/v//'
    fi
}
export -f github_latest_tag

[[ -z $DOTFILES ]] && export DOTFILES="$HOME/dotfiles"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export script_dir

green='\033[1;92m'
clear='\033[0m'

os="ubuntu"
[[ $(uname -s) == "Darwin" ]] && os="mac"
[[ $(uname -a) == *Ubuntu* ]] && os="ubuntu"
[[ $(uname -r) == *microsoft* ]] && os="wsl"
export os

grep=""
dry_run="0"

while [[ $# -gt 0 ]]; do
    echo "ARG: \"$1\""
    if [[ "$1" == "--dry" ]]; then
        dry_run="1"
    else
        grep="$1"
    fi
    shift
done

packages=(
    android-sdk-platform-tools
    cloc
    curl
    git
    htop
    jq
    neofetch
    ripgrep
    shellcheck
    stow
    tldr
    tmux
    vim
    wget
    zsh
)

if [[ "$os" == "mac" ]]; then
    packages+=(fd)
else
    packages+=(fd-find)
fi

mkdir -p "$HOME"/code/work
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.local/bin

if [[ "$os" == "mac" ]]; then
    brew update
    brew upgrade
    brew install "${packages[@]}"
else
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y "${packages[@]}"
fi

if [[ $SHELL != "/bin/zsh" ]]; then
    echo -e "${green}Changing shell to zsh${clear}"
    sudo chsh -s /bin/zsh "$USER"
fi

setup=$(find "$script_dir/setup" -mindepth 1 -maxdepth 1 -executable)

for script in $setup; do
    # if echo "$script" | grep -vq "$grep"; then
    if echo "$script" | grep --invert-match --quiet "$grep"; then
        echo "grep \"$grep\" filtered out $script"
        continue
    fi

    # log "running script: $script"
    echo "running script: $script"

    # if [[ $dry_run == "0" ]]; then
        $script
    # fi
done
