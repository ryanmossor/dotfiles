#!/usr/bin/env bash

apt_updates=$(apt list --upgradable 2>/dev/null | tail -n +2 | sed 's/\/.*//g')
flatpak_updates=$(flatpak remote-ls --updates | tail -n +1 | awk '{print $2}')

if [ -n "$apt_updates" ]; then
    echo "$apt_updates" > /tmp/available_updates.txt
fi

if [ -n "$flatpak_updates" ]; then
    echo >> /tmp/available_updates.txt
    echo "$flatpak_updates" >> /tmp/available_updates.txt
fi

if [ -n "$apt_updates" ]; then
    apt_update_count=$(printf '%s\n' "$apt_updates" | wc -l)
else
    apt_update_count=0
fi

if [ -n "$flatpak_updates" ]; then
    flatpak_update_count=$(printf '%s\n' "$flatpak_updates" | wc -l)
else
    flatpak_update_count=0
fi

total_updates=$(($apt_update_count + $flatpak_update_count))
if [ "$total_updates" -eq 0 ]; then
    exit 0
fi

echo "$total_updates"
