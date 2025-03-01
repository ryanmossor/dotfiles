#!/usr/bin/env bash
# shellcheck disable=2154

fonts_updated=false

mkdir -p "$HOME/.fonts"

if ! dpkg -s ttf-mscorefonts-installer &> /dev/null; then
    # Auto agree to EULA prompt for Microsoft fonts
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
    sudo apt-get install -y ttf-mscorefonts-installer
    fonts_updated=true
fi

if ! ls /home/$USER/.fonts/FiraCode-*.ttf &> /dev/null; then
    fira_repo="tonsky/FiraCode"
    fira_ver=$(github_latest_tag "${fira_repo}")
    wget -O /tmp/FiraCode.zip "https://github.com/${fira_repo}/releases/download/${fira_ver}/Fira_Code_v${fira_ver}.zip"
    unzip /tmp/FiraCode.zip -d /tmp/FiraCode
    mv /tmp/FiraCode/ttf/*.ttf "/home/${USER}/.fonts"
    rm -rf /tmp/FiraCode.zip /tmp/FiraCode/
    fonts_updated=true
fi

if ! ls /home/$USER/.fonts/FiraCodeNerdFont*.ttf &> /dev/null; then
    fira_nerd_repo="ryanoasis/nerd-fonts"
    fira_nerd_ver=$(github_latest_tag "${fira_nerd_repo}")
    wget -O /tmp/FiraCodeNerd.zip "https://github.com/${fira_nerd_repo}/releases/download/v${fira_nerd_ver}/FiraCode.zip"
    unzip /tmp/FiraCodeNerd.zip -d /tmp/FiraCodeNerd
    mv /tmp/FiraCodeNerd/*.ttf "/home/${USER}/.fonts"
    rm -rf /tmp/FiraCodeNerd.zip /tmp/FiraCodeNerd/
    fonts_updated=true
fi

if ! ls /home/$USER/.fonts/UbuntuNerdFont*.ttf &> /dev/null; then
    ubuntu_nerd_repo="ryanoasis/nerd-fonts"
    ubuntu_nerd_ver=$(github_latest_tag "${ubuntu_nerd_repo}")
    wget -O /tmp/Ubuntu.zip "https://github.com/${ubuntu_nerd_repo}/releases/download/v${ubuntu_nerd_ver}/Ubuntu.zip"
    unzip /tmp/Ubuntu.zip -d /tmp/Ubuntu
    mv /tmp/Ubuntu/*.ttf "/home/${USER}/.fonts"
    rm -rf /tmp/Ubuntu.zip /tmp/Ubuntu/
    fonts_updated=true
fi

if ! ls /home/$USER/.fonts/Cascadia*.ttf &> /dev/null; then
    cascadia_repo="microsoft/cascadia-code"
    cascadia_ver=$(github_latest_tag "${cascadia_repo}")
    wget -O /tmp/CascadiaCode.zip "https://github.com/${cascadia_repo}/releases/download/v${cascadia_ver}/CascadiaCode-${cascadia_ver}.zip"
    unzip /tmp/CascadiaCode.zip -d /tmp/CascadiaCode
    mv /tmp/CascadiaCode/ttf/*.ttf "/home/${USER}/.fonts"
    rm -rf /tmp/CascadiaCode.zip /tmp/CascadiaCode/
    fonts_updated=true
fi

if ! ls /home/$USER/.fonts/JetBrainsMono*.ttf &> /dev/null; then
    jetbrains_mono_repo="JetBrains/JetBrainsMono"
    jetbrains_mono_ver=$(github_latest_tag "${jetbrains_mono_repo}")
    wget -O /tmp/JetBrainsMono.zip "https://github.com/${jetbrains_mono_repo}/releases/download/v${jetbrains_mono_ver}/JetBrainsMono-${jetbrains_mono_ver}.zip"
    unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono
    mv /tmp/JetBrainsMono/fonts/ttf/*.ttf "/home/${USER}/.fonts"
    rm -rf /tmp/JetBrainsMono.zip /tmp/JetBrainsMono/
    fonts_updated=true
fi

if [ "$fonts_updated" == true ]; then
    # Reload font cache
    fc-cache -f &> /dev/null
fi

