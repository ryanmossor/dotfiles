#!/usr/bin/env bash

blue='\033[1;94m'
green='\033[1;92m'
red='\033[1;91m'
clear='\033[0m'

[ -z "$DOTFILES" ] && export DOTFILES="$HOME/dotfiles"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export script_dir

os="ubuntu"
[[ $(uname -s) == "Darwin" ]] && os="mac"
[[ $(uname -a) == *Ubuntu* ]] && os="ubuntu"
[[ $(uname -r) == *microsoft* ]] && os="wsl"
export os

have() {
  command -v "$1" &> /dev/null
}
export -f have

github_latest_tag() {
    local repo="$1"
    curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' | sed 's/v//'
}
export -f github_latest_tag

log() {
    if [ $dry_run = true ]; then
        echo -e "${red}[DRY_RUN]${clear} $1"
    else
        echo -e "$1"
    fi
}

run_setup() {
    local dir="$script_dir/setup"
    [ -n "$1" ] && dir="$script_dir/setup/$1"

    # Find all executable files
    setup_dir=$(find "$dir" -mindepth 1 -maxdepth 1 -type f -perm -111)

    for script in $setup_dir; do
        if [ -n "$filter_list" ] && echo "$filter_list" | grep --invert-match --quiet "$(basename "$script" .sh)"; then
            log "Filter list ${green}$filter_list${clear} filtered out ${blue}$script${clear}"
            continue
        fi

        log "running script: ${blue}$script${clear}"

        if [ $dry_run = false ]; then
            $script
        fi
    done
}

dry_run=false
install_personal=false
filter_list=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --dry)
            dry_run=true
            ;;
        -p|--personal)
            install_personal=true
            ;;
        *)
            if [[ "$filter_list" == "" ]]; then
                filter_list="$1"
            else
                filter_list+=":$1"
            fi
            ;;
    esac
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

mkdir -p "$HOME/Applications"
mkdir -p "$HOME/code/work"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/scripts"
mkdir -p "$HOME/.local/share/applications"

if [[ "$os" == "mac" ]]; then
    brew update
    brew upgrade
    brew install "${packages[@]}"
else
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y "${packages[@]}"
fi

if [[ $SHELL != "/bin/zsh" ]]; then
    log "${green}Changing shell to zsh${clear}"
    sudo chsh -s /bin/zsh "$USER"
fi

run_setup

if [ $install_personal = false ]; then
    exit 0
fi

run_setup "linux-desktop" 

