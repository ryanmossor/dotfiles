#!/usr/bin/env bash

[[ -z $WIN_HOME ]] && WIN_HOME="/mnt/c/Users/$USER"

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

copy_windows_apps() {
    local target_dir="$1"
    shift
    local apps=("$@")
    [[ -z $DOTFILES ]] && DOTFILES="$HOME/dotfiles"

    for app in "${apps[@]}"; do
        echo -e "Copying ${green}${app}${clear} to ${blue}${target_dir}${clear}"
        pushd "$DOTFILES"/"$app" > /dev/null || exit
        cp -r . "$target_dir"
        popd > /dev/null || exit
    done
}

unstow_apps() {
    local apps=("$@")
    for app in "${apps[@]}"; do
        echo "Removing $app"
        stow -D "$app"
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
    ripgrep
    stow
    tmux
    vim
    wget
    zsh
)

if [[ $(uname -s) == "Darwin" ]]; then
    packages+=(fd)
else
    packages+=(fd-find)
fi

install_packages() {
    mkdir -p "$HOME"/.config
    mkdir -p "$HOME"/.local/bin

    echo "Updating required packages..."
    if [[ $(uname -s) == "Darwin" ]]; then
        brew update
        brew upgrade
        brew install "${packages[@]}"
    else
        echo "Updating required packages..."
        sudo apt update
        sudo apt upgrade -y
        sudo apt install "${packages[@]}" -y
    fi

    if [[ $SHELL != "/bin/zsh" ]]; then
        echo -e "${green}Changing shell to zsh${clear}"
        sudo chsh -s /bin/zsh "$USER"
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
    keycastow
    pwsh
    vim # vim goes to both $HOME and $WIN_HOME
    vsvim
)

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|-r|--delete|--remove)
            unstow_apps "${base[@]}" "${personal[@]}" "${windows[@]}"
            exit
            ;;
        -i|--init|--install)
            install_packages
            [[ $(uname -a) == *mint* ]] && sudo apt install xclip
            [[ $(uname -s) != "Darwin" ]] && sudo apt install openssh-server
            ;;
        -p|--personal)
            stow_apps "$HOME" "${personal[@]}"
            ;;
        -w|--windows)
            copy_windows_apps "$WIN_HOME" "${windows[@]}"
            ;;
        *)
            echo "Unknown option: $1"
            exit
            ;;
    esac
    shift
done
 
stow_apps "$HOME" "${base[@]}"

if [[ $(uname -s) == "Darwin" ]]; then
    bat cache --build &> /dev/null
else
    batcat cache --build &> /dev/null
fi
