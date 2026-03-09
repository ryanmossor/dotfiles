#!/usr/bin/env bash

if ! have dotnet; then
    sudo add-apt-repository ppa:dotnet/backports
    sudo apt-get update
    sudo apt-get install dotnet-sdk-10.0 dotnet-sdk-9.0 dotnet-sdk-8.0 -y
fi

