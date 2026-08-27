#!/usr/bin/env bash

(have brave || have brave-browser) && exit 0

case "$os" in
    omarchy) omarchy-install-browser brave ;;
    ubuntu)  curl -fsS https://dl.brave.com/install.sh | sh ;;
esac
