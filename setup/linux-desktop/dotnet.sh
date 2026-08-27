#!/usr/bin/env bash

have dotnet && exit 0

case "$os" in
    omarchy)
        mise use --global dotnet@latest ;;
    ubuntu)
        sudo add-apt-repository ppa:dotnet/backports
        sudo apt-get update
        sudo apt-get install dotnet-sdk-10.0 dotnet-sdk-9.0 dotnet-sdk-8.0 -y
        ;;
esac
