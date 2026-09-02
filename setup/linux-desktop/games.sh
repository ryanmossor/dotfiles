#!/usr/bin/env bash

if [ ! -d /mnt/adata ]; then
    echo "ADATA drive not mounted. Skipping game installations."
    exit 1
fi

GAMES_DIR="/mnt/adata/Games"
[ ! -d "$GAMES_DIR" ] && mkdir -p "$GAMES_DIR"

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
if [ -f "${GAMES_DIR}/cemu/version" ]; then
    cemu_current=$(<"${GAMES_DIR}/cemu/version")
fi

if [[ "$cemu_current" == "$cemu_latest" ]]; then
    echo "Cemu already up to date"
else
    [ -z "$cemu_current" ] && echo "Installing Cemu ${cemu_latest}" \
        || echo "Updating Cemu from ${cemu_current} to ${cemu_latest}"
    cemu_download=$(get_latest_appimage "${cemu_repo}" "AppImage")
    [ ! -d  "${GAMES_DIR}/cemu" ] && mkdir "${GAMES_DIR}/cemu"
    wget -qO "${GAMES_DIR}/cemu/cemu.appimage" "${cemu_download}"
    chmod +x "${GAMES_DIR}/cemu/cemu.appimage"
    echo "$cemu_latest" > "${GAMES_DIR}/cemu/version"
fi

# Slippi
slippi_repo="project-slippi/slippi-launcher"
slippi_latest=$(github_latest_tag "${slippi_repo}")
slippi_current=""
if [ -f "${GAMES_DIR}/slippi/version" ]; then
    slippi_current=$(<"${GAMES_DIR}/slippi/version")
fi

if [[ "$slippi_current" == "$slippi_latest" ]]; then
    echo "Slippi already up to date"
else
    [[ "$os" == "ubuntu" ]] && sudo apt-get install -y libopengl0
    [ -z "$slippi_current" ] && echo "Installing Slippi ${slippi_latest}" \
        || echo "Updating Slippi from ${slippi_current} to ${slippi_latest}"
    slippi_download=$(get_latest_appimage "${slippi_repo}" "AppImage")
    [ ! -d  "${GAMES_DIR}/slippi" ] && mkdir "${GAMES_DIR}/slippi"
    wget -qO "${GAMES_DIR}/slippi/slippi.appimage" "${slippi_download}"
    chmod +x "${GAMES_DIR}/slippi/slippi.appimage"
    echo "$slippi_latest" > "${GAMES_DIR}/slippi/version"
fi

# OoT Ship of Harkinian
soh_repo="HarbourMasters/Shipwright"
soh_latest=$(github_latest_tag "${soh_repo}")
soh_current=""
if [ -f "${GAMES_DIR}/ocarina-of-time/version" ]; then
    soh_current=$(<"${GAMES_DIR}/ocarina-of-time/version")
fi

if [[ "$soh_current" == "$soh_latest" ]]; then
    echo "Ocarina of Time already up to date"
else
    [ -z "$soh_current" ] && echo "Installing Ocarina of Time ${soh_latest}" \
        || echo "Updating Ocarina of Time from ${soh_current} to ${soh_latest}"
    soh_download=$(get_latest_appimage "${soh_repo}" "Linux")
    [ ! -d  "${GAMES_DIR}/ocarina-of-time" ] && mkdir "${GAMES_DIR}/ocarina-of-time"
    wget -qO "/tmp/soh.zip" "${soh_download}"
    unzip -uo /tmp/soh.zip -d "${GAMES_DIR}/ocarina-of-time"
    chmod +x "${GAMES_DIR}/ocarina-of-time/soh.appimage"
    echo "$soh_latest" > "${GAMES_DIR}/ocarina-of-time/version"
fi

# MM Ship of Harkinian
mm_repo="HarbourMasters/2ship2harkinian"
mm_latest=$(github_latest_tag "${mm_repo}")
mm_current=""
if [ -f "${GAMES_DIR}/majoras-mask/version" ]; then
    mm_current=$(<"${GAMES_DIR}/majoras-mask/version")
fi

if [[ "$mm_current" == "$mm_latest" ]]; then
    echo "Majora's Mask already up to date"
else
    [ -z "$mm_current" ] && echo "Installing Majora's Mask ${mm_latest}" \
        || echo "Updating Majora's Mask from ${mm_current} to ${mm_latest}"
    mm_download=$(get_latest_appimage "${mm_repo}" "Linux")
    [ ! -d  "${GAMES_DIR}/majoras-mask" ] && mkdir "${GAMES_DIR}/majoras-mask"
    wget -qO "/tmp/2ship.zip" "${mm_download}"
    unzip -uo /tmp/2ship.zip -d "${GAMES_DIR}/majoras-mask"
    chmod +x "${GAMES_DIR}/majoras-mask/2ship.appimage"
    echo "$mm_latest" > "${GAMES_DIR}/majoras-mask/version"
fi
