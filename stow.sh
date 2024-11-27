#!/usr/bin/env bash

[[ -z $WIN_HOME ]] && export WIN_HOME="/mnt/c/Users/$USER"
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/dotfiles"

[[ $(uname -s) == "Darwin" ]] && is_mac=true
[[ $(uname -a) == *Ubuntu* ]] && is_linux=true
[[ $(uname -r) == *microsoft* ]] && is_windows=true

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
    cloc
    curl
    # fzf -- installed below via git
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

if [ "$is_mac" ]; then
    packages+=(fd)
else
    packages+=(fd-find)
fi

install_packages() {
    mkdir -p "$HOME"/.config
    mkdir -p "$HOME"/.local/bin

    if [ "$is_mac" ]; then
        brew update
        brew upgrade
        brew install "${packages[@]}"
        brew install --cask wezterm
        brew install azure-cli
        sudo apt install openssh-server -y
    else
        sudo apt update
        sudo apt upgrade -y
        sudo apt install "${packages[@]}" -y
        sudo apt install xclip -y
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash # azure cli
    fi

    if [[ $SHELL != "/bin/zsh" ]]; then
        echo -e "${green}Changing shell to zsh${clear}"
        sudo chsh -s /bin/zsh "$USER"
    fi

    # fzf latest version
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
    
    # neovim latest stable
    git clone https://github.com/neovim/neovim.git --branch=stable ~/code/neovim
    pushd ~/code/neovim > /dev/null || exit
    make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install 
    popd > /dev/null || exit
}

base=(
    bat
    git
    ideavim
    nvim
    scripts
    #tmux
    vim
    wezterm
    zsh
)

personal=(
    #i3
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
            install_packages
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

if [ "$is_mac" ]; then
   bat cache --build &> /dev/null
else
    batcat cache --build &> /dev/null
fi
