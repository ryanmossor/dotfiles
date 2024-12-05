#!/usr/bin/env bash

[[ -z $WIN_HOME ]] && export WIN_HOME="/mnt/c/Users/$USER"
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/dotfiles"

[[ $(uname -s) == "Darwin" ]] && is_mac=true
[[ $(uname -a) == *Ubuntu* ]] && is_linux=true
[[ $(uname -r) == *microsoft* ]] && is_windows=true

blue='\033[1;94m'
green='\033[1;92m'
clear='\033[0m'

github_latest_tag() {
    local repo="$1"
    if command -v jq &> /dev/null; then
        curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' | sed 's/v//'
    else
        curl -s "https://api.github.com/repos/${repo}/releases/latest" | grep "tag_name" | cut -d '"' -f 4 | sed 's/v//'
    fi
}

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

if [ "$is_mac" ]; then
    packages+=(fd)
else
    packages+=(fd-find)
fi

brew_packages=(
    azure-cli
    jesseduffield/lazygit/lazygit
    yazi
)

linux_packages=(
    i3
    i3lock
    pavucontrol
    picom
    polybar
    pulseaudio
    openssh-server
    wezterm
    xclip
)

install_packages() {
    mkdir -p "$HOME"/code/work
    mkdir -p "$HOME"/.config
    mkdir -p "$HOME"/.local/bin

    if [ "$is_mac" ]; then
        brew update
        brew upgrade
        brew install "${packages[@]}"
        brew install "${brew_packages[@]}"
        brew install --cask wezterm
    else
        sudo apt update
        sudo apt upgrade -y
        sudo apt install -y "${packages[@]}"
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash # azure cli

        if [[ $(uname -a) == *mint* ]]; then
            # wezterm repo
            curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
            echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

            sudo apt install -y "${linux_packages[@]}"
        fi

        lazygit_latest=$(github_latest_tag "jesseduffield/lazygit")
        lazygit_current=$(lazygit -v 2> /dev/null | cut -d ' ' -f 6 | sed 's/version=\(.*\),/\1/')
        if [[ "$lazygit_current" != "$lazygit_latest" ]]; then
            pushd /tmp > /dev/null || exit
            curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_latest}/lazygit_${lazygit_latest}_Linux_x86_64.tar.gz"
            tar xf lazygit.tar.gz lazygit
            sudo install lazygit -D -t /usr/local/bin/
            popd > /dev/null || exit
        fi

        yazi_latest=$(github_latest_tag "sxyazi/yazi")
        yazi_current=$(yazi --version | cut -d ' ' -f 2)
        if [[ "$yazi_current" != "$yazi_latest" ]]; then
            pushd /tmp > /dev/null || exit
            curl -Lo yazi.zip "https://github.com/sxyazi/yazi/releases/download/v${yazi_latest}/yazi-x86_64-unknown-linux-gnu.zip"
            mkdir -p yazi
            unzip yazi.zip
            sudo install yazi-x86_64-unknown-linux-gnu/yazi -D -t /usr/local/bin/
            popd > /dev/null || exit
        fi
    fi

    if [[ $SHELL != "/bin/zsh" ]]; then
        echo -e "${green}Changing shell to zsh${clear}"
        sudo chsh -s /bin/zsh "$USER"
    fi

    # fzf latest version
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc

    # neovim latest stable
    nvim_current=$(nvim -v | head -n 1 | sed 's/NVIM v\(.*\)$/\1/')
    nvim_latest=$(github_latest_tag "neovim/neovim")
    if [[ "$nvim_current" != "$nvim_latest" ]]; then
        [ ! -d ~/code/neovim ] && git clone https://github.com/neovim/neovim.git ~/code/neovim
        pushd ~/code/neovim > /dev/null || exit
        git checkout stable && git pull
        make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install 
        popd > /dev/null || exit
    fi
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
    i3
    picom
    polybar
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

