#!/usr/bin/env bash

blue='\033[1;94m'
green='\033[1;92m'
clear='\033[0m'

stow_apps() {
    local target_dir="$1"
    shift # removes first param & shifts others 1 to left, allowing use of "$@" to reference list of app names
    local apps=("$@")

    for app in "${apps[@]}"; do
        echo -e "Stowing ${green}${app}${clear} in ${blue}${target_dir}${clear}"
        stow -Rt "$target_dir" "$app"
    done
}

packages=(
    bat
    curl
    fzf
    git
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

install_packages() {
    echo "Updating required packages..."
    if [[ $(uname -s) == "Darwin" ]]; then
        brew update > /dev/null 2>&1
        brew upgrade > /dev/null 2>&1
        brew install "${packages[@]}" > /dev/null 2>&1
    else
        echo "Updating required packages..."
        sudo apt update > /dev/null 2>&1
        sudo apt upgrade -y > /dev/null 2>&1
        sudo apt install "${packages[@]}" -y > /dev/null 2>&1
    fi
}

base=(
    bat
    scripts
    #tmux
    vim
    zsh
)

personal=(
    devilspie2
    #i3
    rofi
)

windows=(
    pwsh
    vim # vim goes to both $HOME and $WIN_HOME
    vsvim
)

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--install)
            install_packages
            ;;
        -p|--personal)
            stow_apps "$HOME" "${personal[@]}"
            ;;
        -w|--windows)
            stow_apps "$WIN_HOME" "${windows[@]}"
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done
 
stow_apps "$HOME" "${base[@]}"
