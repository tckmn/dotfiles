#!/bin/bash
touch ~/startup01
sleep 5
touch ~/startup02

nohup ~/programs/chromium-vim/cvim_server.py &
touch ~/startup03
setxkbmap -layout us,ru
touch ~/startup04
setxkbmap -option ctrl:nocaps -option compose:menu -option grp:toggle
touch ~/startup05
synclient "VertScrollDelta=-$(synclient | grep VertScrollDelta | grep -o '[0-9]*')"
touch ~/startup06
nohup wicd-client -t &
touch ~/startup07
xcape
touch ~/startup08
xflux -z 77024
touch ~/startup09
xrandr --output HDMI2 --right-of eDP1
touch ~/startup10
xrdb ~/.Xresources
touch ~/startup11
nohup xss-lock i3lock &
touch ~/startup12
