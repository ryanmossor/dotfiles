#!/usr/bin/env bash

get_latest_appimage() {
    local repo="$1"
    local search_term="$2"
    curl -s "https://api.github.com/repos/${repo}/releases/latest" \
        | jq -r --arg search_term "${search_term}" '.assets[] | select(.name | contains($search_term)) | .browser_download_url'
    }

# Cemu
cemu_repo="cemu-project/Cemu"
cemu_latest=$(github_latest_tag "${cemu_repo}")
cemu_current=""
if [ -f "/home/${USER}/Applications/Cemu.AppImage" ]; then
    cemu_current=$("/home/${USER}/Applications/Cemu.AppImage" --version)
fi

if [[ "$cemu_current" == "$cemu_latest" ]]; then
    echo "Cemu already up to date."
else
    cemu_download=$(get_latest_appimage "${cemu_repo}" "AppImage")
    wget -O "/home/${USER}/Applications/Cemu.AppImage" "${cemu_download}"
    chmod +x "/home/${USER}/Applications/Cemu.AppImage"
fi

# Slippi - will update this one manually via slippi launcher since no easy way to check version
if [ ! -f "/home/${USER}/Applications/Slippi.AppImage" ]; then
    sudo apt install -y libopengl0
    slippi_download=$(get_latest_appimage "project-slippi/slippi-launcher" "AppImage")
    wget -O "/home/${USER}/Applications/Slippi.AppImage" "${slippi_download}"
    chmod +x "/home/${USER}/Applications/Slippi.AppImage"
fi

# OoT Ship of Harkinian
if [ ! -f "/home/${USER}/Applications/ocarina-of-time/soh.appimage" ]; then
    oot_download=$(get_latest_appimage "HarbourMasters/Shipwright" "Linux-Performance")
    wget -O "/tmp/soh.zip" "${oot_download}"
    unzip /tmp/soh.zip -d "/home/${USER}/Applications/ocarina-of-time"
    chmod +x "/home/${USER}/Applications/ocarina-of-time/soh.appimage"
fi

# SoH (Anchor) - https://github.com/garrettjoecox/OOT/pull/64
if [ ! -f "/home/${USER}/Applications/oot-anchor/soh.appimage" ]; then
    anchor_download=$(get_latest_appimage "garrettjoecox/OOT" "linux-performance")
    wget -O "/tmp/anchor.zip" "${anchor_download}"
    unzip /tmp/anchor.zip -d "/home/${USER}/Applications/oot-anchor"
    chmod +x "/home/${USER}/Applications/oot-anchor/soh.appimage"
fi

# MM Ship of Harkinian
if [ ! -f "/home/${USER}/Applications/majoras-mask/2ship.appimage" ]; then
    mm_download=$(get_latest_appimage "HarbourMasters/2ship2harkinian" "Linux")
    wget -O "/tmp/2ship.zip" "${mm_download}"
    unzip /tmp/2ship.zip -d "/home/${USER}/Applications/majoras-mask"
    chmod +x "/home/${USER}/Applications/majoras-mask/2ship.appimage"
fi

