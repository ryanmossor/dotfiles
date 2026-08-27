#!/usr/bin/env bash
# shellcheck disable=2154

have indicator-sound-switcher && exit 0

sudo apt-add-repository -y ppa:yktooo/ppa
sudo apt-get update
sudo apt-get install -y indicator-sound-switcher
