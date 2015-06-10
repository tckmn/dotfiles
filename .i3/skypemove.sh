#!/bin/bash
xdotool keyup Alt_L
# take screenshot of single-pixel column to look for orange highlight
import -window root -crop 1x$(xdpyinfo | grep dimensions | grep -o '[0-9]*' | \
    sed -n 2p)+50+0 /tmp/skypemove.png
# find pixel value of first orange pixel and add or subtract appropriate amount
x=$(( $(convert /tmp/skypemove.png txt: | grep 'srgb(240,119,70)' | \
    grep -o '[0-9]*' | sed -n 2p) + 20 $([[ $1 = next ]] && printf '+' || \
    printf '-') 40 ))
# click at that location
xdotool mousemove 90 $x
xdotool click 1
xdotool keydown Alt_L
