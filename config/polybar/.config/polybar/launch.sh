#!/usr/bin/env bash

if type "xrandr"; then
    # show on all monitors
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --config=~/.config/polybar/config.ini --reload bar &
    done
else
    # show only on primary
    polybar --reload --config=~/.config/polybar/config.ini bar &
fi

