#!/usr/bin/env bash

case "$os" in
    mac)
        if [ ! -d '/Applications/JetBrains Toolbox.app' ]; then
            open "https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=macM1"
        fi
        ;;
    omarchy|ubuntu)
        if [ ! -f ~/.local/share/applications/jetbrains-toolbox.desktop ]; then
            xdg-open "https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux"
        fi
        ;;
    *)
        echo "OS not supported. Skipping JetBrains Toolbox installation." ;;
esac
