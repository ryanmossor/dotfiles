#!/usr/bin/env bash

blue='\033[1;94m'
green='\033[1;92m'
clear='\033[0m'

packages=(
    bat
    curl
    fzf
    git
    git-team
    htop
    jq
    neofetch
    #openssh-server
    ripgrep
    stow
    tmux
    vim
    wget
    xclip
    zsh
)

if [[ $(uname -s) == "Darwin" ]]; then
    brew update
    brew upgrade
    brew install "${packages[@]}"
else
    sudo apt update
    sudo apt upgrade -y
    sudo apt install "${packages[@]}" -y
fi

base=(
    bat
    tmux
    vim
    zsh
)

personal=(
    devilspie2
    #i3
    mint
    rofi
)

windows=(
    vim # vim goes to both $HOME and $WIN_HOME
    wsl
)

stow_apps() {
    local target_dir="$1"
    shift # removes first param & shifts others 1 to left, allowing use of "$@" to reference list of app names
    local apps=("$@")

    for app in "${apps[@]}"; do
        stow -Rvt "$target_dir" "$app"
        echo -e "Stowing ${green}${app}${clear} in ${blue}${target_dir}${clear}"
    done
}

stow_apps "$HOME" "${base[@]}"

if [[ "$1" = "--personal" ]]; then
    stow_apps "$HOME" "${personal[@]}"
elif [[ "$1" = "--windows" ]]; then
    stow_apps "$WIN_HOME" "${windows[@]}"
fi
