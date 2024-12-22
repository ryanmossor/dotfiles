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
    echo "Updating Cemu to ${cemu_latest}"
    cemu_download=$(get_latest_appimage "${cemu_repo}" "AppImage")
    wget -qO "/home/${USER}/Applications/Cemu.AppImage" "${cemu_download}"
    chmod +x "/home/${USER}/Applications/Cemu.AppImage"
fi

# Slippi
slippi_repo="project-slippi/slippi-launcher"
slippi_latest=$(github_latest_tag "${slippi_repo}")
slippi_current=""
if [ -f "/home/${USER}/Applications/slippi/version.txt" ]; then
    slippi_current=$(<"/home/${USER}/Applications/slippi/version.txt")
fi

if [[ "$slippi_current" == "$slippi_latest" ]]; then
    echo "Slippi already up to date."
else
    sudo apt-get install -y libopengl0
    echo "Updating Slippi to ${slippi_latest}"
    slippi_download=$(get_latest_appimage "${slippi_repo}" "AppImage")
    [ ! -d  "/home/${USER}/Applications/slippi" ] && mkdir "/home/${USER}/Applications/slippi"
    wget -qO "/home/${USER}/Applications/slippi/Slippi.appimage" "${slippi_download}"
    chmod +x "/home/${USER}/Applications/slippi/Slippi.appimage"
    echo "$slippi_latest" > "/home/${USER}/Applications/slippi/version.txt"
fi

# OoT Ship of Harkinian
soh_repo="HarbourMasters/Shipwright"
soh_latest=$(github_latest_tag "${soh_repo}")
soh_current=""
if [ -f "/home/${USER}/Applications/ocarina-of-time/version.txt" ]; then
    soh_current=$(<"/home/${USER}/Applications/ocarina-of-time/version.txt")
fi

if [[ "$soh_current" == "$soh_latest" ]]; then
    echo "Ocarina of Time already up to date."
else
    echo "Updating Ocarina of Time to ${soh_latest}"
    soh_download=$(get_latest_appimage "${soh_repo}" "Linux-Performance")
    [ ! -d  "/home/${USER}/Applications/ocarina-of-time" ] && mkdir "/home/${USER}/Applications/ocarina-of-time"
    wget -qO "/tmp/soh.zip" "${soh_download}"
    unzip -uo /tmp/soh.zip -d "/home/${USER}/Applications/ocarina-of-time"
    chmod +x "/home/${USER}/Applications/ocarina-of-time/soh.appimage"
    echo "$soh_latest" > "/home/${USER}/Applications/ocarina-of-time/version.txt"
fi

# SoH (Anchor) - https://github.com/garrettjoecox/OOT/pull/64
anchor_repo="garrettjoecox/OOT"
anchor_latest=$(github_latest_tag "${anchor_repo}")
anchor_current=""
if [ -f "/home/${USER}/Applications/oot-anchor/version.txt" ];then
    anchor_current=$(<"/home/${USER}/Applications/oot-anchor/version.txt")
fi

if [[ "$anchor_current" == "$anchor_latest" ]]; then
    echo "Anchor already up to date."
else
    echo "Updating Anchor to ${anchor_latest}"
    anchor_download=$(get_latest_appimage "${anchor_repo}" "linux-performance")
    [ ! -d  "/home/${USER}/Applications/oot-anchor" ] && mkdir "/home/${USER}/Applications/oot-anchor"
    wget -qO "/tmp/anchor.zip" "${anchor_download}"
    unzip -uo /tmp/anchor.zip -d "/home/${USER}/Applications/oot-anchor"
    chmod +x "/home/${USER}/Applications/oot-anchor/soh.appimage"
    echo "$anchor_latest" > "/home/${USER}/Applications/oot-anchor/version.txt"
fi

# MM Ship of Harkinian
mm_repo="HarbourMasters/2ship2harkinian"
mm_latest=$(github_latest_tag "${mm_repo}")
mm_current=""
if [ -f "/home/${USER}/Applications/majoras-mask/version.txt" ];then
    mm_current=$(<"/home/${USER}/Applications/majoras-mask/version.txt")
fi

if [[ "$mm_current" == "$mm_latest" ]]; then
    echo "Ship of Harkinian already up to date."
else
    echo "Updating Majora's Mask to ${mm_latest}"
    mm_download=$(get_latest_appimage "${mm_repo}" "Linux")
    [ ! -d  "/home/${USER}/Applications/majoras-mask" ] && mkdir "/home/${USER}/Applications/majoras-mask"
    wget -qO "/tmp/2ship.zip" "${mm_download}"
    unzip -uo /tmp/2ship.zip -d "/home/${USER}/Applications/majoras-mask"
    chmod +x "/home/${USER}/Applications/majoras-mask/2ship.appimage"
    echo "$mm_latest" > "/home/${USER}/Applications/majoras-mask/version.txt"
fi

