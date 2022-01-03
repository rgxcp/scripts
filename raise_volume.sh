#!/bin/bash

main () {
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    VOLUME=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $4}' | tr -d '[]')
    notify-send -u low -t 1500 " Volume: $VOLUME"
}

main
