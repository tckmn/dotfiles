#!/bin/bash
if [ $(pidof dzen2) ]
then
    killall dzen2
else
    (
    while :
    do
        echo "\
$(date '+%a. %b %d, %I:%M:%S %p') | \
Battery: $(upower -d | grep percentage | grep -o '[0-9]*%') | \
Volume: $(amixer -D pulse get Master | grep -o '[0-9]*%' | head -n1) | \
Network: $(bc <<< "scale = 4; $(iwconfig 2>/dev/null | grep -o '[0-9]\+/[0-9]*')*100" | cut -c -5)%"
        sleep 0.2
    done
    ) | dzen2 -y 100 -fn 'monospace-25' &
fi
