#!/bin/bash

main () {
    xbacklight -dec 10
    BRIGHTNESS=$(xbacklight | awk '{printf("%.2f\n", $1)}' | cut -c1-2)
    notify-send -u low -t 1500 " Brightness: $BRIGHTNESS%"
}

main
