#!/usr/bin/env bash

blue='\033[1;94m'
green='\033[1;92m'
clear='\033[0m'

stow_apps() {
    local target_dir="$1"
    shift # removes first param & shifts others 1 to left, allowing use of "$@" to reference list of app names
    local apps=("$@")

    for app in "${apps[@]}"; do
        stow -Rvt "$target_dir" "$app"
        echo -e "Stowing ${green}${app}${clear} in ${blue}${target_dir}${clear}"
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

stow_apps "$HOME" "${base[@]}"

while [[ "$#" -gt 0 ]]; do
    case $1 in
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
 