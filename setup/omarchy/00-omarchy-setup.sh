#!/usr/bin/env bash

# Remove existing config files
rm -rf ~/.config/hypr/{autostart,bindings,hyprland,input,looknfeel,monitors}.lua \
    ~/.config/hypr/hyprsunset.conf \
    ~/.config/lazygit/config.yml \
    ~/.config/nvim \
    ~/.config/omarchy/extensions/omarchy-menu.jsonc \
    ~/.config/omarchy/{shell.json,shell.toml} \
    ~/.config/tmux/tmux.conf \
    ~/.config/ghostty/config \
    ~/.config/git/config \
    ~/.bashrc

# Remove system packages
packages=(
    chromium
    obsidian
)
for pkg in "${packages[@]}"; do
    omarchy-pkg-drop "$pkg"
done

# Remove launcher shortcuts
shortcuts=(
    foot
    'Google Contacts'
    'Google Maps'
    'Google Messages'
    'Google Photos'
    HEY
    WhatsApp
    X
    Zoom
)
for app in "${shortcuts[@]}"; do
    omarchy-webapp-remove "$app"
done
