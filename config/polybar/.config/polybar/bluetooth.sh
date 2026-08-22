#!/usr/bin/env bash

powered=$(bluetoothctl show | grep "Powered: yes")

if [[ -z "$powered" ]]; then
    echo "%{F#444444}%{F-}"
elif bluetoothctl devices Connected | grep -q .; then
    echo "%{F#89B4FA}%{F-}"
else
    echo "%{F#6C7086}%{F-}"
fi
