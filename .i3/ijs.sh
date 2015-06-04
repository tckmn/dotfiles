#!/bin/bash

if [ "$(pidof -x ijs.sh | grep ' [^ ]* ')" ]
then
    killall ijs.sh
else
    repeat=$(zenity --entry --text='What to repeat?' --entry-text=ijs)
    while :
    do
        xdotool type --delay 50 "$repeat"
        xdotool key Return
    done
fi
