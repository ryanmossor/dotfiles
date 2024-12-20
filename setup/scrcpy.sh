#!/usr/bin/env bash
# shellcheck disable=2154

if [[ "$os" == "mac" ]]; then
    brew install scrcpy
else
    scrcpy_latest=$(github_latest_tag "Genymobile/scrcpy")
    scrcpy_current=$(scrcpy --version | head -n 1 | awk '{print $2}')

    if [[ "$scrcpy_current" == "$scrcpy_latest" ]]; then
        echo "scrcpy already up to date."
        exit 0
    fi

    deps=(
        adb
        ffmpeg
        gcc
        git
        libavcodec-dev
        libavdevice-dev
        libavformat-dev
        libavutil-dev
        libsdl2-2.0-0
        libsdl2-dev
        libswresample-dev
        libusb-1.0-0
        libusb-1.0-0-dev
        meson
        ninja-build
        pkg-config
        wget
    )
    if ! have scrcpy; then
        sudo apt install -y "${deps[@]}"
    fi

    git clone --depth 1 --branch "v${scrcpy_latest}" https://github.com/Genymobile/scrcpy.git /tmp/scrcpy
    pushd /tmp/scrcpy &> /dev/null || exit
    ./install_release.sh
    popd &> /dev/null || exit
fi
