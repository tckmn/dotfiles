#!/bin/bash

function color {
    red=$(bc -l <<< "x=(100-$1)/50*255;scale=0;x/1")
    green=$(bc -l <<< "x=$1/50*255;scale=0;x/1")
    echo "#$(printf '%.2x%.2x' $((red>255?255:red)) $((green>255?255:green)))00"
}

# icons can be generated via:
# cp /usr/share/icons/gnome/scalable/status/network-wireless-signal-*-symbolic.svg .; for x in *.svg; do inkscape -z -e $(basename $x .svg).png -w 32 -h 32 $x; convert $(basename $x .svg).png -background white -alpha Background $(basename $x .svg).xpm; done; rm *.svg *.png
# I know. Very very ugly :(

# Just For Fun(tm): change the line that sets battery to
# battery=$((10#$(date +%N | cut -c 1-2)))
# and remove the sleep 0.1.

if [ "$(pidof -x toggle-dzen.sh | grep ' [^ ]* ')" ]
then
    killall toggle-dzen.sh
else
    (
    while :
    do
        battery=$(upower -d | grep percentage | grep -o '[0-9]*')
        charging=$([ "$(upower -d | grep state | grep discharging)" ] && echo -n '' || echo -n ' ⚡')
        volume=$(amixer -D pulse get Master | grep -o '[0-9]*%' | head -n1 | grep -o '[0-9]*')
        network=$(bc -l <<< "x=$(iwconfig 2>/dev/null | grep -o '[0-9]\+/[0-9]*')*4;scale=0;x/1")
        case $network in
            0) network=weak ;;
            1) network=ok ;;
            2) network=good ;;
            3) network=excellent ;;
        esac
        echo "\
$(date '+%a. %b %d, %I:%M:%S %p') | \
^fg($(color $battery))^r($((battery))x20)^ro($((100-battery))x20)^r(5x10)$charging^fg() | \
^fg($(color $volume))^co(100)^p(-$((50+volume/2)))^c($volume)^p(+$((51-volume/2)))^fg() | \
^i($HOME/.xmonad/network-wireless-signal-$network-symbolic.xpm)"
        sleep 0.1
    done
    ) | dzen2 -fn 'monospace-20' &
fi
