#!/usr/bin/env bash

if [[ ! -d "$HOME/.local/share/themes/Orchis-Dark-Compact" ]]; then
    git clone https://github.com/vinceliuice/Orchis-theme.git /tmp/orchis
    /tmp/orchis/install.sh -c dark -s compact -l
    sudo flatpak override --filesystem=xdg-config/gtk-3.0
    sudo flatpak override --filesystem=xdg-config/gtk-4.0
fi

