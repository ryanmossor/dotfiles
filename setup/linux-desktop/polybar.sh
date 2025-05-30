#!/usr/bin/env bash
# shellcheck disable=2154

polybar_current=$(polybar --version | head -n 1 | awk '{print $NF}')
polybar_latest=$(github_latest_tag "polybar/polybar")

if [[ "$polybar_current" == "$polybar_latest" ]]; then
    echo "Polybar already up to date."
    exit 0
fi

deps=(
    build-essential
    cmake
    cmake-data
    git
    i3-wm
    libasound2-dev
    libcairo2-dev
    libcurl4-openssl-dev
    libjsoncpp-dev
    libmpdclient-dev
    libnl-genl-3-dev
    libpulse-dev
    libuv1-dev
    libxcb-composite0-dev
    libxcb-cursor-dev
    libxcb-ewmh-dev
    libxcb-icccm4-dev
    libxcb-image0-dev
    libxcb-randr0-dev
    libxcb-util0-dev
    libxcb-xkb-dev
    libxcb-xrm-dev
    libxcb1-dev
    pkg-config
    python3-packaging
    python3-sphinx
    python3-xcbgen
    xcb-proto
)

if ! have polybar; then
    sudo apt-get install -y "${deps[@]}"
fi

pushd /tmp &> /dev/null || exit
curl -Lo "polybar-${polybar_latest}.tar.gz" "https://github.com/polybar/polybar/releases/download/${polybar_latest}/polybar-${polybar_latest}.tar.gz"
tar xvzf "polybar-${polybar_latest}.tar.gz"
cd "polybar-${polybar_latest}" || exit
./build.sh --all-features --jobs --auto
popd &> /dev/null || exit

