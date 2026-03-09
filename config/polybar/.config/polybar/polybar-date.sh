#!/usr/bin/env bash

t=0
sleep_pid=0

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
    if [ $t -eq 0 ]; then
        date "+%A, %B %e   %l:%M %p"
    else
        date -u "+%A, %B %e   %H:%M UTC"
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done
