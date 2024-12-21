#!/usr/bin/env bash

[[ -z $WIN_HOME ]] && export WIN_HOME="/mnt/c/Users/$USER"
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/code/dotfiles"

blue='\033[1;94m'
green='\033[1;92m'
clear='\033[0m'

stow_apps() {
    pushd "$DOTFILES/config" &> /dev/null || exit
    local target_dir="$1"
    shift # removes first param & shifts others 1 to left, allowing use of "$@" to reference list of app names
    local apps=("$@")

    for app in "${apps[@]}"; do
        echo -e "Stowing ${green}${app}${clear} in ${blue}${target_dir}${clear}"
        stow -Rt "$target_dir" "$app"

        if [[ "$app" == "bat" ]]; then
            [[ $(uname -s) == "Darwin" ]] && bat cache --build &> /dev/null
            [[ $(uname -a) == *Ubuntu* ]] && batcat cache --build &> /dev/null
        fi
    done
    popd &> /dev/null || exit
}

copy_windows_apps() {
    local target_dir="$1"
    shift
    local apps=("$@")

    for app in "${apps[@]}"; do
        echo -e "Copying ${green}${app}${clear} to ${blue}${target_dir}${clear}"
        pushd "$DOTFILES/config/$app" &> /dev/null || exit
        cp -r . "$target_dir"
        popd &> /dev/null || exit
    done
}

unstow_apps() {
    pushd "$DOTFILES/config" &> /dev/null || exit
    local apps=("$@")
    for app in "${apps[@]}"; do
        echo "Removing $app"
        stow -D "$app"
    done
    popd &> /dev/null || exit
}

base=(
    bat
    git
    ideavim
    lazygit
    nvim
    scripts
    #tmux
    vim
    wezterm
    yazi
    zsh
)

personal=(
    flameshot
    gtk-3.0
    i3
    picom
    polybar
    rofi
    shortcuts
)

windows=(
    git # goes to both $HOME and $WIN_HOME
    ideavim
    keycastow
    pwsh
    vim # goes to both $HOME and $WIN_HOME
    vsvim
    wezterm # goes to both $HOME and $WIN_HOME
)

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
            "$DOTFILES/scripts/.local/bin/dot" --help
            exit
            ;;
        -d|-r|--delete|--remove)
            unstow_apps "${base[@]}" "${personal[@]}" "${windows[@]}"
            exit
            ;;
        -i|--init|--install)
            "$DOTFILES/install.sh"
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

