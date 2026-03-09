#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade -y
flatpak update -y

sleep 5

# Restart polybar to clear package update module
polybar-msg cmd restart
